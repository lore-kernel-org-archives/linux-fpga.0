Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v4 3/4] fpga: bridge: change api, don't use drvdata
Date: Thu, 12 Apr 2018 15:30:42 -0500
Message-Id: <20180412203043.3001-4-atull@kernel.org>
In-Reply-To: <20180412203043.3001-1-atull@kernel.org>
References: <20180412203043.3001-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Change fpga_bridge_register to not set drvdata.  This is to support
the case where a PCIe device can have more than one bridge.

Add API functions to create/free the fpga bridge struct. Change
fpga_bridge_register/unregister to take FPGA bridge struct as
the only parameter.

  struct fpga_bridge
  *fpga_bridge_create(struct device *dev, const char *name,
                      const struct fpga_bridge_ops *br_ops,
                      void *priv);
  void fpga_bridge_free(struct fpga_bridge *br);
  int fpga_bridge_register(struct fpga_bridge *br);
  void fpga_bridge_unregister(struct fpga_bridge *br);

Update the drivers that call fpga_bridge_register with the new API.

Signed-off-by: Alan Tull <atull@kernel.org>
Reported-by: Jiuyue Ma <majiuyue@huawei.com>
---
v2: change fpga_bridge_register to not need parent device param
    fix undeclared - s/dev/&pdev->dev/
v3: minor changes to make diffs smaller and more obviously correct
v4: rework API, add fpga_bridge_create/free
---
 drivers/fpga/altera-fpga2sdram.c    | 21 ++++++++---
 drivers/fpga/altera-freeze-bridge.c | 22 ++++++++++--
 drivers/fpga/altera-hps2fpga.c      | 24 ++++++++++---
 drivers/fpga/fpga-bridge.c          | 70 ++++++++++++++++++++++++-------------
 drivers/fpga/xilinx-pr-decoupler.c  | 22 +++++++++---
 include/linux/fpga/fpga-bridge.h    |  9 +++--
 6 files changed, 123 insertions(+), 45 deletions(-)

diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
index d4eeb74..5a29ab6 100644
--- a/drivers/fpga/altera-fpga2sdram.c
+++ b/drivers/fpga/altera-fpga2sdram.c
@@ -106,6 +106,7 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct alt_fpga2sdram_data *priv;
+	struct fpga_bridge *br;
 	u32 enable;
 	struct regmap *sysmgr;
 	int ret = 0;
@@ -131,10 +132,18 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 	/* Get f2s bridge configuration saved in handoff register */
 	regmap_read(sysmgr, SYSMGR_ISWGRP_HANDOFF3, &priv->mask);
 
-	ret = fpga_bridge_register(dev, F2S_BRIDGE_NAME,
-				   &altera_fpga2sdram_br_ops, priv);
-	if (ret)
+	br = fpga_bridge_create(dev, F2S_BRIDGE_NAME,
+				&altera_fpga2sdram_br_ops, priv);
+	if (!br)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, br);
+
+	ret = fpga_bridge_register(br);
+	if (ret) {
+		fpga_bridge_free(br);
 		return ret;
+	}
 
 	dev_info(dev, "driver initialized with handoff %08x\n", priv->mask);
 
@@ -146,7 +155,7 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 				 (enable ? "enabling" : "disabling"));
 			ret = _alt_fpga2sdram_enable_set(priv, enable);
 			if (ret) {
-				fpga_bridge_unregister(&pdev->dev);
+				fpga_bridge_unregister(br);
 				return ret;
 			}
 		}
@@ -157,7 +166,9 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 
 static int alt_fpga_bridge_remove(struct platform_device *pdev)
 {
-	fpga_bridge_unregister(&pdev->dev);
+	struct fpga_bridge *br = platform_get_drvdata(pdev);
+
+	fpga_bridge_unregister(br);
 
 	return 0;
 }
diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
index 6159cfcf..fa4b693 100644
--- a/drivers/fpga/altera-freeze-bridge.c
+++ b/drivers/fpga/altera-freeze-bridge.c
@@ -221,8 +221,10 @@ static int altera_freeze_br_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	void __iomem *base_addr;
 	struct altera_freeze_br_data *priv;
+	struct fpga_bridge *br;
 	struct resource *res;
 	u32 status, revision;
+	int ret;
 
 	if (!np)
 		return -ENODEV;
@@ -254,13 +256,27 @@ static int altera_freeze_br_probe(struct platform_device *pdev)
 
 	priv->base_addr = base_addr;
 
