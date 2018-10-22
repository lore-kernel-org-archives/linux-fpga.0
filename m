Return-Path: <SRS0=VnBr=NC=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=VnBr=NC=ettus.com=moritz.fischer@kernel.org>
Date: Mon, 22 Oct 2018 03:33:24 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [Bug] altera_cvp registers a PCI device (Altera/Intel FPGA)
 without verifying that it supports CVP
Message-ID: <20181022103324.GA6888@archbook>
References: <2c6313a3f7c04b70b8a06a50934fe27a@SRV177.busymouse24.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c6313a3f7c04b70b8a06a50934fe27a@SRV177.busymouse24.de>
To: Andreas Puhm <puhm@oregano.at>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Andreas,

On Fri, Oct 19, 2018 at 03:53:02PM +0000, Andreas Puhm wrote:
> Hello,
> 
> I hope the following information is descriptive enough.
> If this is no the case, I will provide further details.
> 
> --------------------------------------------------------------------
> Full description:
> The altera_cvp probe function only checks, 
> if the Altera/Intel PCI device configuration space contains a vendor specific entry (VSEC Capability Header 0x000b) at offset 0x200.
>  But the probe function does not verify, if the PCI device (and further the FPGA), 
> for which it has been called, actually supports the Configure-via-Protocol feature.
> 
> The PCI device (FPGA) can explicitly disable the Configur-via-Protocol (CvP) feature by setting the CVP_EN bit, index 20 of CVP_STATUS register, to '0'. 
> As the altera_cvp probe function does not check this it registers the device in any way. 
> At this point, the altera_cvp module cannot be used to program this device via CvP. 
> In addition no other module can use the device, as it is still registered by altera_cvp.
> 
> Keywords: altera_cvp module, PCI, Configure-via-Protocol
> 
> Kernel version: problem occured with v4.15, should occur from 4.14+
> 
> Instructions to reproduce: 
> Proper hardware is necessary to reproduce this, i.e., FPGA with instantiated Altera/Intel PCIe IP Core with disabled CvP feature.
> 
> Workaround:
> It is possible to circumvent this problem by manually unloading or blacklisting the altera_cvp module.
> 
> Suggested Patch:
> This patch was successfully build and tested for 4.15 and 4.18
> 
> Subject: [PATCH] register device only, if it supports CvP operation

Could you make this: 'fpga: altera_cvp: Conditionalize registration' or
something along those lines?
> 
> This patch is based on: git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tag/?h=v4.18

Put some of the extensive description you made above in the git commit
message, please, such that future us will know why the change was made
:)

Thanks for your patch,

Moritz
