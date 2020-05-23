Return-Path: <SRS0=R2AP=7F=nvidia.com=jhubbard@kernel.org>
Return-Path: <SRS0=R2AP=7F=nvidia.com=jhubbard@kernel.org>
Subject: Re: [PATCH v2] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
References: <20200519201449.3136033-1-jhubbard@nvidia.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <64aa1494-7570-5319-b096-ea354ff20431@nvidia.com>
Date: Fri, 22 May 2020 18:52:34 -0700
MIME-Version: 1.0
In-Reply-To: <20200519201449.3136033-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 2020-05-19 13:14, John Hubbard wrote:
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
>      https://lwn.net/Articles/807108/
> 
> Cc: Xu Yilun <yilun.xu@intel.com>
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: linux-fpga@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>


Hi Moritz and FPGA developers,

Is this OK? And if so, is it going into your git tree? Or should I
send it up through a different tree? (I'm new to the FPGA development
model).


thanks,
-- 
John Hubbard
NVIDIA



> ---
> 
> Hi,
> 
> Changes since v1:
> 
> Changed the label from "put_pages", to "unpin_pages".
> 
> thanks,
> John Hubbard
> NVIDIA
>   
>   drivers/fpga/dfl-afu-dma-region.c | 19 +++++--------------
>   1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> index 62f924489db5..a31dd3a7e581 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -16,15 +16,6 @@
>   
>   #include "dfl-afu.h"
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
>   void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
>   {
>   	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
> @@ -57,11 +48,11 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
>   		goto unlock_vm;
>   	}
>   
> -	pinned = get_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
> +	pinned = pin_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
>   				     region->pages);
>   	if (pinned < 0) {
>   		ret = pinned;
> -		goto put_pages;
> +		goto unpin_pages;
>   	} else if (pinned != npages) {
>   		ret = -EFAULT;
>   		goto free_pages;
> @@ -71,8 +62,8 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
>   
>   	return 0;
>   
> -put_pages:
> -	put_all_pages(region->pages, pinned);
> +unpin_pages:
> +	unpin_user_pages(region->pages, pinned);
>   free_pages:
>   	kfree(region->pages);
>   unlock_vm:
> @@ -94,7 +85,7 @@ static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
>   	long npages = region->length >> PAGE_SHIFT;
>   	struct device *dev = &pdata->dev->dev;
>   
> -	put_all_pages(region->pages, npages);
> +	unpin_user_pages(region->pages, npages);
>   	kfree(region->pages);
>   	account_locked_vm(current->mm, npages, false);
>   
> 
