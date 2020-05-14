Return-Path: <SRS0=gD37=64=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=gD37=64=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:42676 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgENCcn (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 13 May 2020 22:32:43 -0400
Date: Thu, 14 May 2020 10:29:35 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH] fpga: dfl: afu: Corrected error handling levels
Message-ID: <20200514022935.GE29933@yilunxu-OptiPlex-7050>
References: <1589397725-29697-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589397725-29697-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org

The patch looks good to me.

Maybe we could add the Fixes tag:
  Fixes: fa8dda1edef9 (fpga: dfl: afu: add DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support)

Thanks,
Yilun

On Thu, May 14, 2020 at 12:52:05AM +0530, Souptick Joarder wrote:
> Corrected error handling goto sequnece. Level put_pages should
> be called when pinned pages >= 0 && pinned != npages. Level
> free_pages should be called when pinned pages < 0.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/fpga/dfl-afu-dma-region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> index 62f9244..5942343 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -61,10 +61,10 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
>  				     region->pages);
>  	if (pinned < 0) {
>  		ret = pinned;
> -		goto put_pages;
> +		goto free_pages;
>  	} else if (pinned != npages) {
>  		ret = -EFAULT;
> -		goto free_pages;
> +		goto put_pages;
>  	}
>  
>  	dev_dbg(dev, "%d pages pinned\n", pinned);
> -- 
> 1.9.1
