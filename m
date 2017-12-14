Return-Path: <SRS0=VOhP=DK=free-electrons.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=VOhP=DK=free-electrons.com=thomas.petazzoni@kernel.org>
Date: Thu, 14 Dec 2017 06:27:52 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] fpga: add simple userspace interface to trigger FPGA
 programming
Message-ID: <20171214062752.0c86a658@windsurf.png.is.keysight.com>
In-Reply-To: <CANk1AXT_Nuu-rvt8DhC7YgXxKV0Ffd76EKU35ezxfTvau1BJFw@mail.gmail.com>
References: <20171204154315.30128-1-thomas.petazzoni@free-electrons.com>
	<CANk1AXR==vnPTKA4EZZrebd9WViLiaZAxmnnSRyMPPBpJNA4pw@mail.gmail.com>
	<e730ef80-df19-3caa-68b2-02d6ef56f04e@gmail.com>
	<CANk1AXQ5ds=DY5cNrnzFthHBf6mRxSDuP4FoZWfM6hcXk9Nm=A@mail.gmail.com>
	<20171210234410.67e48bae@windsurf.lan>
	<alpine.DEB.2.20.1712130626150.1@5af5ed6f0bd3>
	<20171213062352.0e1042a4@windsurf.png.is.keysight.com>
	<CANk1AXT_Nuu-rvt8DhC7YgXxKV0Ffd76EKU35ezxfTvau1BJFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>
Cc: Yves Vandervennet <yves.vandervennet@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

Hello,

On Wed, 13 Dec 2017 09:59:55 -0600, Alan Tull wrote:

> An FPGA bridge is something that connects the FPGA fabric to the world
> outside the FPGA.  Not every setup will have this.  During programming
> the bridge can be disabled to protect the outside world from bad
> randomness (the fabric may wiggle some).   It the case of full
> reconfiguration, it would be a hardware bridge/bridges on the bus.  In
> the case of partial reconfiguration, it would be a freeze bridge
> surrounding the partial reconfiguration region since the same manager
> could be used to reprogram each of several regions, but each will have
> their own bridge.  It sounds like in your case, it's full
> reconfiguration and either there's no bridge or it's left enabled or
> the programming code is handling the bridge or you're enabling the
> bridge after programming.  FPGA regions were created as a way of
> allowing an interface to potentially work for both setups that have
> bridges or don't have them.  This is all just to give some context as
> to why interfaces should be added on top of a region rather than a
> manager.  So people could use the interface whether they have a bridge
> or not.

Hum, OK. I'm not sure to grasp all the details here. In my use case, I
don't have anything that looks like a software-controlled FPGA bridge.
There is a memory-mapped CPLD, which provides some registers that the
SoC uses to program the FPGA. Based on those register writes, the CPLD
programs the FPGA.

> > My use case is
> > pretty simple:
> >
> >  - The SoC has a PCIE controller. The PCIE controller is a hard IP
> >    block in the SoC.
> >
> >  - There is a FPGA on the board which is connected directly to the SoC
> >    over PCIe + over a control bus that allows programming of the FPGA.  
> 
> Just to be clear, the programming is not through PCIe, right?

Correct, there's a side-band channel in the form of a memory-mapped
CPLD.

> > Therefore, there is no bridge involved: once the FPGA is programmed,
> > the PCIE controller in the SoC can enumerate and see a new PCIE device,
> > which happens to be implemented in the FPGA.  
> 
> Yes, full reconfiguration of a FPGA that's on PCIe is a common use
> case and one we want to support.  This subsystem started out
> supporting embedded FPGAs so some things may need to adapt for PCIe.
> The code on linux-next is a step towards that, but not a complete
> solution.

Could you summarize what is in linux-next and how it is a step towards
that, and what is missing ?

Thanks a lot for your feedback,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
