Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652283CC7CE
	for <linux-fpga@vger.kernel.org>; Mon,  8 Jun 2026 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937020; cv=none; b=D81MAI5KtP6H5E9w6dNoXCp1y6KeYjlSYqYadyO6k6i3B5VZ4srOLrGEUtMxnUGk298P+QErIf6fa+O8o0aEBrjGfINXDroHRDq+N5ss5hBj0ct0VflnZZssZrpyqHJxtj7QY6MrHCzmYQBl8B8teluLgJLyIDf/t1qrUmbWOF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937020; c=relaxed/simple;
	bh=iGXFAsF26C7oRFCmQ/z+OFsZgWcHawD5/WfTiXsPZmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXXE+uCIYcrhEskz0DEKtXsGRduNM2rV+rirH9fzdK8s3IhY9XD+t5Lw/G6DKHotRZoLSkoxcXBEc7LL3Q6jh5SFnAHfNyC9jPJeW7QDhpEJaC8HwuwOcvktJzXSIImD8cA5mRMkBVZMNUooQcPMoQbn5/pC3qtofK0g5vUqvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lx8PLr5c; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lx8PLr5c"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780937016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMI09XAlKdRQ8+cuGEDQt1VnEkD4HYzmt0VkOhaCz5I=;
	b=Lx8PLr5cCGiyy41edraldcF8/vgqLcUvR621277QYF6hRbjn8JhwFtgiMeHkGYuU7ulUQ7
	ASoVSHV0bVGHaAJOC7/QECUMJsRb6bLyM8d+/YFFuLnROiBrlo7UMbgYDOw2f791tCYpAr
	dSb7nAnVH76IbW/EqZD/c2PF16DN16M=
From: Marco Pagani <marco.pagani@linux.dev>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marco.pagani@linux.dev>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH fpga/for-next 2/2] fpga: of-fpga-region: Add support for region variants
Date: Mon,  8 Jun 2026 18:42:47 +0200
Message-ID: <20260608164247.1998417-3-marco.pagani@linux.dev>
In-Reply-To: <20260608164247.1998417-1-marco.pagani@linux.dev>
References: <20260608164247.1998417-1-marco.pagani@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extend of-fpga-region with support for FPGA region variants statically
defined in the device tree.

During probing, the code now looks for an fpga-variants container
node. If present, it parses each variant child node and registers it.
The variant that is programmed in the region at boot time is defined
by the base-variant property. Additionally, the firmware-cached
property allows caching bitstreams in memory, enabling a fast
reconfiguration path for real-time (latency-sensitive) applications.

Signed-off-by: Marco Pagani <marco.pagani@linux.dev>
---
 drivers/fpga/of-fpga-region.c | 272 +++++++++++++++++++++++++++++++++-
 1 file changed, 270 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 9107a5b461d3..ea32775b55ce 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -8,6 +8,7 @@
 #include <linux/fpga/fpga-bridge.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-region.h>
+#include <linux/firmware.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -18,6 +19,18 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+/**
+ * struct of_fpga_variant_priv - private data for FPGA Region variants
+ * @fw_name: name of the firmware file containing the FPGA image
+ * @fw_buf: buffer containing the cached firmware image
+ * @fw_size: size in bytes of the buffer containing the cached firmware image
+ */
+struct of_fpga_variant_priv {
+	char *fw_name;
+	void *fw_buf;
+	size_t fw_size;
+};
+
 static const struct of_device_id fpga_region_of_match[] = {
 	{ .compatible = "fpga-region", },
 	{},
@@ -140,6 +153,168 @@ static int of_fpga_region_get_bridges(struct fpga_region *region)
 	return 0;
 }
 
