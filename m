Return-Path: <SRS0=Rud9=7B=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=Rud9=7B=intel.com=yilun.xu@kernel.org>
Date: Tue, 19 May 2020 23:10:37 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
Message-ID: <20200519151037.GA20726@yilunxu-OptiPlex-7050>
References: <20200517011837.382189-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517011837.382189-1-jhubbard@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Sat, May 16, 2020 at 06:18:37PM -0700, John Hubbard wrote:
> This code was using get_user_pages_fast(), in a "Case 2" scenario
> (DMA/RDMA), using the categorization from [1]. That means that it's
> time to convert the get_user_pages_fast() + put_page() calls to
> pin_user_pages_fast() + unpin_user_pages() calls.
> 
> There is some helpful background in [2]: basically, this is a small
> part of fixing a long-standing disconnect between pinning pages, and
> file systems' use of those pages.
> 
> [1] Documentation/core-api/pin_user_pages.rst
> 
> [2] "Explicit pinning of user-space pages":
>     https://lwn.net/Articles/807108/
> 
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: linux-fpga@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/fpga/dfl-afu-dma-region.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> index 62f924489db5..84f696d5ba82 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -16,15 +16,6 @@
>  
>  #include "dfl-afu.h"
>  
> -static void put_all_pages(struct page **pages, int npages)
> -{
> -	int i;
> -
> -	for (i = 0; i < npages; i++)
> -		if (pages[i])
> -			put_page(pages[i]);
> -}
> -
>  void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
>  {
>  	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
> @@ -57,7 +48,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
>  		goto unlock_vm;
>  	}
>  
> -	pinned = get_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
> +	pinned = pin_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
>  				     region->pages);
>  	if (pinned < 0) {
>  		ret = pinned;
> @@ -72,7 +63,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
>  	return 0;
>  
>  put_pages:

How about we also change the tag to "unpin_pages"?

Others look good to me.

Thanks,
Yilun.

> -	put_all_pages(region->pages, pinned);
> +	unpin_user_pages(region->pages, pinned);
>  free_pages:
>  	kfree(region->pages);
>  unlock_vm:
> @@ -94,7 +85,7 @@ static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
>  	long npages = region->length >> PAGE_SHIFT;
>  	struct device *dev = &pdata->dev->dev;
>  
> -	put_all_pages(region->pages, npages);
> +	unpin_user_pages(region->pages, npages);
>  	kfree(region->pages);
>  	account_locked_vm(current->mm, npages, false);
>  
> 
> base-commit: 3d1c1e5931ce45b3a3f309385bbc00c78e9951c6
> -- 
> 2.26.2