-	return fpga_bridge_register(dev, FREEZE_BRIDGE_NAME,
-				    &altera_freeze_br_br_ops, priv);
+	br = fpga_bridge_create(dev, FREEZE_BRIDGE_NAME,
+				&altera_freeze_br_br_ops, priv);
+	if (!br)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, br);
+
+	ret = fpga_bridge_register(br);
+	if (ret) {
+		fpga_bridge_free(br);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int altera_freeze_br_remove(struct platform_device *pdev)
 {
-	fpga_bridge_unregister(&pdev->dev);
+	struct fpga_bridge *br = platform_get_drvdata(pdev);
+
+	fpga_bridge_unregister(br);
 
 	return 0;
 }
diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
index 406d2f1..e4d39f0 100644
--- a/drivers/fpga/altera-hps2fpga.c
+++ b/drivers/fpga/altera-hps2fpga.c
@@ -139,6 +139,7 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct altera_hps2fpga_data *priv;
 	const struct of_device_id *of_id;
+	struct fpga_bridge *br;
 	u32 enable;
 	int ret;
 
@@ -190,11 +191,24 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = fpga_bridge_register(dev, priv->name, &altera_hps2fpga_br_ops,
-				   priv);
-err:
+	br = fpga_bridge_create(dev, priv->name, &altera_hps2fpga_br_ops, priv);
+	if (!br) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, br);
+
+	ret = fpga_bridge_register(br);
 	if (ret)
-		clk_disable_unprepare(priv->clk);
+		goto err_free;
+
+	return 0;
+
+err_free:
+	fpga_bridge_free(br);
+err:
+	clk_disable_unprepare(priv->clk);
 
 	return ret;
 }
@@ -204,7 +218,7 @@ static int alt_fpga_bridge_remove(struct platform_device *pdev)
 	struct fpga_bridge *bridge = platform_get_drvdata(pdev);
 	struct altera_hps2fpga_data *priv = bridge->priv;
 
