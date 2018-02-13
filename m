Return-Path: <SRS0=DkGj=FH=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=DkGj=FH=intel.com=hao.wu@kernel.org>
From: Wu Hao <hao.wu@intel.com>
Subject: [PATCH v4 19/24] fpga: dfl-fme-region: add compat_id support
Date: Tue, 13 Feb 2018 17:24:48 +0800
Message-Id: <1518513893-4719-20-git-send-email-hao.wu@intel.com>
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com, yi.z.zhang@intel.com, hao.wu@intel.com
List-ID: <linux-fpga@vger.kernel.org>

This patch adds compat_id support, configure the compat_id value
of fpga_region, then userspace could read it from the common sysfs
interface compat_id of fpga_region.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl-fme-region.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 1f5f33d..bcef98a 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -48,6 +48,7 @@ static int fme_region_probe(struct platform_device *pdev)
 	region->get_bridges = fme_region_get_bridges;
 	region->priv = pdata;
 	region->parent = dev;
+	region->compat_id = pdata->compat_id;
 	platform_set_drvdata(pdev, region);
 
 	ret = fpga_region_register(region);
-- 
2.7.4
