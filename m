Return-Path: <SRS0=hO1J=4C=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=hO1J=4C=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv1 3/7] fpga: stratix10-soc: add compatible property value for intel agilex
Date: Fri, 14 Feb 2020 10:00:48 -0600
Message-Id: <1581696052-11540-4-git-send-email-richard.gong@linux.intel.com>
In-Reply-To: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
To: gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

Add compatible property value so we can reuse FPGA manager driver on
Intel Agilex SoC platform.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 drivers/fpga/stratix10-soc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 215d337..bac93d0 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -482,7 +482,8 @@ static int s10_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id s10_of_match[] = {
-	{ .compatible = "intel,stratix10-soc-fpga-mgr", },
+	{.compatible = "intel,stratix10-soc-fpga-mgr"},
+	{.compatible = "intel,agilex-soc-fpga-mgr"},
 	{},
 };
 
-- 
2.7.4
