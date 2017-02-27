Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 4/4] fpga: region: Add fpga-region property 'encrypted-fpga-config'
Date: Mon, 27 Feb 2017 09:19:02 -0600
Message-Id: <20170227151902.3403-5-atull@kernel.org>
In-Reply-To: <20170227151902.3403-1-atull@kernel.org>
References: <20170227151902.3403-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

From: Moritz Fischer <mdf@kernel.org>

Add fpga-region property to allow passing the fact that the bitstream is
encrypted to the fpga-region and ultimately to the low-level driver.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
 Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
 drivers/fpga/fpga-region.c                             | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index 3b32ba1..81bf3ad 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -186,6 +186,7 @@ Optional properties:
 	otherwise full reconfiguration is done.
 - external-fpga-config : boolean, set if the FPGA has already been configured
 	prior to OS boot up.
+- encrypted-fpga-config : boolean, set if the bitstream is encrypted
 - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
 	bridges to successfully become enabled after the region has been
 	programmed.
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 3222fdb..2fe2a52 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -337,8 +337,9 @@ static int child_regions_with_firmware(struct device_node *overlay)
  * The overlay must add either firmware-name or external-fpga-config property
  * to the FPGA Region.
  *
- *   firmware-name        : program the FPGA
- *   external-fpga-config : FPGA is already programmed
+ *   firmware-name         : program the FPGA
+ *   external-fpga-config  : FPGA is already programmed
+ *   encrypted-fpga-config : FPGA bitstream is encrypted
  *
  * The overlay can add other FPGA regions, but child FPGA regions cannot have a
  * firmware-name property since those regions don't exist yet.
@@ -373,6 +374,9 @@ static int fpga_region_notify_pre_apply(struct fpga_region *region,
 	if (of_property_read_bool(nd->overlay, "external-fpga-config"))
 		info->flags |= FPGA_MGR_EXTERNAL_CONFIG;
 
+	if (of_property_read_bool(nd->overlay, "encrypted-fpga-config"))
+		info->flags |= FPGA_MGR_ENCRYPTED_BITSTREAM;
+
 	of_property_read_string(nd->overlay, "firmware-name", &firmware_name);
 
 	of_property_read_u32(nd->overlay, "region-unfreeze-timeout-us",
-- 
2.7.4
