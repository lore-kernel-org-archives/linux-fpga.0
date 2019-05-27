Return-Path: <SRS0=xpEw=T3=huawei.com=yuehaibing@kernel.org>
Return-Path: <SRS0=xpEw=T3=huawei.com=yuehaibing@kernel.org>
From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] fpga: dfl: afu: Remove set but not used variable 'afu'
Date: Mon, 27 May 2019 23:37:55 +0800
Message-ID: <20190527153755.7332-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
To: hao.wu@intel.com, atull@kernel.org, mdf@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-ID: <linux-fpga@vger.kernel.org>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/fpga/dfl-afu-main.c: In function afu_dev_destroy:
drivers/fpga/dfl-afu-main.c:529:18: warning: variable afu set but not used [-Wunused-but-set-variable]

It is never used since introduction in commit
857a26222ff7 ("fpga: dfl: afu: add afu sub feature support")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/fpga/dfl-afu-main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 02baa6a227c0..5e166b81d14a 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -526,10 +526,8 @@ static int afu_dev_init(struct platform_device *pdev)
 static int afu_dev_destroy(struct platform_device *pdev)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct dfl_afu *afu;
 
 	mutex_lock(&pdata->lock);
-	afu = dfl_fpga_pdata_get_private(pdata);
 	afu_mmio_region_destroy(pdata);
 	afu_dma_region_destroy(pdata);
 	dfl_fpga_pdata_set_private(pdata, NULL);
-- 
2.17.1
