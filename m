Return-Path: <SRS0=LsED=WI=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=LsED=WI=intel.com=hao.wu@kernel.org>
From: Wu Hao <hao.wu@intel.com>
Subject: [PATCH v5 1/9] fpga: dfl: make init callback optional
Date: Mon, 12 Aug 2019 10:49:56 +0800
Message-Id: <1565578204-13969-2-git-send-email-hao.wu@intel.com>
In-Reply-To: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
To: gregkh@linuxfoundation.org, mdf@kernel.org, linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, atull@kernel.org, Wu Hao <hao.wu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

This patch makes init callback of sub features optional. With
this change, people don't need to prepare any empty init callback.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index c0512af..96a2b82 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -271,11 +271,13 @@ static int dfl_feature_instance_init(struct platform_device *pdev,
 				     struct dfl_feature *feature,
 				     struct dfl_feature_driver *drv)
 {
-	int ret;
+	int ret = 0;
 
-	ret = drv->ops->init(pdev, feature);
-	if (ret)
-		return ret;
+	if (drv->ops->init) {
+		ret = drv->ops->init(pdev, feature);
+		if (ret)
+			return ret;
+	}
 
 	feature->ops = drv->ops;
 
-- 
1.8.3.1
