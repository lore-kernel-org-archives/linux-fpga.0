Return-Path: <SRS0=K4gU=B2=mev.co.uk=abbotti@kernel.org>
Return-Path: <SRS0=K4gU=B2=mev.co.uk=abbotti@kernel.org>
From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH] fpga: region: release of_parse_phandle nodes after use
Date: Fri, 27 Oct 2017 17:56:54 +0100
Message-Id: <20171027165654.12663-1-abbotti@mev.co.uk>
To: linux-fpga@vger.kernel.org
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>, stable@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Both fpga_region_get_manager() and fpga_region_get_bridges() call
of_parse_phandle(), but nothing calls of_node_put() on the returned
struct device_node pointers.  Make sure to do that to stop their
reference counters getting out of whack.

Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/fpga/fpga-region.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index d9ab7c75b14f..e0c73ceba2ed 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -147,6 +147,7 @@ static struct fpga_manager *fpga_region_get_manager(struct fpga_region *region)
 			mgr_node = of_parse_phandle(np, "fpga-mgr", 0);
 			if (mgr_node) {
 				mgr = of_fpga_mgr_get(mgr_node);
+				of_node_put(mgr_node);
 				of_node_put(np);
 				return mgr;
 			}
@@ -192,10 +193,13 @@ static int fpga_region_get_bridges(struct fpga_region *region,
 		parent_br = region_np->parent;
 
 	/* If overlay has a list of bridges, use it. */
-	if (of_parse_phandle(overlay, "fpga-bridges", 0))
+	br = of_parse_phandle(overlay, "fpga-bridges", 0);
+	if (br) {
+		of_node_put(br);
 		np = overlay;
-	else
+	} else {
 		np = region_np;
+	}
 
 	for (i = 0; ; i++) {
 		br = of_parse_phandle(np, "fpga-bridges", i);
@@ -203,12 +207,15 @@ static int fpga_region_get_bridges(struct fpga_region *region,
 			break;
 
 		/* If parent bridge is in list, skip it. */
-		if (br == parent_br)
+		if (br == parent_br) {
+			of_node_put(br);
 			continue;
+		}
 
 		/* If node is a bridge, get it and add to list */
 		ret = fpga_bridge_get_to_list(br, region->info,
 					      &region->bridge_list);
+		of_node_put(br);
 
 		/* If any of the bridges are in use, give up */
 		if (ret == -EBUSY) {
-- 
2.14.2
