Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 2/5] fpga-bridge: support getting bridge from device
Date: Mon, 13 Mar 2017 16:53:30 -0500
Message-Id: <20170313215333.3008-3-atull@kernel.org>
In-Reply-To: <20170313215333.3008-1-atull@kernel.org>
References: <20170313215333.3008-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Add two functions for getting the FPGA bridge from the device
rather than device tree node.  This is to enable writing code
that will support using FPGA bridges without device tree.
Rename one old function to make it clear that it is device
tree-ish.

* fpga_bridge_get
  Get the bridge given the device.

* fpga_bridges_get_to_list
  Given the device, get the bridge and add it to a list.

* of_fpga_bridges_get_to_list
  Renamed from priviously existing fpga_bridges_get_to_list.
  Given the device node, get the bridge and add it to a list.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/fpga-bridge.c       | 107 +++++++++++++++++++++++++++++++--------
 drivers/fpga/fpga-region.c       |   8 +--
 include/linux/fpga/fpga-bridge.h |   7 ++-
 3 files changed, 95 insertions(+), 27 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 0f8b7dc..11fd40c 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -70,29 +70,12 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_disable);
 
-/**
- * of_fpga_bridge_get - get an exclusive reference to a fpga bridge
- *
- * @np: node pointer of a FPGA bridge
- * @info: fpga image specific information
- *
- * Return fpga_bridge struct if successful.
- * Return -EBUSY if someone already has a reference to the bridge.
- * Return -ENODEV if @np is not a FPGA Bridge.
- */
-struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
-				       struct fpga_image_info *info)
-
+struct fpga_bridge *__fpga_bridge_get(struct device *dev,
+				      struct fpga_image_info *info)
 {
-	struct device *dev;
 	struct fpga_bridge *bridge;
 	int ret = -ENODEV;
 
-	dev = class_find_device(fpga_bridge_class, NULL, np,
-				fpga_bridge_of_node_match);
-	if (!dev)
-		goto err_dev;
-
 	bridge = to_fpga_bridge(dev);
 	if (!bridge)
 		goto err_dev;
@@ -117,8 +100,58 @@ struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
 	put_device(dev);
 	return ERR_PTR(ret);
 }
+
+/**
+ * of_fpga_bridge_get - get an exclusive reference to a fpga bridge
+ *
+ * @np: node pointer of a FPGA bridge
+ * @info: fpga image specific information
+ *
+ * Return fpga_bridge struct if successful.
+ * Return -EBUSY if someone already has a reference to the bridge.
+ * Return -ENODEV if @np is not a FPGA Bridge.
+ */
+struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
+				       struct fpga_image_info *info)
+{
+	struct device *dev;
+
+	dev = class_find_device(fpga_bridge_class, NULL, np,
+				fpga_bridge_of_node_match);
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+
+	return __fpga_bridge_get(dev, info);
+}
 EXPORT_SYMBOL_GPL(of_fpga_bridge_get);
 
+static int fpga_bridge_dev_match(struct device *dev, const void *data)
+{
+	return dev->parent == data;
+}
+
+/**
+ * fpga_bridge_get - get an exclusive reference to a fpga bridge
+ * @dev:	parent device that fpga bridge was registered with
+ *
+ * Given a device, get an exclusive reference to a fpga bridge.
+ *
+ * Return: fpga manager struct or IS_ERR() condition containing error code.
+ */
+struct fpga_bridge *fpga_bridge_get(struct device *dev,
+				    struct fpga_image_info *info)
+{
+	struct device *bridge_dev;
+
+	bridge_dev = class_find_device(fpga_bridge_class, NULL, dev,
+				       fpga_bridge_dev_match);
+	if (!bridge_dev)
+		return ERR_PTR(-ENODEV);
+
+	return __fpga_bridge_get(bridge_dev, info);
+}
+EXPORT_SYMBOL_GPL(fpga_bridge_get);
+
 /**
  * fpga_bridge_put - release a reference to a bridge
  *
@@ -213,7 +246,7 @@ void fpga_bridges_put(struct list_head *bridge_list)
 EXPORT_SYMBOL_GPL(fpga_bridges_put);
 
 /**
- * fpga_bridges_get_to_list - get a bridge, add it to a list
+ * of_fpga_bridge_get_to_list - get a bridge, add it to a list
  *
  * @np: node pointer of a FPGA bridge
  * @info: fpga image specific information
@@ -223,14 +256,44 @@ EXPORT_SYMBOL_GPL(fpga_bridges_put);
  *
  * Return 0 for success, error code from of_fpga_bridge_get() othewise.
  */
