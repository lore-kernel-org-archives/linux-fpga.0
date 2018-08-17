Return-Path: <SRS0=s2IE=LA=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=s2IE=LA=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:54176
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbeHQKDI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 17 Aug 2018 06:03:08 -0400
From: Federico Vaga <federico.vaga@cern.ch>
Reply-To: <federico.vaga@cern.ch>
Subject: Re: [PATCH 2/2] fpga: add FPGA manager debugfs
Date: Fri, 17 Aug 2018 09:00:38 +0200
Message-ID: <2759044.uKe7sI2ItL@pcbe13614>
In-Reply-To: <20180816220034.GA4431@archbook>
References: <20180815220958.3606-1-atull@kernel.org> <1841468.1pWPcT6Du7@harkonnen> <20180816220034.GA4431@archbook>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Dinh Nguyen <dinguyen@kernel.org>, Appana Durga Kedareswara Rao <appanad@xilinx.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Alan Tull <atull@opensource.altera.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>

Hi Mortiz,

I'm not 100% into the problem to understand all cases. I'm putting on the 
table the point of view, mainly, of an user. If you say there are problems 
here or there I believe you. At the beginning, you did not say that this 
interface may introduce problems (and I'm interested in those problems since I 
implemented one and we are using it), but that you fear that it becomes the 
default (usually, being a default is a good thing).

Since you and Alan are working on this for a long time, you can read each 
other mind, but I need a more verbose email to understand ^_^'

Of course the interface must be safe, I totally agree. In order to make me 
understand what are the issues, can you list some of them? And expand your 
comment about  MMIO.

(I just did a dummy backport, and implemented that interface. So, I repeat 
myself: I do not have enough experience with this framework to understand all 
consequences, but I'm interested to know what are the risks behind this 
interface)

On Friday, August 17, 2018 12:00:34 AM CEST Moritz Fischer wrote:
> Hi Federico,
> 
> On Thu, Aug 16, 2018 at 11:21:32PM +0200, Federico Vaga wrote:
> > Hi,
> > 
> > On Thursday, August 16, 2018 10:04:51 PM CEST Alan Tull wrote:
> > > On Thu, Aug 16, 2018 at 1:59 PM, Moritz Fischer <mdf@kernel.org> wrote:
> > > > Hi Alan,
> > > 
> > > Hi Moritz,
> > > 
> > > > comments inline. While I see how this is useful, I have the
> > > > suspicion that from the moment this gets merged vendor kernels
> > > > will just default to use this ...
> > > 
> > > Yeah, I have that suspicion as well.  That's probably why I sat on
> > > this and didn't upstream it for 2 years.  But on the other hand, I
> > > keep hearing of lots of cases of people implementing this
> > > independently anyway.  At least if it is debugfs, it makes it clear
> > > that it's not intended for production use.
> > 
> > I'm one of those guys who implemented this independently.
> 
> We all have in one way or another ;) Most people on ARM run an out of tree
> patch using devicetree overlays these days I hope rather than /dev/mem
> and UIO ... or other vender solutions...
> 
> > @Mortiz
> > I do not see how this can be a bad thing (from what you wrote I guess you
> > prefer another interface). Which interface to use depends on the use case.
> > If you have this suspicion it's, I guess, because such interface it is
> > extremely easy to use.
> 
> What happens to a kernel driver doing MMIO with devices while you reload
> the entire FPGA from userland?
> 
> > @Alan
> > DebugFS can be a first step, but I would go for a normal device in /dev at
> > some point. I do not see why this should not be used in production
> 
> I'm not against having a userland interface to reprogram the FPGA, the
> Intel DFL code is a good example of a sensible one, doing so in a safe
> manner.
>
> Ideally we'll get around to have a more generic interface, as we get
> time to work on it.
> 
> - Moritz
