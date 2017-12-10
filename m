Return-Path: <SRS0=9m2e=DG=free-electrons.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=9m2e=DG=free-electrons.com=thomas.petazzoni@kernel.org>
Date: Sun, 10 Dec 2017 23:42:11 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] fpga: add simple userspace interface to trigger FPGA
 programming
Message-ID: <20171210234211.6c704dfa@windsurf.lan>
In-Reply-To: <e730ef80-df19-3caa-68b2-02d6ef56f04e@gmail.com>
References: <20171204154315.30128-1-thomas.petazzoni@free-electrons.com>
	<CANk1AXR==vnPTKA4EZZrebd9WViLiaZAxmnnSRyMPPBpJNA4pw@mail.gmail.com>
	<e730ef80-df19-3caa-68b2-02d6ef56f04e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

Hello,

On Sat, 9 Dec 2017 10:05:55 -0800, Florian Fainelli wrote:

> > The problem I see with this is that it's allowing userspace to switch
> > out what's on the FPGA without controlling bridges and without
> > unloading drivers first.  
> 
> We can actually use the Linux device driver model to do that though.
> Assuming all peripherals behind the FPGA do have the FPGA manager's
> struct device as a parent (which they should),

Well in my setup, that isn't the case. The device implemented in the
FPGA is a PCIe endpoint, so its parent device from a device model point
of view if the PCIe root complex, which is a platform_device in the SoC.

So there is currently no connection between the PCIe endpoint
implemented in the FPGA, and the FPGA device itself.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