-int fpga_bridge_get_to_list(struct device_node *np,
+int of_fpga_bridge_get_to_list(struct device_node *np,
+			       struct fpga_image_info *info,
+			       struct list_head *bridge_list)
+{
+	struct fpga_bridge *bridge;
+	unsigned long flags;
+
+	bridge = of_fpga_bridge_get(np, info);
+	if (IS_ERR(bridge))
+		return PTR_ERR(bridge);
+
+	spin_lock_irqsave(&bridge_list_lock, flags);
+	list_add(&bridge->node, bridge_list);
+	spin_unlock_irqrestore(&bridge_list_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_fpga_bridge_get_to_list);
+
+/**
+ * fpga_bridge_get_to_list - given device, get a bridge, add it to a list
+ *
+ * @dev: FPGA bridge device
+ * @info: fpga image specific information
+ * @bridge_list: list of FPGA bridges
+ *
+ * Get an exclusive reference to the bridge and and it to the list.
+ *
+ * Return 0 for success, error code from fpga_bridge_get() othewise.
+ */
+int fpga_bridge_get_to_list(struct device *dev,
 			    struct fpga_image_info *info,
 			    struct list_head *bridge_list)
 {
 	struct fpga_bridge *bridge;
 	unsigned long flags;
 
-	bridge = of_fpga_bridge_get(np, info);
+	bridge = fpga_bridge_get(dev, info);
 	if (IS_ERR(bridge))
 		return PTR_ERR(bridge);
 
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 24f4ed5..294556e 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -183,8 +183,8 @@ static int fpga_region_get_bridges(struct fpga_region *region,
 	int i, ret;
 
 	/* If parent is a bridge, add to list */
-	ret = fpga_bridge_get_to_list(region_np->parent, region->info,
-				      &region->bridge_list);
+	ret = of_fpga_bridge_get_to_list(region_np->parent, region->info,
+					 &region->bridge_list);
 	if (ret == -EBUSY)
 		return ret;
 
@@ -207,8 +207,8 @@ static int fpga_region_get_bridges(struct fpga_region *region,
 			continue;
 
 		/* If node is a bridge, get it and add to list */
-		ret = fpga_bridge_get_to_list(br, region->info,
-					      &region->bridge_list);
+		ret = of_fpga_bridge_get_to_list(br, region->info,
+						 &region->bridge_list);
 
 		/* If any of the bridges are in use, give up */
 		if (ret == -EBUSY) {
diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
index dba6e3c..9f6696b 100644
--- a/include/linux/fpga/fpga-bridge.h
+++ b/include/linux/fpga/fpga-bridge.h
@@ -42,6 +42,8 @@ struct fpga_bridge {
 
 struct fpga_bridge *of_fpga_bridge_get(struct device_node *node,
 				       struct fpga_image_info *info);
+struct fpga_bridge *fpga_bridge_get(struct device *dev,
+				    struct fpga_image_info *info);
 void fpga_bridge_put(struct fpga_bridge *bridge);
 int fpga_bridge_enable(struct fpga_bridge *bridge);
 int fpga_bridge_disable(struct fpga_bridge *bridge);
@@ -49,9 +51,12 @@ int fpga_bridge_disable(struct fpga_bridge *bridge);
 int fpga_bridges_enable(struct list_head *bridge_list);
 int fpga_bridges_disable(struct list_head *bridge_list);
 void fpga_bridges_put(struct list_head *bridge_list);
-int fpga_bridge_get_to_list(struct device_node *np,
+int fpga_bridge_get_to_list(struct device *dev,
 			    struct fpga_image_info *info,
 			    struct list_head *bridge_list);
+int of_fpga_bridge_get_to_list(struct device_node *np,
+			       struct fpga_image_info *info,
+			       struct list_head *bridge_list);
 
 int fpga_bridge_register(struct device *dev, const char *name,
 			 const struct fpga_bridge_ops *br_ops, void *priv);
-- 
2.7.4
