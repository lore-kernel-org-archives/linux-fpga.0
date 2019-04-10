Return-Path: <SRS0=dEo/=SM=redhat.com=swood@kernel.org>
Return-Path: <SRS0=dEo/=SM=redhat.com=swood@kernel.org>
From: Scott Wood <swood@redhat.com>
Subject: [PATCH] fpga: dfl: afu: Pass the correct device to dma_mapping_error()
Date: Wed, 10 Apr 2019 16:53:27 -0500
Message-Id: <20190410215327.8024-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Wu Hao <hao.wu@intel.com>, Scott Wood <swood@redhat.com>
List-ID: <linux-fpga@vger.kernel.org>

dma_mapping_error() was being called on a different device struct than
what was passed to map/unmap.  Besides rendering the error checking
ineffective, it caused a debug splat with CONFIG_DMA_API_DEBUG.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 drivers/fpga/dfl-afu-dma-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index e18a786fc943..cd68002ac097 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -399,7 +399,7 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 				    region->pages[0], 0,
 				    region->length,
 				    DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(&pdata->dev->dev, region->iova)) {
+	if (dma_mapping_error(dfl_fpga_pdata_to_parent(pdata), region->iova)) {
 		dev_err(&pdata->dev->dev, "failed to map for dma\n");
 		ret = -EFAULT;
 		goto unpin_pages;
-- 
1.8.3.1
