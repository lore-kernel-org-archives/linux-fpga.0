Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [RFC 2/2] fpga: of region: add of-fpga-region to whitelist
Date: Mon, 27 Nov 2017 14:58:04 -0600
Message-Id: <1511816284-12145-3-git-send-email-atull@kernel.org>
In-Reply-To: <1511816284-12145-1-git-send-email-atull@kernel.org>
References: <1511816284-12145-1-git-send-email-atull@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

During each FPGA region's probe, add to whitelist.  Remove
during driver remove.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/of-fpga-region.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 7dfaa95..abb57a9 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -435,6 +435,10 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 	/* Specify how to get bridges for this type of region. */
 	region->get_bridges = of_fpga_region_get_bridges;
 
+	ret = of_add_whitelist_node(np);
+	if (ret)
+		goto eprobe_wl_err;
+
 	ret = fpga_region_register(region);
 	if (ret)
 		goto eprobe_mgr_put;
@@ -447,6 +451,8 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 	return 0;
 
 eprobe_mgr_put:
+	of_remove_whitelist_node(np);
+eprobe_wl_err:
 	fpga_mgr_put(mgr);
 	return ret;
 }
@@ -454,7 +460,10 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 static int of_fpga_region_remove(struct platform_device *pdev)
 {
 	struct fpga_region *region = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 
+	of_remove_whitelist_node(np);
 	fpga_region_unregister(region);
 	fpga_mgr_put(region->mgr);
 
-- 
2.7.4
