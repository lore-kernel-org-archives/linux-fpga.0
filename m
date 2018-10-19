Return-Path: <SRS0=lgA+=M7=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=lgA+=M7=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mx01.busymouse24.de ([83.246.107.19]:53149 "EHLO
        mx01.busymouse24.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeJTAFw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 19 Oct 2018 20:05:52 -0400
From: Andreas Puhm <puhm@oregano.at>
Subject: [Bug] altera_cvp registers a PCI device (Altera/Intel FPGA) without
 verifying that it supports CVP
Date: Fri, 19 Oct 2018 15:53:02 +0000
Message-ID: <2c6313a3f7c04b70b8a06a50934fe27a@SRV177.busymouse24.de>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello,

I hope the following information is descriptive enough.
If this is no the case, I will provide further details.

--------------------------------------------------------------------
Full description:
The altera_cvp probe function only checks, 
if the Altera/Intel PCI device configuration space contains a vendor specific entry (VSEC Capability Header 0x000b) at offset 0x200.
 But the probe function does not verify, if the PCI device (and further the FPGA), 
for which it has been called, actually supports the Configure-via-Protocol feature.

The PCI device (FPGA) can explicitly disable the Configur-via-Protocol (CvP) feature by setting the CVP_EN bit, index 20 of CVP_STATUS register, to '0'. 
As the altera_cvp probe function does not check this it registers the device in any way. 
At this point, the altera_cvp module cannot be used to program this device via CvP. 
In addition no other module can use the device, as it is still registered by altera_cvp.

Keywords: altera_cvp module, PCI, Configure-via-Protocol

Kernel version: problem occured with v4.15, should occur from 4.14+

Instructions to reproduce: 
Proper hardware is necessary to reproduce this, i.e., FPGA with instantiated Altera/Intel PCIe IP Core with disabled CvP feature.

Workaround:
It is possible to circumvent this problem by manually unloading or blacklisting the altera_cvp module.

Suggested Patch:
This patch was successfully build and tested for 4.15 and 4.18

Subject: [PATCH] register device only, if it supports CvP operation

This patch is based on: git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tag/?h=v4.18

Signed-off-by: Andreas Puhm <puhm@oregano.at>
---
 drivers/fpga/altera-cvp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 7fa793672a7a..838abcfca0fb 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -403,6 +403,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	struct altera_cvp_conf *conf;
 	struct fpga_manager *mgr;
 	u16 cmd, val;
+	u32 val32;
 	int ret;
 
 	/*
@@ -416,6 +417,14 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 		return -ENODEV;
 	}
 
+	pci_read_config_dword(pdev, VSE_CVP_STATUS, &val32);
+	if (!(val32 & VSE_CVP_STATUS_CVP_EN)) {
+		dev_err(&pdev->dev,
+			"CVP is disabled for this device: CVP_STATUS Reg 0x%x\n",
+			val32);
+		return -ENODEV;
+	}
+
 	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
 	if (!conf)
 		return -ENOMEM;
--

With best regards,
Andreas Puhm <puhm@oregano.at>
