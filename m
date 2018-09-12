Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 4/5] fpga: of-fpga-region: Use platform_set_drvdata
Date: Wed, 12 Sep 2018 09:43:26 -0500
Message-Id: <20180912144327.3130-5-atull@kernel.org>
In-Reply-To: <20180912144327.3130-1-atull@kernel.org>
References: <20180912144327.3130-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

From: Moritz Fischer <mdf@kernel.org>

Use platform_set_drvdata rather than dev_set_drvdata
to match the platform_get_drvdata in the _remove()
function of the platform driver.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/of-fpga-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 052a134..d6a70e4 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -421,7 +421,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 		goto eprobe_free;
 
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
-	dev_set_drvdata(dev, region);
+	platform_set_drvdata(pdev, region);
 
 	dev_info(dev, "FPGA Region probed\n");
 
-- 
2.7.4
