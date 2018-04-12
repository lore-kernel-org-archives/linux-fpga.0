Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v4 2/4] fpga: manager: change api, don't use drvdata
Date: Thu, 12 Apr 2018 15:30:41 -0500
Message-Id: <20180412203043.3001-3-atull@kernel.org>
In-Reply-To: <20180412203043.3001-1-atull@kernel.org>
References: <20180412203043.3001-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Change fpga_mgr_register to not set or use drvdata.  This supports
the case where a PCIe device has more than one manager.

Add fpga_mgr_create/free functions.  Change fpga_mgr_register and
fpga_mgr_unregister functions to take the mgr struct as their only
parameter.

  struct fpga_manager *fpga_mgr_create(struct device *dev,
                const char *name,
                const struct fpga_manager_ops *mops,
                void *priv);
  void fpga_mgr_free(struct fpga_manager *mgr);
  int fpga_mgr_register(struct fpga_manager *mgr);
  void fpga_mgr_unregister(struct fpga_manager *mgr);

Update the drivers that call fpga_mgr_register with the new API.

Signed-off-by: Alan Tull <atull@kernel.org>
Reported-by: Jiuyue Ma <majiuyue@huawei.com>
---
v2: change fpga_mgr_register to not need parent device param
v3: minor changes to make diffs smaller and more obviously correct
    rebased to current next branch
v4: reworked, adding fpga_manager_create and _free functions
    remove parent from struct
    remove added check for parent.
    clean up commit header
    adjust documentation for the new API
    add fixup for machxo2-spi.c
---
 Documentation/fpga/fpga-mgr.txt  | 35 +++++++++++++-----
 drivers/fpga/altera-cvp.c        | 19 +++++++---
 drivers/fpga/altera-pr-ip-core.c | 18 ++++++++--
 drivers/fpga/altera-ps-spi.c     | 20 +++++++++--
 drivers/fpga/fpga-mgr.c          | 78 ++++++++++++++++++++++++++--------------
 drivers/fpga/ice40-spi.c         | 21 ++++++++---
 drivers/fpga/machxo2-spi.c       | 20 ++++++++---
 drivers/fpga/socfpga-a10.c       | 14 ++++++--
 drivers/fpga/socfpga.c           | 19 ++++++++--
 drivers/fpga/ts73xx-fpga.c       | 20 +++++++++--
 drivers/fpga/xilinx-spi.c        | 20 +++++++++--
 drivers/fpga/zynq-fpga.c         | 14 ++++++--
 include/linux/fpga/fpga-mgr.h    | 10 +++---
 13 files changed, 237 insertions(+), 71 deletions(-)

diff --git a/Documentation/fpga/fpga-mgr.txt b/Documentation/fpga/fpga-mgr.txt
index cc6413e..1155612 100644
--- a/Documentation/fpga/fpga-mgr.txt
+++ b/Documentation/fpga/fpga-mgr.txt
@@ -63,17 +63,23 @@ The user should call fpga_mgr_lock and verify that it returns 0 before
 attempting to program the FPGA.  Likewise, the user should call
 fpga_mgr_unlock when done programming the FPGA.
 
+To alloc/free a FPGA manager struct:
+------------------------------------
+
+	struct fpga_manager *fpga_mgr_create(struct device *dev,
+					     const char *name,
+				 	     const struct fpga_manager_ops *mops,
+					     void *priv);
+	void fpga_mgr_free(struct fpga_manager *mgr);
 
 To register or unregister the low level FPGA-specific driver:
 -------------------------------------------------------------
 
-	int fpga_mgr_register(struct device *dev, const char *name,
-			      const struct fpga_manager_ops *mops,
-			      void *priv);
+	int fpga_mgr_register(struct fpga_manager *mgr);
 
-	void fpga_mgr_unregister(struct device *dev);
+	void fpga_mgr_unregister(struct fpga_manager *mgr);
 
-Use of these two functions is described below in "How To Support a new FPGA
+Use of these functions is described below in "How To Support a new FPGA
 device."
 
 
@@ -148,6 +154,7 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct socfpga_fpga_priv *priv;
+	struct fpga_manager *mgr;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -157,13 +164,25 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
 	/* ... do ioremaps, get interrupts, etc. and save
 	   them in priv... */
 
