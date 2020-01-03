Date: Thu, 2 Jan 2020 20:59:05 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: remove redundant dev_err message
Message-ID: <20200103045903.GA21472@epycbox.lan>
References: <1568107616-12755-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568107616-12755-1-git-send-email-dingxiang@cmss.chinamobile.com>
To: Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Sep 10, 2019 at 05:26:56PM +0800, Ding Xiang wrote:
> devm_ioremap_resource already contains error message, so remove
> the redundant dev_err message
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  drivers/fpga/ts73xx-fpga.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
> index 9a17fe9..2888ff0 100644
> --- a/drivers/fpga/ts73xx-fpga.c
> +++ b/drivers/fpga/ts73xx-fpga.c
> @@ -119,10 +119,8 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	priv->io_base = devm_ioremap_resource(kdev, res);
> -	if (IS_ERR(priv->io_base)) {
> -		dev_err(kdev, "unable to remap registers\n");
> +	if (IS_ERR(priv->io_base))
>  		return PTR_ERR(priv->io_base);
> -	}
>  
>  	mgr = devm_fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
>  				   &ts73xx_fpga_ops, priv);
> -- 
> 1.9.1
> 
> 
> 

Applied to for-next.

Thanks,
Moritz
