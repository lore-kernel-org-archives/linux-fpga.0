Return-Path: <SRS0=93gn=27=xilinx.com=navam@kernel.org>
Return-Path: <SRS0=93gn=27=xilinx.com=navam@kernel.org>
From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH] fpga: xilinx-pr-decoupler: Remove clk_get error message for probe defer
Date: Fri, 10 Jan 2020 12:01:13 +0530
Message-Id: <20200110063113.3064-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
To: mdf@kernel.org, michal.simek@xilinx.com, linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

In probe, the driver checks for devm_clk_get return and print error
message in the failing case. However for -EPROBE_DEFER this message
is confusing so avoid it.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/fpga/xilinx-pr-decoupler.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index af9b387c56d3..7d69af230567 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -101,7 +101,8 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 
 	priv->clk = devm_clk_get(&pdev->dev, "aclk");
 	if (IS_ERR(priv->clk)) {
-		dev_err(&pdev->dev, "input clock not found\n");
+		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "input clock not found\n");
 		return PTR_ERR(priv->clk);
 	}
 
-- 
2.18.0
