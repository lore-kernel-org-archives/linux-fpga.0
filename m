Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v2 1/8] fpga: do not access region struct after fpga_region_unregister
Date: Tue,  4 Sep 2018 16:22:30 -0500
Message-Id: <20180904212237.3078-2-atull@kernel.org>
In-Reply-To: <20180904212237.3078-1-atull@kernel.org>
References: <20180904212237.3078-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

A couple drivers were accessing the region struct after it had been
freed.  Save off the pointer to the mgr before the region struct gets
freed.

Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: no change in v2 of patchset
---
 drivers/fpga/dfl-fme-region.c | 4 +++-
 drivers/fpga/of-fpga-region.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 0b7e19c..51a5ac2 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-region.h>
 
 #include "dfl-fme-pr.h"
@@ -66,9 +67,10 @@ static int fme_region_probe(struct platform_device *pdev)
 static int fme_region_remove(struct platform_device *pdev)
 {
 	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
+	struct fpga_manager *mgr = region->mgr;
 
 	fpga_region_unregister(region);
-	fpga_mgr_put(region->mgr);
+	fpga_mgr_put(mgr);
 
 	return 0;
 }
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 35fabb8..052a134 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -437,9 +437,10 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 static int of_fpga_region_remove(struct platform_device *pdev)
 {
 	struct fpga_region *region = platform_get_drvdata(pdev);
+	struct fpga_manager *mgr = region->mgr;
 
 	fpga_region_unregister(region);
-	fpga_mgr_put(region->mgr);
+	fpga_mgr_put(mgr);
 
 	return 0;
 }
-- 
2.7.4
