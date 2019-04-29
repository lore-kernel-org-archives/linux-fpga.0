Return-Path: <SRS0=3X6n=S7=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=3X6n=S7=intel.com=hao.wu@kernel.org>
From: Wu Hao <hao.wu@intel.com>
Subject: [PATCH v2 02/18] fpga: dfl: fme: remove copy_to_user() in ioctl for PR
Date: Mon, 29 Apr 2019 16:55:35 +0800
Message-Id: <1556528151-17221-3-git-send-email-hao.wu@intel.com>
In-Reply-To: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

This patch removes copy_to_user() code in partial reconfiguration
ioctl, as it's useless as user never needs to read the data
structure after ioctl.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v2: clean up code split from patch 2 in v1 patchset.
---
 drivers/fpga/dfl-fme-pr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index d9ca955..6ec0f09 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -159,9 +159,6 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 	mutex_unlock(&pdata->lock);
 free_exit:
 	vfree(buf);
-	if (copy_to_user((void __user *)arg, &port_pr, minsz))
-		return -EFAULT;
-
 	return ret;
 }
 
-- 
1.8.3.1
