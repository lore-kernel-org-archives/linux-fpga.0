Return-Path: <SRS0=oQeA=QT=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=oQeA=QT=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38600 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfBLLGv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 12 Feb 2019 06:06:51 -0500
Received: by mail-yw1-f66.google.com with SMTP id o184so840309ywo.5
        for <linux-fpga@vger.kernel.org>; Tue, 12 Feb 2019 03:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20190211161754.23902-1-nava.manne@xilinx.com>
In-Reply-To: <20190211161754.23902-1-nava.manne@xilinx.com>
From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Tue, 12 Feb 2019 03:06:38 -0800
Message-ID: <CAAtXAHfXaerVYzfdnA_09rK5AgLVJAiRcE2KEqosfrMZBuO3xQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: Alan Tull <atull@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michal Simek <michal.simek@xilinx.com>, Rajan Vaja <rajanv@xilinx.com>, Jolly Shah <jollys@xilinx.com>, linux-fpga@vger.kernel.org, Devicetree List <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kishore m <chinnikishore369@gmail.com>

Hi Nava,

On Sun, Feb 10, 2019 at 8:17 AM Nava kishore Manne
<nava.manne@xilinx.com> wrote:
>
> This patch adds FPGA Manager support for the Xilinx
> ZynqMP chip.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
>                 -Created patches on top of 5.0-rc5.
>                  No functional changes.
> Changes for v2:
>                 -Fixed some minor coding issues as suggested by
>                  Moritz
>
> Changes for v1:
>                 -None.
>
> Changes for RFC-V2:
>                 -Updated the Fpga Mgr registrations call's
>                  to 4.18
>
>  drivers/fpga/Kconfig       |   9 +++
>  drivers/fpga/Makefile      |   1 +
>  drivers/fpga/zynqmp-fpga.c | 165 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 175 insertions(+)
>  create mode 100644 drivers/fpga/zynqmp-fpga.c
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 0bb7b5c..9f17203 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -204,4 +204,13 @@ config FPGA_DFL_PCI
>
>           To compile this as a module, choose M here.
>
> +config FPGA_MGR_ZYNQMP_FPGA
> +       tristate "Xilinx ZynqMP FPGA"
> +       depends on ARCH_ZYNQMP || COMPILE_TEST
> +       help
> +         FPGA manager driver support for Xilinx ZynqMP FPGAs.
> +         This driver uses the processor configuration port(PCAP)
> +         to configure the programmable logic(PL) through PS
> +         on ZynqMP SoC.
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index c0dd4c8..312b937 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)  += stratix10-soc.o
>  obj-$(CONFIG_FPGA_MGR_TS73XX)          += ts73xx-fpga.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)      += xilinx-spi.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)       += zynq-fpga.o
> +obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)     += zynqmp-fpga.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> new file mode 100644
> index 0000000..f40c3bb
> --- /dev/null
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Xilinx, Inc.
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/string.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +
> +/* Constant Definitions */
> +#define IXR_FPGA_DONE_MASK     0X00000008U
> +
> +/**
> + * struct zynqmp_fpga_priv - Private data structure
> + * @dev:       Device data structure
> + * @flags:     flags which is used to identify the bitfile type
> + */
> +struct zynqmp_fpga_priv {
> +       struct device *dev;
> +       u32 flags;
> +};
> +
> +static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
> +                                     struct fpga_image_info *info,
> +                                     const char *buf, size_t size)
> +{
> +       struct zynqmp_fpga_priv *priv;
> +
> +       priv = mgr->priv;
> +       priv->flags = info->flags;
> +
> +       return 0;
> +}
> +
> +static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
> +                                const char *buf, size_t size)
> +{
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +       struct zynqmp_fpga_priv *priv;
> +       dma_addr_t dma_addr;
> +       u32 eemi_flags = 0;
> +       char *kbuf;
> +       int ret;
> +
> +       if (!eemi_ops || !eemi_ops->fpga_load)
> +               return -ENXIO;
> +
> +       priv = mgr->priv;
> +
> +       kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
> +       if (!kbuf)
> +               return -ENOMEM;
> +
> +       memcpy(kbuf, buf, size);
> +
> +       wmb(); /* ensure all writes are done before initiate FW call */
> +
> +       if (priv->flags & FPGA_MGR_PARTIAL_RECONFIG)
> +               eemi_flags |= XILINX_ZYNQMP_PM_FPGA_PARTIAL;
> +
> +       ret = eemi_ops->fpga_load(dma_addr, size, eemi_flags);
> +
> +       dma_free_coherent(priv->dev, size, kbuf, dma_addr);
> +
> +       return ret;
> +}
> +
> +static int zynqmp_fpga_ops_write_complete(struct fpga_manager *mgr,
> +                                         struct fpga_image_info *info)
> +{
> +       return 0;
> +}
> +
> +static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
> +{
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +       u32 status;
> +
> +       if (!eemi_ops || !eemi_ops->fpga_get_status)
> +               return FPGA_MGR_STATE_UNKNOWN;
> +
> +       eemi_ops->fpga_get_status(&status);
> +       if (status & IXR_FPGA_DONE_MASK)
> +               return FPGA_MGR_STATE_OPERATING;
> +
> +       return FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static const struct fpga_manager_ops zynqmp_fpga_ops = {
> +       .state = zynqmp_fpga_ops_state,
> +       .write_init = zynqmp_fpga_ops_write_init,
> +       .write = zynqmp_fpga_ops_write,
> +       .write_complete = zynqmp_fpga_ops_write_complete,
> +};
> +
> +static int zynqmp_fpga_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct zynqmp_fpga_priv *priv;
> +       struct fpga_manager *mgr;
> +       int err, ret;

Just use err everywhere, or ret, your choice.
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev = dev;
> +       ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
Here?
> +       if (ret < 0) {
> +               dev_err(dev, "no usable DMA configuration");
> +               return ret;
> +       }
> +
> +       mgr = fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
> +                             &zynqmp_fpga_ops, priv);
> +       if (!mgr)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, mgr);
> +
> +       err = fpga_mgr_register(mgr);
vs here.
> +       if (err) {
> +               dev_err(dev, "unable to register FPGA manager");
> +               fpga_mgr_free(mgr);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int zynqmp_fpga_remove(struct platform_device *pdev)
> +{
> +       struct fpga_manager *mgr = platform_get_drvdata(pdev);
> +
> +       fpga_mgr_unregister(mgr);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id zynqmp_fpga_of_match[] = {
> +       { .compatible = "xlnx,zynqmp-pcap-fpga", },
> +       {},
> +};
> +
> +MODULE_DEVICE_TABLE(of, zynqmp_fpga_of_match);
> +
> +static struct platform_driver zynqmp_fpga_driver = {
> +       .probe = zynqmp_fpga_probe,
> +       .remove = zynqmp_fpga_remove,
> +       .driver = {
> +               .name = "zynqmp_fpga_manager",
> +               .of_match_table = of_match_ptr(zynqmp_fpga_of_match),
> +       },
> +};
> +
> +module_platform_driver(zynqmp_fpga_driver);
> +
> +MODULE_AUTHOR("Nava kishore Manne <navam@xilinx.com>");
> +MODULE_DESCRIPTION("Xilinx ZynqMp FPGA Manager");
> +MODULE_LICENSE("GPL");
> --
> 2.7.4
>

Thanks,
Moritz
