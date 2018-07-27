Return-Path: <SRS0=2b8I=KL=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=2b8I=KL=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-eopbgr700048.outbound.protection.outlook.com ([40.107.70.48]:43865
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbeG0HnK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 27 Jul 2018 03:43:10 -0400
From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v4 1/2] fpga: fpga-mgr: Add readback support
Date: Fri, 27 Jul 2018 11:52:30 +0530
Message-ID: <1532672551-22146-1-git-send-email-appana.durga.rao@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: atull@kernel.org, mdf@kernel.org, michal.simek@xilinx.com, kedare06@gmail.com
Cc: linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, navam@xilinx.com, apandey@xilinx.com, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>

Inorder to debug issues with fpga's users would
like to read the fpga configuration information.
This patch adds readback support for fpga configuration data
in the framework through debugfs interface.

Usage:
        cat /sys/kernel/debug/fpga/fpga0/image

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
Changes for v4:
--> None.
Changes for v3:
--> None.
Changes for v2:
--> Fixed debug attribute path and name as suggested by Alan
--> Add config entry for DEBUG as suggested by Alan
--> Fixed trival coding style issues.

 drivers/fpga/Kconfig          |  7 +++++
 drivers/fpga/fpga-mgr.c       | 68 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fpga/fpga-mgr.h |  5 ++++
 3 files changed, 80 insertions(+)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 53d3f55..838ad4e 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -11,6 +11,13 @@ menuconfig FPGA
 
 if FPGA
 
+config FPGA_MGR_DEBUG_FS
+	tristate "FPGA Debug fs"
+	select DEBUG_FS
+	help
+	  FPGA manager debug provides support for reading fpga configuration
+	  information.
+
 config FPGA_MGR_SOCFPGA
 	tristate "Altera SOCFPGA FPGA Manager"
 	depends on ARCH_SOCFPGA || COMPILE_TEST
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 9939d2c..4bea860 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -484,6 +484,48 @@ void fpga_mgr_put(struct fpga_manager *mgr)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_put);
 
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+#include <linux/debugfs.h>
+
+static int fpga_mgr_read(struct seq_file *s, void *data)
+{
+	struct fpga_manager *mgr = (struct fpga_manager *)s->private;
+	int ret = 0;
+
+	if (!mgr->mops->read)
+		return -ENOENT;
+
+	if (!mutex_trylock(&mgr->ref_mutex))
+		return -EBUSY;
+
+	if (mgr->state != FPGA_MGR_STATE_OPERATING) {
+		ret = -EPERM;
+		goto err_unlock;
+	}
+
+	/* Read the FPGA configuration data from the fabric */
+	ret = mgr->mops->read(mgr, s);
+	if (ret)
+		dev_err(&mgr->dev, "Error while reading configuration data from FPGA\n");
+
+err_unlock:
+	mutex_unlock(&mgr->ref_mutex);
+
+	return ret;
+}
+
+static int fpga_mgr_read_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, fpga_mgr_read, inode->i_private);
+}
+
+static const struct file_operations fpga_mgr_ops_image = {
+	.owner = THIS_MODULE,
+	.open = fpga_mgr_read_open,
+	.read = seq_read,
+};
+#endif
+
 /**
  * fpga_mgr_lock - Lock FPGA manager for exclusive use
  * @mgr:	fpga manager
@@ -581,6 +623,29 @@ int fpga_mgr_register(struct device *dev, const char *name,
 	if (ret)
 		goto error_device;
 
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	struct dentry *d, *parent;
+
+	mgr->dir = debugfs_create_dir("fpga", NULL);
+	if (!mgr->dir)
+		goto error_device;
+
+	parent = mgr->dir;
+	d = debugfs_create_dir(mgr->dev.kobj.name, parent);
+	if (!d) {
+		debugfs_remove_recursive(parent);
+		goto error_device;
+	}
+
+	parent = d;
+	d = debugfs_create_file("image", 0644, parent, mgr,
+				&fpga_mgr_ops_image);
+	if (!d) {
+		debugfs_remove_recursive(mgr->dir);
+		goto error_device;
+	}
+#endif
+
 	dev_info(&mgr->dev, "%s registered\n", mgr->name);
 
 	return 0;
@@ -604,6 +669,9 @@ void fpga_mgr_unregister(struct device *dev)
 
 	dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
 
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	debugfs_remove_recursive(mgr->dir);
+#endif
 	/*
 	 * If the low level driver provides a method for putting fpga into
 	 * a desired state upon unregister, do it.
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 3c6de23..e9e17a9 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -114,6 +114,7 @@ struct fpga_image_info {
  * @write: write count bytes of configuration data to the FPGA
  * @write_sg: write the scatter list of configuration data to the FPGA
  * @write_complete: set FPGA to operating state after writing is done
+ * @read: optional: read FPGA configuration information
  * @fpga_remove: optional: Set FPGA into a specific state during driver remove
  * @groups: optional attribute groups.
  *
@@ -131,6 +132,7 @@ struct fpga_manager_ops {
 	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
 	int (*write_complete)(struct fpga_manager *mgr,
 			      struct fpga_image_info *info);
+	int (*read)(struct fpga_manager *mgr, struct seq_file *s);
 	void (*fpga_remove)(struct fpga_manager *mgr);
 	const struct attribute_group **groups;
 };
@@ -151,6 +153,9 @@ struct fpga_manager {
 	enum fpga_mgr_states state;
 	const struct fpga_manager_ops *mops;
 	void *priv;
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	struct dentry *dir;
+#endif
 };
 
 #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
-- 
2.7.4

