Return-Path: <SRS0=h6Hu=NC=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=h6Hu=NC=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mx11lb.world4you.com ([81.19.149.121]:59948 "EHLO
        mx11lb.world4you.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeJVVx0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 22 Oct 2018 17:53:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 22 Oct 2018 15:34:44 +0200
From: Eric Schwarz <eas@sw-optimization.com>
Subject: Re: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled
 devices
In-Reply-To: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
References: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
Message-ID: <8fb9f5ddd5faa05f4351a8eaea3d77c6@sw-optimization.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Andreas Puhm <puhm@oregano.at>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fpga-owner@vger.kernel.org

Hi Andreas,

Am 22.10.2018 15:15, schrieb Andreas Puhm:

> Hi Moritz,
> 
> Thank you, for your fast response!
> Below you can find the updated patch.
> 
> --------------------------------------------------------------------
> Full description:
> The altera_cvp probe function only checks,
> if the Altera/Intel PCI device configuration space contains a vendor 
> specific entry (VSEC Capability Header 0x000b) at offset 0x200.
> But the probe function does not verify, if the PCI device (and further 
> the FPGA),
> for which it has been called, actually supports the 
> Configure-via-Protocol feature.
> 
> The PCI device (FPGA) can explicitly disable the Configur-via-Protocol 
> (CvP) feature by setting the CVP_EN bit, index 20 of CVP_STATUS 
> register, to '0'.
> As the altera_cvp probe function does not check this it registers the 
> device in any way.
> At this point, the altera_cvp module cannot be used to program this 
> device via CvP.
> In addition no other module can use the device, as it is still 
> registered by altera_cvp.
> 
> Keywords: altera_cvp module, PCI, Configure-via-Protocol
> 
> Kernel version: problem occured with v4.15, should occur from 4.14+
> 
> Instructions to reproduce:
> Proper hardware is necessary to reproduce this, i.e., FPGA with 
> instantiated Altera/Intel PCIe IP Core with disabled CvP feature.
> 
> Workaround:
> It is possible to circumvent this problem by manually unloading or 
> blacklisting the altera_cvp module.
> --------------------------------------------------------------------
> Suggested Patch:
> This patch was successfully build and tested for 4.15 and 4.18
> 
> The patch is based on: 
> git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tag/?h=v4.18
> 
> Subject: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled 
> devices
> 
> The altera-cvp probe function now verifies, that the PCI device 
> supports
> the CvP feature, before it registers the device.
> This is done by reading the CVP_EN bit,
> Bit 20 of the CVP_STATUS register (@ PCI Config Address 0x21C).
> 
> If this bit is '1' (CvP enabled), altera-cvp will register the device
> for further interaction.
> If this bit is '0' (CvP disabled), altera-cvp will not register the 
> device.
> 
> Signed-off-by: Andreas Puhm <puhm@oregano.at>
> ---
> drivers/fpga/altera-cvp.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 7fa793672a7a..838abcfca0fb 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -403,6 +403,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> struct altera_cvp_conf *conf;
> struct fpga_manager *mgr;
> u16 cmd, val;
> +    u32 val32;

Please do not use variable size in variable name.

> int ret;
> 
> /*
> @@ -416,6 +417,14 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> return -ENODEV;
> }
> 
> +    pci_read_config_dword(pdev, VSE_CVP_STATUS, &val32);
> +    if (!(val32 & VSE_CVP_STATUS_CVP_EN)) {
> +        dev_err(&pdev->dev,
> +            "CVP is disabled for this device: CVP_STATUS Reg 0x%x\n",
> +            val32);
> +        return -ENODEV;
> +    }
> +
> conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
> if (!conf)
> return -ENOMEM;
> --
> 
> With best regards,
> Andreas Puhm <puhm@oregano.at>

Cheers
Eric
