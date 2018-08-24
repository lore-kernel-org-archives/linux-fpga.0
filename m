Return-Path: <SRS0=4jE6=LH=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=4jE6=LH=ettus.com=moritz.fischer@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 2/2] fpga: dfl-fme-region: Use platform_get_drvdata()
Date: Fri, 24 Aug 2018 08:25:13 -0700
Message-Id: <20180824152513.8336-2-mdf@kernel.org>
In-Reply-To: <20180824152513.8336-1-mdf@kernel.org>
References: <20180824152513.8336-1-mdf@kernel.org>
To: hao.wu@intel.com, atull@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Use platform_get_drvdata() in remove() function of
the platform driver rather than dev_get_drvdata()
to match the platform_set_drvdata in the probe().

Signed-off-by: Moritz Fischer <mdf@kernel.org>
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
