Return-Path: <SRS0=JvJ4=M4=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=JvJ4=M4=gmail.com=frowand.list@kernel.org>
From: frowand.list@gmail.com
Subject: [PATCH v4 13/18] of: overlay: check prevents multiple fragments touching same property
Date: Mon, 15 Oct 2018 19:37:33 -0700
Message-Id: <1539657458-24401-14-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

From: Frank Rowand <frank.rowand@sony.com>

Add test case of two fragments updating the same property.  After
adding the test case, the system hangs at end of boot, after
after slub stack dumps from kfree() in crypto modprobe code.

Multiple overlay fragments adding, modifying, or deleting the same
property is not supported.  Add check to detect the attempt and fail
the overlay apply.

Before this patch, the first fragment error would terminate
processing.  Allow fragment checking to proceed and report all
of the fragment errors before terminating the overlay apply. This
is not a hot path, thus not a performance issue (the error is not
transient and requires fixing the overlay before attempting to
apply it again).

After applying this patch, the devicetree unittest messages will
include:

   OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/rpm_avail

   ...

   ### dt-test ### end of unittest - 212 passed, 0 failed

The check to detect two fragments updating the same property is
folded into the patch that created the test case to maintain
bisectability.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
Changes since v3:
  - Update patch comment header to state that this patch modifies the
    previous patch to not return immediately on fragment error and
    explain this is not a performance issue.
  - remove redundant "overlay" from two error messages.  "OF: overlay:"
    is already present in pr_fmt()

 drivers/of/overlay.c                               | 118 ++++++++++++++-------
 drivers/of/unittest-data/Makefile                  |   1 +
 .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 +++++
 drivers/of/unittest-data/overlay_base.dts          |   1 +
 drivers/of/unittest.c                              |   5 +
 5 files changed, 112 insertions(+), 37 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 0dc7452e2ed5..01afd22566ed 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -518,52 +518,96 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
 	return 0;
 }
 
