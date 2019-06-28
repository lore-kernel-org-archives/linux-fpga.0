Return-Path: <SRS0=1/Hx=U3=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=1/Hx=U3=ettus.com=moritz.fischer@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 02/15] fpga: dfl: fme: remove copy_to_user() in ioctl for PR
Date: Thu, 27 Jun 2019 17:49:38 -0700
Message-Id: <20190628004951.6202-3-mdf@kernel.org>
In-Reply-To: <20190628004951.6202-1-mdf@kernel.org>
References: <20190628004951.6202-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

From: Wu Hao <hao.wu@intel.com>

This patch removes copy_to_user() code in partial reconfiguration
ioctl, as it's useless as user never needs to read the data
structure after ioctl.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-fme-pr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index d9ca9554844a..6ec0f09e5994 100644
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
2.22.0
