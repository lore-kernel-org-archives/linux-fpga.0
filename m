Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v6 08/18] fpga: region: fix slow warning with more than one overlay
Date: Wed, 15 Nov 2017 14:20:18 -0600
Message-Id: <1510777228-4291-9-git-send-email-atull@kernel.org>
In-Reply-To: <1510777228-4291-1-git-send-email-atull@kernel.org>
References: <1510777228-4291-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

When DT overlays are applied, each FPGA region keeps track of the fpga
image info as region->info.  This pointer is assigned only if an
overlay causes the FPGA to be programmed.  As it stands, this pointer
can be overwritten, causing a slow warning later when overlays are
removed.

This patch fixes this by changing the allowed behaviour.  If a region
has received an overlay that programmed the FPGA, reject other
overlays that try to program the FPGA.  To reprogram the FPGA, first
remove the overlay.  This makes sense as removing the overlay also
removes the devices cleanly.  Note that overlays that make DT changes
without reprogramming the FPGA are exempt from this restriction.

Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v2: split out from another patch
v3: better explanation in header
v4: no change to this patch in this version of patchset
v5: no change to this patch in this version of patchset
v6: Add Moritz' ack
---
 drivers/fpga/fpga-region.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index afac543..35af952 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -355,6 +355,11 @@ static int fpga_region_notify_pre_apply(struct fpga_region *region,
 	const char *firmware_name;
 	int ret;
 
+	if (region->info) {
+		dev_err(dev, "Region already has overlay applied.\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Reject overlay if child FPGA Regions added in the overlay have
 	 * firmware-name property (would mean that an FPGA region that has
-- 
2.7.4
