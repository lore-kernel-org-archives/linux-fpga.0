Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v3 4/4] fpga: region: change fpga_region_register to have one param
Date: Wed,  7 Feb 2018 15:05:30 -0600
Message-Id: <20180207210530.3099-5-atull@kernel.org>
In-Reply-To: <20180207210530.3099-1-atull@kernel.org>
References: <20180207210530.3099-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Anatolij Gustschin <agust@denx.de>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, Joel Holdsworth <joel@airwebreathe.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Joshua Clayton <stillcompiling@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Change fpga_region_register to only take one parameter:

  int fpga_region_register(struct fpga_region *region)

The parent dev is added to struct fpga_region.

This make it similar to fpga_bridge_register and fpga_mgr_register
which also just take their respective struct.

The one caller of fpga_region_register is changed to alloc the
fpga_region struct, fill it in, and pass it to the register
function.

Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: This patch added in this version of the patchset
v3: minor changes to make diffs smaller and more obviously correct
---
 Documentation/fpga/fpga-region.txt | 3 +--
 drivers/fpga/fpga-region.c         | 8 +++++++-
 drivers/fpga/of-fpga-region.c      | 3 ++-
 include/linux/fpga/fpga-region.h   | 4 +++-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/fpga/fpga-region.txt b/Documentation/fpga/fpga-region.txt
index 139a02b..d38fa3b 100644
--- a/Documentation/fpga/fpga-region.txt
+++ b/Documentation/fpga/fpga-region.txt
@@ -42,8 +42,7 @@ The FPGA region API
 To register or unregister a region:
 -----------------------------------
 
-	int fpga_region_register(struct device *dev,
-				 struct fpga_region *region);
+	int fpga_region_register(struct fpga_region *region);
 	int fpga_region_unregister(struct fpga_region *region);
 
 An example of usage can be seen in the probe function of [3]
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index ebe1f87..660a91b 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -162,10 +162,16 @@ int fpga_region_program_fpga(struct fpga_region *region)
 }
 EXPORT_SYMBOL_GPL(fpga_region_program_fpga);
 
-int fpga_region_register(struct device *dev, struct fpga_region *region)
+int fpga_region_register(struct fpga_region *region)
 {
+	struct device *dev = region->parent;
 	int id, ret = 0;
 
+	if (!dev) {
+		pr_err("Attempt to register fpga region without parent\n");
+		return -EINVAL;
+	}
+
 	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		return id;
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 35e7e8c..a7b38aa 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -428,12 +428,13 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 		goto eprobe_mgr_put;
 	}
 
+	region->parent = dev;
 	region->mgr = mgr;
 
 	/* Specify how to get bridges for this type of region. */
 	region->get_bridges = of_fpga_region_get_bridges;
 
-	ret = fpga_region_register(dev, region);
+	ret = fpga_region_register(region);
 	if (ret)
 		goto eprobe_mgr_put;
 
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index b652031..423c87e 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -8,6 +8,7 @@
 /**
  * struct fpga_region - FPGA Region structure
  * @dev: FPGA Region device
+ * @parent: parent device
  * @mutex: enforces exclusive reference to region
  * @bridge_list: list of FPGA bridges specified in region
  * @mgr: FPGA manager
@@ -18,6 +19,7 @@
  */
 struct fpga_region {
 	struct device dev;
+	struct device *parent;
 	struct mutex mutex; /* for exclusive reference to region */
 	struct list_head bridge_list;
 	struct fpga_manager *mgr;
@@ -34,7 +36,7 @@ struct fpga_region *fpga_region_class_find(
 	int (*match)(struct device *, const void *));
 
 int fpga_region_program_fpga(struct fpga_region *region);
-int fpga_region_register(struct device *dev, struct fpga_region *region);
+int fpga_region_register(struct fpga_region *region);
 int fpga_region_unregister(struct fpga_region *region);
 
 #endif /* _FPGA_REGION_H */
-- 
2.7.4
