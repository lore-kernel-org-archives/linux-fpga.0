Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8805CE7B10
	for <linux-fpga@archiver.kernel.org>; Thu, 28 Sep 2023 10:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjI1J7m (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Thu, 28 Sep 2023 05:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjI1J7j (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 28 Sep 2023 05:59:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34237199;
        Thu, 28 Sep 2023 02:59:37 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rx83h3WW5ztS6W;
        Thu, 28 Sep 2023 17:55:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 28 Sep
 2023 17:59:35 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Russ Weight <russell.h.weight@intel.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] fpga: fpga-mgr: Fix possible memory leak in fpga_mgr_register_full()
Date:   Thu, 28 Sep 2023 17:59:08 +0800
Message-ID: <20230928095909.1298103-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

If device_register() fails in fpga_mgr_register_full(), the mgr
allocated by kzalloc() and the id allocated by ida_alloc() also need be
freed otherwise will cause memory leak.

Fixes: 4ba0b2c294fe ("fpga: mgr: Use standard dev_release for class driver")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/fpga/fpga-mgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 06651389c592..9724f192ba16 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -827,13 +827,13 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 	mgr->state = fpga_mgr_state(mgr);
 
 	ret = device_register(&mgr->dev);
-	if (ret) {
-		put_device(&mgr->dev);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto error_put_device;
 
 	return mgr;
 
+error_put_device:
+	put_device(&mgr->dev);
 error_device:
 	ida_free(&fpga_mgr_ida, id);
 error_kfree:
-- 
2.34.1

