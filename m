Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v4 07/18] fpga: region: check for child regions before allocing image info
Date: Wed, 13 Sep 2017 15:48:30 -0500
Message-Id: <20170913204841.2730-8-atull@kernel.org>
In-Reply-To: <20170913204841.2730-1-atull@kernel.org>
References: <20170913204841.2730-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

During a device tree overlay pre-apply notification, the check
for child FPGA regions can happen slightly earlier.  This saves
us from allocating the FPGA image info that just gets thrown
away.

This is a baby step in refactoring the FPGA region code to
separate out common FPGA region code from FPGA region
Device Tree overlay support.

Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v2: split out from another patch
v3: s/dev/&region->dev/ in one place
    add Moritz' ack
v4: no change to this patch in this version of patchset
---
 drivers/fpga/fpga-region.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index d78f444..afac543 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -355,15 +355,19 @@ static int fpga_region_notify_pre_apply(struct fpga_region *region,
 	const char *firmware_name;
 	int ret;
 
-	info = fpga_image_info_alloc(dev);
-	if (!info)
-		return -ENOMEM;
-
-	/* Reject overlay if child FPGA Regions have firmware-name property */
+	/*
+	 * Reject overlay if child FPGA Regions added in the overlay have
+	 * firmware-name property (would mean that an FPGA region that has
+	 * not been added to the live tree yet is doing FPGA programming).
+	 */
 	ret = child_regions_with_firmware(nd->overlay);
 	if (ret)
 		return ret;
 
+	info = fpga_image_info_alloc(dev);
+	if (!info)
+		return -ENOMEM;
+
 	/* Read FPGA region properties from the overlay */
 	if (of_property_read_bool(nd->overlay, "partial-fpga-config"))
 		info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
-- 
2.7.4
