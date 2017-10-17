Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v5 16/18] fpga: of-fpga-region: accept overlays that don't program FPGA
Date: Tue, 17 Oct 2017 16:20:29 -0500
Message-Id: <20171017212031.3770-17-atull@kernel.org>
In-Reply-To: <20171017212031.3770-1-atull@kernel.org>
References: <20171017212031.3770-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The FPGA may already have a static image programmed when
Linux boots.  In that case a DT overlay may be used to add
the devices that already exist.  This commit allows that
by shuffling the order of some checks.

Signed-off-by: Alan Tull <atull@kernel.org>
---
v4: Patch added to patchset in v4
v5: no change to this patch in this version of patchset
---
 drivers/fpga/of-fpga-region.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 1533506..c6b2119 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -298,18 +298,19 @@ static int of_fpga_region_notify_pre_apply(struct fpga_region *region,
 	struct fpga_image_info *info;
 	int ret;
 
-	if (region->info) {
-		dev_err(dev, "Region already has overlay applied.\n");
-		return -EINVAL;
-	}
-
 	info = of_fpga_region_parse_ov(region, nd->overlay);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
+	/* If overlay doesn't program the FPGA, accept it anyway. */
 	if (!info)
 		return 0;
 
+	if (region->info) {
+		dev_err(dev, "Region already has overlay applied.\n");
+		return -EINVAL;
+	}
+
 	region->info = info;
 	ret = fpga_region_program_fpga(region);
 	if (ret) {
-- 
2.7.4
