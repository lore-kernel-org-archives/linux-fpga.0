Return-Path: <SRS0=BXsM=ND=denx.de=agust@kernel.org>
Return-Path: <SRS0=BXsM=ND=denx.de=agust@kernel.org>
Date: Tue, 23 Oct 2018 18:26:49 +0200
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled
 devices
Message-ID: <20181023182649.047f1f93@crub>
In-Reply-To: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
References: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andreas Puhm <puhm@oregano.at>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Andreas,

On Mon, 22 Oct 2018 13:15:34 +0000
Andreas Puhm puhm@oregano.at wrote:
...
>Full description:
>The altera_cvp probe function only checks, 
>if the Altera/Intel PCI device configuration space contains a vendor
>specific entry (VSEC Capability Header 0x000b) at offset 0x200.
> But the probe function does not verify, if the PCI device (and further
>the FPGA), for which it has been called, actually supports the Configure-
>via-Protocol feature.
>
>The PCI device (FPGA) can explicitly disable the Configur-via-Protocol
>(CvP) feature by setting the CVP_EN bit, index 20 of CVP_STATUS register,
>to '0'.
>As the altera_cvp probe function does not check this it registers the
>device in any way.

The CvP docs says that on some FPGAs (e.g. Arria 10) the assertion of CVP
status can take up to 500ms. However it is not clear whether this delay
might be required after peripheral image configuration and after PCIe
link activation. The diagram describing configuration sequence suggests
that CVP_EN should be polled until it is asserted. I can imaging the
situation that this bit is still not asserted when the device is being
probed. Maybe we should better defer device probing if CVP_EN bit is
cleared? When deferred probing fails again and sufficient period for
CVP_EN bit assertion elapsed, then stop deferred probing and return
-ENODEV?

Thanks,

Anatolij
