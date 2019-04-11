Return-Path: <SRS0=DIAb=SN=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=DIAb=SN=intel.com=hao.wu@kernel.org>
Date: Thu, 11 Apr 2019 20:33:14 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH] fpga: dfl: afu: Pass the correct device to
 dma_mapping_error()
Message-ID: <20190411123314.GA19198@hao-dev>
References: <20190410215327.8024-1-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410215327.8024-1-swood@redhat.com>
To: Scott Wood <swood@redhat.com>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Apr 10, 2019 at 04:53:27PM -0500, Scott Wood wrote:
> dma_mapping_error() was being called on a different device struct than
> what was passed to map/unmap.  Besides rendering the error checking
> ineffective, it caused a debug splat with CONFIG_DMA_API_DEBUG.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>

Hi Scott,

Looks good to me. Thanks for catching this issue.

Acked-by: Wu Hao <hao.wu@intel.com>

Hao

> ---
>  drivers/fpga/dfl-afu-dma-region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> index e18a786fc943..cd68002ac097 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -399,7 +399,7 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
>  				    region->pages[0], 0,
>  				    region->length,
>  				    DMA_BIDIRECTIONAL);
> -	if (dma_mapping_error(&pdata->dev->dev, region->iova)) {
> +	if (dma_mapping_error(dfl_fpga_pdata_to_parent(pdata), region->iova)) {
>  		dev_err(&pdata->dev->dev, "failed to map for dma\n");
>  		ret = -EFAULT;
>  		goto unpin_pages;
> -- 
> 1.8.3.1
