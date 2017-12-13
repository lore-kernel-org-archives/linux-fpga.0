Return-Path: <SRS0=E9wj=DJ=free-electrons.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=E9wj=DJ=free-electrons.com=thomas.petazzoni@kernel.org>
Date: Wed, 13 Dec 2017 06:23:52 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] fpga: add simple userspace interface to trigger FPGA
 programming
Message-ID: <20171213062352.0e1042a4@windsurf.png.is.keysight.com>
In-Reply-To: <alpine.DEB.2.20.1712130626150.1@5af5ed6f0bd3>
References: <20171204154315.30128-1-thomas.petazzoni@free-electrons.com>
	<CANk1AXR==vnPTKA4EZZrebd9WViLiaZAxmnnSRyMPPBpJNA4pw@mail.gmail.com>
	<e730ef80-df19-3caa-68b2-02d6ef56f04e@gmail.com>
	<CANk1AXQ5ds=DY5cNrnzFthHBf6mRxSDuP4FoZWfM6hcXk9Nm=A@mail.gmail.com>
	<20171210234410.67e48bae@windsurf.lan>
	<alpine.DEB.2.20.1712130626150.1@5af5ed6f0bd3>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: yves.vandervennet@linux.intel.com
Cc: Alan Tull <atull@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

Hello,

On Wed, 13 Dec 2017 06:30:22 +0000 (UTC),
yves.vandervennet@linux.intel.com wrote:

> > 2. The device implemented in the FPGA is self-discoverable because it
> >    sits on a PCI bus, so there is no point in doing a static
> >    description of the device in a DT overlay.  
> How is the enumeration triggered?

I am manually forcing a rescan of the PCI bus by doing

 echo 1 > /sys/bus/pci/rescan

Right now my process is:

 1. Remove the PCIe device instantiated in the FPGA if it exists (the
    FPGA programming is preserved across a warm reset of the platform).
    Indeed, as was mentioned in the this thread earlier, things don't
    work really well if your PCIe device instantiated in the FPGA is
    enumerated, and the FPGA gets reprogrammed underneath.

 2. Program the FPGA using the additional sysfs file that my patch
    proposes to add.

 3. Rescan the PCI bus by echoing to /sys/bus/pci/rescan.

> Do you have any bridges to take care of?

I am not sure what you mean by bridge in this context. My use case is
pretty simple:

 - The SoC has a PCIE controller. The PCIE controller is a hard IP
   block in the SoC.

 - There is a FPGA on the board which is connected directly to the SoC
   over PCIe + over a control bus that allows programming of the FPGA.

Therefore, there is no bridge involved: once the FPGA is programmed,
the PCIE controller in the SoC can enumerate and see a new PCIE device,
which happens to be implemented in the FPGA.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
