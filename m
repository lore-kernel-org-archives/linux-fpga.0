Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EADBC433E0
	for <linux-fpga@archiver.kernel.org>; Tue,  9 Feb 2021 22:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2E764EB8
	for <linux-fpga@archiver.kernel.org>; Tue,  9 Feb 2021 22:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhBIWIe (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:08:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:20938 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233466AbhBIWFd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 9 Feb 2021 17:05:33 -0500
IronPort-SDR: zOC2gByhckXfAN970mQlEB0lr+mUCPyKi1AC02KJThAb5CnnrBO230OWKoXc7jakRq5SyvuYW9
 mJLeetX0nAJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="201058923"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="201058923"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 14:02:11 -0800
IronPort-SDR: M2rElMlbAcnOjRx8vKa3mMp9M8g8G37n1wv0etn1DbgCW36x5mzm/fHFBFGyHjBUW3In1Thr40
 9ZXP6N9ZvBOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="361959982"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 09 Feb 2021 14:02:11 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
Subject: [PATCHv5 6/7] dt-bindings: fpga: add authenticate-fpga-config property
Date:   Tue,  9 Feb 2021 16:20:32 -0600
Message-Id: <1612909233-13867-7-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add authenticate-fpga-config property for FPGA bitstream authentication,
which makes sure a signed bitstream has valid signatures.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v5: rewrite the description to highlight two things with
    authenticate-fpga-config flag
v4: explain authenticate-fpga-config flag further
v3: no change
v2: put authenticate-fpga-config above partial-fpga-config
    update commit messages
---
 Documentation/devicetree/bindings/fpga/fpga-region.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index e811cf8..dca0e37 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -182,6 +182,16 @@ Optional properties:
 	This property is optional if the FPGA Manager handles the bridges.
         If the fpga-region is  the child of a fpga-bridge, the list should not
         contain the parent bridge.
+- authenticate-fpga-config : boolean, set if do bitstream authentication only.
+	If 'authenticate-fpga-config' is added then adding a new node or another
+	operation is not allowed.
+	Flag authenticate-fpga-config is used to check the integrity of the
+	bitstream.
+	Except for the actual configuration of the device, the authentication
+	works in the same way as FPGA configuration. If the authentication passes,
+	other operations such as full or partial reconfiguration can be performed.
+	When the bitstream into QSPI flash memory at device is programmed, it is
+	expected that there will be no issue when starting the device.
 - partial-fpga-config : boolean, set if partial reconfiguration is to be done,
 	otherwise full reconfiguration is done.
 - external-fpga-config : boolean, set if the FPGA has already been configured
-- 
2.7.4

