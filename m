Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 3/3] fpga: region: release of_parse_phandle nodes after use
Date: Wed, 15 Nov 2017 16:33:12 -0600
Message-Id: <1510785192-10123-4-git-send-email-atull@kernel.org>
In-Reply-To: <1510785192-10123-1-git-send-email-atull@kernel.org>
References: <1510785192-10123-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>, "# 4 . 10+" <stable@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

From: Ian Abbott <abbotti@mev.co.uk>

Both fpga_region_get_manager() and fpga_region_get_bridges() call
of_parse_phandle(), but nothing calls of_node_put() on the returned
struct device_node pointers.  Make sure to do that to stop their
reference counters getting out of whack.

Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/of-fpga-region.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index a0c13cb..7dfaa95 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -73,6 +73,7 @@ static struct fpga_manager *of_fpga_region_get_mgr(struct device_node *np)
 			mgr_node = of_parse_phandle(np, "fpga-mgr", 0);
 			if (mgr_node) {
 				mgr = of_fpga_mgr_get(mgr_node);
+				of_node_put(mgr_node);
 				of_node_put(np);
 				return mgr;
 			}
@@ -120,10 +121,13 @@ static int of_fpga_region_get_bridges(struct fpga_region *region)
 		parent_br = region_np->parent;
 
 	/* If overlay has a list of bridges, use it. */
-	if (of_parse_phandle(info->overlay, "fpga-bridges", 0))
+	br = of_parse_phandle(info->overlay, "fpga-bridges", 0);
+	if (br) {
+		of_node_put(br);
 		np = info->overlay;
-	else
+	} else {
 		np = region_np;
+	}
 
 	for (i = 0; ; i++) {
 		br = of_parse_phandle(np, "fpga-bridges", i);
@@ -131,12 +135,15 @@ static int of_fpga_region_get_bridges(struct fpga_region *region)
 			break;
 
 		/* If parent bridge is in list, skip it. */
-		if (br == parent_br)
+		if (br == parent_br) {
+			of_node_put(br);
 			continue;
+		}
 
 		/* If node is a bridge, get it and add to list */
 		ret = of_fpga_bridge_get_to_list(br, info,
 						 &region->bridge_list);
+		of_node_put(br);
 
 		/* If any of the bridges are in use, give up */
 		if (ret == -EBUSY) {
-- 
2.7.4
