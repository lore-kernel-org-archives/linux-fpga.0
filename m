Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <e730ef80-df19-3caa-68b2-02d6ef56f04e@gmail.com>
References: <20171204154315.30128-1-thomas.petazzoni@free-electrons.com>
 <CANk1AXR==vnPTKA4EZZrebd9WViLiaZAxmnnSRyMPPBpJNA4pw@mail.gmail.com> <e730ef80-df19-3caa-68b2-02d6ef56f04e@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Sat, 9 Dec 2017 22:03:06 -0600
Message-ID: <CANk1AXQ5ds=DY5cNrnzFthHBf6mRxSDuP4FoZWfM6hcXk9Nm=A@mail.gmail.com>
Subject: Re: [PATCH] fpga: add simple userspace interface to trigger FPGA programming
Content-Type: text/plain; charset="UTF-8"
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

On Sat, Dec 9, 2017 at 12:05 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
> On 12/04/2017 07:50 AM, Alan Tull wrote:
>> On Mon, Dec 4, 2017 at 9:43 AM, Thomas Petazzoni
>> <thomas.petazzoni@free-electrons.com> wrote:
>>> The current FPGA subsystem only allows programming the FPGA bitstream
>>> through Device Tree overlays. This assumes that the devices inside the
>>> FPGA are described through a Device Tree.
>>>
>>> However, some platforms have their FPGA connected to the main CPU over
>>> PCIe and the devices in the FPGA are therefore dynamically
>>> discoverable using the normal PCIe enumeration mechanisms. There is
>>> therefore no Device Tree overlay describing the devices in the
>>> FPGA. Furthermore, on my platform (an old SH7786), there is no Device
>>> Tree at all, as there is no support for Device Tree for this SoC.
>>>
>>> Adding a userspace interface to trigger the programming of the FPGA
>>> has already been requested in the past (see [1]) showing that there is
>>> a need for such a feature.
>>>
>>> This commit therefore introduces a very simple interface, in the form
>>> of a "load" sysfs file. Writing the name of the firmware file to
>>> program into the FPGA to this "load" file triggers the programming
>>> process.
>>>
>>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/443034.html
>>>
>>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>
>> Hi Thomas,
>>
>> The problem I see with this is that it's allowing userspace to switch
>> out what's on the FPGA without controlling bridges and without
>> unloading drivers first.
>
> We can actually use the Linux device driver model to do that though.
> Assuming all peripherals behind the FPGA do have the FPGA manager's
> struct device as a parent (which they should), when there is a bistream
> load request, we ought to be able to teardown all of these child struct
> device's and their corresponding drivers (unbind), load the bistream,
> and then rebind the drivers accordingly.

Hi Florain,

FPGA regions are a way of handling all that plus the bridges [1] or
are you proposing something else?  An FPGA region knows what manager
to use and what bridges (if any) needs to be disabled while
programming is happening.  Applying a DT overlay targeting a FPGA
region is used to program the FPGA.  After programming, the child
nodes of the region are added to the DT and drivers get probed.  The
interface I've been using to apply overlays is Pantelis' configfs DT
overlay interface [2] which hasn't been accepted upstream and probably
won't for the foreseeable future [3] [4].

Alan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/fpga/fpga-region.txt

[2] https://github.com/pantoniou/linux-beagle-track-mainline/commit/4f0ed58518749c1a8ce8999cb615b1eb04b8c035

[3] https://lkml.org/lkml/2017/10/18/609

[4] https://lkml.org/lkml/2017/12/6/264

>
> In case you have a DT enabled system, the parent/child relationship is
> established through Device Tree, in case you don't, you should be able
> to use bus notifiers to establish that parenting.
>
> Thoughts?



> --
> Florian
