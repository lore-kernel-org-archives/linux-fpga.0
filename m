Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 1/2] of: overlay: add flag enabling overlays and enable fpga-region overlays
Date: Mon,  4 Dec 2017 13:13:56 -0600
Message-Id: <20171204191357.3211-2-atull@kernel.org>
In-Reply-To: <20171204191357.3211-1-atull@kernel.org>
References: <20171204191357.3211-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Alan Tull <atull@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Add a flag to struct device_node marking the node as a valid target
for device tree overlays.  When an overlay is submitted, if any target
in the overlay is not enabled for overlays, the overlay is rejected.
Drivers that support dynamic configuration can enable/disable their
device node with:

  void of_node_overlay_enable(struct device_node *np)
  void of_node_overlay_disable(struct device_node *np)

During each FPGA region's probe, enable its node for overlays.

Signed-off-by: Alan Tull <atull@kernel.org>
---
v1: (changes from the rfc)
    Add a flag instead of implementing a list
    rename functions for what they do, not how they're implemented
    squash with patch that enables fpga-region nodes
    add a helpful error message
---
 drivers/fpga/of-fpga-region.c |  4 ++++
 drivers/of/overlay.c          | 26 ++++++++++++++++++++++++++
 include/linux/of.h            | 19 +++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 119ff75..8633eea 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -438,6 +438,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 		goto eprobe_mgr_put;
 
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
+	of_node_overlay_enable(np);
 
 	dev_info(dev, "FPGA Region probed\n");
 
@@ -451,7 +452,10 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 static int of_fpga_region_remove(struct platform_device *pdev)
 {
 	struct fpga_region *region = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 
+	of_node_overlay_disable(np);
 	fpga_region_unregister(region);
 	fpga_mgr_put(region->mgr);
 
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 53bc9e3..a9758d6 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/idr.h>
+#include <linux/spinlock.h>
 
 #include "of_private.h"
 
@@ -646,6 +647,27 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 	kfree(ovcs);
 }
 
+static int of_overlay_check_targets(struct overlay_changeset *ovcs)
+{
+	struct device_node *target;
+	int i;
+
+	for (i = 0; i < ovcs->count; i++) {
+		target = ovcs->fragments[i].target;
+
+		if (!of_node_cmp(target->name, "__symbols__"))
+			continue;
+
+		if (!of_node_check_flag(target, OF_OVERLAY_ENABLED)) {
+			pr_err("Overlays not enabled for target %pOF\n",
+			       target);
+			return -EPERM;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * of_overlay_apply() - Create and apply an overlay changeset
  * @tree:	Expanded overlay device tree
@@ -717,6 +739,10 @@ int of_overlay_apply(struct device_node *tree, int *ovcs_id)
 	if (ret)
 		goto err_free_overlay_changeset;
 
+	ret = of_overlay_check_targets(ovcs);
+	if (ret)
+		goto err_free_overlay_changeset;
+
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
 	if (ret) {
 		pr_err("overlay changeset pre-apply notify error %d\n", ret);
diff --git a/include/linux/of.h b/include/linux/of.h
index d3dea1d..16a2cae 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -147,6 +147,7 @@ extern raw_spinlock_t devtree_lock;
 #define OF_DETACHED	2 /* node has been detached from the device tree */
 #define OF_POPULATED	3 /* device already created for the node */
 #define OF_POPULATED_BUS	4 /* of_platform_populate recursed to children of this node */
+#define OF_OVERLAY_ENABLED	5 /* allow DT overlay targeting this node */
 
 #define OF_BAD_ADDR	((u64)-1)
 
@@ -1364,6 +1365,16 @@ int of_overlay_remove_all(void);
 int of_overlay_notifier_register(struct notifier_block *nb);
 int of_overlay_notifier_unregister(struct notifier_block *nb);
 
+static inline void of_node_overlay_enable(struct device_node *np)
+{
+	of_node_set_flag(np, OF_OVERLAY_ENABLED);
+}
+
+static inline void of_node_overlay_disable(struct device_node *np)
+{
+	of_node_clear_flag(np, OF_OVERLAY_ENABLED);
+}
+
 #else
 
 static inline int of_overlay_apply(struct device_node *tree, int *ovcs_id)
@@ -1391,6 +1402,14 @@ static inline int of_overlay_notifier_unregister(struct notifier_block *nb)
 	return 0;
 }
 
+static inline void of_node_overlay_enable(struct device_node *np)
+{
+}
+
+static inline void of_node_overlay_disable(struct device_node *np)
+{
+}
+
 #endif
 
 #endif /* _LINUX_OF_H */
-- 
2.7.4
