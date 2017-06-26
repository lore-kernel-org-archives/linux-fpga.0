Return-Path: <SRS0=SP6n=57=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=SP6n=57=intel.com=hao.wu@kernel.org>
From: Wu Hao <hao.wu@intel.com>
Subject: [PATCH v2 04/22] fpga: mgr: add region_id to fpga_image_info
Date: Mon, 26 Jun 2017 09:52:00 +0800
Message-Id: <1498441938-14046-5-git-send-email-hao.wu@intel.com>
In-Reply-To: <1498441938-14046-1-git-send-email-hao.wu@intel.com>
References: <1498441938-14046-1-git-send-email-hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com, yi.z.zhang@intel.com, hao.wu@intel.com
List-ID: <linux-fpga@vger.kernel.org>

This patch adds region_id to fpga_image_info data structure, it
allows driver to pass region id information to fpga-mgr via
fpga_image_info for fpga reconfiguration function.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 include/linux/fpga/fpga-mgr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 66d0e32..b222a57 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -95,6 +95,7 @@ struct fpga_image_info {
 	struct sg_table *sgt;
 	const char *buf;
 	size_t count;
+	int region_id;
 #ifdef CONFIG_OF
 	struct device_node *overlay;
 #endif
-- 
1.8.3.1
