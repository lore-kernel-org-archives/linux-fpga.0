Return-Path: <SRS0=wxbZ=XF=cmss.chinamobile.com=dingxiang@kernel.org>
Return-Path: <SRS0=wxbZ=XF=cmss.chinamobile.com=dingxiang@kernel.org>
From: Ding Xiang <dingxiang@cmss.chinamobile.com>
Subject: [PATCH] fpga: remove redundant dev_err message
Date: Tue, 10 Sep 2019 17:26:56 +0800
Message-Id: <1568107616-12755-1-git-send-email-dingxiang@cmss.chinamobile.com>
To: mdf@kernel.org, linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

devm_ioremap_resource already contains error message, so remove
the redundant dev_err message

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/fpga/ts73xx-fpga.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 9a17fe9..2888ff0 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -119,10 +119,8 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->io_base = devm_ioremap_resource(kdev, res);
-	if (IS_ERR(priv->io_base)) {
-		dev_err(kdev, "unable to remap registers\n");
+	if (IS_ERR(priv->io_base))
 		return PTR_ERR(priv->io_base);
-	}
 
 	mgr = devm_fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
 				   &ts73xx_fpga_ops, priv);
-- 
1.9.1
