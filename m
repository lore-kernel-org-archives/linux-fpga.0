Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v3 1/4] fpga: mgr: add devm_fpga_mgr_create
Date: Wed, 26 Sep 2018 11:12:19 -0500
Message-Id: <1537978342-17697-2-git-send-email-atull@kernel.org>
In-Reply-To: <1537978342-17697-1-git-send-email-atull@kernel.org>
References: <1537978342-17697-1-git-send-email-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, Federico Vaga <federico.vaga@cern.ch>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Add devm_fpga_mgr_create() which is the managed
version of fpga_mgr_create().

Change current FPGA manager drivers to use
devm_fpga_mgr_create()

Signed-off-by: Alan Tull <atull@kernel.org>
Suggested-by: Federico Vaga <federico.vaga@cern.ch>
---
v2: add suggested-by
v3: remove some unclear documentation about fpga_mgr_unregister
---
 Documentation/driver-api/fpga/fpga-mgr.rst | 13 +++---
 drivers/fpga/altera-cvp.c                  |  8 ++--
 drivers/fpga/altera-pr-ip-core.c           |  9 +----
 drivers/fpga/altera-ps-spi.c               | 11 ++---
 drivers/fpga/dfl-fme-mgr.c                 | 11 ++---
 drivers/fpga/fpga-mgr.c                    | 64 ++++++++++++++++++++++++++----
 drivers/fpga/ice40-spi.c                   | 10 ++---
 drivers/fpga/machxo2-spi.c                 | 11 ++---
 drivers/fpga/socfpga-a10.c                 |  5 +--
 drivers/fpga/socfpga.c                     | 10 ++---
 drivers/fpga/ts73xx-fpga.c                 | 11 ++---
 drivers/fpga/xilinx-spi.c                  | 12 ++----
 drivers/fpga/zynq-fpga.c                   |  5 +--
 include/linux/fpga/fpga-mgr.h              |  4 ++
 14 files changed, 97 insertions(+), 87 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 82b6dbb..db8885e 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -49,18 +49,14 @@ probe function calls fpga_mgr_register(), such as::
 		 * them in priv
 		 */
 
-		mgr = fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
-				      &socfpga_fpga_ops, priv);
+		mgr = devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
+					   &socfpga_fpga_ops, priv);
 		if (!mgr)
 			return -ENOMEM;
 
 		platform_set_drvdata(pdev, mgr);
 
-		ret = fpga_mgr_register(mgr);
-		if (ret)
-			fpga_mgr_free(mgr);
-
-		return ret;
+		return fpga_mgr_register(mgr);
 	}
 
 	static int socfpga_fpga_remove(struct platform_device *pdev)
@@ -170,6 +166,9 @@ API for implementing a new FPGA Manager driver
    :functions: fpga_manager_ops
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
+   :functions: devm_fpga_mgr_create
+
+.. kernel-doc:: drivers/fpga/fpga-mgr.c
    :functions: fpga_mgr_create
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 7fa7936..610a155 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -453,8 +453,8 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
 		 ALTERA_CVP_MGR_NAME, pci_name(pdev));
 
-	mgr = fpga_mgr_create(&pdev->dev, conf->mgr_name,
-			      &altera_cvp_ops, conf);
+	mgr = devm_fpga_mgr_create(&pdev->dev, conf->mgr_name,
+				   &altera_cvp_ops, conf);
 	if (!mgr) {
 		ret = -ENOMEM;
 		goto err_unmap;
@@ -463,10 +463,8 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, mgr);
 
 	ret = fpga_mgr_register(mgr);
-	if (ret) {
-		fpga_mgr_free(mgr);
+	if (ret)
 		goto err_unmap;
-	}
 
 	ret = driver_create_file(&altera_cvp_driver.driver,
 				 &driver_attr_chkcfg);
diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index 65e0b6a..a7a3bf0 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -177,7 +177,6 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
 {
 	struct alt_pr_priv *priv;
 	struct fpga_manager *mgr;
-	int ret;
 	u32 val;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -192,17 +191,13 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
 		(val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
 		(int)(val & ALT_PR_CSR_PR_START));
 
-	mgr = fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
+	mgr = devm_fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
 	if (!mgr)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, mgr);
 
