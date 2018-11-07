Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 1/4] fpga: altera-cvp: fix 'bad IO access' on x86_64
Date: Wed,  7 Nov 2018 11:51:45 -0600
Message-Id: <1541613108-29660-2-git-send-email-atull@kernel.org>
In-Reply-To: <1541613108-29660-1-git-send-email-atull@kernel.org>
References: <1541613108-29660-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
List-ID: <linux-fpga@vger.kernel.org>

From: Anatolij Gustschin <agust@denx.de>

If mapping the CvP BAR fails, we still can configure the FPGA via
PCI config space access. In this case the iomap pointer is NULL.
On x86_64, passing NULL address to pci_iounmap() generates
"Bad IO access at port 0x0" output with stack call trace. Fix it.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/altera-cvp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 610a155..144fa2a 100644
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
2.7.4
