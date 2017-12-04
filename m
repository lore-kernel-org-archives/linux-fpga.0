Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171204164901.GA29779@tyrael.ni.corp.natinst.com>
References: <20171204154315.30128-1-thomas.petazzoni@free-electrons.com>
 <CANk1AXR==vnPTKA4EZZrebd9WViLiaZAxmnnSRyMPPBpJNA4pw@mail.gmail.com>
 <20171204165835.33824aa8@windsurf.lan> <CANk1AXQJwnMzoOWkOwRh0YnEGXaE26zHdiRB_SsQHxFgd=+NxQ@mail.gmail.com>
 <20171204164901.GA29779@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 4 Dec 2017 11:30:36 -0600
Message-ID: <CANk1AXQ368P2En4VJMFrU88osB4A2kTkCWvq0SgCyEMxz9uUqQ@mail.gmail.com>
Subject: Re: [PATCH] fpga: add simple userspace interface to trigger FPGA programming
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fpga@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Marek Vasut <marek.vasut@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Dec 4, 2017 at 10:49 AM, Moritz Fischer <mdf@kernel.org> wrote:
> On Mon, Dec 04, 2017 at 10:25:47AM -0600, Alan Tull wrote:
>> On Mon, Dec 4, 2017 at 9:58 AM, Thomas Petazzoni
>> <thomas.petazzoni@free-electrons.com> wrote:
>> > Hello,
>> >
>> > On Mon, 4 Dec 2017 09:50:14 -0600, Alan Tull wrote:
>> >
>> >> Hi Thomas,
>> >>
>> >> The problem I see with this is that it's allowing userspace to switch
>> >> out what's on the FPGA without controlling bridges and without
>> >> unloading drivers first.
>> >
>> > Correct. Do you have an idea on how to handle this? I'm not sure there's
>> > an easy way to do that, but simply preventing people from programming
>> > their FPGAs seems like a rather poor solution to the problem :-)
>>
>> Yes.  It's not an easy one to solve or we would have added something
>> like this by now.  There is one large patchset that is currently under
>> review.
>> It's called "Intel FPGA Drivers"[1] but I don't see anything Intel
>> specific in it.  It's dependent on the FPGA having a base image that
>> contains structures for some enumeration.  When the PR regions are
>> programmed, the FPGA based hardware in those regions also have similar
>> structures.  The first iteration of this is PCIe based.
>
> The difference here is, that in Thomas' case there's no base device to
> bind to, i.e. there's no base image in the FPGA the first time around.
>
> In the Intel FPGA case there's something that connects to the bus that
> the FPGA manager driver can bind to.
>

Yeah, I know. I'm mentioning it only because it is the only pcie based
non-DT solution that has been offered so far that handles the bridges
and drivers.

>> Others have suggested using device tree on platforms that aren't
>> normally using device tree.  If I had time I'd be experimenting with
>> that.
>>
>
> Moritz
