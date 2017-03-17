Return-Path: <SRS0=MxXm=22=xilinx.com=michal.simek@kernel.org>
Return-Path: <SRS0=MxXm=22=xilinx.com=michal.simek@kernel.org>
Subject: Re: [PATCH v2 2/2] fpga: Add support for Xilinx LogiCORE PR Decoupler
References: <1489711910-17443-1-git-send-email-mdf@kernel.org>
 <1489711910-17443-2-git-send-email-mdf@kernel.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <f2d3ae3f-1f74-1ce6-b7af-f51b383d3a5d@xilinx.com>
Date: Fri, 17 Mar 2017 11:54:23 +0100
MIME-Version: 1.0
In-Reply-To: <1489711910-17443-2-git-send-email-mdf@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, "Michal Simek  <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?=" <soren.brinkmann@xilinx.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 17.3.2017 01:51, Moritz Fischer wrote:
> This adds support for the Xilinx LogiCORE PR Decoupler
> soft-ip that does decoupling of PR regions in the FPGA
> fabric during partial reconfiguration.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
> 
> Changes from v1:
> - Added Michal as Co-Author since I pulled in some of his code
> - Reworked clk handling in _remove()
> - Pulled in Michal's version of show_enable(), ditched priv->enabled
> 
> ---
>  drivers/fpga/Kconfig               |   9 +++
>  drivers/fpga/Makefile              |   1 +
>  drivers/fpga/xilinx-pr-decoupler.c | 147 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 157 insertions(+)
>  create mode 100644 drivers/fpga/xilinx-pr-decoupler.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 967cda4..e42c7dc 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -69,6 +69,15 @@ config ALTERA_FREEZE_BRIDGE
>  	  isolate one region of the FPGA from the busses while that
>  	  region is being reprogrammed.
>  
> +config XILINX_PR_DECOUPLER
> +	tristate "Xilinx LogiCORE PR Decoupler"
> +	depends on FPGA_BRIDGE
> +	help
> +	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler.
> +	  The PR Decoupler exists in the FPGA fabric to isolate one
> +	  region of the FPGA from the busses while that region is
> +	  being reprogrammed during partial reconfig.
> +
>  endif # FPGA
>  
>  endmenu
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index cc0d364..3f04bcf 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
>  obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+= altera-freeze-bridge.o
> +obj-$(CONFIG_XILINX_PR_DECOUPLER)	+= xilinx-pr-decoupler.o
>  
>  # High Level Interfaces
>  obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> new file mode 100644
> index 0000000..761700c
> --- /dev/null
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -0,0 +1,147 @@
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
> +#define CTRL_CMD_DECOUPLE	BIT(0)
> +#define CTRL_CMD_COUPLE		~BIT(0)
> +
> +struct xlnx_pr_decoupler_data {
> +	void __iomem *io_base;
> +	struct clk *clk;
> +};
> +
> +static int xlnx_pr_decoupler_enable_set(struct fpga_bridge *bridge, bool enable)
> +{
> +	int err;
> +	struct xlnx_pr_decoupler_data *priv = bridge->priv;
> +
> +	err = clk_enable(priv->clk);
> +	if (err)
> +		return err;
> +
> +	if (enable)
> +		writel(CTRL_CMD_COUPLE, priv->io_base);
> +	else
> +		writel(CTRL_CMD_DECOUPLE, priv->io_base);
> +
> +	clk_disable(priv->clk);
> +
> +	return 0;
> +}
> +
> +static int xlnx_pr_decoupler_enable_show(struct fpga_bridge *bridge)
> +{
> +	const struct xlnx_pr_decoupler_data *priv = bridge->priv;
> +	u32 status;
> +	int err;
> +
> +	err = clk_enable(priv->clk);
> +	if (err)
> +		return err;
> +
> +	status = readl(priv->io_base);
> +
> +	clk_disable(priv->clk);
> +
> +	return !status;
> +}
> +
> +static struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
> +	.enable_set = xlnx_pr_decoupler_enable_set,
> +	.enable_show = xlnx_pr_decoupler_enable_show,
> +};
> +
> +static const struct of_device_id xlnx_pr_decoupler_of_match[] = {
> +	{ .compatible = "xlnx,pr-decoupler-1.00", },

I would add here that generic compatible string too.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
