Return-Path: <SRS0=Ghnj=LS=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Ghnj=LS=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45385 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725726AbeIEEIe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Sep 2018 00:08:34 -0400
Received: by mail-yw1-f68.google.com with SMTP id p206-v6so1941697ywg.12
        for <linux-fpga@vger.kernel.org>; Tue, 04 Sep 2018 16:41:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180904212237.3078-2-atull@kernel.org>
References: <20180904212237.3078-1-atull@kernel.org> <20180904212237.3078-2-atull@kernel.org>
From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Tue, 4 Sep 2018 16:41:09 -0700
Message-ID: <CAAtXAHfzhmdZ6SnheZ-DXD14dde7Ccm66jEM=Q3UWDukKsyGBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] fpga: do not access region struct after fpga_region_unregister
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>

Hi Alan,

On Tue, Sep 4, 2018 at 2:22 PM, Alan Tull <atull@kernel.org> wrote:
> A couple drivers were accessing the region struct after it had been
> freed.  Save off the pointer to the mgr before the region struct gets
> freed.
>
> Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: no change in v2 of patchset
> ---
>  drivers/fpga/dfl-fme-region.c | 4 +++-
>  drivers/fpga/of-fpga-region.c | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> index 0b7e19c..51a5ac2 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -14,6 +14,7 @@
>   */
>
>  #include <linux/module.h>
> +#include <linux/fpga/fpga-mgr.h>
>  #include <linux/fpga/fpga-region.h>
>
>  #include "dfl-fme-pr.h"
> @@ -66,9 +67,10 @@ static int fme_region_probe(struct platform_device *pdev)
>  static int fme_region_remove(struct platform_device *pdev)
>  {
>         struct fpga_region *region = dev_get_drvdata(&pdev->dev);
> +       struct fpga_manager *mgr = region->mgr;
>
>         fpga_region_unregister(region);
> -       fpga_mgr_put(region->mgr);
> +       fpga_mgr_put(mgr);
>
>         return 0;
>  }
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index 35fabb8..052a134 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -437,9 +437,10 @@ static int of_fpga_region_probe(struct platform_device *pdev)
>  static int of_fpga_region_remove(struct platform_device *pdev)
>  {
>         struct fpga_region *region = platform_get_drvdata(pdev);
> +       struct fpga_manager *mgr = region->mgr;
>
>         fpga_region_unregister(region);
> -       fpga_mgr_put(region->mgr);
> +       fpga_mgr_put(mgr);
>
>         return 0;
>  }
> --
> 2.7.4
>

Thanks,
Moritz