-	return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
-				 &socfpga_fpga_ops, priv);
+	mgr = fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
+			      &socfpga_fpga_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mgr);
+
+	ret = fpga_mgr_register(mgr);
+	if (ret)
+		fpga_mgr_free(mgr);
+
+	return ret;
 }
 
 static int socfpga_fpga_remove(struct platform_device *pdev)
 {
-	fpga_mgr_unregister(&pdev->dev);
+	struct fpga_manager *mgr = platform_get_drvdata(pdev);
+
+	fpga_mgr_unregister(mgr);
 
 	return 0;
 }
diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 77b04e4..dd4edd8 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -401,6 +401,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *dev_id)
 {
 	struct altera_cvp_conf *conf;
+	struct fpga_manager *mgr;
 	u16 cmd, val;
 	int ret;
 
@@ -452,16 +453,24 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
 		 ALTERA_CVP_MGR_NAME, pci_name(pdev));
 
-	ret = fpga_mgr_register(&pdev->dev, conf->mgr_name,
-				&altera_cvp_ops, conf);
-	if (ret)
+	mgr = fpga_mgr_create(&pdev->dev, conf->mgr_name,
+			      &altera_cvp_ops, conf);
+	if (!mgr)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, mgr);
+
+	ret = fpga_mgr_register(mgr);
+	if (ret) {
+		fpga_mgr_free(mgr);
 		goto err_unmap;
+	}
 
 	ret = driver_create_file(&altera_cvp_driver.driver,
 				 &driver_attr_chkcfg);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't create sysfs chkcfg file\n");
-		fpga_mgr_unregister(&pdev->dev);
+		fpga_mgr_unregister(mgr);
 		goto err_unmap;
 	}
 
@@ -483,7 +492,7 @@ static void altera_cvp_remove(struct pci_dev *pdev)
 	u16 cmd;
 
 	driver_remove_file(&altera_cvp_driver.driver, &driver_attr_chkcfg);
-	fpga_mgr_unregister(&pdev->dev);
+	fpga_mgr_unregister(mgr);
 	pci_iounmap(pdev, conf->map);
 	pci_release_region(pdev, CVP_BAR);
 	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index a7b31f9..eea5217 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -187,6 +187,8 @@ static const struct fpga_manager_ops alt_pr_ops = {
 int alt_pr_register(struct device *dev, void __iomem *reg_base)
 {
 	struct alt_pr_priv *priv;
+	struct fpga_manager *mgr;
+	int ret;
 	u32 val;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -201,15 +203,27 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
 		(val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
 		(int)(val & ALT_PR_CSR_PR_START));
 
-	return fpga_mgr_register(dev, dev_name(dev), &alt_pr_ops, priv);
+	mgr = fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, mgr);
+
+	ret = fpga_mgr_register(mgr);
+	if (ret)
+		fpga_mgr_free(mgr);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(alt_pr_register);
 
 int alt_pr_unregister(struct device *dev)
 {
+	struct fpga_manager *mgr = dev_get_drvdata(dev);
+
 	dev_dbg(dev, "%s\n", __func__);
 
-	fpga_mgr_unregister(dev);
+	fpga_mgr_unregister(mgr);
 
 	return 0;
 }
diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 14f14ef..01753a0 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -238,6 +238,8 @@ static int altera_ps_probe(struct spi_device *spi)
 {
 	struct altera_ps_conf *conf;
 	const struct of_device_id *of_id;
+	struct fpga_manager *mgr;
+	int ret;
 
 	conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
 	if (!conf)
@@ -273,13 +275,25 @@ static int altera_ps_probe(struct spi_device *spi)
 	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
 		 dev_driver_string(&spi->dev), dev_name(&spi->dev));
 
-	return fpga_mgr_register(&spi->dev, conf->mgr_name,
-				 &altera_ps_ops, conf);
+	mgr = fpga_mgr_create(&spi->dev, conf->mgr_name,
+			      &altera_ps_ops, conf);
+	if (!mgr)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, mgr);
+
+	ret = fpga_mgr_register(mgr);
+	if (ret)
+		fpga_mgr_free(mgr);
+
+	return ret;
 }
 
 static int altera_ps_remove(struct spi_device *spi)
 {
-	fpga_mgr_unregister(&spi->dev);
+	struct fpga_manager *mgr = spi_get_drvdata(spi);
+
+	fpga_mgr_unregister(mgr);
 
 	return 0;
 }
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 9939d2c..0a5181d 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -515,17 +515,17 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
 EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
 
 /**
- * fpga_mgr_register - register a low level fpga manager driver
+ * fpga_mgr_create - create and initialize a FPGA manager struct
  * @dev:	fpga manager device from pdev
  * @name:	fpga manager name
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
  *
- * Return: 0 on success, negative error code otherwise.
+ * Return: pointer to struct fpga_manager or NULL
  */
