MIME-Version: 1.0
In-Reply-To: <CANk1AXTUYTEJgWneS1n2WwaqyOAmohYFFoXOU51XX6j02=q9xw@mail.gmail.com>
References: <20180815220958.3606-1-atull@kernel.org>
	<1841468.1pWPcT6Du7@harkonnen>
	<20180816220034.GA4431@archbook>
	<2759044.uKe7sI2ItL@pcbe13614>
	<CANk1AXTUYTEJgWneS1n2WwaqyOAmohYFFoXOU51XX6j02=q9xw@mail.gmail.com>
Date: Fri, 17 Aug 2018 08:22:56 -0700
Message-ID: <CAJYdmeNJwkr3dLpdDDL-ER=X+TJgB+7Kf2U0VVQbhUjQE8TBMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpga: add FPGA manager debugfs
From: Moritz Fischer <moritz.fischer.private@gmail.com>
Content-Type: text/plain; charset="UTF-8"
To: Alan Tull <atull@kernel.org>
Cc: Federico Vaga <federico.vaga@cern.ch>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Dinh Nguyen <dinguyen@kernel.org>, Appana Durga Kedareswara Rao <appanad@xilinx.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Alan Tull <atull@opensource.altera.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan, Federico,

On Fri, Aug 17, 2018 at 6:19 AM, Alan Tull <atull@kernel.org> wrote:
> On Fri, Aug 17, 2018, 2:00 AM Federico Vaga <federico.vaga@cern.ch> wrote:
>>
>> Hi Mortiz,
>>
>> I'm not 100% into the problem to understand all cases. I'm putting on the
>> table the point of view, mainly, of an user. If you say there are problems
>> here or there I believe you. At the beginning, you did not say that this
>> interface may introduce problems (and I'm interested in those problems
>> since I
>> implemented one and we are using it), but that you fear that it becomes
>> the
>> default (usually, being a default is a good thing).
>>
>> Since you and Alan are working on this for a long time, you can read each
>> other mind, but I need a more verbose email to understand ^_^'
>>
>> Of course the interface must be safe, I totally agree. In order to make me
>> understand what are the issues, can you list some of them?

Say you have kernel drivers (a network driver in the FPGA, or an I2C controller)
for example bound to hardware on a MMIO bus in the the FPGA.
You reprogram the FPGA using the debugfs interface, and the drivers don't get
unloaded correctly, the driver will try to access the registers and depending
on your system / bus either give you bad values or lock up.
Now userland locked up your system. Bad.

I'm not saying it isn't possible to do this if you're careful, of
course you could
first unload the drivers using rrmod and it would work just fine.

I just feel an interface like this might make it easier to create the
wrong design.
I've seen plenty of Application notes from vendors where they literally did
"cat foo.bin > /dev/fpga" followed by mmap(/dev/mem...).

>
>
> Before we repeat what the doc l posted says, could you look at it and
> comment on what I'm not saying there?
>
> https://lkml.org/lkml/2018/8/15/525

Alan, maybe I didn't express myself well. I'm fine with the debugfs interface
as a debug interface, just not for general usage ;-) I think your document is
clear on that.

Thanks,

Moritz