+static int of_fpga_remove_variant_child(struct device *dev, void *data)
+{
+	struct device_node *variant_np = data;
+
+	if (dev->of_node && dev->of_node->parent == variant_np) {
+		if (dev_is_platform(dev)) {
+			of_node_clear_flag(dev->of_node, OF_POPULATED);
+			platform_device_unregister(to_platform_device(dev));
+		}
+	}
+	return 0;
+}
+
+static int of_fpga_region_populate_variant(struct device *dev,
+					   struct device_node *variant_np)
+{
+	struct device_node *child_np;
+
+	for_each_available_child_of_node(variant_np, child_np) {
+		if (!of_platform_device_create(child_np, NULL, dev))
+			dev_warn(dev, "failed to create device node.\n");
+	}
+
+	return 0;
+}
+
+/**
+ * of_fpga_region_apply_variant - apply a specific FPGA variant to the region
+ * @region: FPGA region to be programmed
+ * @variant: FPGA variant requested to be applied
+ *
+ * Retrieves the specific variant node from the fpga-variants container,
+ * handles firmware loading (including lazy caching if firmware-cached is
+ * set), programs the FPGA region with the variant, and finally populates
+ * the platform devices for the child IPs.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int of_fpga_region_apply_variant(struct fpga_region *region,
+					struct fpga_variant *variant)
+{
+	struct of_fpga_variant_priv *priv = variant->priv;
+	struct device *dev = &region->dev;
+	struct device_node *variants_np, *variant_np;
+	const struct firmware *fw;
+	struct fpga_image_info *info;
+	int ret;
+
+	variants_np = of_get_child_by_name(dev->of_node, "fpga-variants");
+	if (!variants_np)
+		return -ENODEV;
+
+	variant_np = of_get_child_by_name(variants_np, variant->name);
+	of_node_put(variants_np);
+	if (!variant_np)
+		return -ENODEV;
+
+	info = fpga_image_info_alloc(dev);
+	if (!info) {
+		ret = -ENOMEM;
+		goto err_put_node;
+	}
+
+	if (!of_property_read_bool(variant_np, "firmware-cached")) {
+		info->firmware_name = devm_kstrdup(dev, priv->fw_name, GFP_KERNEL);
+		if (!info->firmware_name) {
+			ret = -ENOMEM;
+			goto err_free_info;
+		}
+	} else if (priv->fw_buf) {
+		info->buf = priv->fw_buf;
+		info->count = priv->fw_size;
+	} else {
+		ret = request_firmware(&fw, priv->fw_name, dev);
+		if (ret) {
+			dev_err(dev, "failed to request firmware '%s'\n", priv->fw_name);
+			goto err_free_info;
+		}
+
+		priv->fw_buf = devm_kmemdup(dev, fw->data, fw->size, GFP_KERNEL);
+		priv->fw_size = fw->size;
+		release_firmware(fw);
+
+		if (!priv->fw_buf) {
+			ret = -ENOMEM;
+			goto err_free_info;
+		}
+
+		info->buf = priv->fw_buf;
+		info->count = priv->fw_size;
+	}
+
+	/* Checked during probing */
+	info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
+
+	of_property_read_u32(dev->of_node, "region-unfreeze-timeout-us",
+			     &info->enable_timeout_us);
+	of_property_read_u32(dev->of_node, "region-freeze-timeout-us",
+			     &info->disable_timeout_us);
+	of_property_read_u32(dev->of_node, "config-complete-timeout-us",
+			     &info->config_complete_timeout_us);
+
+	region->info = info;
+
+	if (info->firmware_name || info->buf) {
+		ret = fpga_region_program_fpga(region);
+		if (ret) {
+			dev_err(dev, "failed to program FPGA\n");
+			goto err_clear_info;
+		}
+	}
+
+	ret = of_fpga_region_populate_variant(dev, variant_np);
+	if (ret) {
+		dev_err(dev, "failed to populate variant IP nodes\n");
+		goto err_clear_info;
+	}
+
+	of_node_put(variant_np);
+	return 0;
+
+err_clear_info:
+	region->info = NULL;
+err_free_info:
+	fpga_image_info_free(info);
+err_put_node:
+	of_node_put(variant_np);
+	return ret;
+}
+
+/**
+ * of_fpga_region_remove_variant - remove the current FPGA variant from the region
+ * @region: FPGA region
+ * @variant: FPGA variant being removed
+ *
+ * Unregisters all devices that were populared for the variant's IPs
+ * during apply_variant() and frees the FPGA image.
+ */
+static void of_fpga_region_remove_variant(struct fpga_region *region,
+					  struct fpga_variant *variant)
+{
+	struct device_node *variants_np, *variant_np;
+	struct device *dev = &region->dev;
+
+	variants_np = of_get_child_by_name(dev->of_node, "fpga-variants");
+	if (variants_np) {
+		variant_np = of_get_child_by_name(variants_np, variant->name);
+		of_node_put(variants_np);
+
+		if (variant_np) {
+			device_for_each_child(dev, variant_np,
+					      of_fpga_remove_variant_child);
+			of_node_put(variant_np);
+		}
+	}
+
+	if (region->info) {
+		fpga_image_info_free(region->info);
+		region->info = NULL;
+	}
+}
+
 /**
  * child_regions_with_firmware - Used to check the child region info.
  * @overlay: device node of the overlay
@@ -397,8 +572,16 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	struct device_node *var_np, *base_np = NULL, *variants_np = NULL;
 	struct fpga_region *region;
 	struct fpga_manager *mgr;
+	struct fpga_region_info info = { 0 };
+	struct of_fpga_variant_priv *priv;
+	const char *base_variant_name = NULL;
+	const char *fw_name = NULL;
+	bool has_base_variant = false;
+	bool base_variant_found = false;
+	bool is_base = false;
 	int ret;
 
 	/* Find the FPGA mgr specified by region or parent region. */
