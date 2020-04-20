Return-Path: <SRS0=YV0W=6E=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=YV0W=6E=intel.com=yilun.xu@kernel.org>
From: Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v5 5/7] fpga: dfl: fme: add interrupt support for global error reporting
Date: Mon, 20 Apr 2020 16:11:41 +0800
Message-Id: <1587370303-25568-6-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1587370303-25568-1-git-send-email-yilun.xu@intel.com>
References: <1587370303-25568-1-git-send-email-yilun.xu@intel.com>
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: trix@redhat.com, bhu@redhat.com, Xu Yilun <yilun.xu@intel.com>, Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

Error reporting interrupt is very useful to notify users that some
errors are detected by the hardware. Once users are notified, they
could query hardware logged error states, no need to continuously
poll on these states.

This patch adds interrupt support for fme global error reporting sub
feature. It follows the common DFL interrupt notification and handling
mechanism. And it implements two ioctls below for user to query
number of irqs supported, and set/unset interrupt triggers.

 Ioctls:
 * DFL_FPGA_FME_ERR_GET_IRQ_NUM
   get the number of irqs, which is used to determine whether/how many
   interrupts fme error reporting feature supports.

 * DFL_FPGA_FME_ERR_SET_IRQ
   set/unset given eventfds as fme error reporting interrupt triggers.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Acked-by: Wu Hao <hao.wu@intel.com>
----
v2: use DFL_FPGA_FME_ERR_GET_IRQ_NUM instead of
    DFL_FPGA_FME_ERR_GET_INFO
    Delete flags field for DFL_FPGA_FME_ERR_SET_IRQ
v3: put_user() instead of copy_to_user()
    improves comments
v4: use common functions to handle irq ioctls
v5: Minor fixes for Hao's comments
---
 drivers/fpga/dfl-fme-error.c  | 18 ++++++++++++++++++
 drivers/fpga/dfl-fme-main.c   |  6 ++++++
 include/uapi/linux/fpga-dfl.h | 23 +++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
index f897d41..51c2892 100644
--- a/drivers/fpga/dfl-fme-error.c
+++ b/drivers/fpga/dfl-fme-error.c
@@ -15,6 +15,7 @@
  *   Mitchel, Henry <henry.mitchel@intel.com>
  */
 
+#include <linux/fpga-dfl.h>
 #include <linux/uaccess.h>
 
 #include "dfl.h"
@@ -348,6 +349,22 @@ static void fme_global_err_uinit(struct platform_device *pdev,
 	fme_err_mask(&pdev->dev, true);
 }
 
+static long
+fme_global_error_ioctl(struct platform_device *pdev,
+		       struct dfl_feature *feature,
+		       unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case DFL_FPGA_FME_ERR_GET_IRQ_NUM:
+		return dfl_feature_ioctl_get_num_irqs(pdev, feature, arg);
+	case DFL_FPGA_FME_ERR_SET_IRQ:
+		return dfl_feature_ioctl_set_irq(pdev, feature, arg);
+	default:
+		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
+		return -ENODEV;
+	}
+}
+
 const struct dfl_feature_id fme_global_err_id_table[] = {
 	{.id = FME_FEATURE_ID_GLOBAL_ERR,},
 	{0,}
@@ -356,4 +373,5 @@ const struct dfl_feature_id fme_global_err_id_table[] = {
 const struct dfl_feature_ops fme_global_err_ops = {
 	.init = fme_global_err_init,
 	.uinit = fme_global_err_uinit,
+	.ioctl = fme_global_error_ioctl,
 };
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 56d720c..ab3722d 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -616,11 +616,17 @@ static int fme_release(struct inode *inode, struct file *filp)
 {
 	struct dfl_feature_platform_data *pdata = filp->private_data;
 	struct platform_device *pdev = pdata->dev;
+	struct dfl_feature *feature;
 
 	dev_dbg(&pdev->dev, "Device File Release\n");
 
 	mutex_lock(&pdata->lock);
 	dfl_feature_dev_use_end(pdata);
+
+	if (!dfl_feature_dev_use_count(pdata))
+		dfl_fpga_dev_for_each_feature(pdata, feature)
+			dfl_fpga_set_irq_triggers(feature, 0,
+						  feature->nr_irqs, NULL);
 	mutex_unlock(&pdata->lock);
 
 	return 0;
diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
index 6c71c9d..b6495ea 100644
--- a/include/uapi/linux/fpga-dfl.h
+++ b/include/uapi/linux/fpga-dfl.h
@@ -230,4 +230,27 @@ struct dfl_fpga_fme_port_pr {
  */
 #define DFL_FPGA_FME_PORT_ASSIGN     _IOW(DFL_FPGA_MAGIC, DFL_FME_BASE + 2, int)
 
+/**
+ * DFL_FPGA_FME_ERR_GET_IRQ_NUM - _IOR(DFL_FPGA_MAGIC, DFL_FME_BASE + 3,
+ *							__u32 num_irqs)
+ *
+ * Get the number of irqs supported by the fpga fme error reporting private
+ * feature. Currently hardware supports up to 1 irq.
+ * Return: 0 on success, -errno on failure.
+ */
+#define DFL_FPGA_FME_ERR_GET_IRQ_NUM	_IOR(DFL_FPGA_MAGIC,	\
+					     DFL_FME_BASE + 3, __u32)
+
+/**
+ * DFL_FPGA_FME_ERR_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_FME_BASE + 4,
+ *						struct dfl_fpga_irq_set)
+ *
+ * Set fpga fme error reporting interrupt trigger if evtfds[n] is valid.
+ * Unset related interrupt trigger if evtfds[n] is a negative value.
+ * Return: 0 on success, -errno on failure.
+ */
+#define DFL_FPGA_FME_ERR_SET_IRQ	_IOW(DFL_FPGA_MAGIC,	\
+					     DFL_FME_BASE + 4,	\
+					     struct dfl_fpga_irq_set)
+
 #endif /* _UAPI_LINUX_FPGA_DFL_H */
-- 
2.7.4
