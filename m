Return-Path: <SRS0=FSxJ=6A=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=FSxJ=6A=intel.com=yilun.xu@kernel.org>
From: Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Date: Thu, 16 Apr 2020 11:11:51 +0800
Message-Id: <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: trix@redhat.com, bhu@redhat.com, Xu Yilun <yilun.xu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

This is to fix lkp cppcheck warnings:

 drivers/fpga/dfl-pci.c:230:6: warning: The scope of the variable 'ret' can be reduced. [variableScope]
    int ret = 0;
        ^

 drivers/fpga/dfl-pci.c:230:10: warning: Variable 'ret' is assigned a value that is never used. [unreadVariable]
    int ret = 0;
            ^

Fixes: 3c2760b78f90 ("fpga: dfl: pci: fix return value of cci_pci_sriov_configure")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/dfl-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 5387550..a78c409 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -227,7 +227,6 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
 {
 	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
 	struct dfl_fpga_cdev *cdev = drvdata->cdev;
-	int ret = 0;
 
 	if (!num_vfs) {
 		/*
@@ -239,6 +238,8 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
 		dfl_fpga_cdev_config_ports_pf(cdev);
 
 	} else {
+		int ret;
+
 		/*
 		 * before enable SRIOV, put released ports into VF access mode
 		 * first of all.
-- 
2.7.4
