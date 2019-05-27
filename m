Return-Path: <SRS0=xpEw=T3=huawei.com=yuehaibing@kernel.org>
Return-Path: <SRS0=xpEw=T3=huawei.com=yuehaibing@kernel.org>
From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] fpga: dfl: fme: Remove set but not used variable 'fme'
Date: Mon, 27 May 2019 23:34:24 +0800
Message-ID: <20190527153424.10268-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
To: hao.wu@intel.com, atull@kernel.org, mdf@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-ID: <linux-fpga@vger.kernel.org>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/fpga/dfl-fme-main.c: In function fme_dev_destroy:
drivers/fpga/dfl-fme-main.c:216:18: warning: variable fme set but not used [-Wunused-but-set-variable]

It's never used since introduction in commit 29de76240e86 ("fpga:
dfl: fme: add partial reconfiguration sub feature support")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/fpga/dfl-fme-main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 086ad2420ade..cb7c4e258298 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -213,10 +213,8 @@ static int fme_dev_init(struct platform_device *pdev)
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
2.17.1
