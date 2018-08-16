Return-Path: <SRS0=iILP=K7=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=iILP=K7=ettus.com=moritz.fischer@kernel.org>
Date: Thu, 16 Aug 2018 15:00:34 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 2/2] fpga: add FPGA manager debugfs
Message-ID: <20180816220034.GA4431@archbook>
References: <20180815220958.3606-1-atull@kernel.org>
 <20180816185952.GA3932@archbook>
 <CANk1AXTZqaZxrEeb3TpyH7HtiVNw+MvVsBZzXWZkSLzUGQkrnA@mail.gmail.com>
 <1841468.1pWPcT6Du7@harkonnen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1841468.1pWPcT6Du7@harkonnen>
To: Federico Vaga <federico.vaga@cern.ch>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Dinh Nguyen <dinguyen@kernel.org>, Appana Durga Kedareswara Rao <appanad@xilinx.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Alan Tull <atull@opensource.altera.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

Hi Federico,

On Thu, Aug 16, 2018 at 11:21:32PM +0200, Federico Vaga wrote:
> Hi,
> 
> On Thursday, August 16, 2018 10:04:51 PM CEST Alan Tull wrote:
> > On Thu, Aug 16, 2018 at 1:59 PM, Moritz Fischer <mdf@kernel.org> wrote:
> > > Hi Alan,
> > 
> > Hi Moritz,
> > 
> > > comments inline. While I see how this is useful, I have the
> > > suspicion that from the moment this gets merged vendor kernels
> > > will just default to use this ...
> > 
> > Yeah, I have that suspicion as well.  That's probably why I sat on
> > this and didn't upstream it for 2 years.  But on the other hand, I
> > keep hearing of lots of cases of people implementing this
> > independently anyway.  At least if it is debugfs, it makes it clear
> > that it's not intended for production use.
> 
> I'm one of those guys who implemented this independently.

We all have in one way or another ;) Most people on ARM run an out of tree
patch using devicetree overlays these days I hope rather than /dev/mem
and UIO ... or other vender solutions...
> 
> @Mortiz
> I do not see how this can be a bad thing (from what you wrote I guess you 
> prefer another interface). Which interface to use depends on the use case.
> If you have this suspicion it's, I guess, because such interface it is 
> extremely easy to use.

What happens to a kernel driver doing MMIO with devices while you reload
the entire FPGA from userland?
> 
> @Alan
> DebugFS can be a first step, but I would go for a normal device in /dev at 
> some point. I do not see why this should not be used in production

I'm not against having a userland interface to reprogram the FPGA, the 
Intel DFL code is a good example of a sensible one, doing so in a safe
manner.

Ideally we'll get around to have a more generic interface, as we get
time to work on it.

- Moritz
