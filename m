Return-Path: <SRS0=PlAX=DK=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF25C47095
	for <linux-fpga@archiver.kernel.org>; Sat,  3 Oct 2020 01:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE73206FA
	for <linux-fpga@archiver.kernel.org>; Sat,  3 Oct 2020 01:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgJCBY3 (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Fri, 2 Oct 2020 21:24:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:5546 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgJCBYV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 2 Oct 2020 21:24:21 -0400
IronPort-SDR: o9Jt8knZv65T1NXSA9TA6hA5ncWC8c2OqNKs0r1k5t4ju5RM50FKHHgVWd5SZw/HHpY0IdcyUN
 s9PmYg9y0vfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="162363112"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="162363112"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 18:24:21 -0700
IronPort-SDR: 2C0Dn41qRn11VF3IhoCN0qz2i61xDdc6HQYCRzl95CH3dsgyq/yyEhLILk+jU7Qsh90qV+cLkl
 C5xetxOUExrw==
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="516097873"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.254.5.53])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 18:24:21 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 6/6] fpga: m10bmc-sec: add max10 get_hw_errinfo callback func
Date:   Fri,  2 Oct 2020 18:24:12 -0700
Message-Id: <20201003012412.16831-7-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201003012412.16831-1-russell.h.weight@intel.com>
References: <20201003012412.16831-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the MAX10 BMC Security Engine driver to include
a function that returns 64 bits of additional HW specific
data for errors that require additional information.
This callback function enables the hw_errinfo sysfs
node in the Intel Security Manager class driver.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v2:
  - Implemented HW_ERRINFO_POISON for m10bmc_sec_hw_errinfo() to
    ensure that corresponding bits are set to 1 if we are unable
    to read the doorbell or auth_result registers.
  - Added m10bmc_ prefix to functions in m10bmc_iops structure
---
 drivers/fpga/intel-m10-bmc-secure.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index a9617c5b3845..9edc39439c97 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -495,6 +495,30 @@ static enum ifpga_sec_err m10bmc_sec_cancel(struct ifpga_sec_mgr *imgr)
 	return ret ? IFPGA_SEC_ERR_RW_ERROR : IFPGA_SEC_ERR_NONE;
 }
 
+#define HW_ERRINFO_POISON	GENMASK(31, 0)
+static u64 m10bmc_sec_hw_errinfo(struct ifpga_sec_mgr *imgr)
+{
+	struct m10bmc_sec *sec = imgr->priv;
+	u32 doorbell, auth_result;
+
+	switch (imgr->err_code) {
+	case IFPGA_SEC_ERR_HW_ERROR:
+	case IFPGA_SEC_ERR_TIMEOUT:
+	case IFPGA_SEC_ERR_BUSY:
+	case IFPGA_SEC_ERR_WEAROUT:
+		if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell))
+			doorbell = HW_ERRINFO_POISON;
+
+		if (m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT,
+				     &auth_result))
+			auth_result = HW_ERRINFO_POISON;
+
+		return (u64)doorbell << 32 | (u64)auth_result;
+	default:
+		return 0;
+	}
+}
+
 static const struct ifpga_sec_mgr_ops m10bmc_iops = {
 	.user_flash_count = m10bmc_user_flash_count,
 	.bmc_root_entry_hash = m10bmc_bmc_root_entry_hash,
@@ -513,6 +537,7 @@ static const struct ifpga_sec_mgr_ops m10bmc_iops = {
 	.write_blk = m10bmc_sec_write_blk,
 	.poll_complete = m10bmc_sec_poll_complete,
 	.cancel = m10bmc_sec_cancel,
+	.get_hw_errinfo = m10bmc_sec_hw_errinfo,
 };
 
 static int m10bmc_secure_probe(struct platform_device *pdev)
-- 
2.17.1