-	ret = fpga_mgr_register(mgr);
-	if (ret)
-		fpga_mgr_free(mgr);
-
-	return ret;
+	return fpga_mgr_register(mgr);
 }
 EXPORT_SYMBOL_GPL(alt_pr_register);
 
diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 24b25c6..33aafda 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -239,7 +239,6 @@ static int altera_ps_probe(struct spi_device *spi)
 	struct altera_ps_conf *conf;
 	const struct of_device_id *of_id;
 	struct fpga_manager *mgr;
-	int ret;
 
 	conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
 	if (!conf)
@@ -275,18 +274,14 @@ static int altera_ps_probe(struct spi_device *spi)
 	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
 		 dev_driver_string(&spi->dev), dev_name(&spi->dev));
 
-	mgr = fpga_mgr_create(&spi->dev, conf->mgr_name,
-			      &altera_ps_ops, conf);
+	mgr = devm_fpga_mgr_create(&spi->dev, conf->mgr_name,
+				   &altera_ps_ops, conf);
 	if (!mgr)
 		return -ENOMEM;
 
 	spi_set_drvdata(spi, mgr);
 
-	ret = fpga_mgr_register(mgr);
-	if (ret)
-		fpga_mgr_free(mgr);
-
-	return ret;
+	return fpga_mgr_register(mgr);
 }
 
 static int altera_ps_remove(struct spi_device *spi)
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index 9f045d0..76f3770 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -287,7 +287,6 @@ static int fme_mgr_probe(struct platform_device *pdev)
 	struct fme_mgr_priv *priv;
 	struct fpga_manager *mgr;
 	struct resource *res;
-	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -309,19 +308,15 @@ static int fme_mgr_probe(struct platform_device *pdev)
 
 	fme_mgr_get_compat_id(priv->ioaddr, compat_id);
 
-	mgr = fpga_mgr_create(dev, "DFL FME FPGA Manager",
-			      &fme_mgr_ops, priv);
+	mgr = devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
+				   &fme_mgr_ops, priv);
 	if (!mgr)
 		return -ENOMEM;
 
 	mgr->compat_id = compat_id;
 	platform_set_drvdata(pdev, mgr);
 
-	ret = fpga_mgr_register(mgr);
-	if (ret)
-		fpga_mgr_free(mgr);
-
-	return ret;
+	return fpga_mgr_register(mgr);
 }
 
 static int fme_mgr_remove(struct platform_device *pdev)
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index a41b07e..c386681 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -558,6 +558,9 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
  *
+ * The caller of this function is responsible for freeing the struct with
+ * fpga_mgr_free().  Using devm_fpga_mgr_create() instead is recommended.
+ *
  * Return: pointer to struct fpga_manager or NULL
  */
 struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
@@ -618,8 +621,8 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 EXPORT_SYMBOL_GPL(fpga_mgr_create);
 
 /**
- * fpga_mgr_free - deallocate a FPGA manager
- * @mgr:	fpga manager struct created by fpga_mgr_create
+ * fpga_mgr_free - free a FPGA manager created with fpga_mgr_create()
+ * @mgr:	fpga manager struct
  */
 void fpga_mgr_free(struct fpga_manager *mgr)
 {
@@ -628,9 +631,55 @@ void fpga_mgr_free(struct fpga_manager *mgr)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_free);
 
