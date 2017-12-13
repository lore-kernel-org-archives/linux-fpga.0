Return-Path: <SRS0=xmgw=DI=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=xmgw=DI=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:14643 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752218AbdLLT06 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 12 Dec 2017 14:26:58 -0500
Date: Wed, 13 Dec 2017 06:30:22 +0000 (UTC)
From: yves.vandervennet@linux.intel.com
Subject: Re: [PATCH] fpga: add simple userspace interface to trigger FPGA
 programming
In-Reply-To: <20171210234410.67e48bae@windsurf.lan>
Message-ID: <alpine.DEB.2.20.1712130626150.1@5af5ed6f0bd3>
References: <20171204154315.30128-1-thomas.petazzoni@free-electrons.com>        <CANk1AXR==vnPTKA4EZZrebd9WViLiaZAxmnnSRyMPPBpJNA4pw@mail.gmail.com>        <e730ef80-df19-3caa-68b2-02d6ef56f04e@gmail.com>        <CANk1AXQ5ds=DY5cNrnzFthHBf6mRxSDuP4FoZWfM6hcXk9Nm=A@mail.gmail.com>
 <20171210234410.67e48bae@windsurf.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Alan Tull <atull@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>



On Sun, 10 Dec 2017, Thomas Petazzoni wrote:

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

Thomas,

> I thought my initial patch made it clear: DT overlays are not an
> applicable solution for my use case, for two reasons:
>
> 1. My platform doesn't use Device Tree at all.
>
>
> 2. The device implemented in the FPGA is self-discoverable because it
>    sits on a PCI bus, so there is no point in doing a static
>    description of the device in a DT overlay.
How is the enumeration triggered? Do you have any bridges to take care of?

>
> So, solutions based on DT overlays are quite irrelevant for my use
> case. Am I missing something here ?

Cheers
Yves

>
> Best regards,
>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
