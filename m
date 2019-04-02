Return-Path: <moritz.fischer.private@gmail.com>
Date: Tue, 2 Apr 2019 06:31:30 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Message-ID: <20190402133130.GA14646@archbook>
References: <20190402123123.915-1-nava.manne@xilinx.com>
 <20190402123123.915-4-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402123123.915-4-nava.manne@xilinx.com>
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com, jollys@xilinx.com, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chinnikishore369@gmail.com
List-ID: <linux-fpga@vger.kernel.org>

Hi Nava,

looks mostly good to me. One minor nit below:

On Tue, Apr 02, 2019 at 06:01:23PM +0530, Nava kishore Manne wrote:

[..]
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> new file mode 100644
> index 000000000000..f6e35fe95adb
> --- /dev/null
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -0,0 +1,159 @@
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
> +#define IXR_FPGA_DONE_MASK	0X00000008U

You could use the BIT(x) macro here.
> +
> +/**
> + * struct zynqmp_fpga_priv - Private data structure
> + * @dev:	Device data structure
> + * @flags:	flags which is used to identify the bitfile type
> + */
> +struct zynqmp_fpga_priv {
> +	struct device *dev;
> +	u32 flags;
> +};
> +

[..]

Reviewed-by: Moritz Fischer <mdf@kernel.org>

Thanks,

Moritz
