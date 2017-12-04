Return-Path: <SRS0=wyNS=DA=free-electrons.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=wyNS=DA=free-electrons.com=thomas.petazzoni@kernel.org>
Date: Mon, 4 Dec 2017 16:58:35 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] fpga: add simple userspace interface to trigger FPGA
 programming
Message-ID: <20171204165835.33824aa8@windsurf.lan>
In-Reply-To: <CANk1AXR==vnPTKA4EZZrebd9WViLiaZAxmnnSRyMPPBpJNA4pw@mail.gmail.com>
References: <20171204154315.30128-1-thomas.petazzoni@free-electrons.com>
	<CANk1AXR==vnPTKA4EZZrebd9WViLiaZAxmnnSRyMPPBpJNA4pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Marek Vasut <marek.vasut@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

Hello,

On Mon, 4 Dec 2017 09:50:14 -0600, Alan Tull wrote:

> Hi Thomas,
> 
> The problem I see with this is that it's allowing userspace to switch
> out what's on the FPGA without controlling bridges and without
> unloading drivers first.

Correct. Do you have an idea on how to handle this? I'm not sure there's
an easy way to do that, but simply preventing people from programming
their FPGAs seems like a rather poor solution to the problem :-)

Right now, the way it works for me is that at boot time the FPGA is
unprogrammed so the initial PCI enumeration doesn't find any PCI
device. The FPGA is programmed, and I then force a PCI bus rescan
using /sys/bus/pci/rescan, which detects the device and probes the
driver.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
