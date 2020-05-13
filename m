Return-Path: <SRS0=Pe3T=63=gmail.com=jrdr.linux@kernel.org>
Return-Path: <SRS0=Pe3T=63=gmail.com=jrdr.linux@kernel.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] fpga: dfl: afu: Corrected error handling levels
Date: Thu, 14 May 2020 00:52:05 +0530
Message-Id: <1589397725-29697-1-git-send-email-jrdr.linux@gmail.com>
To: hao.wu@intel.com, mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Souptick Joarder <jrdr.linux@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

Corrected error handling goto sequnece. Level put_pages should
be called when pinned pages >= 0 && pinned != npages. Level
free_pages should be called when pinned pages < 0.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/fpga/dfl-afu-dma-region.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 62f9244..5942343 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -61,10 +61,10 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
 				     region->pages);
 	if (pinned < 0) {
 		ret = pinned;
-		goto put_pages;
+		goto free_pages;
 	} else if (pinned != npages) {
 		ret = -EFAULT;
-		goto free_pages;
+		goto put_pages;
 	}
 
 	dev_dbg(dev, "%d pages pinned\n", pinned);
-- 
1.9.1
