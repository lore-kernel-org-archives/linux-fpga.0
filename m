Return-Path: <SRS0=Mh8S=PW=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Mh8S=PW=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfANWP3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Jan 2019 17:15:29 -0500
MIME-Version: 1.0
References: <20190110230626.4130-1-atull@kernel.org> <CAAtXAHeuGCz7msGnG-kPWN18h6h9z3VgbrBf0eXKvtKaEm7=mA@mail.gmail.com>
In-Reply-To: <CAAtXAHeuGCz7msGnG-kPWN18h6h9z3VgbrBf0eXKvtKaEm7=mA@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 14 Jan 2019 16:14:51 -0600
Message-ID: <CANk1AXRtWBWhR3UEihL35pa7YmhPiOTDzHK+nAZe6qmMtQ8_HQ@mail.gmail.com>
Subject: Re: [PATCH] fpga: altera_freeze_bridge: remove restriction to socfpga
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org

On Fri, Jan 11, 2019 at 12:42 PM Moritz Fischer
<moritz.fischer@ettus.com> wrote:

Hi Moritz,

>
> Hi Alan,
>
> On Thu, Jan 10, 2019 at 3:06 PM Alan Tull <atull@kernel.org> wrote:
> >
> > The Altera Freeze Bridge should not be restricted to ARCH_SOCFPGA
> > since it can be used on other platforms such as Stratix10.
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
> > ---
> >  drivers/fpga/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 0bb7b5c..0bdbd3d 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -104,7 +104,7 @@ config SOCFPGA_FPGA_BRIDGE
> >
> >  config ALTERA_FREEZE_BRIDGE
> >         tristate "Altera FPGA Freeze Bridge"
> > -       depends on ARCH_SOCFPGA && FPGA_BRIDGE
> > +       depends on FPGA_BRIDGE
>
> Doesn't that need a dependency on HAS_IOMEM at least, then?

Right you are!  Thanks!

Alan

> >         help
> >           Say Y to enable drivers for Altera FPGA Freeze bridges.  A
> >           freeze bridge is a bridge that exists in the FPGA fabric to
> > --
> > 2.7.4
> >
>
> Thanks,
> Moritz
