Return-Path: <SRS0=lsyE=3B=gmail.com=delicious.quinoa@kernel.org>
Return-Path: <SRS0=lsyE=3B=gmail.com=delicious.quinoa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1490334216-31068-2-git-send-email-mdf@kernel.org>
References: <1490334216-31068-1-git-send-email-mdf@kernel.org> <1490334216-31068-2-git-send-email-mdf@kernel.org>
From: Alan Tull <delicious.quinoa@gmail.com>
Date: Fri, 24 Mar 2017 10:23:18 -0500
Message-ID: <CANk1AXRJq_CioHLvQQApeBNbU-gNceFv34pcuW804tnANqYOVQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] fpga: Add support for Xilinx LogiCORE PR Decoupler
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Mar 24, 2017 at 12:43 AM, Moritz Fischer <mdf@kernel.org> wrote:
> This adds support for the Xilinx LogiCORE PR Decoupler
> soft-ip that does decoupling of PR regions in the FPGA
> fabric during partial reconfiguration.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Acked-by: Alan Tull <atull@kernel.org>

> Cc: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
> Changes from v3:
> - Adressed build bot issues
>
> Changes from v2:
> - Added Michal's Signed-off-by
> - Added "xlnx,pr-decoupler" unversioned fallback
>
> Changes from v1:
> - Added Michal as Co-Author since I pulled in some of his code
> - Reworked clk handling in _remove()
> - Pulled in Michal's version of show_enable(), ditched priv->enabled
>
> ---
>  drivers/fpga/Kconfig               |  10 +++
>  drivers/fpga/Makefile              |   1 +
>  drivers/fpga/xilinx-pr-decoupler.c | 161 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 172 insertions(+)
>  create mode 100644 drivers/fpga/xilinx-pr-decoupler.c
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index ce861a2..6eabfbe 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -63,6 +63,16 @@ config ALTERA_FREEZE_BRIDGE
>           isolate one region of the FPGA from the busses while that
>           region is being reprogrammed.
>
> +config XILINX_PR_DECOUPLER
> +       tristate "Xilinx LogiCORE PR Decoupler"
> +       depends on FPGA_BRIDGE
> +       depends on HAS_IOMEM
> +       help
> +         Say Y to enable drivers for Xilinx LogiCORE PR Decoupler.
> +         The PR Decoupler exists in the FPGA fabric to isolate one
> +         region of the FPGA from the busses while that region is
> +         being reprogrammed during partial reconfig.
> +
>  endif # FPGA
>
>  endmenu
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 8df07bc..ba94b79 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)      +=3D zynq-fpga.o
>  obj-$(CONFIG_FPGA_BRIDGE)              +=3D fpga-bridge.o
>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)      +=3D altera-hps2fpga.o altera-fpg=
a2sdram.o
>  obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)     +=3D altera-freeze-bridge.o
> +obj-$(CONFIG_XILINX_PR_DECOUPLER)      +=3D xilinx-pr-decoupler.o
>
>  # High Level Interfaces
>  obj-$(CONFIG_FPGA_REGION)              +=3D fpga-region.o
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-=
decoupler.c
> new file mode 100644
> index 0000000..e359930
> --- /dev/null
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -0,0 +1,161 @@
> +/*
> + * Copyright (c) 2017, National Instruments Corp.
> + * Copyright (c) 2017, Xilix Inc
> + *
> + * FPGA Bridge Driver for the Xilinx LogiCORE Partial Reconfiguration
> + * Decoupler IP Core.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/of_device.h>
> +#include <linux/module.h>
> +#include <linux/fpga/fpga-bridge.h>
> +
> +#define CTRL_CMD_DECOUPLE      BIT(0)
> +#define CTRL_CMD_COUPLE                0
> +#define CTRL_OFFSET            0
> +
> +struct xlnx_pr_decoupler_data {
> +       void __iomem *io_base;
> +       struct clk *clk;
> +};
> +
> +static inline void xlnx_pr_decoupler_write(struct xlnx_pr_decoupler_data=
 *d,
> +                                          u32 offset, u32 val)
> +{
> +       writel(val, d->io_base + offset);
> +}
> +
> +static inline u32 xlnx_pr_decouple_read(const struct xlnx_pr_decoupler_d=
ata *d,
> +                                       u32 offset)
> +{
> +       return readl(d->io_base + offset);
> +}
> +
> +static int xlnx_pr_decoupler_enable_set(struct fpga_bridge *bridge, bool=
 enable)
> +{
> +       int err;
> +       struct xlnx_pr_decoupler_data *priv =3D bridge->priv;
> +
> +       err =3D clk_enable(priv->clk);
> +       if (err)
> +               return err;
> +
> +       if (enable)
> +               xlnx_pr_decoupler_write(priv, CTRL_OFFSET, CTRL_CMD_COUPL=
E);
> +       else
> +               xlnx_pr_decoupler_write(priv, CTRL_OFFSET, CTRL_CMD_DECOU=
PLE);
> +
> +       clk_disable(priv->clk);
> +
> +       return 0;
> +}
> +
> +static int xlnx_pr_decoupler_enable_show(struct fpga_bridge *bridge)
> +{
> +       const struct xlnx_pr_decoupler_data *priv =3D bridge->priv;
> +       u32 status;
> +       int err;
> +
> +       err =3D clk_enable(priv->clk);
> +       if (err)
> +               return err;
> +
> +       status =3D readl(priv->io_base);
> +
> +       clk_disable(priv->clk);
> +
> +       return !status;
> +}
> +
> +static struct fpga_bridge_ops xlnx_pr_decoupler_br_ops =3D {
> +       .enable_set =3D xlnx_pr_decoupler_enable_set,
> +       .enable_show =3D xlnx_pr_decoupler_enable_show,
> +};
> +
> +static const struct of_device_id xlnx_pr_decoupler_of_match[] =3D {
> +       { .compatible =3D "xlnx,pr-decoupler-1.00", },
> +       { .compatible =3D "xlnx,pr-decoupler", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, xlnx_pr_decoupler_of_match);
> +
> +static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
> +{
> +       struct xlnx_pr_decoupler_data *priv;
> +       int err;
> +       struct resource *res;
> +
> +       priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       priv->io_base =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(priv->io_base))
> +               return PTR_ERR(priv->io_base);
> +
> +       priv->clk =3D devm_clk_get(&pdev->dev, "aclk");
> +       if (IS_ERR(priv->clk)) {
> +               dev_err(&pdev->dev, "input clock not found\n");
> +               return PTR_ERR(priv->clk);
> +       }
> +
> +       err =3D clk_prepare_enable(priv->clk);
> +       if (err) {
> +               dev_err(&pdev->dev, "unable to enable clock\n");
> +               return err;
> +       }
> +
> +       clk_disable(priv->clk);
> +
> +       err =3D fpga_bridge_register(&pdev->dev, "Xilinx PR Decoupler",
> +                                  &xlnx_pr_decoupler_br_ops, priv);
> +
> +       if (err) {
> +               dev_err(&pdev->dev, "unable to register Xilinx PR Decoupl=
er");
> +               clk_unprepare(priv->clk);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int xlnx_pr_decoupler_remove(struct platform_device *pdev)
> +{
> +       struct fpga_bridge *bridge =3D platform_get_drvdata(pdev);
> +       struct xlnx_pr_decoupler_data *p =3D bridge->priv;
> +
> +       fpga_bridge_unregister(&pdev->dev);
> +
> +       clk_unprepare(p->clk);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver xlnx_pr_decoupler_driver =3D {
> +       .probe =3D xlnx_pr_decoupler_probe,
> +       .remove =3D xlnx_pr_decoupler_remove,
> +       .driver =3D {
> +               .name =3D "xlnx_pr_decoupler",
> +               .of_match_table =3D of_match_ptr(xlnx_pr_decoupler_of_mat=
ch),
> +       },
> +};
> +
> +module_platform_driver(xlnx_pr_decoupler_driver);
> +
> +MODULE_DESCRIPTION("Xilinx Partial Reconfiguration Decoupler");
> +MODULE_AUTHOR("Moritz Fischer <mdf@kernel.org>");
> +MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
