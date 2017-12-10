Return-Path: <SRS0=Cl42=DG=gmail.com=f.fainelli@kernel.org>
Return-Path: <SRS0=Cl42=DG=gmail.com=f.fainelli@kernel.org>
Subject: Re: [PATCH] fpga: add simple userspace interface to trigger FPGA
 programming
References: <20171204154315.30128-1-thomas.petazzoni@free-electrons.com>
 <CANk1AXR==vnPTKA4EZZrebd9WViLiaZAxmnnSRyMPPBpJNA4pw@mail.gmail.com>
 <e730ef80-df19-3caa-68b2-02d6ef56f04e@gmail.com>
 <CANk1AXQ5ds=DY5cNrnzFthHBf6mRxSDuP4FoZWfM6hcXk9Nm=A@mail.gmail.com>
 <20171210234410.67e48bae@windsurf.lan>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <818e6012-6919-7428-1d05-79d5b89a5e1d@gmail.com>
Date: Sun, 10 Dec 2017 14:59:36 -0800
MIME-Version: 1.0
In-Reply-To: <20171210234410.67e48bae@windsurf.lan>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>



On 12/10/2017 02:44 PM, Thomas Petazzoni wrote:
> Hello,
> 
> On Sat, 9 Dec 2017 22:03:06 -0600, Alan Tull wrote:
> 
>>> We can actually use the Linux device driver model to do that though.
>>> Assuming all peripherals behind the FPGA do have the FPGA manager's
>>> struct device as a parent (which they should), when there is a bistream
>>> load request, we ought to be able to teardown all of these child struct
>>> device's and their corresponding drivers (unbind), load the bistream,
>>> and then rebind the drivers accordingly.  
>>
>> Hi Florain,
>>
>> FPGA regions are a way of handling all that plus the bridges [1] or
>> are you proposing something else?  An FPGA region knows what manager
>> to use and what bridges (if any) needs to be disabled while
>> programming is happening.  Applying a DT overlay targeting a FPGA
>> region is used to program the FPGA.
> 
> I thought my initial patch made it clear: DT overlays are not an
> applicable solution for my use case, for two reasons:
> 
>  1. My platform doesn't use Device Tree at all.
> 
>  2. The device implemented in the FPGA is self-discoverable because it
>     sits on a PCI bus, so there is no point in doing a static
>     description of the device in a DT overlay.

Agreed, sorry for side tracking the discussion a bit on that topic.

> 
> So, solutions based on DT overlays are quite irrelevant for my use
> case. Am I missing something here ?

I don't think you are, in fact, as it stands today, unless your FPGA has
a bistream which is already loaded, in which case you don't really need
the FPGA manager framework at all, this framework is completely useless
in offering people the ability to load bistreams on non-DT enabled
platforms without resorting to out of tree hacks like this one for instance:

https://github.com/ffainelli/linux/commit/78a4824165d7bf627c1b2dbb645ce013185331de

So what needs to be done so we can allow people to take full advantage
of the fact that FPGAs are (re)programmable, even when the platform does
not use DT?
-- 
Florian
