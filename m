Date: Thu, 18 Jun 2020 18:38:09 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 2/5] fpga manager: xilinx-spi: valid for the 7 Series too
Message-ID: <20200619013807.GB3685@epycbox.lan>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
 <20200611211144.9421-2-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611211144.9421-2-luca@lucaceresoli.net>
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jun 11, 2020 at 11:11:41PM +0200, Luca Ceresoli wrote:
> The Xilinx 7-series uses the same protocol, mention that.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/fpga/xilinx-spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 272ee0c22822..79106626c3f8 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Xilinx Spartan6 Slave Serial SPI Driver
> + * Xilinx Spartan6 and 7 Series Slave Serial SPI Driver
>   *
>   * Copyright (C) 2017 DENX Software Engineering
>   *
> -- 
> 2.27.0
> 

Applied to for-next,

Thanks
