Return-Path: <SRS0=5vXW=CI=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507C7C433E6
	for <linux-fpga@archiver.kernel.org>; Sun, 30 Aug 2020 16:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190032071B
	for <linux-fpga@archiver.kernel.org>; Sun, 30 Aug 2020 16:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgH3QjJ (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Sun, 30 Aug 2020 12:39:09 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:43436 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbgH3QjH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 30 Aug 2020 12:39:07 -0400
Received: from [78.134.86.56] (port=34202 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kCQMC-000E3G-2F; Sun, 30 Aug 2020 18:39:04 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v4 2/5] fpga manager: xilinx-spi: remove final dot from dev_err() strings
Date:   Sun, 30 Aug 2020 18:38:47 +0200
Message-Id: <20200830163850.8380-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200830163850.8380-1-luca@lucaceresoli.net>
References: <20200830163850.8380-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Most dev_err messages in this file have no final dot. Remove the only two
exceptions to make them consistent.

Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v4:
 - add Reviewed-by Tom Rix

Changes in v3: none.

Changes in v2:
 - move before the "provide better diagnostics on programming failure"
   patch for clarity
---
 drivers/fpga/xilinx-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 502fae0d1d85..01f494172379 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -77,7 +77,7 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
 	int err;
 
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
-		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
+		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
 		return -EINVAL;
 	}
 
@@ -169,7 +169,7 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
 			return xilinx_spi_apply_cclk_cycles(conf);
 	}
 
-	dev_err(&mgr->dev, "Timeout after config data transfer.\n");
+	dev_err(&mgr->dev, "Timeout after config data transfer\n");
 	return -ETIMEDOUT;
 }
 
-- 
2.28.0

