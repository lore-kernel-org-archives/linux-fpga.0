Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4E2C48BE5
	for <linux-fpga@archiver.kernel.org>; Thu, 10 Jun 2021 19:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACEF61419
	for <linux-fpga@archiver.kernel.org>; Thu, 10 Jun 2021 19:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFJTgc (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Thu, 10 Jun 2021 15:36:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:36545 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230462AbhFJTgb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jun 2021 15:36:31 -0400
IronPort-SDR: HYVwLFb3MaHAsexnOuaiyZUyGLm/ZgJq++52O/ov2EbGpArElIaabzGDT8iOY0Tb3y8L3IKXOn
 0wvD8dIa7BQw==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="185756072"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="185756072"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 12:34:28 -0700
IronPort-SDR: y82jeO9v9SFrcwnrw4gVjWpBwuOMoq9dYiwUExMoWsLrxWpe9Yd+EAIP3+xlfbLZqE1fbtGItw
 e9M462aaSL8A==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="477458080"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.184.121])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 12:34:28 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 2/8] fpga: stratix10-soc: Add missing fpga_mgr_free() call
Date:   Thu, 10 Jun 2021 12:34:16 -0700
Message-Id: <20210610193422.286835-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610193422.286835-1-russell.h.weight@intel.com>
References: <20210610193422.286835-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The stratix10-soc driver uses fpga_mgr_create() function and is therefore
responsible to call fpga_mgr_free() to release the class driver resources.
Add a missing call to fpga_mgr_free in the s10_remove() function.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
---
v3:
  - No change
v2:
  - Added reviewed-by tag
---
 drivers/fpga/stratix10-soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 657a70c5fc99..9e34bbbce26e 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -454,6 +454,7 @@ static int s10_remove(struct platform_device *pdev)
 	struct s10_priv *priv = mgr->priv;
 
 	fpga_mgr_unregister(mgr);
+	fpga_mgr_free(mgr);
 	stratix10_svc_free_channel(priv->chan);
 
 	return 0;
-- 
2.25.1

