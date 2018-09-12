Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 5/5] fpga: dfl-fme-region: Use platform_get_drvdata()
Date: Wed, 12 Sep 2018 09:43:27 -0500
Message-Id: <20180912144327.3130-6-atull@kernel.org>
In-Reply-To: <20180912144327.3130-1-atull@kernel.org>
References: <20180912144327.3130-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

From: Moritz Fischer <mdf@kernel.org>

Use platform_get_drvdata() in remove() function of
the platform driver rather than dev_get_drvdata()
to match the platform_set_drvdata in the probe().

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/dfl-fme-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 51a5ac2..3fa0de2 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -66,7 +66,7 @@ static int fme_region_probe(struct platform_device *pdev)
 
 static int fme_region_remove(struct platform_device *pdev)
 {
-	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
+	struct fpga_region *region = platform_get_drvdata(pdev);
 	struct fpga_manager *mgr = region->mgr;
 
 	fpga_region_unregister(region);
-- 
2.7.4
