Return-Path: <SRS0=BuYj=BL=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=BuYj=BL=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgHAM4q (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 1 Aug 2020 08:56:46 -0400
Date: Sat, 1 Aug 2020 14:56:57 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 00/17] Drop uses of pci_read_config_*() return value
Message-ID: <20200801125657.GA25391@nazgul.tnic>
References: <20200801112446.149549-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200801112446.149549-1-refactormyself@gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc: helgaas@kernel.org, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Joerg Roedel <joro@8bytes.org>, bjorn@helgaas.com, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-mtd@lists.infradead.org, iommu@lists.linux-foundation.org, linux-rdma@vger.kernel.org, linux-ide@vger.kernel.org, linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-gpio@vger.kernel.org, linux-fpga@vger.kernel.org, linux-edac@vger.kernel.org, dmaengine@vger.kernel.org, linux-crypto@vger.kernel.org, linux-atm-general@lists.sourceforge.net

On Sat, Aug 01, 2020 at 01:24:29PM +0200, Saheed O. Bolarinwa wrote:
> The return value of pci_read_config_*() may not indicate a device error.
> However, the value read by these functions is more likely to indicate
> this kind of error. This presents two overlapping ways of reporting
> errors and complicates error checking.

So why isn't the *value check done in the pci_read_config_* functions
instead of touching gazillion callers?

For example, pci_conf{1,2}_read() could check whether the u32 *value it
just read depending on the access method, whether that value is ~0 and
return proper PCIBIOS_ error in that case.

The check you're replicating

	if (val32 == (u32)~0)

everywhere, instead, is just ugly and tests a naked value ~0 which
doesn't mean anything...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
