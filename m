Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8EB3CFF6B
	for <linux-fpga@vger.kernel.org>; Mon,  8 Jun 2026 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937008; cv=none; b=SSmCT6pC0o5CrdarUaGl/zzHq9zPnjBSoul/Dkyhq7jEPdc1F09qJpgfQtfSEm0/frY5qIpCaXed868PTkMYHnLEXWA/AdCP/9yJ82golUDyCBWyaXzL51L8Szv/0WLVpE5fLtUapaZOMRCKv4ns5oLPsjo2x8hBA+NjG8hnYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937008; c=relaxed/simple;
	bh=43aOFbhEeHT9PxYOrEp6k4NUkjYRy5qTPTzl63iF25A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhyuY+t8MKyXfHxGPzxr9U52xw42EvKOU+l7If8n0KnkTMSRMY7udyt+CljjRSW1hC1hcpszQ+2+6Dr77vv011szWnN9NojQN5g+7u+x5rd+XYwOE15e08P8EvXu62bVPLwRGuOIN06x7lca2KquX4Zahky1UZL+tRxuMoASVr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cqL8CjR6; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cqL8CjR6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780937003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQsMoxqaBqU93YHzchyGjIGkclyytp/JQEP/XuCArG4=;
	b=cqL8CjR6NpQGTJq6KhEu5ErbrwvLal4OmhgZHMmzjRQGci/3By5PpkF/7cZzLNWhU5+F7R
	08jsXrwGkUt+cBb19iHRLmzFJITi4KonC4oS3SyaXnfHV/wwrKDmgcQmpUOlSm1pwymZ0r
	vNj9D5N+2u6LqvgXxJUGveV5S09vDlE=
From: Marco Pagani <marco.pagani@linux.dev>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marco.pagani@linux.dev>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH fpga/for-next 1/2] fpga: region: Add support for FPGA region variants
Date: Mon,  8 Jun 2026 18:42:46 +0200
Message-ID: <20260608164247.1998417-2-marco.pagani@linux.dev>
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

Extend the fpga-region to support FPGA variants. Add the logic and
the interface functions to manage a list of variants, and define the
apply_variant() and remove_variant() methods that concrete regions must
implement to define how variants are populated and depopulated.

Signed-off-by: Marco Pagani <marco.pagani@linux.dev>
---
 drivers/fpga/fpga-region.c       | 171 +++++++++++++++++++++++++++++++
 include/linux/fpga/fpga-region.h |  32 ++++++
 2 files changed, 203 insertions(+)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 662e8e4203ca..60404cce6188 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -80,6 +80,101 @@ static void fpga_region_put(struct fpga_region *region)
 	mutex_unlock(&region->mutex);
 }
 