+static void devm_fpga_mgr_release(struct device *dev, void *res)
+{
+	struct fpga_manager *mgr = *(struct fpga_manager **)res;
+
+	fpga_mgr_free(mgr);
+}
+
+/**
+ * devm_fpga_mgr_create - create and initialize a managed FPGA manager struct
+ * @dev:	fpga manager device from pdev
+ * @name:	fpga manager name
+ * @mops:	pointer to structure of fpga manager ops
+ * @priv:	fpga manager private data
+ *
+ * This function is intended for use in a FPGA manager driver's probe function.
+ * After the manager driver creates the manager struct with
+ * devm_fpga_mgr_create(), it should register it with fpga_mgr_register().  The
+ * manager driver's remove function should call fpga_mgr_unregister().  The
+ * manager struct allocated with this function will be freed automatically on
+ * driver detach.  This includes the case of a probe function returning error
+ * before calling fpga_mgr_register(), the struct will still get cleaned up.
+ *
+ * Return: pointer to struct fpga_manager or NULL
+ */
+struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
+					  const struct fpga_manager_ops *mops,
+					  void *priv)
+{
+	struct fpga_manager **ptr, *mgr;
+
+	ptr = devres_alloc(devm_fpga_mgr_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	mgr = fpga_mgr_create(dev, name, mops, priv);
+	if (!mgr) {
+		devres_free(ptr);
+	} else {
+		*ptr = mgr;
+		devres_add(dev, ptr);
+	}
+
+	return mgr;
+}
+EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
+
 /**
  * fpga_mgr_register - register a FPGA manager
- * @mgr:	fpga manager struct created by fpga_mgr_create
+ * @mgr: fpga manager struct
  *
  * Return: 0 on success, negative error code otherwise.
  */
@@ -661,8 +710,10 @@ int fpga_mgr_register(struct fpga_manager *mgr)
 EXPORT_SYMBOL_GPL(fpga_mgr_register);
 
 /**
- * fpga_mgr_unregister - unregister and free a FPGA manager
- * @mgr:	fpga manager struct
+ * fpga_mgr_unregister - unregister a FPGA manager
+ * @mgr: fpga manager struct
+ *
+ * This function is intended for use in a FPGA manager driver's remove function.
  */
 void fpga_mgr_unregister(struct fpga_manager *mgr)
 {
@@ -681,9 +732,6 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
 
 static void fpga_mgr_dev_release(struct device *dev)
 {
-	struct fpga_manager *mgr = to_fpga_manager(dev);
-
-	fpga_mgr_free(mgr);
 }
 
 static int __init fpga_mgr_class_init(void)
diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 5981c7e..6154661 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -175,18 +175,14 @@ static int ice40_fpga_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	mgr = fpga_mgr_create(dev, "Lattice iCE40 FPGA Manager",
-			      &ice40_fpga_ops, priv);
+	mgr = devm_fpga_mgr_create(dev, "Lattice iCE40 FPGA Manager",
+				   &ice40_fpga_ops, priv);
 	if (!mgr)
 		return -ENOMEM;
 
 	spi_set_drvdata(spi, mgr);
 
-	ret = fpga_mgr_register(mgr);
-	if (ret)
-		fpga_mgr_free(mgr);
-
-	return ret;
+	return fpga_mgr_register(mgr);
 }
 
 static int ice40_fpga_remove(struct spi_device *spi)
diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index a582e00..4d8a876 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -356,25 +356,20 @@ static int machxo2_spi_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
 	struct fpga_manager *mgr;
-	int ret;
 
 	if (spi->max_speed_hz > MACHXO2_MAX_SPEED) {
 		dev_err(dev, "Speed is too high\n");
 		return -EINVAL;
 	}
 
-	mgr = fpga_mgr_create(dev, "Lattice MachXO2 SPI FPGA Manager",
-			      &machxo2_ops, spi);
+	mgr = devm_fpga_mgr_create(dev, "Lattice MachXO2 SPI FPGA Manager",
+				   &machxo2_ops, spi);
 	if (!mgr)
 		return -ENOMEM;
 
 	spi_set_drvdata(spi, mgr);
 
-	ret = fpga_mgr_register(mgr);
-	if (ret)
-		fpga_mgr_free(mgr);
-
-	return ret;
+	return fpga_mgr_register(mgr);
 }
 
 static int machxo2_spi_remove(struct spi_device *spi)
diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index be30c48..573d88b 100644
--- a/drivers/fpga/socfpga-a10.c
+++ b/drivers/fpga/socfpga-a10.c
@@ -508,8 +508,8 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	mgr = fpga_mgr_create(dev, "SoCFPGA Arria10 FPGA Manager",
-			      &socfpga_a10_fpga_mgr_ops, priv);
+	mgr = devm_fpga_mgr_create(dev, "SoCFPGA Arria10 FPGA Manager",
+				   &socfpga_a10_fpga_mgr_ops, priv);
 	if (!mgr)
 		return -ENOMEM;
 
