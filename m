Return-Path: <SRS0=HrTw=KC=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=HrTw=KC=intel.com=hao.wu@kernel.org>
Date: Wed, 18 Jul 2018 12:11:06 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH] drivers: fpga: fix two trivial spelling mistakes
Message-ID: <20180718041106.GB18178@hao-dev>
References: <20180717092138.19010-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717092138.19010-1-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Jiri Kosina <trivial@kernel.org>, linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Jul 17, 2018 at 10:21:38AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trival fix to two spellling mistakes

Thank you very much for this fixing. Only one minor thing here.

s/Trival/Trivial/
s/spellling/spelling/

Thanks
Hao

> "execeeded" -> "exceeded"
> "Invaild" -> "Invalid"
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
