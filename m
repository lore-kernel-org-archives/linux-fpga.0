Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20190617031113.4506-1-atull@kernel.org> <20190617033510.GA25342@archbook>
In-Reply-To: <20190617033510.GA25342@archbook>
From: Alan Tull <atull@kernel.org>
Date: Mon, 17 Jun 2019 10:33:51 -0500
Message-ID: <CANk1AXQTbMN2oDruwfS+NGtrKLMGJtp9R+2=o=yvwiuX1ebn9A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: fpga: hand off maintainership to Moritz
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dinh Nguyen <dinguyen@kernel.org>, Thor Thayer <thor.thayer@linux.intel.com>, Richard Gong <richard.gong@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Sun, Jun 16, 2019 at 10:35 PM Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

>
> Hi Alan,
>
> On Sun, Jun 16, 2019 at 10:11:13PM -0500, Alan Tull wrote:
> > I'm moving on to a new position and stepping down as FPGA subsystem
> > maintainer.  Moritz has graciously agreed to take over the
> > maintainership.
>
> Thanks a lot for all the work you put into this, it was good fun working
> with you, and I hope you'll be back someday, or at least you'll keep
> working on the Linux Kernel in other areas.

Thank you for your support and all the good work and enthusiasm you've
put into this subsystem!

Alan

>
> All: It'll take me a bit to get everything sorted, since I just switched
> jobs and am still getting set up there, too, so please be patient :)
>
> > Signed-off-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 80e2bfa049d7..448730982545 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6266,7 +6266,6 @@ F:      include/linux/ipmi-fru.h
> >  K:   fmc_d.*register
> >
> >  FPGA MANAGER FRAMEWORK
> > -M:   Alan Tull <atull@kernel.org>
> >  M:   Moritz Fischer <mdf@kernel.org>
> >  L:   linux-fpga@vger.kernel.org
> >  S:   Maintained
> > --
> > 2.21.0
> >
>
> Cheers,
> Moritz
