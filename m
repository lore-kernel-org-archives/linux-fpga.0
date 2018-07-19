Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180718072526.25378-1-colin.king@canonical.com>
References: <20180718072526.25378-1-colin.king@canonical.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 19 Jul 2018 10:30:23 -0500
Message-ID: <CANk1AXQ1CO5_D7nspi8W8Vd8-2kPKXCCUeHBf-ZhfvktboLOqA@mail.gmail.com>
Subject: Re: [PATCH][V2] drivers: fpga: fix two trivial spelling mistakes
Content-Type: text/plain; charset="UTF-8"
To: Colin King <colin.king@canonical.com>
Cc: Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>, Jiri Kosina <trivial@kernel.org>, linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Jul 18, 2018 at 2:25 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to two spelling mistakes
> "execeeded" -> "exceeded"
> "Invaild" -> "Invalid"
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Alan Tull <atull@kernel.org>

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
>         dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
>                 incr ? '+' : '-', npages << PAGE_SHIFT,
>                 current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
> -               ret ? "- execeeded" : "");
> +               ret ? "- exceeded" : "");
>
>         up_write(&current->mm->mmap_sem);
>
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index b5ef405b6d88..9f045d058cfd 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -201,7 +201,7 @@ static int fme_mgr_write(struct fpga_manager *mgr,
>                 }
>
>                 if (count < 4) {
> -                       dev_err(dev, "Invaild PR bitstream size\n");
> +                       dev_err(dev, "Invalid PR bitstream size\n");
>                         return -EINVAL;
>                 }
>
> --
> 2.17.1
>

Thanks,
Alan
