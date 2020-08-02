Return-Path: <SRS0=Ty8l=BM=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Ty8l=BM=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:58748 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbgHBUSo (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 2 Aug 2020 16:18:44 -0400
Date: Sun, 2 Aug 2020 22:18:06 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 00/17] Drop uses of pci_read_config_*() return value
Message-ID: <20200802201806.GA24437@nazgul.tnic>
References: <20200802184648.GA23190@nazgul.tnic>
 <20200802191406.GA248232@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200802191406.GA248232@bjorn-Precision-5520>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Saheed Bolarinwa <refactormyself@gmail.com>, trix@redhat.com, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Joerg Roedel <joro@8bytes.org>, bjorn@helgaas.com, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-mtd@lists.infradead.org, iommu@lists.linux-foundation.org, linux-rdma@vger.kernel.org, linux-ide@vger.kernel.org, linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-gpio@vger.kernel.org, linux-fpga@vger.kernel.org, linux-edac@vger.kernel.org, dmaengine@vger.kernel.org, linux-crypto@vger.kernel.org, linux-atm-general@lists.sourceforge.net

On Sun, Aug 02, 2020 at 02:14:06PM -0500, Bjorn Helgaas wrote:
> Wait, I'm not convinced yet.  I know that if a PCI read fails, you
> normally get ~0 data because the host bridge fabricates it to complete
> the CPU load.
> 
> But what guarantees that a PCI config register cannot contain ~0?

Well, I don't think you can differentiate that case, right?

I guess this is where the driver knowledge comes into play: if the read
returns ~0, the pci_read_config* should probably return in that case
something like:

	PCIBIOS_READ_MAYBE_FAILED

to denote it is all 1s and then the caller should be able to determine,
based on any of domain:bus:slot.func and whatever else the driver knows
about its hardware, whether the 1s are a valid value or an error.
Hopefully.

Or something better of which I cannot think of right now...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
