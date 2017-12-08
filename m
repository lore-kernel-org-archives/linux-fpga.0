Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH] fpga: socfpga-a10: disable clk on error in socfpga_a10_fpga_probe()
Date: Fri,  8 Dec 2017 11:37:00 -0600
Message-Id: <1512754620-3723-2-git-send-email-atull@kernel.org>
In-Reply-To: <1512754620-3723-1-git-send-email-atull@kernel.org>
References: <1512754620-3723-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>
List-ID: <linux-fpga@vger.kernel.org>

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

If fpga_mgr_register() fails, a clock is left undisabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/socfpga-a10.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index f8770af..a46e343 100644
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
