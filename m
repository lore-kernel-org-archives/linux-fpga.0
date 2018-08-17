Return-Path: <SRS0=NZzS=LA=cern.ch=federico.vaga@kernel.org>
Return-Path: <SRS0=NZzS=LA=cern.ch=federico.vaga@kernel.org>
From: Federico Vaga <federico.vaga@cern.ch>
Reply-To: <federico.vaga@cern.ch>
Subject: Re: [PATCH 2/2] fpga: add FPGA manager debugfs
Date: Fri, 17 Aug 2018 16:54:16 +0200
Message-ID: <3209150.S88njOrd88@pcbe13614>
In-Reply-To: <CANk1AXTUYTEJgWneS1n2WwaqyOAmohYFFoXOU51XX6j02=q9xw@mail.gmail.com>
References: <20180815220958.3606-1-atull@kernel.org> <2759044.uKe7sI2ItL@pcbe13614> <CANk1AXTUYTEJgWneS1n2WwaqyOAmohYFFoXOU51XX6j02=q9xw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Randy Dunlap  <rdunlap@infradead.org>, Dinh Nguyen <dinguyen@kernel.org>,  Appana Durga Kedareswara Rao  <appanad@xilinx.com>, linux-kernel" <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, "Linux Doc Mailing List  <linux-doc@vger.kernel.org>, Alan Tull" <atull@opensource.altera.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Friday, August 17, 2018 3:19:24 PM CEST Alan Tull wrote:
> On Fri, Aug 17, 2018, 2:00 AM Federico Vaga <federico.vaga@cern.ch> wrote:
> > Hi Mortiz,
> > 
> > I'm not 100% into the problem to understand all cases. I'm putting on the
> > table the point of view, mainly, of an user. If you say there are problems
> > here or there I believe you. At the beginning, you did not say that this
> > interface may introduce problems (and I'm interested in those problems
> > since I
> > implemented one and we are using it), but that you fear that it becomes
> > the
> > default (usually, being a default is a good thing).
> > 
> > Since you and Alan are working on this for a long time, you can read each
> > other mind, but I need a more verbose email to understand ^_^'
> > 
> > Of course the interface must be safe, I totally agree. In order to make me
> > understand what are the issues, can you list some of them?
> 
> Before we repeat what the doc l posted says, could you look at it and
> comment on what I'm not saying there?
> 
> https://lkml.org/lkml/2018/8/15/525

I read it, but do you mean that the problems you foresee are only the ones 
listed in there? If this is so, comments:

loading devices
It is true that it is a problem, and probably it is clear to everyone who will 
try to use such interface: "and now how do I load my devices?". But this is 
only a possible case, the FPGA may run without device driver and in this case 
it is perfectly fine for production.

If the answer to the above question is: "ok, let me see where my devices are 
in the memory ..." well if the machine crashes, it's their problem. This 
problem exists even without the FPGA manager.

bridge
My understand is that it is optional. Developers are allowed to not implement 
the bridge's operations. Which probably means that it does not exist or it is 
not needed.
When an user uses this interface from userspace it shouldn't be hard to detect 
if the operation is risky or not (bridge enabled/disabled). And if it is 
risky, the operation fails with EPERM, EBUSY.

I have to say that I'm not familiar with the bridge design, perhaps I'm 
missing something.


Conclusions
Yes, those are problems but I think they do not justify the label "not for 
production": in some cases I think is fine.
