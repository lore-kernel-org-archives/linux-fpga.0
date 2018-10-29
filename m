Return-Path: <SRS0=bKZa=NJ=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=bKZa=NJ=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:33776 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbeJ3A5b (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 29 Oct 2018 20:57:31 -0400
From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH] fpga: altera-cvp: fix 'bad IO access' on x86_64
Date: Mon, 29 Oct 2018 17:08:14 +0100
Message-Id: <20181029160814.5530-1-agust@denx.de>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org
Cc: atull@kernel.org, mdf@kernel.org

If mapping the CvP BAR fails, we still can configure the FPGA via
PCI config space access. In this case the iomap pointer is NULL.
On x86_64, passing NULL address to pci_iounmap() generates
"Bad IO access at port 0x0" output with stack call trace. Fix it.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/fpga/altera-cvp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 610a1558e0ed..144fa2a4d4cc 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -477,7 +477,8 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	return 0;
 
 err_unmap:
-	pci_iounmap(pdev, conf->map);
+	if (conf->map)
+		pci_iounmap(pdev, conf->map);
 	pci_release_region(pdev, CVP_BAR);
 err_disable:
 	cmd &= ~PCI_COMMAND_MEMORY;
@@ -493,7 +494,8 @@ static void altera_cvp_remove(struct pci_dev *pdev)
 
 	driver_remove_file(&altera_cvp_driver.driver, &driver_attr_chkcfg);
 	fpga_mgr_unregister(mgr);
-	pci_iounmap(pdev, conf->map);
+	if (conf->map)
+		pci_iounmap(pdev, conf->map);
 	pci_release_region(pdev, CVP_BAR);
 	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
 	cmd &= ~PCI_COMMAND_MEMORY;
-- 
2.17.1
