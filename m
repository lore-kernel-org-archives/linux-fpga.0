Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20180912144327.3130-1-atull@kernel.org> <20180912144327.3130-5-atull@kernel.org>
 <20180930154921.GB13200@kroah.com>
In-Reply-To: <20180930154921.GB13200@kroah.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 12 Nov 2018 09:48:00 -0600
Message-ID: <CANk1AXSr1xdqfmyNeN6Jc-OnZhDqbL+C2Uz_j37NGopVRWNj6g@mail.gmail.com>
Subject: Re: [PATCH 4/5] fpga: of-fpga-region: Use platform_set_drvdata
Content-Type: text/plain; charset="UTF-8"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Sun, Sep 30, 2018 at 10:49 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

Hi Greg,

>
> On Wed, Sep 12, 2018 at 09:43:26AM -0500, Alan Tull wrote:
> > From: Moritz Fischer <mdf@kernel.org>
> >
> > Use platform_set_drvdata rather than dev_set_drvdata
> > to match the platform_get_drvdata in the _remove()
> > function of the platform driver.
> >
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > Acked-by: Alan Tull <atull@kernel.org>
> > ---
> >  drivers/fpga/of-fpga-region.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> > index 052a134..d6a70e4 100644
> > --- a/drivers/fpga/of-fpga-region.c
> > +++ b/drivers/fpga/of-fpga-region.c
> > @@ -421,7 +421,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
> >               goto eprobe_free;
> >
> >       of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
> > -     dev_set_drvdata(dev, region);
> > +     platform_set_drvdata(pdev, region);
>
> Again, not really a bugfix :)

Could you take this patch 4/5 (just sent a reminder for 5/5)?

Thanks
Alan
