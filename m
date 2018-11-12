Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20180912144327.3130-1-atull@kernel.org> <20180912144327.3130-6-atull@kernel.org>
 <20180930154845.GA13200@kroah.com> <CANk1AXR=psRx319i_2S3fqM+4WsK6YgwJMPn=2o3zw5AQ3mr6w@mail.gmail.com>
 <20181112180206.GA28739@kroah.com>
In-Reply-To: <20181112180206.GA28739@kroah.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 12 Nov 2018 13:39:38 -0600
Message-ID: <CANk1AXSTOEZD9paFVc=G+VDKmj3E4dAMPpvhrCECeiF7=aS8pA@mail.gmail.com>
Subject: Re: [PATCH 5/5] fpga: dfl-fme-region: Use platform_get_drvdata()
Content-Type: text/plain; charset="UTF-8"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Nov 12, 2018 at 12:02 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Nov 12, 2018 at 09:46:53AM -0600, Alan Tull wrote:
> > On Sun, Sep 30, 2018 at 10:48 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >
> > Hi Greg,
> >
> > >
> > > On Wed, Sep 12, 2018 at 09:43:27AM -0500, Alan Tull wrote:
> > > > From: Moritz Fischer <mdf@kernel.org>
> > > >
> > > > Use platform_get_drvdata() in remove() function of
> > > > the platform driver rather than dev_get_drvdata()
> > > > to match the platform_set_drvdata in the probe().
> > > >
> > > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > > Acked-by: Alan Tull <atull@kernel.org>
> > > > ---
> > > >  drivers/fpga/dfl-fme-region.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> > > > index 51a5ac2..3fa0de2 100644
> > > > --- a/drivers/fpga/dfl-fme-region.c
> > > > +++ b/drivers/fpga/dfl-fme-region.c
> > > > @@ -66,7 +66,7 @@ static int fme_region_probe(struct platform_device *pdev)
> > > >
> > > >  static int fme_region_remove(struct platform_device *pdev)
> > > >  {
> > > > -     struct fpga_region *region = dev_get_drvdata(&pdev->dev);
> > > > +     struct fpga_region *region = platform_get_drvdata(pdev);
> > >
> > > This is nice, but not a bugfix.  I'll wait for 4.20-rc1 for this patch.
> >
> > Could you take patch 4/5 and 5/5?  They didn't make it into a 4.20 rc yet.
>
> Can you resend them please?  I don't see either of these in my queue
> anywhere.
>
> thanks,
>
> greg k-h

Sure! Just sent them.

Thanks,
Alan
