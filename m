Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171213062352.0e1042a4@windsurf.png.is.keysight.com>
References: <20171204154315.30128-1-thomas.petazzoni@free-electrons.com>
 <CANk1AXR==vnPTKA4EZZrebd9WViLiaZAxmnnSRyMPPBpJNA4pw@mail.gmail.com>
 <e730ef80-df19-3caa-68b2-02d6ef56f04e@gmail.com> <CANk1AXQ5ds=DY5cNrnzFthHBf6mRxSDuP4FoZWfM6hcXk9Nm=A@mail.gmail.com>
 <20171210234410.67e48bae@windsurf.lan> <alpine.DEB.2.20.1712130626150.1@5af5ed6f0bd3>
 <20171213062352.0e1042a4@windsurf.png.is.keysight.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 13 Dec 2017 09:59:55 -0600
Message-ID: <CANk1AXT_Nuu-rvt8DhC7YgXxKV0Ffd76EKU35ezxfTvau1BJFw@mail.gmail.com>
Subject: Re: [PATCH] fpga: add simple userspace interface to trigger FPGA programming
Content-Type: text/plain; charset="UTF-8"
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Yves Vandervennet <yves.vandervennet@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Dec 12, 2017 at 11:23 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> On Wed, 13 Dec 2017 06:30:22 +0000 (UTC),
> yves.vandervennet@linux.intel.com wrote:
>
>> > 2. The device implemented in the FPGA is self-discoverable because it
>> >    sits on a PCI bus, so there is no point in doing a static
>> >    description of the device in a DT overlay.
>> How is the enumeration triggered?
>
> I am manually forcing a rescan of the PCI bus by doing
>
>  echo 1 > /sys/bus/pci/rescan
>
> Right now my process is:
>
>  1. Remove the PCIe device instantiated in the FPGA if it exists (the
>     FPGA programming is preserved across a warm reset of the platform).
>     Indeed, as was mentioned in the this thread earlier, things don't
>     work really well if your PCIe device instantiated in the FPGA is
>     enumerated, and the FPGA gets reprogrammed underneath.
>
>  2. Program the FPGA using the additional sysfs file that my patch
>     proposes to add.
>
>  3. Rescan the PCI bus by echoing to /sys/bus/pci/rescan.
>
>> Do you have any bridges to take care of?
>
> I am not sure what you mean by bridge in this context.

Hi Thomas,

An FPGA bridge is something that connects the FPGA fabric to the world
outside the FPGA.  Not every setup will have this.  During programming
the bridge can be disabled to protect the outside world from bad
randomness (the fabric may wiggle some).   It the case of full
reconfiguration, it would be a hardware bridge/bridges on the bus.  In
the case of partial reconfiguration, it would be a freeze bridge
surrounding the partial reconfiguration region since the same manager
could be used to reprogram each of several regions, but each will have
their own bridge.  It sounds like in your case, it's full
reconfiguration and either there's no bridge or it's left enabled or
the programming code is handling the bridge or you're enabling the
bridge after programming.  FPGA regions were created as a way of
allowing an interface to potentially work for both setups that have
bridges or don't have them.  This is all just to give some context as
to why interfaces should be added on top of a region rather than a
manager.  So people could use the interface whether they have a bridge
or not.

> My use case is
> pretty simple:
>
>  - The SoC has a PCIE controller. The PCIE controller is a hard IP
>    block in the SoC.
>
>  - There is a FPGA on the board which is connected directly to the SoC
>    over PCIe + over a control bus that allows programming of the FPGA.

Just to be clear, the programming is not through PCIe, right?

>
> Therefore, there is no bridge involved: once the FPGA is programmed,
> the PCIE controller in the SoC can enumerate and see a new PCIE device,
> which happens to be implemented in the FPGA.

Yes, full reconfiguration of a FPGA that's on PCIe is a common use
case and one we want to support.  This subsystem started out
supporting embedded FPGAs so some things may need to adapt for PCIe.
The code on linux-next is a step towards that, but not a complete
solution.

Alan

>
> Best regards,
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
