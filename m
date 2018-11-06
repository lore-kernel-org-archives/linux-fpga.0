Return-Path: <SRS0=L03T=NR=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=L03T=NR=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:55492 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbeKGGCQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 7 Nov 2018 01:02:16 -0500
From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH] fpga: altera-cvp: fix probing for multiple FPGAs on the bus
Date: Tue,  6 Nov 2018 21:35:12 +0100
Message-Id: <20181106203512.4509-1-agust@denx.de>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org
Cc: atull@kernel.org, mdf@kernel.org

Currently registering CvP managers works only for first probed CvP
device, for all other devices it is refused due to duplicated chkcfg
sysfs entry:

fpga_manager fpga3: Altera CvP FPGA Manager @0000:0c:00.0 registered
sysfs: cannot create duplicate filename '/bus/pci/drivers/altera-cvp/chkcfg'
CPU: 0 PID: 3808 Comm: bash Tainted: G           O      4.19.0-custom+ #5
Call Trace:
  dump_stack+0x46/0x5b
  sysfs_warn_dup+0x53/0x60
  sysfs_add_file_mode_ns+0x16d/0x180
  sysfs_create_file_ns+0x51/0x60
  altera_cvp_probe+0x16f/0x2a0 [altera_cvp]
  local_pci_probe+0x3f/0xa0
  ? pci_match_device+0xb1/0xf0
  pci_device_probe+0x116/0x170
  really_probe+0x21b/0x2c0
  driver_probe_device+0x4b/0xe0
  bind_store+0xcb/0x130
  kernfs_fop_write+0xfd/0x180
  __vfs_write+0x21/0x150
  ? selinux_file_permission+0xdc/0x130
  vfs_write+0xa8/0x1a0
  ? find_vma+0xd/0x60
  ksys_write+0x3d/0x90
  do_syscall_64+0x44/0xf0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
  ...
 altera-cvp 0000:0c:00.0: Can't create sysfs chkcfg file
 fpga_manager fpga3: fpga_mgr_unregister Altera CvP FPGA Manager @0000:0c:00.0

Skip chkcfg creation for all but first probed device. Remove chkcfg
interface when last potential user has gone.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/fpga/altera-cvp.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 144fa2a4d4cc..381d0c42450f 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -60,6 +60,7 @@
 
 /* Optional CvP config error status check for debugging */
 static bool altera_cvp_chkcfg;
+static unsigned int altera_cvp_cnt;
 
 struct altera_cvp_conf {
 	struct fpga_manager	*mgr;
@@ -466,12 +467,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_unmap;
 
-	ret = driver_create_file(&altera_cvp_driver.driver,
-				 &driver_attr_chkcfg);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't create sysfs chkcfg file\n");
-		fpga_mgr_unregister(mgr);
-		goto err_unmap;
+	if (!altera_cvp_cnt++) {
+		ret = driver_create_file(&altera_cvp_driver.driver,
+					 &driver_attr_chkcfg);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't create sysfs chkcfg file\n");
+			fpga_mgr_unregister(mgr);
+			altera_cvp_cnt--;
+			goto err_unmap;
+		}
 	}
 
 	return 0;
@@ -492,7 +496,11 @@ static void altera_cvp_remove(struct pci_dev *pdev)
 	struct altera_cvp_conf *conf = mgr->priv;
 	u16 cmd;
 
-	driver_remove_file(&altera_cvp_driver.driver, &driver_attr_chkcfg);
+	if (!--altera_cvp_cnt) {
+		driver_remove_file(&altera_cvp_driver.driver,
+				   &driver_attr_chkcfg);
+	}
+
 	fpga_mgr_unregister(mgr);
 	if (conf->map)
 		pci_iounmap(pdev, conf->map);
-- 
2.17.1
