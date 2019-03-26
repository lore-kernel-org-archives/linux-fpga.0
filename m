Return-Path: <SRS0=d/Y2=R5=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=d/Y2=R5=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:51162 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfCZAoR (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Mar 2019 20:44:17 -0400
Date: Tue, 26 Mar 2019 08:28:52 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH 02/17] fpga: dfl: fme: align PR buffer size per PR
 datawidth
Message-ID: <20190326002852.GA2901@hao-dev>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-3-git-send-email-hao.wu@intel.com>
 <CANk1AXSUMkfQu8QnN-T0B5qeA4vaGxDTvGur9EGyLbGsBFBeKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXSUMkfQu8QnN-T0B5qeA4vaGxDTvGur9EGyLbGsBFBeKQ@mail.gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>

On Mon, Mar 25, 2019 at 12:50:40PM -0500, Alan Tull wrote:
> On Sun, Mar 24, 2019 at 10:23 PM Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> Looks good, one question below.
> 
> >
> > Current driver checks if input bitstream file size is aligned or
> > not per PR data width (default 32bits). It requires one additional
> > step for end user when they generate the bitstream file, padding
> > extra zeros to bitstream file to align its size per PR data width,
> > but they don't have to as hardware will drop extra padding bytes
> > automatically.
> >
> > In order to simplify the user steps, this patch aligns PR buffer
> > size per PR data width in driver, to allow user to pass unaligned
> > size bitstream files to driver.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > ---
> >  drivers/fpga/dfl-fme-pr.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> > index d9ca955..c1fb1fe 100644
> > --- a/drivers/fpga/dfl-fme-pr.c
> > +++ b/drivers/fpga/dfl-fme-pr.c
> > @@ -74,6 +74,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
> >         struct dfl_fme *fme;
> >         unsigned long minsz;
> >         void *buf = NULL;
> > +       size_t length;
> >         int ret = 0;
> >         u64 v;
> >
> > @@ -85,9 +86,6 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
> >         if (port_pr.argsz < minsz || port_pr.flags)
> >                 return -EINVAL;
> >
> > -       if (!IS_ALIGNED(port_pr.buffer_size, 4))
> > -               return -EINVAL;
> > -
> >         /* get fme header region */
> >         fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
> >                                                FME_FEATURE_ID_HEADER);
> > @@ -103,7 +101,13 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
> >                        port_pr.buffer_size))
> >                 return -EFAULT;
> >
> > -       buf = vmalloc(port_pr.buffer_size);
> > +       /*
> > +        * align PR buffer per PR bandwidth, as HW ignores the extra padding
> > +        * data automatically.
> > +        */
> > +       length = ALIGN(port_pr.buffer_size, 4);
> > +
> > +       buf = vmalloc(length);
> 
> Since it may not be completely filled, would it be worthwhile to alloc
> a zero'ed buff?
>

Hi Alan,

Thanks for the review, acutally per spec, hw doesn't care about the
extra padding data. So for now, i guess we don't need this.

Thanks
Hao

> Alan
> 