@@ -517,7 +517,6 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
 
 	ret = fpga_mgr_register(mgr);
 	if (ret) {
-		fpga_mgr_free(mgr);
 		clk_disable_unprepare(priv->clk);
 		return ret;
 	}
diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index 959d71f..4a8a2fc 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -571,18 +571,14 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	mgr = fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
-			      &socfpga_fpga_ops, priv);
+	mgr = devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
+				   &socfpga_fpga_ops, priv);
 	if (!mgr)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, mgr);
 
-	ret = fpga_mgr_register(mgr);
-	if (ret)
-		fpga_mgr_free(mgr);
-
-	return ret;
+	return fpga_mgr_register(mgr);
 }
 
 static int socfpga_fpga_remove(struct platform_device *pdev)
diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 08efd18..dc22a58 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -118,7 +118,6 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
 	struct ts73xx_fpga_priv *priv;
 	struct fpga_manager *mgr;
 	struct resource *res;
-	int ret;
 
 	priv = devm_kzalloc(kdev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -133,18 +132,14 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->io_base);
 	}
 
-	mgr = fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
-			      &ts73xx_fpga_ops, priv);
+	mgr = devm_fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
+				   &ts73xx_fpga_ops, priv);
 	if (!mgr)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, mgr);
 
-	ret = fpga_mgr_register(mgr);
-	if (ret)
-		fpga_mgr_free(mgr);
-
-	return ret;
+	return fpga_mgr_register(mgr);
 }
 
 static int ts73xx_fpga_remove(struct platform_device *pdev)
diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 8d19459..469486b 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -144,7 +144,6 @@ static int xilinx_spi_probe(struct spi_device *spi)
 {
 	struct xilinx_spi_conf *conf;
 	struct fpga_manager *mgr;
-	int ret;
 
 	conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
 	if (!conf)
@@ -167,18 +166,15 @@ static int xilinx_spi_probe(struct spi_device *spi)
 		return PTR_ERR(conf->done);
 	}
 
-	mgr = fpga_mgr_create(&spi->dev, "Xilinx Slave Serial FPGA Manager",
-			      &xilinx_spi_ops, conf);
+	mgr = devm_fpga_mgr_create(&spi->dev,
+				   "Xilinx Slave Serial FPGA Manager",
+				   &xilinx_spi_ops, conf);
 	if (!mgr)
 		return -ENOMEM;
 
 	spi_set_drvdata(spi, mgr);
 
-	ret = fpga_mgr_register(mgr);
-	if (ret)
-		fpga_mgr_free(mgr);
-
-	return ret;
+	return fpga_mgr_register(mgr);
 }
 
 static int xilinx_spi_remove(struct spi_device *spi)
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 3110e00..bb82efe 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -614,8 +614,8 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 
 	clk_disable(priv->clk);
 
-	mgr = fpga_mgr_create(dev, "Xilinx Zynq FPGA Manager",
-			      &zynq_fpga_ops, priv);
+	mgr = devm_fpga_mgr_create(dev, "Xilinx Zynq FPGA Manager",
+				   &zynq_fpga_ops, priv);
 	if (!mgr)
 		return -ENOMEM;
 
@@ -624,7 +624,6 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 	err = fpga_mgr_register(mgr);
 	if (err) {
 		dev_err(dev, "unable to register FPGA manager\n");
-		fpga_mgr_free(mgr);
 		clk_unprepare(priv->clk);
 		return err;
 	}
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 8ab5df7..e8ca62b 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -198,4 +198,8 @@ void fpga_mgr_free(struct fpga_manager *mgr);
 int fpga_mgr_register(struct fpga_manager *mgr);
 void fpga_mgr_unregister(struct fpga_manager *mgr);
 
+struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
+					  const struct fpga_manager_ops *mops,
+					  void *priv);
+
 #endif /*_LINUX_FPGA_MGR_H */
-- 
2.7.4
