Return-Path: <SRS0=aM/a=GT=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=aM/a=GT=ettus.com=moritz.fischer@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 5/6] fpga: fpga-region: comment on fpga_region_program_fpga locking
Date: Thu, 29 Mar 2018 08:36:57 -0700
Message-Id: <20180329153658.11614-6-mdf@kernel.org>
In-Reply-To: <20180329153658.11614-1-mdf@kernel.org>
References: <20180329153658.11614-1-mdf@kernel.org>
To: gregkh@linuxfoundation.org
Cc: atull@kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

From: Alan Tull <atull@kernel.org>

Add a comment to the header of fpga_region_program_fpga()
regarding locking of the bridges.

Signed-off-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/fpga-region.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 660a91b9e246..3af960e24558 100644
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
2.16.2
