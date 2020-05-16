Return-Path: <SRS0=aU3i=66=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=aU3i=66=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726528AbgEPUWn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 16 May 2020 16:22:43 -0400
MIME-Version: 1.0
References: <1589397725-29697-1-git-send-email-jrdr.linux@gmail.com>
 <20200514022935.GE29933@yilunxu-OptiPlex-7050> <DM6PR11MB38193B495FB1DB4697F0094F85BC0@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB38193B495FB1DB4697F0094F85BC0@DM6PR11MB3819.namprd11.prod.outlook.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sun, 17 May 2020 01:52:29 +0530
Message-ID: <CAFqt6zYA1EotyQSeBa19mC_Az8MbPUyfYZvjYWb01bm927FH4A@mail.gmail.com>
Subject: Re: [PATCH] fpga: dfl: afu: Corrected error handling levels
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: "Wu, Hao" <hao.wu@intel.com>
Cc: "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>

On Thu, May 14, 2020 at 11:36 AM Wu, Hao <hao.wu@intel.com> wrote:
>
> > -----Original Message-----
> > From: Xu, Yilun <yilun.xu@intel.com>
> > Sent: Thursday, May 14, 2020 10:30 AM
> > To: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: Wu, Hao <hao.wu@intel.com>; mdf@kernel.org; linux-
> > fpga@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] fpga: dfl: afu: Corrected error handling levels
> >
> > The patch looks good to me.
> >
> > Maybe we could add the Fixes tag:
> >   Fixes: fa8dda1edef9 (fpga: dfl: afu: add
> > DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support)
>
> Thanks for catching this problem.
>
> With this line,
> Acked-by: Wu Hao <hao.wu@intel.com>

Thanks. Will post v2.

>
> Thanks!
> Hao
>
> >
> > Thanks,
> > Yilun
> >
> > On Thu, May 14, 2020 at 12:52:05AM +0530, Souptick Joarder wrote:
> > > Corrected error handling goto sequnece. Level put_pages should
> > > be called when pinned pages >= 0 && pinned != npages. Level
> > > free_pages should be called when pinned pages < 0.
> > >
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > ---
> > >  drivers/fpga/dfl-afu-dma-region.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-
> > region.c
> > > index 62f9244..5942343 100644
> > > --- a/drivers/fpga/dfl-afu-dma-region.c
> > > +++ b/drivers/fpga/dfl-afu-dma-region.c
> > > @@ -61,10 +61,10 @@ static int afu_dma_pin_pages(struct
> > dfl_feature_platform_data *pdata,
> > >                                  region->pages);
> > >     if (pinned < 0) {
> > >             ret = pinned;
> > > -           goto put_pages;
> > > +           goto free_pages;
> > >     } else if (pinned != npages) {
> > >             ret = -EFAULT;
> > > -           goto free_pages;
> > > +           goto put_pages;
> > >     }
> > >
> > >     dev_dbg(dev, "%d pages pinned\n", pinned);
> > > --
> > > 1.9.1
