Return-Path: <SRS0=1xIF=C5=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=1xIF=C5=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:54310 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbdLAU0g (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 1 Dec 2017 15:26:36 -0500
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] fpga: socfpga-a10: disable clk on error in socfpga_a10_fpga_probe()
Date: Fri,  1 Dec 2017 23:26:24 +0300
Message-Id: <1512159984-23948-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

If fpga_mgr_register() fails, a clock is left undisabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/fpga/socfpga-a10.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index f8770af0f6b5..a46e343a5b72 100644
--- a/drivers/fpga/socfpga-a10.c
+++ b/drivers/fpga/socfpga-a10.c
@@ -519,8 +519,14 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	return fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
+	ret = fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
 				 &socfpga_a10_fpga_mgr_ops, priv);
+	if (ret) {
+		clk_disable_unprepare(priv->clk);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int socfpga_a10_fpga_remove(struct platform_device *pdev)
-- 
2.7.4

