Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72219C32771
	for <linux-fpga@archiver.kernel.org>; Mon, 26 Sep 2022 15:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiIZP2L (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbiIZP0J (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Sep 2022 11:26:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4796FA1B
        for <linux-fpga@vger.kernel.org>; Mon, 26 Sep 2022 07:10:41 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mbl176yp4zWh76;
        Mon, 26 Sep 2022 22:06:35 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 22:10:39 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 22:10:38 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-fpga@vger.kernel.org>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>
Subject: [PATCH -next resend] fpga: zynq: Switch to use dev_err_probe() helper
Date:   Mon, 26 Sep 2022 22:17:29 +0800
Message-ID: <20220926141729.2292311-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In the probe path, dev_err() can be replaced with dev_err_probe()
which will check if error code is -EPROBE_DEFER and prints the
error name. It also sets the defer probe reason which can be
checked later through debugfs. It's more simple in error path.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
Resend for adding SoB.
---
 drivers/fpga/zynq-fpga.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 426aa34c6a0d..ae0da361e6c6 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -582,11 +582,9 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 		return priv->irq;
 
 	priv->clk = devm_clk_get(dev, "ref_clk");
-	if (IS_ERR(priv->clk)) {
-		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
-			dev_err(dev, "input clock not found\n");
-		return PTR_ERR(priv->clk);
-	}
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "input clock not found\n");
 
 	err = clk_prepare_enable(priv->clk);
 	if (err) {
-- 
2.25.1

