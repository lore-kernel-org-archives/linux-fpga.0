Return-Path: <SRS0=FVIH=25=xilinx.com=michal.simek@kernel.org>
Return-Path: <SRS0=FVIH=25=xilinx.com=michal.simek@kernel.org>
Subject: Re: [PATCH v3 2/2] fpga: Add support for Xilinx LogiCORE PR Decoupler
References: <1489781473-30772-1-git-send-email-mdf@kernel.org>
 <1489781473-30772-2-git-send-email-mdf@kernel.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <ce16ea40-bf9b-7aa3-b7ac-07c05932cd99@xilinx.com>
Date: Mon, 20 Mar 2017 11:02:16 +0100
MIME-Version: 1.0
In-Reply-To: <1489781473-30772-2-git-send-email-mdf@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, "Michal Simek  <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?=" <soren.brinkmann@xilinx.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 17.3.2017 21:11, Moritz Fischer wrote:
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
> Changes from v2:
> - Added Michal's Signed-off-by

btw: you forgot to add it above. :-)

> - Added "xlnx,pr-decoupler" unversioned fallback
> 
> Changes from v1:
> - Added Michal as Co-Author since I pulled in some of his code
> - Reworked clk handling in _remove()
> - Pulled in Michal's version of show_enable(), ditched priv->enabled
> 
> ---
>  drivers/fpga/Kconfig               |   9 +++
>  drivers/fpga/Makefile              |   1 +
>  drivers/fpga/xilinx-pr-decoupler.c | 148 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 158 insertions(+)
>  create mode 100644 drivers/fpga/xilinx-pr-decoupler.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index ce861a2..ce0c91d 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -63,6 +63,15 @@ config ALTERA_FREEZE_BRIDGE
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
> index 8df07bc..ba94b79 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
>  obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+= altera-freeze-bridge.o
> +obj-$(CONFIG_XILINX_PR_DECOUPLER)	+= xilinx-pr-decoupler.o
>  
>  # High Level Interfaces
>  obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> new file mode 100644
> index 0000000..dd37b1c
> --- /dev/null
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -0,0 +1,148 @@
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

for others - this was reported by 0-day testing system as a warning.

M
