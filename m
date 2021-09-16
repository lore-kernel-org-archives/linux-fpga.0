Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6385CC433F5
	for <linux-fpga@archiver.kernel.org>; Thu, 16 Sep 2021 21:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1CE611C4
	for <linux-fpga@archiver.kernel.org>; Thu, 16 Sep 2021 21:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbhIPVJt (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:09:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:28746 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232910AbhIPVJt (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 Sep 2021 17:09:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="219475669"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="219475669"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 14:08:22 -0700
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="545866591"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.150.34])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 14:08:21 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com, rc@silicom.dk,
        Russ Weight <russell.h.weight@intel.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/1] fpga: dfl: Avoid reads to AFU CSRs during enumeration
Date:   Thu, 16 Sep 2021 14:07:33 -0700
Message-Id: <20210916210733.153388-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

CSR address space for Accelerator Functional Units (AFU) is not available
during the early Device Feature List (DFL) enumeration. Early access
to this space results in invalid data and port errors. This change adds
a condition to prevent an early read from the AFU CSR space.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>

Fixes: 23bcda750558 ("fpga: dfl: expose feature revision from struct
dfl_device")
Cc: stable@vger.kernel.org
---
 drivers/fpga/dfl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index c99b78ee008a..f86666cf2c6a 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1019,16 +1019,18 @@ create_feature_instance(struct build_feature_devs_info *binfo,
 {
 	unsigned int irq_base, nr_irqs;
 	struct dfl_feature_info *finfo;
+	u8 revision = 0;
 	int ret;
-	u8 revision;
 	u64 v;
 
-	v = readq(binfo->ioaddr + ofst);
-	revision = FIELD_GET(DFH_REVISION, v);
+	if (fid != FEATURE_ID_AFU) {
+		v = readq(binfo->ioaddr + ofst);
+		revision = FIELD_GET(DFH_REVISION, v);
 
-	/* read feature size and id if inputs are invalid */
-	size = size ? size : feature_size(v);
-	fid = fid ? fid : feature_id(v);
+		/* read feature size and id if inputs are invalid */
+		size = size ? size : feature_size(v);
+		fid = fid ? fid : feature_id(v);
+	}
 
 	if (binfo->len - ofst < size)
 		return -EINVAL;
-- 
2.25.1

