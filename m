Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v6 18/18] fpga: add attribute groups
Date: Wed, 15 Nov 2017 14:20:28 -0600
Message-Id: <1510777228-4291-19-git-send-email-atull@kernel.org>
In-Reply-To: <1510777228-4291-1-git-send-email-atull@kernel.org>
References: <1510777228-4291-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Make it easy to add attributes to low level FPGA drivers the right
way.  Add attribute groups pointers to structures that are used when
registering a manager, bridge, or group.  When the low level driver
registers, set the device attribute group.  The attributes are
created in device_add.

Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v4: Patch added to patchset in v4
v5: no change to this patch in this version of patchset
v6: Add Moritz' ack
---
 drivers/fpga/fpga-bridge.c       | 1 +
 drivers/fpga/fpga-mgr.c          | 1 +
 drivers/fpga/fpga-region.c       | 1 +
 include/linux/fpga/fpga-bridge.h | 2 ++
 include/linux/fpga/fpga-mgr.h    | 2 ++
 include/linux/fpga/fpga-region.h | 2 ++
 6 files changed, 9 insertions(+)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 0dfe9d7..e693c36 100644
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
index d27e8d2..223f240 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -569,6 +569,7 @@ int fpga_mgr_register(struct device *dev, const char *name,
 
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
index 6ca41f8..3694821 100644
--- a/include/linux/fpga/fpga-bridge.h
+++ b/include/linux/fpga/fpga-bridge.h
@@ -13,11 +13,13 @@ struct fpga_bridge;
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
index 4fb706b..3c6de23 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -115,6 +115,7 @@ struct fpga_image_info {
  * @write_sg: write the scatter list of configuration data to the FPGA
  * @write_complete: set FPGA to operating state after writing is done
  * @fpga_remove: optional: Set FPGA into a specific state during driver remove
+ * @groups: optional attribute groups.
  *
  * fpga_manager_ops are the low level functions implemented by a specific
  * fpga manager driver.  The optional ones are tested for NULL before being
@@ -131,6 +132,7 @@ struct fpga_manager_ops {
 	int (*write_complete)(struct fpga_manager *mgr,
 			      struct fpga_image_info *info);
 	void (*fpga_remove)(struct fpga_manager *mgr);
+	const struct attribute_group **groups;
 };
 
 /**
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 7048449..b652031 100644
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
