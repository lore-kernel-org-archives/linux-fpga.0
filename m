Return-Path: <SRS0=W+aB=B2=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=W+aB=B2=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from gateway23.websitewelcome.com ([192.185.50.119]:35314 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750781AbdJ0VIl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 27 Oct 2017 17:08:41 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 9E7FB11B2E
        for <linux-fpga@vger.kernel.org>; Fri, 27 Oct 2017 15:19:52 -0500 (CDT)
Date: Fri, 27 Oct 2017 15:19:51 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] fpga: fpga-bridge: remove unnecessary null check in
 of_fpga_bridge_get
Message-ID: <20171027201951.GA27077@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

Notice that bridge = to_fpga_bridge(dev); expands to:

bridge = container_of(dev, struct fpga_bridge, dev);

and container_of is never null, so this null check is
unnecessary.

Addresses-Coverity-ID: 1397912
Reported-by: Alan Tull <atull@kernel.org>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/fpga/fpga-bridge.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 9651aa5..409d1ac 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -94,8 +94,6 @@ struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
 		goto err_dev;
 
 	bridge = to_fpga_bridge(dev);
-	if (!bridge)
-		goto err_dev;
 
 	bridge->info = info;
 
-- 
2.7.4

