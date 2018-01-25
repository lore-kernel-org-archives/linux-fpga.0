Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH] fpga: fpga-region: comment on fpga_region_program_fpga locking
Date: Thu, 25 Jan 2018 09:39:22 -0600
Message-Id: <20180125153922.3119-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Add a comment to the header of fpga_region_program_fpga()
regarding locking of the bridges.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/fpga-region.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index edab2a2..cb0603e 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -95,6 +95,11 @@ static void fpga_region_put(struct fpga_region *region)
  * fpga_region_program_fpga - program FPGA
  * @region: FPGA region
  * Program an FPGA using fpga image info (region->info).
+ * If the region has a get_bridges function, the exclusive reference for the
+ * bridges will be held if programming succeeds.  This is intended to prevent
+ * reprogramming the region until the caller considers it safe to do so.
+ * The caller will need to call fpga_bridges_put() before attempting to
+ * reprogram the region.
  * Return 0 for success or negative error code.
  */
 int fpga_region_program_fpga(struct fpga_region *region)
-- 
2.7.4
