Return-Path: <SRS0=PlAX=DK=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2912C4363C
	for <linux-fpga@archiver.kernel.org>; Sat,  3 Oct 2020 01:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2497206FA
	for <linux-fpga@archiver.kernel.org>; Sat,  3 Oct 2020 01:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgJCBYV (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Fri, 2 Oct 2020 21:24:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:5543 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJCBYU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 2 Oct 2020 21:24:20 -0400
IronPort-SDR: +m6HP54fIgAvJ91wrmdeOuXFptBpJhmmFvT62saiRXaEJDVyCGQeLU5Btr59Ct+h4l3wCT3ylB
 2cRC/YugKy+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="162363108"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="162363108"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 18:24:19 -0700
IronPort-SDR: AhV9UbA4068pqn4tPtvAPpbk8oVpVdCUxylEWRzqlcQRCgg3flyeqedsuW/gXemkiQiGzPeWsE
 4Z6AdfBZOIig==
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="516097862"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.254.5.53])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 18:24:19 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 3/6] fpga: m10bmc-sec: expose max10 flash update counts
Date:   Fri,  2 Oct 2020 18:24:09 -0700
Message-Id: <20201003012412.16831-4-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201003012412.16831-1-russell.h.weight@intel.com>
References: <20201003012412.16831-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the MAX10 BMC Security Engine driver to provide a
handler to expose the flash update count for the FPGA user
image in sysfs.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v2:
  - Renamed get_qspi_flash_count() to m10bmc_user_flash_count()
  - Minor code cleanup per review comments
  - Added m10bmc_ prefix to functions in m10bmc_iops structure
---
 drivers/fpga/intel-m10-bmc-secure.c | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index df8ebda9a9cb..da61cfda3c50 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -11,6 +11,7 @@
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/vmalloc.h>
 
 struct m10bmc_sec {
@@ -105,7 +106,37 @@ static int m10bmc_pr_root_entry_hash(struct ifpga_sec_mgr *imgr,
 	return m10bmc_root_entry_hash(imgr, PR_REH_ADDR, hash, size);
 }
 
+#define FLASH_COUNT_SIZE 4096	/* count stored in inverted bit vector */
+
+static int m10bmc_user_flash_count(struct ifpga_sec_mgr *imgr)
+{
+	struct m10bmc_sec *sec = imgr->priv;
+	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+	unsigned int num_bits = FLASH_COUNT_SIZE * 8;
+	u8 *flash_buf;
+	int ret;
+
+	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
+	if (!flash_buf)
+		return -ENOMEM;
+
+	ret = m10bmc_raw_bulk_read(sec->m10bmc, USER_FLASH_COUNT, flash_buf,
+				   FLASH_COUNT_SIZE / stride);
+	if (ret) {
+		dev_err(sec->dev, "%s failed to read %d\n", __func__, ret);
+		goto exit_free;
+	}
+
+	ret = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
+
+exit_free:
+	kfree(flash_buf);
+
+	return ret;
+}
+
 static const struct ifpga_sec_mgr_ops m10bmc_iops = {
+	.user_flash_count = m10bmc_user_flash_count,
 	.bmc_root_entry_hash = m10bmc_bmc_root_entry_hash,
 	.sr_root_entry_hash = m10bmc_sr_root_entry_hash,
 	.pr_root_entry_hash = m10bmc_pr_root_entry_hash,
-- 
2.17.1

