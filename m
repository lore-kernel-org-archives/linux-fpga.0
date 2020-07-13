Return-Path: <SRS0=10uA=AY=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=10uA=AY=intel.com=yilun.xu@kernel.org>
From: Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Date: Mon, 13 Jul 2020 14:10:02 +0800
Message-Id: <1594620603-18029-2-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1594620603-18029-1-git-send-email-yilun.xu@intel.com>
References: <1594620603-18029-1-git-send-email-yilun.xu@intel.com>
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lgoncalv@redhat.com, trix@redhat.com, Xu Yilun <yilun.xu@intel.com>
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
Acked-by: Wu Hao <hao.wu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v2: Add Reviewed-by of Tom, no code change.
---
 drivers/fpga/dfl-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 4a14a24..73b5153 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -285,7 +285,6 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
 {
 	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
 	struct dfl_fpga_cdev *cdev = drvdata->cdev;
-	int ret = 0;
 
 	if (!num_vfs) {
 		/*
@@ -297,6 +296,8 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
 		dfl_fpga_cdev_config_ports_pf(cdev);
 
 	} else {
+		int ret;
+
 		/*
 		 * before enable SRIOV, put released ports into VF access mode
 		 * first of all.
-- 
2.7.4
