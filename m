Return-Path: <SRS0=63Yb=M3=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=63Yb=M3=gmail.com=frowand.list@kernel.org>
From: frowand.list@gmail.com
Subject: [PATCH v3 09/18] of: overlay: validate overlay properties #address-cells and #size-cells
Date: Sun, 14 Oct 2018 17:24:21 -0700
Message-Id: <1539563070-12969-10-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
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
changeset and eliminates a possible memory leak.  This is
verified by 12 fewer warnings during the devicetree unittest,
as the possible memory leak warnings about #address-cells and

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 272a0d1a5e18..ee66651db553 100644
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
@@ -322,13 +328,39 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 	if (!new_prop)
 		return -ENOMEM;
 
-	if (!prop)
+	if (!prop) {
+
+		check_for_non_overlay_node = true;
 		ret = of_changeset_add_property(&ovcs->cset, target->np,
 						new_prop);
-	else
+
+	} else if (!of_prop_cmp(prop->name, "#address-cells")) {
+
+		if (prop->length != 4 || new_prop->length != 4 ||
+		    *(u32 *)prop->value != *(u32 *)new_prop->value)
+			pr_err("ERROR: overlay and/or live tree #address-cells invalid in node %pOF\n",
+			       target->np);
+
+	} else if (!of_prop_cmp(prop->name, "#size-cells")) {
+
+		if (prop->length != 4 || new_prop->length != 4 ||
+		    *(u32 *)prop->value != *(u32 *)new_prop->value)
+			pr_err("ERROR: overlay and/or live tree #size-cells invalid in node %pOF\n",
+			       target->np);
+
+	} else {
+
+		check_for_non_overlay_node = true;
 		ret = of_changeset_update_property(&ovcs->cset, target->np,
 						   new_prop);
 
+	}
+
+	if (check_for_non_overlay_node &&
+	    !of_node_check_flag(target->np, OF_OVERLAY))
+		pr_err("WARNING: %s(), memory leak will occur if overlay removed.  Property: %pOF/%s\n",
+		       __func__, target->np, new_prop->name);
+
 	if (ret) {
 		kfree(new_prop->name);
 		kfree(new_prop->value);
-- 
Frank Rowand <frank.rowand@sony.com>
