Return-Path: <SRS0=PW67=LH=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=PW67=LH=intel.com=hao.wu@kernel.org>
Date: Sat, 25 Aug 2018 02:16:49 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH 2/2] fpga: dfl-fme-region: Use platform_get_drvdata()
Message-ID: <20180824181649.GA11371@hao-dev>
References: <20180824152513.8336-1-mdf@kernel.org>
 <20180824152513.8336-2-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824152513.8336-2-mdf@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: atull@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Aug 24, 2018 at 08:25:13AM -0700, Moritz Fischer wrote:
> Use platform_get_drvdata() in remove() function of
> the platform driver rather than dev_get_drvdata()
> to match the platform_set_drvdata in the probe().

Hi Moritz,

Thanks for this patch, it looks good to me. : )

Hao

> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-fme-region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> index 0b7e19c27c6d..11d3c23a8936 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -65,7 +65,7 @@ static int fme_region_probe(struct platform_device *pdev)
>  
>  static int fme_region_remove(struct platform_device *pdev)
>  {
> -	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
> +	struct fpga_region *region = platform_get_drvdata(pdev);
>  
>  	fpga_region_unregister(region);
>  	fpga_mgr_put(region->mgr);
> -- 
> 2.18.0
