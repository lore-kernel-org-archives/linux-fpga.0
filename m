Return-Path: <SRS0=D9aK=4N=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=D9aK=4N=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:13719 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgBYGJM (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 25 Feb 2020 01:09:12 -0500
From: Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH] fpga: dfl: pci: fix return value of cci_pci_sriov_configure
Date: Tue, 25 Feb 2020 14:07:18 +0800
Message-Id: <1582610838-7019-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>

pci_driver.sriov_configure should return negative value on error and
number of enabled VFs on success. But now the driver returns 0 on
success. The sriov configure still works but will cause a warning
message:

  XX VFs requested; only 0 enabled

This patch changes the return value accordingly.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl-pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 89ca292..5387550 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -248,11 +248,13 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
 			return ret;
 
 		ret = pci_enable_sriov(pcidev, num_vfs);
-		if (ret)
+		if (ret) {
 			dfl_fpga_cdev_config_ports_pf(cdev);
+			return ret;
+		}
 	}
 
-	return ret;
+	return num_vfs;
 }
 
 static void cci_pci_remove(struct pci_dev *pcidev)
-- 
2.7.4