-int fpga_mgr_register(struct device *dev, const char *name,
-		      const struct fpga_manager_ops *mops,
-		      void *priv)
+struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
+				     const struct fpga_manager_ops *mops,
+				     void *priv)
 {
 	struct fpga_manager *mgr;
 	int id, ret;
@@ -534,17 +534,17 @@ int fpga_mgr_register(struct device *dev, const char *name,
 	    !mops->write_init || (!mops->write && !mops->write_sg) ||
 	    (mops->write && mops->write_sg)) {
 		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
-		return -EINVAL;
+		return NULL;
 	}
 
 	if (!name || !strlen(name)) {
 		dev_err(dev, "Attempt to register with no name!\n");
-		return -EINVAL;
+		return NULL;
 	}
 
 	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
 	if (!mgr)
-		return -ENOMEM;
+		return NULL;
 
 	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
 	if (id < 0) {
@@ -558,25 +558,56 @@ int fpga_mgr_register(struct device *dev, const char *name,
 	mgr->mops = mops;
 	mgr->priv = priv;
 
-	/*
-	 * Initialize framework state by requesting low level driver read state
-	 * from device.  FPGA may be in reset mode or may have been programmed
-	 * by bootloader or EEPROM.
-	 */
-	mgr->state = mgr->mops->state(mgr);
-
 	device_initialize(&mgr->dev);
 	mgr->dev.class = fpga_mgr_class;
 	mgr->dev.groups = mops->groups;
 	mgr->dev.parent = dev;
 	mgr->dev.of_node = dev->of_node;
 	mgr->dev.id = id;
-	dev_set_drvdata(dev, mgr);
 
 	ret = dev_set_name(&mgr->dev, "fpga%d", id);
 	if (ret)
 		goto error_device;
 
+	return mgr;
+
+error_device:
+	ida_simple_remove(&fpga_mgr_ida, id);
+error_kfree:
+	kfree(mgr);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(fpga_mgr_create);
+
+/**
+ * fpga_mgr_free - deallocate a FPGA manager
+ * @mgr:	fpga manager struct created by fpga_mgr_create
+ */
+void fpga_mgr_free(struct fpga_manager *mgr)
+{
+	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
+	kfree(mgr);
+}
+EXPORT_SYMBOL_GPL(fpga_mgr_free);
+
+/**
+ * fpga_mgr_register - register a FPGA manager
+ * @mgr:	fpga manager struct created by fpga_mgr_create
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int fpga_mgr_register(struct fpga_manager *mgr)
+{
+	int ret;
+
+	/*
+	 * Initialize framework state by requesting low level driver read state
+	 * from device.  FPGA may be in reset mode or may have been programmed
+	 * by bootloader or EEPROM.
+	 */
+	mgr->state = mgr->mops->state(mgr);
+
 	ret = device_add(&mgr->dev);
 	if (ret)
 		goto error_device;
@@ -586,22 +617,18 @@ int fpga_mgr_register(struct device *dev, const char *name,
 	return 0;
 
 error_device:
-	ida_simple_remove(&fpga_mgr_ida, id);
-error_kfree:
-	kfree(mgr);
+	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_register);
 
 /**
- * fpga_mgr_unregister - unregister a low level fpga manager driver
- * @dev:	fpga manager device from pdev
+ * fpga_mgr_unregister - unregister a FPGA manager
+ * @mgr:	fpga manager struct
  */
-void fpga_mgr_unregister(struct device *dev)
+void fpga_mgr_unregister(struct fpga_manager *mgr)
 {
-	struct fpga_manager *mgr = dev_get_drvdata(dev);
-
 	dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
 
 	/*
@@ -619,8 +646,7 @@ static void fpga_mgr_dev_release(struct device *dev)
 {
 	struct fpga_manager *mgr = to_fpga_manager(dev);
 
-	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
-	kfree(mgr);
+	fpga_mgr_free(mgr);
 }
 
 static int __init fpga_mgr_class_init(void)
diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 7fca820..5981c7e 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -133,6 +133,7 @@ static int ice40_fpga_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
 	struct ice40_fpga_priv *priv;
+	struct fpga_manager *mgr;
 	int ret;
 
 	priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
@@ -174,14 +175,26 @@ static int ice40_fpga_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	/* Register with the FPGA manager */
-	return fpga_mgr_register(dev, "Lattice iCE40 FPGA Manager",
-				 &ice40_fpga_ops, priv);
+	mgr = fpga_mgr_create(dev, "Lattice iCE40 FPGA Manager",
+			      &ice40_fpga_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, mgr);
+
+	ret = fpga_mgr_register(mgr);
+	if (ret)
+		fpga_mgr_free(mgr);
+
+	return ret;
 }
 
 static int ice40_fpga_remove(struct spi_device *spi)
 {
-	fpga_mgr_unregister(&spi->dev);
+	struct fpga_manager *mgr = spi_get_drvdata(spi);
+
+	fpga_mgr_unregister(mgr);
+
 	return 0;
 }
 
diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 8e95ec9..a582e00 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -355,21 +355,33 @@ static const struct fpga_manager_ops machxo2_ops = {
 static int machxo2_spi_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct fpga_manager *mgr;
+	int ret;
 
 	if (spi->max_speed_hz > MACHXO2_MAX_SPEED) {
 		dev_err(dev, "Speed is too high\n");
 		return -EINVAL;
 	}
 
-	return fpga_mgr_register(dev, "Lattice MachXO2 SPI FPGA Manager",
-				 &machxo2_ops, spi);
+	mgr = fpga_mgr_create(dev, "Lattice MachXO2 SPI FPGA Manager",
+			      &machxo2_ops, spi);
+	if (!mgr)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, mgr);
+
+	ret = fpga_mgr_register(mgr);
+	if (ret)
+		fpga_mgr_free(mgr);
+
+	return ret;
 }
 
 static int machxo2_spi_remove(struct spi_device *spi)
 {
-	struct device *dev = &spi->dev;
+	struct fpga_manager *mgr = spi_get_drvdata(spi);
 
-	fpga_mgr_unregister(dev);
+	fpga_mgr_unregister(mgr);
 
 	return 0;
 }
diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index a46e343..dec3db5 100644
--- a/drivers/fpga/socfpga-a10.c
+++ b/drivers/fpga/socfpga-a10.c
@@ -482,6 +482,7 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct a10_fpga_priv *priv;
 	void __iomem *reg_base;
+	struct fpga_manager *mgr;
 	struct resource *res;
 	int ret;
 
@@ -519,9 +520,16 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	ret = fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
-				 &socfpga_a10_fpga_mgr_ops, priv);
+	mgr = fpga_mgr_create(dev, "SoCFPGA Arria10 FPGA Manager",
+			      &socfpga_a10_fpga_mgr_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mgr);
+
+	ret = fpga_mgr_register(mgr);
 	if (ret) {
+		fpga_mgr_free(mgr);
 		clk_disable_unprepare(priv->clk);
 		return ret;
 	}
@@ -534,7 +542,7 @@ static int socfpga_a10_fpga_remove(struct platform_device *pdev)
 	struct fpga_manager *mgr = platform_get_drvdata(pdev);
 	struct a10_fpga_priv *priv = mgr->priv;
 
-	fpga_mgr_unregister(&pdev->dev);
+	fpga_mgr_unregister(mgr);
 	clk_disable_unprepare(priv->clk);
 
 	return 0;
diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index b6672e6..51efaf9 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -555,6 +555,7 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct socfpga_fpga_priv *priv;
+	struct fpga_manager *mgr;
 	struct resource *res;
 	int ret;
 
@@ -581,13 +582,25 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
-				 &socfpga_fpga_ops, priv);
+	mgr = fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
+			      &socfpga_fpga_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mgr);
+
+	ret = fpga_mgr_register(mgr);
+	if (ret)
+		fpga_mgr_free(mgr);
+
+	return ret;
 }
 
 static int socfpga_fpga_remove(struct platform_device *pdev)
 {
-	fpga_mgr_unregister(&pdev->dev);
+	struct fpga_manager *mgr = platform_get_drvdata(pdev);
+
+	fpga_mgr_unregister(mgr);
 
 	return 0;
 }
diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index f6a96b4..08efd18 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -116,7 +116,9 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
 {
 	struct device *kdev = &pdev->dev;
 	struct ts73xx_fpga_priv *priv;
+	struct fpga_manager *mgr;
 	struct resource *res;
+	int ret;
 
 	priv = devm_kzalloc(kdev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -131,13 +133,25 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->io_base);
 	}
 
-	return fpga_mgr_register(kdev, "TS-73xx FPGA Manager",
-				 &ts73xx_fpga_ops, priv);
+	mgr = fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
+			      &ts73xx_fpga_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mgr);
+
+	ret = fpga_mgr_register(mgr);
+	if (ret)
+		fpga_mgr_free(mgr);
+
+	return ret;
 }
 
 static int ts73xx_fpga_remove(struct platform_device *pdev)
 {
-	fpga_mgr_unregister(&pdev->dev);
+	struct fpga_manager *mgr = platform_get_drvdata(pdev);
+
+	fpga_mgr_unregister(mgr);
 
 	return 0;
 }
diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 9b62a4c..8d19459 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -143,6 +143,8 @@ static const struct fpga_manager_ops xilinx_spi_ops = {
 static int xilinx_spi_probe(struct spi_device *spi)
 {
 	struct xilinx_spi_conf *conf;
+	struct fpga_manager *mgr;
+	int ret;
 
 	conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
 	if (!conf)
@@ -165,13 +167,25 @@ static int xilinx_spi_probe(struct spi_device *spi)
 		return PTR_ERR(conf->done);
 	}
 
-	return fpga_mgr_register(&spi->dev, "Xilinx Slave Serial FPGA Manager",
-				 &xilinx_spi_ops, conf);
+	mgr = fpga_mgr_create(&spi->dev, "Xilinx Slave Serial FPGA Manager",
+			      &xilinx_spi_ops, conf);
+	if (!mgr)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, mgr);
+
+	ret = fpga_mgr_register(mgr);
+	if (ret)
+		fpga_mgr_free(mgr);
+
+	return ret;
 }
 
 static int xilinx_spi_remove(struct spi_device *spi)
 {
-	fpga_mgr_unregister(&spi->dev);
+	struct fpga_manager *mgr = spi_get_drvdata(spi);
+
+	fpga_mgr_unregister(mgr);
 
 	return 0;
 }
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 70b15b3..3110e00 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -558,6 +558,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct zynq_fpga_priv *priv;
+	struct fpga_manager *mgr;
 	struct resource *res;
 	int err;
 