-	fpga_bridge_unregister(&pdev->dev);
+	fpga_bridge_unregister(bridge);
 
 	clk_disable_unprepare(priv->clk);
 
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 31bd2c5..2db1573 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -328,28 +328,29 @@ static struct attribute *fpga_bridge_attrs[] = {
 ATTRIBUTE_GROUPS(fpga_bridge);
 
 /**
- * fpga_bridge_register - register a fpga bridge driver
+ * fpga_bridge_create - create and initialize a struct fpga_bridge
  * @dev:	FPGA bridge device from pdev
  * @name:	FPGA bridge name
  * @br_ops:	pointer to structure of fpga bridge ops
  * @priv:	FPGA bridge private data
  *
- * Return: 0 for success, error code otherwise.
+ * Return: struct fpga_bridge or NULL
  */
-int fpga_bridge_register(struct device *dev, const char *name,
-			 const struct fpga_bridge_ops *br_ops, void *priv)
+struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
+				       const struct fpga_bridge_ops *br_ops,
+				       void *priv)
 {
 	struct fpga_bridge *bridge;
 	int id, ret = 0;
 
 	if (!name || !strlen(name)) {
 		dev_err(dev, "Attempt to register with no name!\n");
-		return -EINVAL;
+		return NULL;
 	}
 
 	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
 	if (!bridge)
-		return -ENOMEM;
+		return NULL;
 
 	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
 	if (id < 0) {
@@ -370,40 +371,62 @@ int fpga_bridge_register(struct device *dev, const char *name,
 	bridge->dev.parent = dev;
 	bridge->dev.of_node = dev->of_node;
 	bridge->dev.id = id;
-	dev_set_drvdata(dev, bridge);
 
 	ret = dev_set_name(&bridge->dev, "br%d", id);
 	if (ret)
 		goto error_device;
 
-	ret = device_add(&bridge->dev);
-	if (ret)
-		goto error_device;
-
-	of_platform_populate(dev->of_node, NULL, NULL, dev);
-
-	dev_info(bridge->dev.parent, "fpga bridge [%s] registered\n",
-		 bridge->name);
-
-	return 0;
+	return bridge;
 
 error_device:
 	ida_simple_remove(&fpga_bridge_ida, id);
 error_kfree:
 	kfree(bridge);
 
-	return ret;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(fpga_bridge_create);
+
+/**
+ * fpga_bridge_free - free a fpga bridge and its id
+ * @bridge:	FPGA bridge struct created by fpga_bridge_create
+ */
+void fpga_bridge_free(struct fpga_bridge *bridge)
+{
+	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
+	kfree(bridge);
+}
+EXPORT_SYMBOL_GPL(fpga_bridge_free);
+
+/**
+ * fpga_bridge_register - register a fpga bridge
+ * @bridge:	FPGA bridge struct created by fpga_bridge_create
+ *
+ * Return: 0 for success, error code otherwise.
+ */
+int fpga_bridge_register(struct fpga_bridge *bridge)
+{
+	struct device *dev = &bridge->dev;
+	int ret;
+
+	ret = device_add(dev);
+	if (ret)
+		return ret;
+
+	of_platform_populate(dev->of_node, NULL, NULL, dev);
+
+	dev_info(dev->parent, "fpga bridge [%s] registered\n", bridge->name);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_register);
 
 /**
  * fpga_bridge_unregister - unregister a fpga bridge driver
- * @dev: FPGA bridge device from pdev
+ * @bridge:	FPGA bridge struct created by fpga_bridge_create
  */
-void fpga_bridge_unregister(struct device *dev)
+void fpga_bridge_unregister(struct fpga_bridge *bridge)
 {
-	struct fpga_bridge *bridge = dev_get_drvdata(dev);
-
 	/*
 	 * If the low level driver provides a method for putting bridge into
 	 * a desired state upon unregister, do it.
@@ -419,8 +442,7 @@ static void fpga_bridge_dev_release(struct device *dev)
 {
 	struct fpga_bridge *bridge = to_fpga_bridge(dev);
 
-	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
-	kfree(bridge);
+	fpga_bridge_free(bridge);
 }
 
 static int __init fpga_bridge_dev_init(void)
diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 0d77430..07ba153 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -94,6 +94,7 @@ MODULE_DEVICE_TABLE(of, xlnx_pr_decoupler_of_match);
 static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 {
 	struct xlnx_pr_decoupler_data *priv;
+	struct fpga_bridge *br;
 	int err;
 	struct resource *res;
 
@@ -120,16 +121,27 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 
 	clk_disable(priv->clk);
 
-	err = fpga_bridge_register(&pdev->dev, "Xilinx PR Decoupler",
-				   &xlnx_pr_decoupler_br_ops, priv);
+	br = fpga_bridge_create(&pdev->dev, "Xilinx PR Decoupler",
+				&xlnx_pr_decoupler_br_ops, priv);
+	if (!br) {
+		err = -ENOMEM;
+		goto err_clk;
+	}
+
+	platform_set_drvdata(pdev, br);
 
+	err = fpga_bridge_register(br);
 	if (err) {
 		dev_err(&pdev->dev, "unable to register Xilinx PR Decoupler");
-		clk_unprepare(priv->clk);
-		return err;
+		goto err_clk;
 	}
 
 	return 0;
+
+err_clk:
+	clk_unprepare(priv->clk);
+
+	return err;
 }
 
 static int xlnx_pr_decoupler_remove(struct platform_device *pdev)
@@ -137,7 +149,7 @@ static int xlnx_pr_decoupler_remove(struct platform_device *pdev)
 	struct fpga_bridge *bridge = platform_get_drvdata(pdev);
 	struct xlnx_pr_decoupler_data *p = bridge->priv;
 
-	fpga_bridge_unregister(&pdev->dev);
+	fpga_bridge_unregister(bridge);
 
 	clk_unprepare(p->clk);
 
diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
index 3694821..ce550fc 100644
--- a/include/linux/fpga/fpga-bridge.h
+++ b/include/linux/fpga/fpga-bridge.h
@@ -62,8 +62,11 @@ int of_fpga_bridge_get_to_list(struct device_node *np,
 			       struct fpga_image_info *info,
 			       struct list_head *bridge_list);
 
-int fpga_bridge_register(struct device *dev, const char *name,
-			 const struct fpga_bridge_ops *br_ops, void *priv);
-void fpga_bridge_unregister(struct device *dev);
+struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
+				       const struct fpga_bridge_ops *br_ops,
+				       void *priv);
+void fpga_bridge_free(struct fpga_bridge *br);
+int fpga_bridge_register(struct fpga_bridge *br);
+void fpga_bridge_unregister(struct fpga_bridge *br);
 
 #endif /* _LINUX_FPGA_BRIDGE_H */
-- 
2.7.4
