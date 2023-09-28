Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BED1CE7B17
	for <linux-fpga@archiver.kernel.org>; Thu, 28 Sep 2023 10:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjI1J6w (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Thu, 28 Sep 2023 05:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjI1J6v (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 28 Sep 2023 05:58:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA4E122;
        Thu, 28 Sep 2023 02:58:49 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rx85B3ZGDz15NKB;
        Thu, 28 Sep 2023 17:56:30 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 28 Sep
 2023 17:58:46 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Russ Weight <russell.h.weight@intel.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] fpga: bridge: Fix possible memory leak in fpga_bridge_register()
Date:   Thu, 28 Sep 2023 17:58:18 +0800
Message-ID: <20230928095818.1297547-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

If device_register() fails in fpga_bridge_register(), the bridge
allocated by kzalloc() and the id allocated by ida_alloc() also need be
freed otherwise will cause memory leak.

Fixes: 0d70af3c2530 ("fpga: bridge: Use standard dev_release for class driver")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/fpga/fpga-bridge.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index a024be2b84e2..4a298656ce77 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -370,15 +370,15 @@ fpga_bridge_register(struct device *parent, const char *name,
 		goto error_device;
 
 	ret = device_register(&bridge->dev);
-	if (ret) {
-		put_device(&bridge->dev);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto error_put_device;
 
 	of_platform_populate(bridge->dev.of_node, NULL, NULL, &bridge->dev);
 
 	return bridge;
 
+error_put_device:
+	put_device(&bridge->dev);
 error_device:
 	ida_free(&fpga_bridge_ida, id);
 error_kfree:
-- 
2.34.1

