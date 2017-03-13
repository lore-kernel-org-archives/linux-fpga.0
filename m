Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 1/5] fpga-mgr: pass parameters for loading fpga in image info
Date: Mon, 13 Mar 2017 16:53:29 -0500
Message-Id: <20170313215333.3008-2-atull@kernel.org>
In-Reply-To: <20170313215333.3008-1-atull@kernel.org>
References: <20170313215333.3008-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Currently fpga-mgr.c has three methods for loading FPGA's depending on how
the FPGA image is presented: in a sg table, as a single buffer, or as a
firmware file.  This commit adds these parameters to the fpga_image_info
struct and adds a single function that can accept the image as any of these
three.  This allows code to be written that could use any of the three
methods.

Signed-off-by: Alan Tull <atull@kernel.org>
---
v1: changed order that methods are tried
---
 drivers/fpga/fpga-mgr.c       | 12 ++++++++++++
 drivers/fpga/fpga-region.c    | 17 +++++++----------
 include/linux/fpga/fpga-mgr.h | 10 ++++++++++
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 86d2cb2..fde605b 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -309,6 +309,18 @@ int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_firmware_load);
 
+int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
+{
+	if (info->sgt)
+		return fpga_mgr_buf_load_sg(mgr, info, info->sgt);
+	if (info->buf && info->count)
+		return fpga_mgr_buf_load(mgr, info, info->buf, info->count);
+	if (info->firmware_name)
+		return fpga_mgr_firmware_load(mgr, info, info->firmware_name);
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(fpga_mgr_load);
+
 static const char * const state_str[] = {
 	[FPGA_MGR_STATE_UNKNOWN] =		"unknown",
 	[FPGA_MGR_STATE_POWER_OFF] =		"power off",
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 3222fdb..24f4ed5 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -223,14 +223,11 @@ static int fpga_region_get_bridges(struct fpga_region *region,
 /**
  * fpga_region_program_fpga - program FPGA
  * @region: FPGA region
- * @firmware_name: name of FPGA image firmware file
  * @overlay: device node of the overlay
- * Program an FPGA using information in the device tree.
- * Function assumes that there is a firmware-name property.
+ * Program an FPGA using information in the region's fpga image info.
  * Return 0 for success or negative error code.
  */
 static int fpga_region_program_fpga(struct fpga_region *region,
-				    const char *firmware_name,
 				    struct device_node *overlay)
 {
 	struct fpga_manager *mgr;
@@ -260,7 +257,7 @@ static int fpga_region_program_fpga(struct fpga_region *region,
 		goto err_put_br;
 	}
 
-	ret = fpga_mgr_firmware_load(mgr, region->info, firmware_name);
+	ret = fpga_mgr_load(mgr, region->info);
 	if (ret) {
 		pr_err("failed to load fpga image\n");
 		goto err_put_br;
@@ -351,7 +348,6 @@ static int child_regions_with_firmware(struct device_node *overlay)
 static int fpga_region_notify_pre_apply(struct fpga_region *region,
 					struct of_overlay_notify_data *nd)
 {
-	const char *firmware_name = NULL;
 	struct fpga_image_info *info;
 	int ret;
 
@@ -373,7 +369,8 @@ static int fpga_region_notify_pre_apply(struct fpga_region *region,
 	if (of_property_read_bool(nd->overlay, "external-fpga-config"))
 		info->flags |= FPGA_MGR_EXTERNAL_CONFIG;
 
-	of_property_read_string(nd->overlay, "firmware-name", &firmware_name);
+	of_property_read_string(nd->overlay, "firmware-name",
+				&info->firmware_name);
 
 	of_property_read_u32(nd->overlay, "region-unfreeze-timeout-us",
 			     &info->enable_timeout_us);
@@ -382,7 +379,7 @@ static int fpga_region_notify_pre_apply(struct fpga_region *region,
 			     &info->disable_timeout_us);
 
 	/* If FPGA was externally programmed, don't specify firmware */
-	if ((info->flags & FPGA_MGR_EXTERNAL_CONFIG) && firmware_name) {
+	if ((info->flags & FPGA_MGR_EXTERNAL_CONFIG) && info->firmware_name) {
 		pr_err("error: specified firmware and external-fpga-config");
 		return -EINVAL;
 	}
@@ -392,12 +389,12 @@ static int fpga_region_notify_pre_apply(struct fpga_region *region,
 		return 0;
 
 	/* If we got this far, we should be programming the FPGA */
-	if (!firmware_name) {
+	if (!info->firmware_name) {
 		pr_err("should specify firmware-name or external-fpga-config\n");
 		return -EINVAL;
 	}
 
-	return fpga_region_program_fpga(region, firmware_name, nd->overlay);
+	return fpga_region_program_fpga(region, nd->overlay);
 }
 
 /**
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 57beb5d..45df05a 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -76,11 +76,19 @@ enum fpga_mgr_states {
  * @flags: boolean flags as defined above
  * @enable_timeout_us: maximum time to enable traffic through bridge (uSec)
  * @disable_timeout_us: maximum time to disable traffic through bridge (uSec)
+ * @firmware_name: name of FPGA image firmware file
+ * @sgt: scatter/gather table containing FPGA image
+ * @buf: contiguous buffer containing FPGA image
+ * @count: size of buf
  */
 struct fpga_image_info {
 	u32 flags;
 	u32 enable_timeout_us;
 	u32 disable_timeout_us;
+	const char *firmware_name;
+	struct sg_table *sgt;
+	const char *buf;
+	size_t count;
 };
 
 /**
@@ -139,6 +147,8 @@ int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 			   struct fpga_image_info *info,
 			   const char *image_name);
 
+int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info);
+
 struct fpga_manager *of_fpga_mgr_get(struct device_node *node);
 
 struct fpga_manager *fpga_mgr_get(struct device *dev);
-- 
2.7.4