+static int find_dup_cset_node_entry(struct overlay_changeset *ovcs,
+		struct of_changeset_entry *ce_1)
+{
+	struct of_changeset_entry *ce_2;
+	char *fn_1, *fn_2;
+	int node_path_match;
+
+	if (ce_1->action != OF_RECONFIG_ATTACH_NODE &&
+	    ce_1->action != OF_RECONFIG_DETACH_NODE)
+		return 0;
+
+	ce_2 = ce_1;
+	list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
+		if ((ce_2->action != OF_RECONFIG_ATTACH_NODE &&
+		     ce_2->action != OF_RECONFIG_DETACH_NODE) ||
+		    of_node_cmp(ce_1->np->full_name, ce_2->np->full_name))
+			continue;
+
+		fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
+		fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
+		node_path_match = !strcmp(fn_1, fn_2);
+		kfree(fn_1);
+		kfree(fn_2);
+		if (node_path_match) {
+			pr_err("ERROR: multiple fragments add and/or delete node %pOF\n",
+			       ce_1->np);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int find_dup_cset_prop(struct overlay_changeset *ovcs,
+		struct of_changeset_entry *ce_1)
+{
+	struct of_changeset_entry *ce_2;
+	char *fn_1, *fn_2;
+	int node_path_match;
+
+	if (ce_1->action != OF_RECONFIG_ADD_PROPERTY &&
+	    ce_1->action != OF_RECONFIG_REMOVE_PROPERTY &&
+	    ce_1->action != OF_RECONFIG_UPDATE_PROPERTY)
+		return 0;
+
+	ce_2 = ce_1;
+	list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
+		if ((ce_2->action != OF_RECONFIG_ADD_PROPERTY &&
+		     ce_2->action != OF_RECONFIG_REMOVE_PROPERTY &&
+		     ce_2->action != OF_RECONFIG_UPDATE_PROPERTY) ||
+		    of_node_cmp(ce_1->np->full_name, ce_2->np->full_name))
+			continue;
+
+		fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
+		fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
+		node_path_match = !strcmp(fn_1, fn_2);
+		kfree(fn_1);
+		kfree(fn_2);
+		if (node_path_match &&
+		    !of_prop_cmp(ce_1->prop->name, ce_2->prop->name)) {
+			pr_err("ERROR: multiple fragments add, update, and/or delete property %pOF/%s\n",
+			       ce_1->np, ce_1->prop->name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /**
- * check_changeset_dup_add_node() - changeset validation: duplicate add node
+ * changeset_dup_entry_check() - check for duplicate entries
  * @ovcs:	Overlay changeset
  *
- * Check changeset @ovcs->cset for multiple add node entries for the same
- * node.
+ * Check changeset @ovcs->cset for multiple {add or delete} node entries for
+ * the same node or duplicate {add, delete, or update} properties entries
+ * for the same property.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
- * invalid overlay in @ovcs->fragments[].
+ * Returns 0 on success, or -EINVAL if duplicate changeset entry found.
  */
-static int check_changeset_dup_add_node(struct overlay_changeset *ovcs)
+static int changeset_dup_entry_check(struct overlay_changeset *ovcs)
 {
-	struct of_changeset_entry *ce_1, *ce_2;
-	char *fn_1, *fn_2;
-	int name_match;
+	struct of_changeset_entry *ce_1;
+	int dup_entry = 0;
 
 	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
-
-		if (ce_1->action == OF_RECONFIG_ATTACH_NODE ||
-		    ce_1->action == OF_RECONFIG_DETACH_NODE) {
-
-			ce_2 = ce_1;
-			list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
-				if (ce_2->action == OF_RECONFIG_ATTACH_NODE ||
-				    ce_2->action == OF_RECONFIG_DETACH_NODE) {
-					/* inexpensive name compare */
-					if (!of_node_cmp(ce_1->np->full_name,
-					    ce_2->np->full_name)) {
-						/* expensive full path name compare */
-						fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
-						fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
-						name_match = !strcmp(fn_1, fn_2);
-						kfree(fn_1);
-						kfree(fn_2);
-						if (name_match) {
-							pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
-							       ce_1->np);
-							return -EINVAL;
-						}
-					}
-				}
-			}
-		}
+		dup_entry |= find_dup_cset_node_entry(ovcs, ce_1);
+		dup_entry |= find_dup_cset_prop(ovcs, ce_1);
 	}
 
-	return 0;
+	return dup_entry ? -EINVAL : 0;
 }
 
 /**
@@ -621,7 +665,7 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		}
 	}
 
-	return check_changeset_dup_add_node(ovcs);
+	return changeset_dup_entry_check(ovcs);
 }
 
 /*
diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index 166dbdbfd1c5..9b6807065827 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
 			    overlay_13.dtb.o \
 			    overlay_15.dtb.o \
 			    overlay_bad_add_dup_node.dtb.o \
+			    overlay_bad_add_dup_prop.dtb.o \
 			    overlay_bad_phandle.dtb.o \
 			    overlay_bad_symbol.dtb.o \
 			    overlay_base.dtb.o
diff --git a/drivers/of/unittest-data/overlay_bad_add_dup_prop.dts b/drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
new file mode 100644
index 000000000000..c190da54f175
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/*
+ * &electric_1/motor-1 and &spin_ctrl_1 are the same node:
+ *   /testcase-data-2/substation@100/motor-1
+ *
+ * Thus the property "rpm_avail" in each fragment will
+ * result in an attempt to update the same property twice.
+ * This will result in an error and the overlay apply
+ * will fail.
+ */
+
+&electric_1 {
+
+	motor-1 {
+		rpm_avail = < 100 >;
+	};
+};
+
+&spin_ctrl_1 {
+		rpm_avail = < 100 200 >;
+};
diff --git a/drivers/of/unittest-data/overlay_base.dts b/drivers/of/unittest-data/overlay_base.dts
index 820b79ca378a..99ab9d12d00b 100644
--- a/drivers/of/unittest-data/overlay_base.dts
+++ b/drivers/of/unittest-data/overlay_base.dts
@@ -30,6 +30,7 @@
 			spin_ctrl_1: motor-1 {
 				compatible = "ot,ferris-wheel-motor";
 				spin = "clockwise";
+				rpm_avail = < 50 >;
 			};
 
 			spin_ctrl_2: motor-8 {
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 471b8eb6e842..efd9c947f192 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2148,6 +2148,7 @@ struct overlay_info {
 OVERLAY_INFO_EXTERN(overlay_13);
 OVERLAY_INFO_EXTERN(overlay_15);
 OVERLAY_INFO_EXTERN(overlay_bad_add_dup_node);
+OVERLAY_INFO_EXTERN(overlay_bad_add_dup_prop);
 OVERLAY_INFO_EXTERN(overlay_bad_phandle);
 OVERLAY_INFO_EXTERN(overlay_bad_symbol);
 
@@ -2171,6 +2172,7 @@ struct overlay_info {
 	OVERLAY_INFO(overlay_13, 0),
 	OVERLAY_INFO(overlay_15, 0),
 	OVERLAY_INFO(overlay_bad_add_dup_node, -EINVAL),
+	OVERLAY_INFO(overlay_bad_add_dup_prop, -EINVAL),
 	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
 	OVERLAY_INFO(overlay_bad_symbol, -EINVAL),
 	{}
@@ -2418,6 +2420,9 @@ static __init void of_unittest_overlay_high_level(void)
 	unittest(overlay_data_apply("overlay_bad_add_dup_node", NULL),
 		 "Adding overlay 'overlay_bad_add_dup_node' failed\n");
 
+	unittest(overlay_data_apply("overlay_bad_add_dup_prop", NULL),
+		 "Adding overlay 'overlay_bad_add_dup_prop' failed\n");
+
 	unittest(overlay_data_apply("overlay_bad_phandle", NULL),
 		 "Adding overlay 'overlay_bad_phandle' failed\n");
 
-- 
Frank Rowand <frank.rowand@sony.com>