+/**
+ * fpga_region_add_variant - add a new variant to the FPGA region
+ * @region: FPGA region
+ * @name: string identifier for the variant
+ * @is_enabled: whether this variant is the currently enabled variant
+ * @priv: private data to be associated with the variant
+ *
+ * Allocates a new variant and adds it to the region's variant list.
+ * If @is_enabled is true, this variant is marked as the enabled variant.
+ *
+ * Return: 0 on success, or -ENOMEM on memory allocation failure.
+ */
+int fpga_region_add_variant(struct fpga_region *region, const char *name,
+			    bool is_enabled, void *priv)
+{
+	struct fpga_variant *variant;
+	char *variant_name;
+
+	variant_name = devm_kstrdup(&region->dev, name, GFP_KERNEL);
+	if (!variant_name)
+		return -ENOMEM;
+
+	variant = devm_kzalloc(&region->dev, sizeof(*variant), GFP_KERNEL);
+	if (!variant)
+		return -ENOMEM;
+
+	variant->priv = priv;
+	variant->name = variant_name;
+
+	mutex_lock(&region->variant_mutex);
+	if (is_enabled)
+		region->enabled_variant = variant;
+
+	list_add_tail(&variant->node, &region->variant_list);
+	mutex_unlock(&region->variant_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fpga_region_add_variant);
+
+/**
+ * fpga_region_program_variant - switch the variant of an FPGA region
+ * @region: FPGA region
+ * @name: string identifier of the variant to enable
+ *
+ * Get the requested variant from the region's variant list. If found,
+ * and it is not already active, removes the currently enabled variant via
+ * the remove_variant() callback and applies the requested one  via the
+ * apply_variant() callback.
+ *
+ * Return: 0 on success, -EINVAL if the variant is not found, or a negative
+ * error code passed up from the apply_variant() callback.
+ */
+int fpga_region_program_variant(struct fpga_region *region, const char *name)
+{
+	struct fpga_variant *variant;
+	bool found_variant = false;
+	int ret = -EINVAL;
+
+	mutex_lock(&region->variant_mutex);
+
+	list_for_each_entry(variant, &region->variant_list, node) {
+		if (sysfs_streq(variant->name, name)) {
+			found_variant = true;
+			break;
+		}
+	}
+
+	if (!found_variant)
+		goto out_unlock;
+
+	if (region->enabled_variant == variant) {
+		ret = 0;
+		goto out_unlock;
+	}
+
+	if (region->enabled_variant && region->remove_variant)
+		region->remove_variant(region, region->enabled_variant);
+
+	if (region->apply_variant) {
+		ret = region->apply_variant(region, variant);
+		if (ret) {
+			dev_err(&region->dev, "Variant programming failed!\n");
+			region->enabled_variant = NULL;
+		} else {
+			region->enabled_variant = variant;
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&region->variant_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fpga_region_program_variant);
+
 /**
  * fpga_region_program_fpga - program FPGA
  *
@@ -174,12 +269,76 @@ static ssize_t compat_id_show(struct device *dev,
 
 static DEVICE_ATTR_RO(compat_id);
 
+static ssize_t variants_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct fpga_region *region = to_fpga_region(dev);
+	struct fpga_variant *variant;
+	int len = 0;
+
+	mutex_lock(&region->variant_mutex);
+	list_for_each_entry(variant, &region->variant_list, node)
+		len += sysfs_emit_at(buf, len, "%s\n", variant->name);
+	mutex_unlock(&region->variant_mutex);
+
+	return len;
+}
+static DEVICE_ATTR_RO(variants);
+
+static ssize_t enabled_variant_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct fpga_region *region = to_fpga_region(dev);
+	ssize_t len = 0;
+
+	mutex_lock(&region->variant_mutex);
+	if (region->enabled_variant)
+		len = sysfs_emit(buf, "%s\n", region->enabled_variant->name);
+	mutex_unlock(&region->variant_mutex);
+
+	return len;
+}
+
+static ssize_t enabled_variant_store(struct device *dev, struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct fpga_region *region = to_fpga_region(dev);
+	int ret;
+
+	ret = fpga_region_program_variant(region, buf);
+
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_RW(enabled_variant);
+
+static struct attribute *fpga_region_variant_attrs[] = {
+	&dev_attr_enabled_variant.attr,
+	&dev_attr_variants.attr,
+	NULL,
+};
+
+static umode_t fpga_region_variant_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct fpga_region *region = to_fpga_region(dev);
+
+	return region->apply_variant ? attr->mode : 0;
+}
+
+static const struct attribute_group fpga_region_variant_group = {
+	.attrs = fpga_region_variant_attrs,
+	.is_visible = fpga_region_variant_is_visible,
+};
+
 static struct attribute *fpga_region_attrs[] = {
 	&dev_attr_compat_id.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(fpga_region);
 
+static const struct attribute_group *fpga_region_variant_groups[] = {
+	&fpga_region_variant_group,
+	NULL,
+};
+
 /**
  * __fpga_region_register_full - create and register an FPGA Region device
  * @parent: device parent
@@ -216,14 +375,19 @@ __fpga_region_register_full(struct device *parent, const struct fpga_region_info
 	region->priv = info->priv;
 	region->get_bridges = info->get_bridges;
 	region->ops_owner = owner;
+	region->apply_variant = info->apply_variant;
+	region->remove_variant = info->remove_variant;
 
 	mutex_init(&region->mutex);
+	mutex_init(&region->variant_mutex);
 	INIT_LIST_HEAD(&region->bridge_list);
+	INIT_LIST_HEAD(&region->variant_list);
 
 	region->dev.class = &fpga_region_class;
 	region->dev.parent = parent;
 	region->dev.of_node = parent->of_node;
 	region->dev.id = id;
+	region->dev.groups = fpga_region_variant_groups;
 
 	ret = dev_set_name(&region->dev, "region%d", id);
 	if (ret)
@@ -280,6 +444,13 @@ EXPORT_SYMBOL_GPL(__fpga_region_register);
  */
 void fpga_region_unregister(struct fpga_region *region)
 {
+	mutex_lock(&region->variant_mutex);
+	if (region->enabled_variant && region->remove_variant) {
+		region->remove_variant(region, region->enabled_variant);
+		region->enabled_variant = NULL;
+	}
+	mutex_unlock(&region->variant_mutex);
+
 	device_unregister(&region->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_region_unregister);
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 5fbc05fe70a6..3b3d1f8a1189 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -9,12 +9,27 @@
 
 struct fpga_region;
 
+/**
+ * struct fpga_variant - a variant  configuration for an FPGA region
+ * @node: list node for the region's variant list
+ * @name: identifier of the variant
+ * @priv: private data for the region concrete implementation
+ */
+struct fpga_variant {
+	struct list_head node;
+	const char *name;
+	void *priv;
+};
+
 /**
  * struct fpga_region_info - collection of parameters an FPGA Region
  * @mgr: fpga region manager
  * @compat_id: FPGA region id for compatibility check.
+ * @variant_list: linked list of registered variants
  * @priv: fpga region private data
  * @get_bridges: optional function to get bridges to a list
+ * @apply_variant: optional function to apply one of the variants
+ * @remove_variant: optional function to remove one of the variants
  *
  * fpga_region_info contains parameters for the register_full function.
  * These are separated into an info structure because they some are optional
@@ -26,6 +41,8 @@ struct fpga_region_info {
 	struct fpga_compat_id *compat_id;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
+	int (*apply_variant)(struct fpga_region *region, struct fpga_variant *variant);
+	void (*remove_variant)(struct fpga_region *region, struct fpga_variant *variant);
 };
 
 /**
@@ -37,8 +54,13 @@ struct fpga_region_info {
  * @info: FPGA image info
  * @compat_id: FPGA region id for compatibility check.
  * @ops_owner: module containing the get_bridges function
+ * @variant_list: linked list of registered variants
+ * @enabled_variant: pointer to the currently enabled variant
+ * @variant_mutex: protects the enabled variant and variant list
  * @priv: private data
  * @get_bridges: optional function to get bridges to a list
+ * @apply_variant: optional function to apply one of the variants
+ * @remove_variant: optional function to remove one of the variants
  */
 struct fpga_region {
 	struct device dev;
@@ -48,8 +70,14 @@ struct fpga_region {
 	struct fpga_image_info *info;
 	struct fpga_compat_id *compat_id;
 	struct module *ops_owner;
+	struct list_head variant_list;
+	struct fpga_variant *enabled_variant;
+	struct mutex variant_mutex; /* protects variant_list and enabled_variant */
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
+	int (*apply_variant)(struct fpga_region *region, struct fpga_variant *variant);
+	void (*remove_variant)(struct fpga_region *region, struct fpga_variant *variant);
+
 };
 
 #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
@@ -60,6 +88,10 @@ fpga_region_class_find(struct device *start, const void *data,
 
 int fpga_region_program_fpga(struct fpga_region *region);
 
+int fpga_region_add_variant(struct fpga_region *region, const char *name,
+			    bool is_enabled, void *priv);
+int fpga_region_program_variant(struct fpga_region *region, const char *name);
+
 #define fpga_region_register_full(parent, info) \
 	__fpga_region_register_full(parent, info, THIS_MODULE)
 struct fpga_region *
-- 
2.54.0

