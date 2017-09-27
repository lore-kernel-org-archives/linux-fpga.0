Return-Path: <SRS0=04DK=A4=gmail.com=uvv.mail@kernel.org>
Return-Path: <SRS0=04DK=A4=gmail.com=uvv.mail@kernel.org>
From: "Vyacheslav V. Yurkov" <uvv.mail@gmail.com>
Subject: [PATCH 1/1] fpga: region: release bridges in successful path
Date: Wed, 27 Sep 2017 18:43:00 +0200
Message-Id: <20170927164300.3487-1-uvv.mail@gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Vyacheslav Yurkov <uvv.mail@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Vyacheslav Yurkov <uvv.mail@gmail.com>

In case of successful FPGA reconfiguration bridges mutexes are not
unlocked properly.

Signed-off-by: Vyacheslav Yurkov <uvv.mail@gmail.com>
---
 drivers/fpga/fpga-region.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index d9ab7c7..ed858e3 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -274,6 +274,7 @@ static int fpga_region_program_fpga(struct fpga_region *region,
 	}
 
 	fpga_mgr_put(mgr);
+	fpga_bridges_put(&region->bridge_list);
 	fpga_region_put(region);
 
 	return 0;
-- 
2.7.4
