Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 4/8] fpga: add devm_fpga_region_create
Date: Tue, 14 Aug 2018 14:15:22 -0500
Message-Id: <20180814191526.3247-5-atull@kernel.org>
In-Reply-To: <20180814191526.3247-1-atull@kernel.org>
References: <20180814191526.3247-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Add devm_fpga_region_create() which is the
managed version of fpga_region_create().

Change current region drivers to use
devm_fpga_region_create().

Signed-off-by: Alan Tull <atull@kernel.org>
---
 Documentation/driver-api/fpga/fpga-region.rst |  3 ++
 drivers/fpga/dfl-fme-region.c                 |  6 +--
 drivers/fpga/dfl.c                            |  6 +--
 drivers/fpga/fpga-region.c                    | 68 +++++++++++++++++++++++----
 drivers/fpga/of-fpga-region.c                 |  6 +--
 include/linux/fpga/fpga-region.h              |  4 ++
 6 files changed, 73 insertions(+), 20 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
index f30333c..dc9f75c 100644
--- a/Documentation/driver-api/fpga/fpga-region.rst
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -90,6 +90,9 @@ API to add a new FPGA region
    :functions: fpga_region
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
+   :functions: devm_fpga_region_create
+
+.. kernel-doc:: drivers/fpga/fpga-region.c
    :functions: fpga_region_create
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 51a5ac2..ec134ec 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -39,7 +39,7 @@ static int fme_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = fpga_region_create(dev, mgr, fme_region_get_bridges);
+	region = devm_fpga_region_create(dev, mgr, fme_region_get_bridges);
 	if (!region) {
 		ret = -ENOMEM;
 		goto eprobe_mgr_put;
@@ -51,14 +51,12 @@ static int fme_region_probe(struct platform_device *pdev)
 
 	ret = fpga_region_register(region);
 	if (ret)
-		goto region_free;
+		goto eprobe_mgr_put;
 
 	dev_dbg(dev, "DFL FME FPGA Region probed\n");
 
 	return 0;
 
-region_free:
-	fpga_region_free(region);
 eprobe_mgr_put:
 	fpga_mgr_put(mgr);
 	return ret;
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index a9b521b..2c09e50 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -899,7 +899,7 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
 
-	cdev->region = fpga_region_create(info->dev, NULL, NULL);
+	cdev->region = devm_fpga_region_create(info->dev, NULL, NULL);
 	if (!cdev->region) {
 		ret = -ENOMEM;
 		goto free_cdev_exit;
@@ -911,7 +911,7 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
 
 	ret = fpga_region_register(cdev->region);
 	if (ret)
-		goto free_region_exit;
+		goto free_cdev_exit;
 
 	/* create and init build info for enumeration */
 	binfo = devm_kzalloc(info->dev, sizeof(*binfo), GFP_KERNEL);
@@ -942,8 +942,6 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
 
 unregister_region_exit:
 	fpga_region_unregister(cdev->region);
-free_region_exit:
-	fpga_region_free(cdev->region);
 free_cdev_exit:
 	devm_kfree(info->dev, cdev);
 	return ERR_PTR(ret);
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 0d65220..56f773d 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -185,6 +185,10 @@ ATTRIBUTE_GROUPS(fpga_region);
  * @mgr: manager that programs this region
  * @get_bridges: optional function to get bridges to a list
  *
+ * The caller of this function is responsible for freeing the resulting region
+ * struct with fpga_region_free().  Using devm_fpga_region_create() instead is
+ * recommended.
+ *
  * Return: struct fpga_region or NULL
  */
 struct fpga_region
@@ -230,8 +234,8 @@ struct fpga_region
 EXPORT_SYMBOL_GPL(fpga_region_create);
 
 /**
- * fpga_region_free - free a struct fpga_region
- * @region: FPGA region created by fpga_region_create
+ * fpga_region_free - free a FPGA region created by fpga_region_create()
+ * @region: FPGA region
  */
 void fpga_region_free(struct fpga_region *region)
 {
@@ -240,21 +244,72 @@ void fpga_region_free(struct fpga_region *region)
 }
 EXPORT_SYMBOL_GPL(fpga_region_free);
 
+static void devm_fpga_region_release(struct device *dev, void *res)
+{
+	struct fpga_region *region = *(struct fpga_region **)res;
+
+	fpga_region_free(region);
+}
+
+/**
+ * devm_fpga_region_create - create and initialize a managed FPGA region struct
+ * @dev: device parent
+ * @mgr: manager that programs this region
+ * @get_bridges: optional function to get bridges to a list
+ *
+ * This function is intended for use in a FPGA region driver's probe function.
+ * After the region driver creates the region struct with
+ * devm_fpga_region_create(), it should register it with fpga_region_register().
+ * The region driver's remove function should call fpga_region_unregister().
+ * The region struct allocated with this function will be freed automatically on
+ * driver detach.  This includes the case of a probe function returning error
+ * before calling fpga_region_register(), the struct will still get cleaned up.
+ *
+ * Return: struct fpga_region or NULL
+ */
+struct fpga_region
+*devm_fpga_region_create(struct device *dev,
+			 struct fpga_manager *mgr,
+			 int (*get_bridges)(struct fpga_region *))
+{
+	struct fpga_region **ptr, *region;
+
+	ptr = devres_alloc(devm_fpga_region_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	region = fpga_region_create(dev, mgr, get_bridges);
+	if (!region) {
+		devres_free(ptr);
+	} else {
+		*ptr = region;
+		devres_add(dev, ptr);
+	}
+
+	return region;
+}
+EXPORT_SYMBOL_GPL(devm_fpga_region_create);
+
 /**
  * fpga_region_register - register a FPGA region
- * @region: FPGA region created by fpga_region_create
+ * @region: FPGA region
+ *
  * Return: 0 or -errno
  */
 int fpga_region_register(struct fpga_region *region)
 {
 	return device_add(&region->dev);
-
 }
 EXPORT_SYMBOL_GPL(fpga_region_register);
 
 /**
- * fpga_region_unregister - unregister and free a FPGA region
+ * fpga_region_unregister - unregister a FPGA region
  * @region: FPGA region
+ *
+ * This function is intended for use in a FPGA region driver's remove function.
+ * If the region was created by devm_fpga_region_create(), it will be
+ * automatically freed.  If the region was created by fpga_region_create(), the
+ * caller is responsible for freeing it with fpga_region_free().
  */
 void fpga_region_unregister(struct fpga_region *region)
 {
@@ -264,9 +319,6 @@ EXPORT_SYMBOL_GPL(fpga_region_unregister);
 
 static void fpga_region_dev_release(struct device *dev)
 {
-	struct fpga_region *region = to_fpga_region(dev);
-
-	fpga_region_free(region);
 }
 
 /**
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 052a134..122286f 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -410,7 +410,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = fpga_region_create(dev, mgr, of_fpga_region_get_bridges);
+	region = devm_fpga_region_create(dev, mgr, of_fpga_region_get_bridges);
 	if (!region) {
 		ret = -ENOMEM;
 		goto eprobe_mgr_put;
@@ -418,7 +418,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 
 	ret = fpga_region_register(region);
 	if (ret)
-		goto eprobe_free;
+		goto eprobe_mgr_put;
 
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
 	dev_set_drvdata(dev, region);
@@ -427,8 +427,6 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 
 	return 0;
 
-eprobe_free:
-	fpga_region_free(region);
 eprobe_mgr_put:
 	fpga_mgr_put(mgr);
 	return ret;
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 0521b7f..27cb706 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -44,4 +44,8 @@ void fpga_region_free(struct fpga_region *region);
 int fpga_region_register(struct fpga_region *region);
 void fpga_region_unregister(struct fpga_region *region);
 
+struct fpga_region
+*devm_fpga_region_create(struct device *dev, struct fpga_manager *mgr,
+			int (*get_bridges)(struct fpga_region *));
+
 #endif /* _FPGA_REGION_H */
-- 
2.7.4
