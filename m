Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171211220545.GA12954@tyrael.ni.corp.natinst.com>
References: <20171204154315.30128-1-thomas.petazzoni@free-electrons.com>
 <CANk1AXR==vnPTKA4EZZrebd9WViLiaZAxmnnSRyMPPBpJNA4pw@mail.gmail.com>
 <e730ef80-df19-3caa-68b2-02d6ef56f04e@gmail.com> <CANk1AXQ5ds=DY5cNrnzFthHBf6mRxSDuP4FoZWfM6hcXk9Nm=A@mail.gmail.com>
 <20171210234410.67e48bae@windsurf.lan> <818e6012-6919-7428-1d05-79d5b89a5e1d@gmail.com>
 <20171211220545.GA12954@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 11 Dec 2017 17:32:10 -0600
Message-ID: <CANk1AXTKyUj6kRA_qD7hf7fuGW184Z7a8z6LGqjT8vd8MFnO7g@mail.gmail.com>
Subject: Re: [PATCH] fpga: add simple userspace interface to trigger FPGA programming
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fpga@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Dec 11, 2017 at 4:05 PM, Moritz Fischer <mdf@kernel.org> wrote:
> On Sun, Dec 10, 2017 at 02:59:36PM -0800, Florian Fainelli wrote:
>>
>>
>> On 12/10/2017 02:44 PM, Thomas Petazzoni wrote:
>> > Hello,
>> >
>> > On Sat, 9 Dec 2017 22:03:06 -0600, Alan Tull wrote:
>> >
>> >>> We can actually use the Linux device driver model to do that though.
>> >>> Assuming all peripherals behind the FPGA do have the FPGA manager's
>> >>> struct device as a parent (which they should), when there is a bistream
>> >>> load request, we ought to be able to teardown all of these child struct
>> >>> device's and their corresponding drivers (unbind), load the bistream,
>> >>> and then rebind the drivers accordingly.
>> >>
>> >> Hi Florain,
>> >>
>> >> FPGA regions are a way of handling all that plus the bridges [1] or
>> >> are you proposing something else?  An FPGA region knows what manager
>> >> to use and what bridges (if any) needs to be disabled while
>> >> programming is happening.  Applying a DT overlay targeting a FPGA
>> >> region is used to program the FPGA.
>> >
>> > I thought my initial patch made it clear: DT overlays are not an
>> > applicable solution for my use case, for two reasons:
>> >
>> >  1. My platform doesn't use Device Tree at all.
>> >
>> >  2. The device implemented in the FPGA is self-discoverable because it
>> >     sits on a PCI bus, so there is no point in doing a static
>> >     description of the device in a DT overlay.
>>
>> Agreed, sorry for side tracking the discussion a bit on that topic.
>
> I do agree that wee need to find a solution for this. We should not
> force people to use DT overlays in a system that is discoverable,
> or out of tree hacks.
>
>>
>> >
>> > So, solutions based on DT overlays are quite irrelevant for my use
>> > case. Am I missing something here ?
>>
>> I don't think you are, in fact, as it stands today, unless your FPGA has
>> a bistream which is already loaded, in which case you don't really need
>> the FPGA manager framework at all, this framework is completely useless
>> in offering people the ability to load bistreams on non-DT enabled
>> platforms without resorting to out of tree hacks like this one for instance:
>>
>> https://github.com/ffainelli/linux/commit/78a4824165d7bf627c1b2dbb645ce013185331de

I'd like to call attention to the history of the FPGA framework.  I've
posted lots of attempts at userspace interfaces on the list, using
sysfs or configfs mainly.  One by one they have all have gotten shot
down :)  This led to one central thing about this framework: it
separates the devices from the interface.  If someone can come up with
an upper layer that calls the framework functions, it can work on a
broad set of FPGAs.  That's the real usefulness of this useless
framework.

A second piece I want to mention is that I want to urge people to
think in terms of FPGA regions rather than managers.  If you have a
region, that can point to a manager only or to a manager and
bridge(s).  So if you can add an interface that communicates with a
region, it's can support a broader range of devices.  So I'm not
looking for something hooked directly into fpga-mgr.c.

The current code in linux-next separates FPGA region common code from
its DT dependencies.  This enables developing layers to use PCIe
FPGA's using FPGA regions without DT.  Currently the first user of
this is the DFL patchset (which isn't going to suit everybody).  If
someone has a good idea for handling full reconfiguration on PCIe
FPGAs without DT, they can base it on that code.  And yes, I tried to
add an interface to that FPGA region code when I was writing these
changes and that interface also got shot down (it was DT so no huge
loss in this discussion).  Plus the RFC that I followed it up with got
total silence on the mailing list.  It turns out it's hard to get FPGA
people to agree on things :)

>>
>> So what needs to be done so we can allow people to take full advantage
>> of the fact that FPGAs are (re)programmable, even when the platform does
>> not use DT?
>
>
> I like your suggestion of tying into the device model, to tear down
> everything underneath.

Me too.

>
> Would making the PCIe root complex a child to a FPGA region work? Seems
> clumsy. Do we have other examples of devices reloading firmware
> triggered by userland?
>
> - Moritz
