Return-Path: <SRS0=CYgq=NU=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=CYgq=NU=gmail.com=frowand.list@kernel.org>
From: frowand.list@gmail.com
Subject: [PATCH v7 08/17] of: overlay: validate overlay properties #address-cells and #size-cells
Date: Thu,  8 Nov 2018 22:05:56 -0800
Message-Id: <1541743565-23163-9-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
References: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

From: Frank Rowand <frank.rowand@sony.com>

If overlay properties #address-cells or #size-cells are already in
the live devicetree for any given node, then the values in the
overlay must match the values in the live tree.

If the properties are already in the live tree then there is no
need to create a changeset entry to add them since they must
have the same value.  This reduces the memory used by the
changeset and eliminates a possible memory leak.

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 32 +++++++++++++++++++++++++++++---
 include/linux/of.h   |  6 ++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 15be3da34fef..72bf00adb9c8 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -287,7 +287,12 @@ static struct property *dup_and_fixup_symbol_prop(
  * @target may be either in the live devicetree or in a new subtree that
  * is contained in the changeset.
  *
- * Some special properties are not updated (no error returned).
+ * Some special properties are not added or updated (no error returned):
+ * "name", "phandle", "linux,phandle".
+ *
+ * Properties "#address-cells" and "#size-cells" are not updated if they
+ * are already in the live tree, but if present in the live tree, the values
+ * in the overlay must match the values in the live tree.
  *
  * Update of property in symbols node is not allowed.
  *
@@ -300,6 +305,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 {
 	struct property *new_prop = NULL, *prop;
 	int ret = 0;
+	bool check_for_non_overlay_node = false;
 
 	if (!of_prop_cmp(overlay_prop->name, "name") ||
 	    !of_prop_cmp(overlay_prop->name, "phandle") ||
@@ -322,12 +328,32 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 	if (!new_prop)
 		return -ENOMEM;
 
-	if (!prop)
+	if (!prop) {
+		check_for_non_overlay_node = true;
 		ret = of_changeset_add_property(&ovcs->cset, target->np,
 						new_prop);
-	else
+	} else if (!of_prop_cmp(prop->name, "#address-cells")) {
+		if (!of_prop_val_eq(prop, new_prop)) {
+			pr_err("ERROR: changing value of #address-cells is not allowed in %pOF\n",
+			       target->np);
+			ret = -EINVAL;
+		}
+	} else if (!of_prop_cmp(prop->name, "#size-cells")) {
+		if (!of_prop_val_eq(prop, new_prop)) {
+			pr_err("ERROR: changing value of #size-cells is not allowed in %pOF\n",
+			       target->np);
+			ret = -EINVAL;
+		}
+	} else {
+		check_for_non_overlay_node = true;
 		ret = of_changeset_update_property(&ovcs->cset, target->np,
 						   new_prop);
+	}
+
+	if (check_for_non_overlay_node &&
+	    !of_node_check_flag(target->np, OF_OVERLAY))
+		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
+		       target->np, new_prop->name);
 
 	if (ret) {
 		kfree(new_prop->name);
diff --git a/include/linux/of.h b/include/linux/of.h
index 664cd5573ae2..18ac8921e90c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -990,6 +990,12 @@ static inline int of_map_rid(struct device_node *np, u32 rid,
 #define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
 #endif
 
+static inline int of_prop_val_eq(struct property *p1, struct property *p2)
+{
+	return p1->length == p2->length &&
+	       !memcmp(p1->value, p2->value, (size_t)p1->length);
+}
+
 #if defined(CONFIG_OF) && defined(CONFIG_NUMA)
 extern int of_node_to_nid(struct device_node *np);
 #else
-- 
Frank Rowand <frank.rowand@sony.com>
