Return-Path: <SRS0=SP6n=57=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=SP6n=57=intel.com=hao.wu@kernel.org>
From: Wu Hao <hao.wu@intel.com>
Subject: [PATCH v2 19/22] fpga: intel: afu: add header sub feature support
Date: Mon, 26 Jun 2017 09:52:15 +0800
Message-Id: <1498441938-14046-20-git-send-email-hao.wu@intel.com>
In-Reply-To: <1498441938-14046-1-git-send-email-hao.wu@intel.com>
References: <1498441938-14046-1-git-send-email-hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com, yi.z.zhang@intel.com, hao.wu@intel.com, Tim Whisonant <tim.whisonant@intel.com>, Enno Luebbers <enno.luebbers@intel.com>, Shiva Rao <shiva.rao@intel.com>, Christopher Rauer <christopher.rauer@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

The header register set is always present for the Port/AFU, it is mainly
for capability, control and status of the ports that AFU connected to.

This patch implements header sub feature support. Below user interfaces
are created by this patch.

Sysfs interface:
* /sys/class/fpga/<fpga.x>/<intel-fpga-port.x>/id
  Read-only. Port ID.

Ioctl interface:
* FPGA_PORT_RESET
  Reset the FPGA AFU Port.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v2: add sysfs documentation.
---
 .../ABI/testing/sysfs-platform-intel-fpga-afu      |  7 ++++
 drivers/fpga/intel-afu-main.c                      | 44 +++++++++++++++++++++-
 include/uapi/linux/intel-fpga.h                    | 14 +++++++
 3 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-fpga-afu

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-fpga-afu b/Documentation/ABI/testing/sysfs-platform-intel-fpga-afu
new file mode 100644
index 0000000..8ad22c9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-intel-fpga-afu
@@ -0,0 +1,7 @@
+What:		/sys/bus/platform/devices/intel-fpga-port.0/id
+Date:		June 2017
+KernelVersion:  4.12
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns id of this port. One Intel FPGA device
+		may have more than one port. Userspace could use this id to
+		distinguish different ports under same FPGA device.
diff --git a/drivers/fpga/intel-afu-main.c b/drivers/fpga/intel-afu-main.c
index 96d0367..2a17cde 100644
--- a/drivers/fpga/intel-afu-main.c
+++ b/drivers/fpga/intel-afu-main.c
@@ -18,25 +18,66 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/intel-fpga.h>
 
 #include "intel-feature-dev.h"
 
+static ssize_t
+id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int id = fpga_port_id(to_platform_device(dev));
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", id);
+}
+static DEVICE_ATTR_RO(id);
+
+static const struct attribute *port_hdr_attrs[] = {
+	&dev_attr_id.attr,
+	NULL,
+};
+
 static int port_hdr_init(struct platform_device *pdev, struct feature *feature)
 {
 	dev_dbg(&pdev->dev, "PORT HDR Init.\n");
 
-	return 0;
+	fpga_port_reset(pdev);
+
+	return sysfs_create_files(&pdev->dev.kobj, port_hdr_attrs);
 }
 
 static void port_hdr_uinit(struct platform_device *pdev,
 					struct feature *feature)
 {
 	dev_dbg(&pdev->dev, "PORT HDR UInit.\n");
+
+	sysfs_remove_files(&pdev->dev.kobj, port_hdr_attrs);
+}
+
+static long
+port_hdr_ioctl(struct platform_device *pdev, struct feature *feature,
+					unsigned int cmd, unsigned long arg)
+{
+	long ret;
+
+	switch (cmd) {
+	case FPGA_PORT_RESET:
+		if (!arg)
+			ret = fpga_port_reset(pdev);
+		else
+			ret = -EINVAL;
+		break;
+	default:
+		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
+		ret = -ENODEV;
+	}
+
+	return ret;
 }
 
 struct feature_ops port_hdr_ops = {
 	.init = port_hdr_init,
 	.uinit = port_hdr_uinit,
+	.ioctl = port_hdr_ioctl,
 };
 
 static struct feature_driver port_feature_drvs[] = {
@@ -76,6 +117,7 @@ static int afu_release(struct inode *inode, struct file *filp)
 
 	dev_dbg(&pdev->dev, "Device File Release\n");
 
+	fpga_port_reset(pdev);
 	feature_dev_use_end(pdata);
 	return 0;
 }
diff --git a/include/uapi/linux/intel-fpga.h b/include/uapi/linux/intel-fpga.h
index be295ae..be5f813 100644
--- a/include/uapi/linux/intel-fpga.h
+++ b/include/uapi/linux/intel-fpga.h
@@ -30,8 +30,11 @@
 #define FPGA_MAGIC 0xB6
 
 #define FPGA_BASE 0
+#define PORT_BASE 0x40
 #define FME_BASE 0x80
 
+/* Common IOCTLs for both FME and AFU file descriptor */
+
 /**
  * FPGA_GET_API_VERSION - _IO(FPGA_MAGIC, FPGA_BASE + 0)
  *
@@ -50,6 +53,17 @@
 
 #define FPGA_CHECK_EXTENSION	_IO(FPGA_MAGIC, FPGA_BASE + 1)
 
+/* IOCTLs for AFU file descriptor */
+
+/**
+ * FPGA_PORT_RESET - _IO(FPGA_MAGIC, PORT_BASE + 0)
+ *
+ * Reset the FPGA AFU Port. No parameters are supported.
+ * Return: 0 on success, -errno of failure
+ */
+
+#define FPGA_PORT_RESET		_IO(FPGA_MAGIC, PORT_BASE + 0)
+
 /* IOCTLs for FME file descriptor */
 
 /**
-- 
1.8.3.1