@@ -406,20 +589,105 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = fpga_region_register(dev, mgr, of_fpga_region_get_bridges);
+	/* Register variants support only if the device tree is well-formed */
+	if (!of_property_read_string(np, "base-variant", &base_variant_name))
+		has_base_variant = true;
+
+	if (has_base_variant) {
+		if (!of_property_read_bool(np, "partial-fpga-config")) {
+			dev_err(dev, "Region '%s' is missing 'partial-fpga-config' property.\n",
+				np->name);
+			ret = -EINVAL;
+			goto eprobe_mgr_put;
+		}
+
+		variants_np = of_get_child_by_name(np, "fpga-variants");
+		if (!variants_np) {
+			dev_err(dev, "Missing 'fpga-variants' container node.\n");
+			ret = -EINVAL;
+			goto eprobe_mgr_put;
+		}
+
+		for_each_available_child_of_node(variants_np, var_np) {
+			if (!of_property_present(var_np, "firmware-name")) {
+				dev_err(dev, "Variant '%s' is missing 'firmware-name'.\n",
+					var_np->name);
+				of_node_put(var_np);
+				ret = -EINVAL;
+				goto eprobe_mgr_put;
+			}
+
+			if (!strcmp(var_np->name, base_variant_name))
+				base_variant_found = true;
+		}
+
+		if (!base_variant_found) {
+			dev_err(dev, "base-variant '%s' does not match.\n",
+				base_variant_name);
+			ret = -EINVAL;
+			goto eprobe_mgr_put;
+		}
+
+		info.apply_variant = of_fpga_region_apply_variant;
+		info.remove_variant = of_fpga_region_remove_variant;
+	}
+
+	info.mgr = mgr;
+	info.get_bridges = of_fpga_region_get_bridges;
+
+	region = fpga_region_register_full(dev, &info);
 	if (IS_ERR(region)) {
 		ret = PTR_ERR(region);
 		goto eprobe_mgr_put;
 	}
+	if (has_base_variant && variants_np) {
+		for_each_available_child_of_node(variants_np, var_np) {
+			priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+			if (!priv) {
+				of_node_put(var_np);
+				ret = -ENOMEM;
+				goto eprobe_region_unregister;
+			}
+
+			of_property_read_string(var_np, "firmware-name", &fw_name);
+			priv->fw_name = devm_kstrdup(dev, fw_name, GFP_KERNEL);
+			if (!priv->fw_name) {
+				of_node_put(var_np);
+				ret = -ENOMEM;
+				goto eprobe_region_unregister;
+			}
+
+			is_base = !strcmp(var_np->name, base_variant_name);
+			if (is_base)
+				base_np = of_node_get(var_np);
+
+			ret = fpga_region_add_variant(region, var_np->name, is_base, priv);
+			if (ret) {
+				dev_err(dev, "Cannot add variant '%s'.\n", var_np->name);
+				of_node_put(var_np);
+				goto eprobe_region_unregister;
+			}
+		}
+		of_node_put(variants_np);
+	}
 
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
-	platform_set_drvdata(pdev, region);
 
+	if (base_np) {
+		of_fpga_region_populate_variant(&region->dev, base_np);
+		of_node_put(base_np);
+	}
+
+	platform_set_drvdata(pdev, region);
 	dev_info(dev, "FPGA Region probed\n");
 
 	return 0;
 
+eprobe_region_unregister:
+	fpga_region_unregister(region);
 eprobe_mgr_put:
+	of_node_put(base_np);
+	of_node_put(variants_np);
 	fpga_mgr_put(mgr);
 	return ret;
 }
-- 
2.54.0

