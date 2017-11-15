Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v6 14/18] fpga: region: add fpga_region_class_find
Date: Wed, 15 Nov 2017 14:20:24 -0600
Message-Id: <1510777228-4291-15-git-send-email-atull@kernel.org>
In-Reply-To: <1510777228-4291-1-git-send-email-atull@kernel.org>
References: <1510777228-4291-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
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
v5: no change to this patch in this version of patchset
v6: no change to this patch in this version of patchset
---
 drivers/fpga/fpga-region.c       | 23 +++++++++++++++--------
 include/linux/fpga/fpga-region.h |  5 ++++-
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 76db81d..5c086957 100644
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
index 8c8a3249f..7048449 100644
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
