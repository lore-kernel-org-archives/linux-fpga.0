Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [RFC 1/2] of: overlay: add whitelist
Date: Mon, 27 Nov 2017 14:58:03 -0600
Message-Id: <1511816284-12145-2-git-send-email-atull@kernel.org>
In-Reply-To: <1511816284-12145-1-git-send-email-atull@kernel.org>
References: <1511816284-12145-1-git-send-email-atull@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Add simple whitelist.  When an overlay is submitted, if any target in
the overlay is not in the whitelist, the overlay is rejected.  Drivers
that support dynamic configuration can register their device node with:

  int of_add_whitelist_node(struct device_node *np)

and remove themselves with:

  void of_remove_whitelist_node(struct device_node *np)

Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/of/overlay.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h   | 12 +++++++++
 2 files changed, 85 insertions(+)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index c150abb..5f952a1 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/idr.h>
+#include <linux/spinlock.h>
 
 #include "of_private.h"
 
@@ -646,6 +647,74 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 	kfree(ovcs);
 }
 
+/* lock for adding/removing device nodes to the whitelist */
+static spinlock_t whitelist_lock;
+
+static struct list_head whitelist_list = LIST_HEAD_INIT(whitelist_list);
+
+struct dt_overlay_whitelist {
+	struct device_node *np;
+	struct list_head node;
+};
+
+int of_add_whitelist_node(struct device_node *np)
+{
+	unsigned long flags;
+	struct dt_overlay_whitelist *wln;
+
+	wln = kzalloc(sizeof(*wln), GFP_KERNEL);
+	if (!wln)
+		return -ENOMEM;
+
+	wln->np = np;
+
+	spin_lock_irqsave(&whitelist_lock, flags);
+	list_add(&wln->node, &whitelist_list);
+	spin_unlock_irqrestore(&whitelist_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_add_whitelist_node);
+
+void of_remove_whitelist_node(struct device_node *np)
+{
+	struct dt_overlay_whitelist *wln;
+	unsigned long flags;
+
+	list_for_each_entry(wln, &whitelist_list, node) {
+		if (np == wln->np) {
+			spin_lock_irqsave(&whitelist_lock, flags);
+			list_del(&wln->node);
+			spin_unlock_irqrestore(&whitelist_lock, flags);
+			kfree(wln);
+			return;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(of_remove_whitelist_node);
+
+static int of_check_whitelist(struct overlay_changeset *ovcs)
+{
+	struct dt_overlay_whitelist *wln;
+	struct device_node *target;
+	int i;
+
+	for (i = 0; i < ovcs->count; i++) {
+		target = ovcs->fragments[i].target;
+		if (!of_node_cmp(target->name, "__symbols__"))
+			continue;
+
+		list_for_each_entry(wln, &whitelist_list, node)
+			if (target == wln->np)
+				break;
+
+		if (target != wln->np)
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
 /**
  * of_overlay_apply() - Create and apply an overlay changeset
  * @tree:	Expanded overlay device tree
@@ -717,6 +786,10 @@ int of_overlay_apply(struct device_node *tree, int *ovcs_id)
 	if (ret)
 		goto err_free_overlay_changeset;
 
+	ret = of_check_whitelist(ovcs);
+	if (ret)
+		goto err_free_overlay_changeset;
+
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
 	if (ret) {
 		pr_err("overlay changeset pre-apply notify error %d\n", ret);
diff --git a/include/linux/of.h b/include/linux/of.h
index d3dea1d..5bf652a1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1364,6 +1364,9 @@ int of_overlay_remove_all(void);
 int of_overlay_notifier_register(struct notifier_block *nb);
 int of_overlay_notifier_unregister(struct notifier_block *nb);
 
+int of_add_whitelist_node(struct device_node *np);
+void of_remove_whitelist_node(struct device_node *np);
+
 #else
 
 static inline int of_overlay_apply(struct device_node *tree, int *ovcs_id)
@@ -1391,6 +1394,15 @@ static inline int of_overlay_notifier_unregister(struct notifier_block *nb)
 	return 0;
 }
 
+static inline int of_add_whitelist_node(struct device_node *np)
+{
+	return 0;
+}
+
+static inline void of_remove_whitelist_node(struct device_node *np)
+{
+}
+
 #endif
 
 #endif /* _LINUX_OF_H */
-- 
2.7.4
