Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 1/2] fpga: add attribute groups
Date: Tue, 22 Aug 2017 10:53:54 -0500
Message-Id: <20170822155355.3896-2-atull@kernel.org>
In-Reply-To: <20170822155355.3896-1-atull@kernel.org>
References: <20170822155355.3896-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>, Anatolij Gustschin <agust@denx.de>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Make it easy to add attributes to low level FPGA drivers the right
way.  Add attribute groups pointers to structures that are used when
registering a manager, bridge, or group.  When the low level driver
registers, set the device attribute group.  The attributes are
created in device_add.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/fpga-bridge.c       | 1 +
 drivers/fpga/fpga-mgr.c          | 1 +
 drivers/fpga/fpga-region.c       | 1 +
 include/linux/fpga/fpga-bridge.h | 2 ++
 include/linux/fpga/fpga-mgr.h    | 2 ++
 include/linux/fpga/fpga-region.h | 2 ++
 6 files changed, 9 insertions(+)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index af6d97e..a189638 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -367,6 +367,7 @@ int fpga_bridge_register(struct device *dev, const char *name,
 	bridge->priv = priv;
 
 	device_initialize(&bridge->dev);
+	bridge->dev.groups = br_ops->groups;
 	bridge->dev.class = fpga_bridge_class;
 	bridge->dev.parent = dev;
 	bridge->dev.of_node = dev->of_node;
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index be13cce..b54f6f0 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -560,6 +560,7 @@ int fpga_mgr_register(struct device *dev, const char *name,
 
 	device_initialize(&mgr->dev);
 	mgr->dev.class = fpga_mgr_class;
+	mgr->dev.groups = mops->groups;
 	mgr->dev.parent = dev;
 	mgr->dev.of_node = dev->of_node;
 	mgr->dev.id = id;
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index afc6188..edab2a2 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -173,6 +173,7 @@ int fpga_region_register(struct device *dev, struct fpga_region *region)
 	mutex_init(&region->mutex);
 	INIT_LIST_HEAD(&region->bridge_list);
 	device_initialize(&region->dev);
+	region->dev.groups = region->groups;
 	region->dev.class = fpga_region_class;
 	region->dev.parent = dev;
 	region->dev.of_node = dev->of_node;
diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
index 9f6696b..652160b 100644
--- a/include/linux/fpga/fpga-bridge.h
+++ b/include/linux/fpga/fpga-bridge.h
@@ -11,11 +11,13 @@ struct fpga_bridge;
  * @enable_show: returns the FPGA bridge's status
  * @enable_set: set a FPGA bridge as enabled or disabled
  * @fpga_bridge_remove: set FPGA into a specific state during driver remove
+ * @groups: optional attribute groups.
  */
 struct fpga_bridge_ops {
 	int (*enable_show)(struct fpga_bridge *bridge);
 	int (*enable_set)(struct fpga_bridge *bridge, bool enable);
 	void (*fpga_bridge_remove)(struct fpga_bridge *bridge);
+	const struct attribute_group **groups;
 };
 
 /**
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 50954cb..bb061a5 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -113,6 +113,7 @@ struct fpga_image_info {
  * @write_sg: write the scatter list of configuration data to the FPGA
  * @write_complete: set FPGA to operating state after writing is done
  * @fpga_remove: optional: Set FPGA into a specific state during driver remove
+ * @groups: optional attribute groups.
  *
  * fpga_manager_ops are the low level functions implemented by a specific
  * fpga manager driver.  The optional ones are tested for NULL before being
@@ -129,6 +130,7 @@ struct fpga_manager_ops {
 	int (*write_complete)(struct fpga_manager *mgr,
 			      struct fpga_image_info *info);
 	void (*fpga_remove)(struct fpga_manager *mgr);
+	const struct attribute_group **groups;
 };
 
 /**
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index f2eecdd..4a5562f 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -14,6 +14,7 @@
  * @info: FPGA image info
  * @priv: private data
  * @get_bridges: optional function to get bridges to a list
+ * @groups: optional attribute groups.
  */
 struct fpga_region {
 	struct device dev;
@@ -23,6 +24,7 @@ struct fpga_region {
 	struct fpga_image_info *info;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
+	const struct attribute_group **groups;
 };
 
 #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
-- 
2.7.4
