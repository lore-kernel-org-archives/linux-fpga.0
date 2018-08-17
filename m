Return-Path: <SRS0=pwAd=LA=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=pwAd=LA=ettus.com=moritz.fischer@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] fpga: dfl: region: Restory symmetry in probe()/remove()
Date: Fri, 17 Aug 2018 16:40:49 -0700
Message-Id: <20180817234049.9624-1-mdf@kernel.org>
To: hao.wu@intel.com
Cc: atull@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Replace dev_get_drvdata() with platform_get_drvdata() to
match the platform_set_drvdata() in the probe function of
the platform driver.

Fixes commit bb61b9be3e6b ("fpga: dfl: add fpga region platform driver for
FME")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-fme-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 0b7e19c27c6d..ce7ebe4b3212 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -65,7 +65,7 @@ static int fme_region_probe(struct platform_device *pdev)
 
 static int fme_region_remove(struct platform_device *pdev)
 {
-	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
+	struct fpga_region *region = platform_get_drvdata(&pdev->dev);
 
 	fpga_region_unregister(region);
 	fpga_mgr_put(region->mgr);
-- 
2.18.0
