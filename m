Return-Path: <SRS0=pC0s=2Q=huawei.com=yukuai3@kernel.org>
Return-Path: <SRS0=pC0s=2Q=huawei.com=yukuai3@kernel.org>
From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH] fpga: dfl: afu: remove set but not used variable 'afu'
Date: Thu, 26 Dec 2019 20:15:33 +0800
Message-ID: <20191226121533.6017-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: hao.wu@intel.com, mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawe.com, zhengbin13@huawei.com
List-ID: <linux-fpga@vger.kernel.org>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/fpga/dfl-afu-main.c: In function ‘afu_dev_destroy’:
drivers/fpga/dfl-afu-main.c:816:18: warning: variable ‘afu’
set but not used [-Wunused-but-set-variable]

It is never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/fpga/dfl-afu-main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index e4a34dc7947f..65437b6a6842 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -813,10 +813,8 @@ static int afu_dev_init(struct platform_device *pdev)
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
2.17.2
