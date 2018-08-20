Return-Path: <SRS0=86sa=LD=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=86sa=LD=ettus.com=moritz.fischer@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2] fpga: dfl: region: Restory symmetry in probe()/remove()
Date: Mon, 20 Aug 2018 10:18:18 -0700
Message-Id: <20180820171818.7710-1-mdf@kernel.org>
To: hao.wu@intel.com
Cc: atull@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Replace dev_get_drvdata() with platform_get_drvdata() to
match the platform_set_drvdata() in the probe function of
the platform driver.

Fixes commit bb61b9be3e6b ("fpga: dfl: add fpga region platform driver for FME")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Changes from v1:
- Still compile after change ...

---
 drivers/fpga/dfl-fme-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 0b7e19c27c6d..11d3c23a8936 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -65,7 +65,7 @@ static int fme_region_probe(struct platform_device *pdev)
 
 static int fme_region_remove(struct platform_device *pdev)
 {
-	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
+	struct fpga_region *region = platform_get_drvdata(pdev);
 
 	fpga_region_unregister(region);
 	fpga_mgr_put(region->mgr);
-- 
2.18.0
