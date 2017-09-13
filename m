Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v4 14/18] fpga: region: add fpga_region_class_find
Date: Wed, 13 Sep 2017 15:48:37 -0500
Message-Id: <20170913204841.2730-15-atull@kernel.org>
In-Reply-To: <20170913204841.2730-1-atull@kernel.org>
References: <20170913204841.2730-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Add a function for searching the fpga-region class.  This
will be useful when device tree code is no longer in the
same file that declares the fpga-region class.  Another
step in separating common FPGA region code from device
tree support.

Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v2: split out from another patch
v3: add Moritz' ack
v4: no change to this patch in this version of patchset
---
 drivers/fpga/fpga-region.c       | 23 +++++++++++++++--------
 include/linux/fpga/fpga-region.h |  5 ++++-
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index ce57383..5f2fa5f6 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -30,6 +30,20 @@
 static DEFINE_IDA(fpga_region_ida);
 static struct class *fpga_region_class;
 
+struct fpga_region *fpga_region_class_find(
+	struct device *start, const void *data,
+	int (*match)(struct device *, const void *))
+{
+	struct device *dev;
+
+	dev = class_find_device(fpga_region_class, start, data, match);
+	if (!dev)
+		return NULL;
+
+	return to_fpga_region(dev);
+}
+EXPORT_SYMBOL_GPL(fpga_region_class_find);
+
 static const struct of_device_id fpga_region_of_match[] = {
 	{ .compatible = "fpga-region", },
 	{},
@@ -51,14 +65,7 @@ static int fpga_region_of_node_match(struct device *dev, const void *data)
  */
 static struct fpga_region *of_fpga_region_find(struct device_node *np)
 {
-	struct device *dev;
-
-	dev = class_find_device(fpga_region_class, NULL, np,
-				fpga_region_of_node_match);
-	if (!dev)
-		return NULL;
-
-	return to_fpga_region(dev);
+	return fpga_region_class_find(NULL, np, fpga_region_of_node_match);
 }
 
 /**
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 76dda68..f2eecdd 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -27,8 +27,11 @@ struct fpga_region {
 
 #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
 
-int fpga_region_program_fpga(struct fpga_region *region);
+struct fpga_region *fpga_region_class_find(
+	struct device *start, const void *data,
+	int (*match)(struct device *, const void *));
 
+int fpga_region_program_fpga(struct fpga_region *region);
 int fpga_region_register(struct device *dev, struct fpga_region *region);
 int fpga_region_unregister(struct fpga_region *region);
 
-- 
2.7.4
