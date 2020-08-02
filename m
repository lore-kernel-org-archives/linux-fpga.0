Return-Path: <SRS0=Ty8l=BM=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Ty8l=BM=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgHBS1f (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 2 Aug 2020 14:27:35 -0400
Subject: Re: [RFC PATCH 00/17] Drop uses of pci_read_config_*() return value
References: <20200801112446.149549-1-refactormyself@gmail.com>
 <20200801125657.GA25391@nazgul.tnic>
From: Saheed Bolarinwa <refactormyself@gmail.com>
Message-ID: <b720aa44-895a-203b-e220-ecdb3acd9278@gmail.com>
Date: Sun, 2 Aug 2020 19:28:00 +0200
MIME-Version: 1.0
In-Reply-To: <20200801125657.GA25391@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, trix@redhat.com
Cc: helgaas@kernel.org, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Joerg Roedel <joro@8bytes.org>, bjorn@helgaas.com, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-mtd@lists.infradead.org, iommu@lists.linux-foundation.org, linux-rdma@vger.kernel.org, linux-ide@vger.kernel.org, linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-gpio@vger.kernel.org, linux-fpga@vger.kernel.org, linux-edac@vger.kernel.org, dmaengine@vger.kernel.org, linux-crypto@vger.kernel.org, linux-atm-general@lists.sourceforge.net


On 8/1/20 2:56 PM, Borislav Petkov wrote:
> On Sat, Aug 01, 2020 at 01:24:29PM +0200, Saheed O. Bolarinwa wrote:
>> The return value of pci_read_config_*() may not indicate a device error.
>> However, the value read by these functions is more likely to indicate
>> this kind of error. This presents two overlapping ways of reporting
>> errors and complicates error checking.
> So why isn't the *value check done in the pci_read_config_* functions
> instead of touching gazillion callers?
Because the value ~0 has a meaning to some drivers and only
drivers have this knowledge. For those cases more checks will
be needed to ensure that it is an error that has actually
happened.
> For example, pci_conf{1,2}_read() could check whether the u32 *value it
> just read depending on the access method, whether that value is ~0 and
> return proper PCIBIOS_ error in that case.

The primary goal is to make pci_config_read*() return void, so
that there is *only* one way to check for error i.e. through the
obtained value.
Again, only the drivers can determine if ~0 is a valid value. This
information is not available inside pci_config_read*().

- Saheed
