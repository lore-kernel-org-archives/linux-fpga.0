Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 2/4] fpga: dfl: fme: remove set but not used variable 'priv'
Date: Wed,  7 Nov 2018 11:51:46 -0600
Message-Id: <1541613108-29660-3-git-send-email-atull@kernel.org>
In-Reply-To: <1541613108-29660-1-git-send-email-atull@kernel.org>
References: <1541613108-29660-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-ID: <linux-fpga@vger.kernel.org>

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/fpga/dfl-fme-pr.c: In function 'pr_mgmt_uinit':
drivers/fpga/dfl-fme-pr.c:447:18: warning:
 variable 'priv' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
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
-- 
2.7.4
