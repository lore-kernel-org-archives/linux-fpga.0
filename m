Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 1/3] fpga: region: don't use drvdata in common fpga code
Date: Tue, 31 Oct 2017 15:42:13 -0500
Message-Id: <1509482535-4921-2-git-send-email-atull@kernel.org>
In-Reply-To: <1509482535-4921-1-git-send-email-atull@kernel.org>
References: <1509482535-4921-1-git-send-email-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Part of patchset that changes the following fpga_*_register
functions to not set drvdata:
* fpga_region_register.
* fpga_mgr_register
* fpga_bridge_register

The rationale is that setting drvdata is fine for DT based devices
that will have one manager, bridge, or region per platform device.
However PCIe based devices may have multiple FPGA mgr/bridge/regions
under one PCIe device.  Without these changes, the PCIe solution has
to create an extra device for each child mgr/bridge/region to hold
drvdata.

Signed-off-by: Alan Tull <atull@kernel.org>
Reported-by: Jiuyue Ma <majiuyue@huawei.com>
---
 drivers/fpga/fpga-region.c    | 1 -
 drivers/fpga/of-fpga-region.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index edab2a2..ebe1f87 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -178,7 +178,6 @@ int fpga_region_register(struct device *dev, struct fpga_region *region)
 	region->dev.parent = dev;
 	region->dev.of_node = dev->of_node;
 	region->dev.id = id;
-	dev_set_drvdata(dev, region);
 
 	ret = dev_set_name(&region->dev, "region%d", id);
 	if (ret)
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index c6b2119..3079ed8 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -431,6 +431,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 		goto eprobe_mgr_put;
 
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
+	dev_set_drvdata(dev, region);
 
 	dev_info(dev, "FPGA Region probed\n");
 
-- 
2.7.4
