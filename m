Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39AFC63777
	for <linux-fpga@archiver.kernel.org>; Tue, 17 Nov 2020 01:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E48424690
	for <linux-fpga@archiver.kernel.org>; Tue, 17 Nov 2020 01:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgKQBYl (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 16 Nov 2020 20:24:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:34910 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgKQBYl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 16 Nov 2020 20:24:41 -0500
IronPort-SDR: 8fwgFIoGeC2nzzHEMWV/WzBKO4YY98qhCsiTLVt+DOO2ZWMLI34Ss4YrcbhVBKERUzvbJoKSY8
 5KGrZxJApV6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="234994419"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="234994419"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 17:24:36 -0800
IronPort-SDR: OhgRdexRzr1QR6Gy1/KxA7T18sCA7sIpzDpCZj+xBPJ3PJQj959MM1kxDfjkdceVPcMvOqq4yz
 D5z7FK9FHX8w==
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="310060650"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 17:24:36 -0800
From:   matthew.gerlach@linux.intel.com
To:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-doc@vger.kernel.org, corbet@lwn.net
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH 1/2] fpga: dfl: refactor cci_enumerate_feature_devs()
Date:   Mon, 16 Nov 2020 17:25:51 -0800
Message-Id: <20201117012552.262149-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117012552.262149-1-matthew.gerlach@linux.intel.com>
References: <20201117012552.262149-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

In preparation of looking for dfls based on a vendor
specific pcie capability, move code that assumes
Bar0/offset0 as start of DFL to its own function.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/fpga/dfl-pci.c | 86 ++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 37 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index a2203d03c9e2..b1b157b41942 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -119,49 +119,20 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
 	return table;
 }
 
-/* enumerate feature devices under pci device */
-static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
+static int find_dfl_in_bar0(struct pci_dev *pcidev,
+			    struct dfl_fpga_enum_info *info)
 {
-	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
-	int port_num, bar, i, nvec, ret = 0;
-	struct dfl_fpga_enum_info *info;
-	struct dfl_fpga_cdev *cdev;
 	resource_size_t start, len;
+	int port_num, bar, i;
 	void __iomem *base;
-	int *irq_table;
+	int ret = 0;
 	u32 offset;
 	u64 v;
 
-	/* allocate enumeration info via pci_dev */
-	info = dfl_fpga_enum_info_alloc(&pcidev->dev);
-	if (!info)
-		return -ENOMEM;
-
-	/* add irq info for enumeration if the device support irq */
-	nvec = cci_pci_alloc_irq(pcidev);
-	if (nvec < 0) {
-		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", nvec);
-		ret = nvec;
-		goto enum_info_free_exit;
-	} else if (nvec) {
-		irq_table = cci_pci_create_irq_table(pcidev, nvec);
-		if (!irq_table) {
-			ret = -ENOMEM;
-			goto irq_free_exit;
-		}
-
-		ret = dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
-		kfree(irq_table);
-		if (ret)
-			goto irq_free_exit;
-	}
-
-	/* start to find Device Feature List in Bar 0 */
+	/* start to find Device Feature List from Bar 0 */
 	base = cci_pci_ioremap_bar0(pcidev);
-	if (!base) {
-		ret = -ENOMEM;
-		goto irq_free_exit;
-	}
+	if (!base)
+		return -ENOMEM;
 
 	/*
 	 * PF device has FME and Ports/AFUs, and VF device only has one
@@ -208,12 +179,53 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 		dfl_fpga_enum_info_add_dfl(info, start, len);
 	} else {
 		ret = -ENODEV;
-		goto irq_free_exit;
 	}
 
 	/* release I/O mappings for next step enumeration */
 	pcim_iounmap_regions(pcidev, BIT(0));
 
+
+	return ret;
+}
+
+/* enumerate feature devices under pci device */
+static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
+{
+	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
+	struct dfl_fpga_enum_info *info;
+	struct dfl_fpga_cdev *cdev;
+	int nvec, ret = 0;
+	int *irq_table;
+
+	/* allocate enumeration info via pci_dev */
+	info = dfl_fpga_enum_info_alloc(&pcidev->dev);
+	if (!info)
+		return -ENOMEM;
+
+	/* add irq info for enumeration if the device support irq */
+	nvec = cci_pci_alloc_irq(pcidev);
+	if (nvec < 0) {
+		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", nvec);
+		ret = nvec;
+		goto enum_info_free_exit;
+	} else if (nvec) {
+		irq_table = cci_pci_create_irq_table(pcidev, nvec);
+		if (!irq_table) {
+			ret = -ENOMEM;
+			goto irq_free_exit;
+		}
+
+		ret = dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
+		kfree(irq_table);
+		if (ret)
+			goto irq_free_exit;
+	}
+
+	ret = find_dfl_in_bar0(pcidev, info);
+
+	if (ret)
+		goto irq_free_exit;
+
 	/* start enumeration with prepared enumeration information */
 	cdev = dfl_fpga_feature_devs_enumerate(info);
 	if (IS_ERR(cdev)) {
-- 
2.25.2

