Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171214062752.0c86a658@windsurf.png.is.keysight.com>
References: <20171204154315.30128-1-thomas.petazzoni@free-electrons.com>
 <CANk1AXR==vnPTKA4EZZrebd9WViLiaZAxmnnSRyMPPBpJNA4pw@mail.gmail.com>
 <e730ef80-df19-3caa-68b2-02d6ef56f04e@gmail.com> <CANk1AXQ5ds=DY5cNrnzFthHBf6mRxSDuP4FoZWfM6hcXk9Nm=A@mail.gmail.com>
 <20171210234410.67e48bae@windsurf.lan> <alpine.DEB.2.20.1712130626150.1@5af5ed6f0bd3>
 <20171213062352.0e1042a4@windsurf.png.is.keysight.com> <CANk1AXT_Nuu-rvt8DhC7YgXxKV0Ffd76EKU35ezxfTvau1BJFw@mail.gmail.com>
 <20171214062752.0c86a658@windsurf.png.is.keysight.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 14 Dec 2017 14:10:05 -0600
Message-ID: <CANk1AXTfqNh3n5fA_QuGExRERibTgxrFkJpXMKeYHDX+JLuMPg@mail.gmail.com>
Subject: Re: [PATCH] fpga: add simple userspace interface to trigger FPGA programming
Content-Type: text/plain; charset="UTF-8"
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Yves Vandervennet <yves.vandervennet@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Dec 13, 2017 at 11:27 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> On Wed, 13 Dec 2017 09:59:55 -0600, Alan Tull wrote:
>
>> An FPGA bridge is something that connects the FPGA fabric to the world
>> outside the FPGA.  Not every setup will have this.  During programming
>> the bridge can be disabled to protect the outside world from bad
>> randomness (the fabric may wiggle some).   It the case of full
>> reconfiguration, it would be a hardware bridge/bridges on the bus.  In
>> the case of partial reconfiguration, it would be a freeze bridge
>> surrounding the partial reconfiguration region since the same manager
>> could be used to reprogram each of several regions, but each will have
>> their own bridge.  It sounds like in your case, it's full
>> reconfiguration and either there's no bridge or it's left enabled or
>> the programming code is handling the bridge or you're enabling the
>> bridge after programming.  FPGA regions were created as a way of
>> allowing an interface to potentially work for both setups that have
>> bridges or don't have them.  This is all just to give some context as
>> to why interfaces should be added on top of a region rather than a
>> manager.  So people could use the interface whether they have a bridge
>> or not.
>
> Hum, OK. I'm not sure to grasp all the details here. In my use case, I
> don't have anything that looks like a software-controlled FPGA bridge.
> There is a memory-mapped CPLD, which provides some registers that the
> SoC uses to program the FPGA. Based on those register writes, the CPLD
> programs the FPGA.
>
>> > My use case is
>> > pretty simple:
>> >
>> >  - The SoC has a PCIE controller. The PCIE controller is a hard IP
>> >    block in the SoC.
>> >
>> >  - There is a FPGA on the board which is connected directly to the SoC
>> >    over PCIe + over a control bus that allows programming of the FPGA.
>>
>> Just to be clear, the programming is not through PCIe, right?
>
> Correct, there's a side-band channel in the form of a memory-mapped
> CPLD.
>
>> > Therefore, there is no bridge involved: once the FPGA is programmed,
>> > the PCIE controller in the SoC can enumerate and see a new PCIE device,
>> > which happens to be implemented in the FPGA.
>>
>> Yes, full reconfiguration of a FPGA that's on PCIe is a common use
>> case and one we want to support.  This subsystem started out
>> supporting embedded FPGAs so some things may need to adapt for PCIe.
>> The code on linux-next is a step towards that, but not a complete
>> solution.
>
> Could you summarize what is in linux-next and how it is a step towards
> that, and what is missing ?

fpga-region.c gains a fpga_region_register() function [1] for creating
regions, similar to the register function for bridges and managers.  A
new file of-fpga-region.c uses fpga_region_register to create a FPGA
region under device tree control.  The intent is that other code could
create fpga regions for their (non-DT) use cases and be more reusable
than if interfaces were added to FPGA manager [2].

In your case a layer could be written that would create a region which
would would just have the manager, plus an interface to trigger
programming, and some code to kick off enumerating/rescan after
successful programming.  If it were done right, someone who has a
similar use case but a different FPGA device could use that same code
but with a different manager and add a bridge if they need it.  That's
the high level view.  I understand that the DFL's use case is not
close enough to your to work for you, but they are an another example
of a layer that is creating regions, managers, bridges, plus doing
enumeration.  Anyway, I'm not suggesting that you use the DFL code,
I'm just trying to explain that now there's two upper layers that have
been implemented sitting on top of FPGA regions.  The end goal is I'd
like to see interfaces added that could be used on multiple FPGA
devices where the use case is similar.

Alan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/fpga/fpga-region.txt

[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/fpga/overview.txt


>
> Thanks a lot for your feedback,is
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
