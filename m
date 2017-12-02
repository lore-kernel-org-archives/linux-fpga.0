Return-Path: <SRS0=9T1G=C6=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=9T1G=C6=ettus.com=moritz.fischer@kernel.org>
Date: Fri, 1 Dec 2017 17:21:08 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: socfpga-a10: disable clk on error in
 socfpga_a10_fpga_probe()
Message-ID: <20171202012108.x5js74t73f3wkpem@derp-derp.lan>
References: <1512159984-23948-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512159984-23948-1-git-send-email-khoroshilov@ispras.ru>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Alexey,

On Fri, Dec 01, 2017 at 11:26:24PM +0300, Alexey Khoroshilov wrote:
> If fpga_mgr_register() fails, a clock is left undisabled.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/socfpga-a10.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
> index f8770af0f6b5..a46e343a5b72 100644
> --- a/drivers/fpga/socfpga-a10.c
> +++ b/drivers/fpga/socfpga-a10.c
> @@ -519,8 +519,14 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>  		return -EBUSY;
>  	}
>  
> -	return fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
> +	ret = fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
>  				 &socfpga_a10_fpga_mgr_ops, priv);
> +	if (ret) {
> +		clk_disable_unprepare(priv->clk);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static int socfpga_a10_fpga_remove(struct platform_device *pdev)
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks for your patch,

Moritz