@@ -613,10 +614,17 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 
 	clk_disable(priv->clk);
 
-	err = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
-				&zynq_fpga_ops, priv);
+	mgr = fpga_mgr_create(dev, "Xilinx Zynq FPGA Manager",
+			      &zynq_fpga_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mgr);
+
+	err = fpga_mgr_register(mgr);
 	if (err) {
 		dev_err(dev, "unable to register FPGA manager\n");
+		fpga_mgr_free(mgr);
 		clk_unprepare(priv->clk);
 		return err;
 	}
@@ -632,7 +640,7 @@ static int zynq_fpga_remove(struct platform_device *pdev)
 	mgr = platform_get_drvdata(pdev);
 	priv = mgr->priv;
 
-	fpga_mgr_unregister(&pdev->dev);
+	fpga_mgr_unregister(mgr);
 
 	clk_unprepare(priv->clk);
 
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 3c6de23..1266c11 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -170,9 +170,11 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
 
 void fpga_mgr_put(struct fpga_manager *mgr);
 
-int fpga_mgr_register(struct device *dev, const char *name,
-		      const struct fpga_manager_ops *mops, void *priv);
-
-void fpga_mgr_unregister(struct device *dev);
+struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
+				     const struct fpga_manager_ops *mops,
+				     void *priv);
+void fpga_mgr_free(struct fpga_manager *mgr);
+int fpga_mgr_register(struct fpga_manager *mgr);
+void fpga_mgr_unregister(struct fpga_manager *mgr);
 
 #endif /*_LINUX_FPGA_MGR_H */
-- 
2.7.4
