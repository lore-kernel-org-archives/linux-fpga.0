Return-Path: <SRS0=6smu=KD=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=6smu=KD=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43334 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732086AbeGST2O (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 19 Jul 2018 15:28:14 -0400
Received: by mail-pl0-f66.google.com with SMTP id o7-v6so4031957plk.10
        for <linux-fpga@vger.kernel.org>; Thu, 19 Jul 2018 11:43:49 -0700 (PDT)
Date: Thu, 19 Jul 2018 11:43:47 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH][V2] drivers: fpga: fix two trivial spelling mistakes
Message-ID: <20180719184347.GA8465@archbook>
References: <20180718072526.25378-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718072526.25378-1-colin.king@canonical.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Wu Hao <hao.wu@intel.com>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Jiri Kosina <trivial@kernel.org>, linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 08:25:26AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to two spelling mistakes
> "execeeded" -> "exceeded"
> "Invaild" -> "Invalid"
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> V2: Fix spelling mistakes in the commit message.
> 
> ---
>  drivers/fpga/dfl-afu-dma-region.c | 2 +-
>  drivers/fpga/dfl-fme-mgr.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> index 0e81d33af856..025aba3ea76c 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -70,7 +70,7 @@ static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
>  	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
>  		incr ? '+' : '-', npages << PAGE_SHIFT,
>  		current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
> -		ret ? "- execeeded" : "");
> +		ret ? "- exceeded" : "");
>  
>  	up_write(&current->mm->mmap_sem);
>  
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index b5ef405b6d88..9f045d058cfd 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -201,7 +201,7 @@ static int fme_mgr_write(struct fpga_manager *mgr,
>  		}
>  
>  		if (count < 4) {
> -			dev_err(dev, "Invaild PR bitstream size\n");
> +			dev_err(dev, "Invalid PR bitstream size\n");
>  			return -EINVAL;
>  		}
>  
> -- 
> 2.17.1
> 
Thanks,

Moritz
