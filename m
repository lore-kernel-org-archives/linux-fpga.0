Return-Path: <SRS0=Lyri=L4=huawei.com=yuehaibing@kernel.org>
Return-Path: <SRS0=Lyri=L4=huawei.com=yuehaibing@kernel.org>
From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] fpga: dfl: fme: remove set but not used variable 'priv'
Date: Fri, 14 Sep 2018 01:33:36 +0000
Message-ID: <1536888816-51700-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
To: Wu Hao <hao.wu@intel.com>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: YueHaibing <yuehaibing@huawei.com>, linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/fpga/dfl-fme-pr.c: In function 'pr_mgmt_uinit':
drivers/fpga/dfl-fme-pr.c:447:18: warning:
 variable 'priv' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/fpga/dfl-fme-pr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index 0b84053..fe5a557 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -444,10 +444,8 @@ static void pr_mgmt_uinit(struct platform_device *pdev,
 			  struct dfl_feature *feature)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct dfl_fme *priv;
 
 	mutex_lock(&pdata->lock);
-	priv = dfl_fpga_pdata_get_private(pdata);
 
 	dfl_fme_destroy_regions(pdata);
 	dfl_fme_destroy_bridges(pdata);
