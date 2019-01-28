Return-Path: <SRS0=HGpG=QE=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=HGpG=QE=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730934AbfA1QBJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Jan 2019 11:01:09 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 039/258] fpga: altera-cvp: fix 'bad IO access' on x86_64
Date: Mon, 28 Jan 2019 10:55:45 -0500
Message-Id: <20190128155924.51521-39-sashal@kernel.org>
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Anatolij Gustschin <agust@denx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-fpga@vger.kernel.org

From: Anatolij Gustschin <agust@denx.de>

[ Upstream commit 187fade88ca0ff2df9d360ca751d948d73db7095 ]

If mapping the CvP BAR fails, we still can configure the FPGA via
PCI config space access. In this case the iomap pointer is NULL.
On x86_64, passing NULL address to pci_iounmap() generates
"Bad IO access at port 0x0" output with stack call trace. Fix it.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/altera-cvp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 1f4c26b4794a..7a42c194b944 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -480,7 +480,8 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	return 0;
 
 err_unmap:
-	pci_iounmap(pdev, conf->map);
+	if (conf->map)
+		pci_iounmap(pdev, conf->map);
 	pci_release_region(pdev, CVP_BAR);
 err_disable:
 	cmd &= ~PCI_COMMAND_MEMORY;
@@ -495,7 +496,8 @@ static void altera_cvp_remove(struct pci_dev *pdev)
 	u16 cmd;
 
 	fpga_mgr_unregister(mgr);
-	pci_iounmap(pdev, conf->map);
+	if (conf->map)
+		pci_iounmap(pdev, conf->map);
 	pci_release_region(pdev, CVP_BAR);
 	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
 	cmd &= ~PCI_COMMAND_MEMORY;
-- 
2.19.1
