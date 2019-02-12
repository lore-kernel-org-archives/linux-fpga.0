Return-Path: <SRS0=oQeA=QT=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=oQeA=QT=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42560 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfBLKyf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 12 Feb 2019 05:54:35 -0500
Received: by mail-yb1-f193.google.com with SMTP id j189so835082ybj.9
        for <linux-fpga@vger.kernel.org>; Tue, 12 Feb 2019 02:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20190212062451.1354-1-cgxu519@gmx.com>
In-Reply-To: <20190212062451.1354-1-cgxu519@gmx.com>
From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Tue, 12 Feb 2019 02:54:23 -0800
Message-ID: <CAAtXAHck6a2LbWGb9Fu7+HP9Uz8oAhTOs9636AqD7P9SOSGi3A@mail.gmail.com>
Subject: Re: [PATCH] fpga: expand minor range when registering chrdev region
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Chengguang Xu <cgxu519@gmx.com>
Cc: Wu Hao <hao.wu@intel.com>, Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org

Hi Chengguang,

On Mon, Feb 11, 2019 at 10:25 PM Chengguang Xu <cgxu519@gmx.com> wrote:
>
> Actually, total amount of available minor number
> for a single major is MINORMARK + 1. So expand
Typo. MINORMASK?

> minor range when registering chrdev region

How does that manifest?
>
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
>  drivers/fpga/dfl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 2c09e502e721..02fff566be46 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -315,7 +315,7 @@ static void dfl_chardev_uinit(void)
>         for (i = 0; i < DFL_FPGA_DEVT_MAX; i++)
>                 if (MAJOR(dfl_chrdevs[i].devt)) {
>                         unregister_chrdev_region(dfl_chrdevs[i].devt,
> -                                                MINORMASK);
> +                                                MINORMASK + 1);
>                         dfl_chrdevs[i].devt = MKDEV(0, 0);
>                 }
>  }
> @@ -325,8 +325,8 @@ static int dfl_chardev_init(void)
>         int i, ret;
>
>         for (i = 0; i < DFL_FPGA_DEVT_MAX; i++) {
> -               ret = alloc_chrdev_region(&dfl_chrdevs[i].devt, 0, MINORMASK,
> -                                         dfl_chrdevs[i].name);
> +               ret = alloc_chrdev_region(&dfl_chrdevs[i].devt, 0,
> +                                         MINORMASK + 1, dfl_chrdevs[i].name);
>                 if (ret)
>                         goto exit;
>         }
> --
> 2.20.1
>

Thanks,
Moritz
