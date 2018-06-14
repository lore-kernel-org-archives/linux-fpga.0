Return-Path: <SRS0=5B4H=JA=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=5B4H=JA=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:32886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755234AbeFNQw7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 14 Jun 2018 12:52:59 -0400
Date: Thu, 14 Jun 2018 13:52:54 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v3 21/27] MAINTAINERS: get rid of non-existing
 Documentation/fpga
Message-ID: <20180614135254.75cfc17d@coco.lan>
In-Reply-To: <CANk1AXRnnYketpdvrsvN11hL6G9=WinzWHVM4k9VrGJZJ99pLQ@mail.gmail.com>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
        <948d6c0304eecaf916d21af5cfb0be21df80ed42.1528990947.git.mchehab+samsung@kernel.org>
        <CANk1AXRnnYketpdvrsvN11hL6G9=WinzWHVM4k9VrGJZJ99pLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org

Em Thu, 14 Jun 2018 11:39:20 -0500
Alan Tull <atull@kernel.org> escreveu:

> On Thu, Jun 14, 2018 at 11:09 AM, Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> > This directory seems to have moved to a new place
> > (Documentation/driver-api/fpga/), with is already at MAINTAINERS.
> >
> > So, get rid of the old location.  
> 
> Wow, you caught that fast!

Just a coincidence :-) I had to rebase a pending patch series close to
the end of the merge window.

When I ran the check tool:
	./scripts/documentation-file-ref-check

It detected this.

> There's other documentation coming to this
> directory soon.  IMO we might as well leave it.  We don't need to keep
> adding and deleting this line from MAINTAINERS.

Yeah, sure. I'll drop this hunk for v4.

> 
> Also, why didn't you cc linux-fpga mailing list on this?  I guess you
> ran get_maintainer.pl after adding this patch? :)

Yeah, that was the case. I also had to sanitize the c/c for this
specific patch as get_maintainers.pl isn't good enough to check for
MAINTAINERS access... it usually just get some random noise...

> 
> Alan
> 
> >
> > Cc: Alan Tull <atull@kernel.org>
> > Cc: Moritz Fischer <mdf@kernel.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 783ce44b3e7a..67641f5bb373 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5632,7 +5632,6 @@ L:        linux-fpga@vger.kernel.org
> >  S:     Maintained
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
> >  Q:     http://patchwork.kernel.org/project/linux-fpga/list/
> > -F:     Documentation/fpga/
> >  F:     Documentation/driver-api/fpga/
> >  F:     Documentation/devicetree/bindings/fpga/
> >  F:     drivers/fpga/
> > --
> > 2.17.1
> >  



Thanks,
Mauro
