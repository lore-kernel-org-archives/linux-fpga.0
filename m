Return-Path: <SRS0=pC0s=2Q=huawei.com=yukuai3@kernel.org>
Return-Path: <SRS0=pC0s=2Q=huawei.com=yukuai3@kernel.org>
From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH] fpga: dfl: fme: remove set but not used variable 'fme'
Date: Thu, 26 Dec 2019 20:16:38 +0800
Message-ID: <20191226121638.10507-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: hao.wu@intel.com, mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawe.com, zhengbin13@huawei.com
List-ID: <linux-fpga@vger.kernel.org>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/fpga/dfl-fme-main.c: In function ‘fme_dev_destroy’:
drivers/fpga/dfl-fme-main.c:678:18: warning: variable ‘fme’ set but not
used [-Wunused-but-set-variable]

It is never used and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/fpga/dfl-fme-main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 7c930e6b314d..1d4690c99268 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -675,10 +675,8 @@ static int fme_dev_init(struct platform_device *pdev)
 static void fme_dev_destroy(struct platform_device *pdev)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct dfl_fme *fme;
 
 	mutex_lock(&pdata->lock);
-	fme = dfl_fpga_pdata_get_private(pdata);
 	dfl_fpga_pdata_set_private(pdata, NULL);
 	mutex_unlock(&pdata->lock);
 }
-- 
2.17.2
