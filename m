Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v6 16/18] fpga: of-fpga-region: accept overlays that don't program FPGA
Date: Wed, 15 Nov 2017 14:20:26 -0600
Message-Id: <1510777228-4291-17-git-send-email-atull@kernel.org>
In-Reply-To: <1510777228-4291-1-git-send-email-atull@kernel.org>
References: <1510777228-4291-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The FPGA may already have a static image programmed when
Linux boots.  In that case a DT overlay may be used to add
the devices that already exist.  This commit allows that
by shuffling the order of some checks.

Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v4: Patch added to patchset in v4
v5: no change to this patch in this version of patchset
v6: Add Moritz' ack
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
