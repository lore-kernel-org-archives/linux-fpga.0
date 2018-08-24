Return-Path: <SRS0=4jE6=LH=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=4jE6=LH=ettus.com=moritz.fischer@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/2] fpga: of-fpga-region: Use platform_set_drvdata
Date: Fri, 24 Aug 2018 08:25:12 -0700
Message-Id: <20180824152513.8336-1-mdf@kernel.org>
To: hao.wu@intel.com, atull@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Use platform_set_drvdata rather than dev_set_drvdata
to match the platform_get_drvdata in the _remove()
function of the platform driver.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/of-fpga-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 35fabb8083fb..8c6120e30930 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -421,7 +421,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 		goto eprobe_free;
 
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
-	dev_set_drvdata(dev, region);
+	platform_set_drvdata(pdev, region);
 
 	dev_info(dev, "FPGA Region probed\n");
 
-- 
2.18.0
