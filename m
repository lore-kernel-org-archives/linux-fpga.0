Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4494EC4361B
	for <linux-fpga@archiver.kernel.org>; Mon, 14 Dec 2020 14:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018032054F
	for <linux-fpga@archiver.kernel.org>; Mon, 14 Dec 2020 14:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440143AbgLNOWu (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 14 Dec 2020 09:22:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:18337 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440138AbgLNOWn (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 09:22:43 -0500
IronPort-SDR: p5Nk35pQU5WtvkKj1e9wlkA0jnAxaLchmdfWXXin5AruqCQkkTBQc3zmwp9LoWoMoihFQjHj6X
 aTy1Us0OoZBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="259437991"
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="259437991"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 06:19:02 -0800
IronPort-SDR: IQMkrSODNO+sYN1uCvryPMIWj0A2M24dZwxeUAmkEuvSenPlIcr9h02GvLa5ZB6H2g/EAxNTJi
 ssGXhskw5yJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="333456254"
Received: from marshy.an.intel.com ([10.122.105.143])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2020 06:18:45 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [RESEND PATCHv2 1/5] firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
Date:   Mon, 14 Dec 2020 08:39:56 -0600
Message-Id: <1607956800-28476-2-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607956800-28476-1-git-send-email-richard.gong@linux.intel.com>
References: <1607956800-28476-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add COMMAND_AUTHENTICATE_BITSTREAM command flag for new added bitstream
authentication feature. Authenticating a bistream is to make sure a signed
bitstream has the valid signatures.

Except for the actual configuration of the device, the bitstream
authentication works the same way as FPGA configuration does. If the
authentication passes, the signed bitstream will be programmed into QSPI
flash memory and will be expected to boot without issues.

Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
aligns with the firmware settings.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v2: new added
---
 include/linux/firmware/intel/stratix10-svc-client.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index a93d859..85463c8 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -51,12 +51,17 @@
 #define SVC_STATUS_NO_SUPPORT		6
 
 /**
- * Flag bit for COMMAND_RECONFIG
+ * Flag bit for COMMAND_RECONFIG, in bit number
  *
  * COMMAND_RECONFIG_FLAG_PARTIAL:
- * Set to FPGA configuration type (full or partial).
+ * Set for partial FPGA configuration.
+ *
+ * COMMAND_AUTHENTICATE_BITSTREAM:
+ * Set for bitstream authentication, which makes sure a signed bitstream
+ * has valid signatures before committing it to QSPI flash memory.
  */
-#define COMMAND_RECONFIG_FLAG_PARTIAL	1
+#define COMMAND_RECONFIG_FLAG_PARTIAL	0
+#define COMMAND_AUTHENTICATE_BITSTREAM	1
 
 /**
  * Timeout settings for service clients:
-- 
2.7.4

