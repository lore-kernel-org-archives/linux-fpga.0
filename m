Return-Path: <SRS0=Ty8l=BM=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Ty8l=BM=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47046 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726356AbgHBOxz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 2 Aug 2020 10:53:55 -0400
Received: by mail-qt1-f198.google.com with SMTP id m88so24937797qtd.15
        for <linux-fpga@vger.kernel.org>; Sun, 02 Aug 2020 07:53:51 -0700 (PDT)
Subject: Re: [RFC PATCH 00/17] Drop uses of pci_read_config_*() return value
References: <20200801112446.149549-1-refactormyself@gmail.com>
 <20200801125657.GA25391@nazgul.tnic>
From: Tom Rix <trix@redhat.com>
Message-ID: <6ecce8f3-350a-b5d5-82c9-4609f2298e61@redhat.com>
Date: Sun, 2 Aug 2020 07:53:46 -0700
MIME-Version: 1.0
In-Reply-To: <20200801125657.GA25391@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc: helgaas@kernel.org, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Joerg Roedel <joro@8bytes.org>, bjorn@helgaas.com, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-mtd@lists.infradead.org, iommu@lists.linux-foundation.org, linux-rdma@vger.kernel.org, linux-ide@vger.kernel.org, linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-gpio@vger.kernel.org, linux-fpga@vger.kernel.org, linux-edac@vger.kernel.org, dmaengine@vger.kernel.org, linux-crypto@vger.kernel.org, linux-atm-general@lists.sourceforge.net


On 8/1/20 5:56 AM, Borislav Petkov wrote:
> On Sat, Aug 01, 2020 at 01:24:29PM +0200, Saheed O. Bolarinwa wrote:
>> The return value of pci_read_config_*() may not indicate a device error.
>> However, the value read by these functions is more likely to indicate
>> this kind of error. This presents two overlapping ways of reporting
>> errors and complicates error checking.
> So why isn't the *value check done in the pci_read_config_* functions
> instead of touching gazillion callers?
>
> For example, pci_conf{1,2}_read() could check whether the u32 *value it
> just read depending on the access method, whether that value is ~0 and
> return proper PCIBIOS_ error in that case.
>
> The check you're replicating
>
> 	if (val32 == (u32)~0)
>
> everywhere, instead, is just ugly and tests a naked value ~0 which
> doesn't mean anything...
>
I agree, if there is a change, it should be in the pci_read_* functions.

Anything returning void should not fail and likely future users of the proposed change will not do the extra checks.

Tom
