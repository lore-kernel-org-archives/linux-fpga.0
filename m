Return-Path: <SRS0=aM/a=GT=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=aM/a=GT=ettus.com=moritz.fischer@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/6] fpga: region: don't use drvdata in common fpga code
Date: Thu, 29 Mar 2018 08:36:53 -0700
Message-Id: <20180329153658.11614-2-mdf@kernel.org>
In-Reply-To: <20180329153658.11614-1-mdf@kernel.org>
References: <20180329153658.11614-1-mdf@kernel.org>
To: gregkh@linuxfoundation.org
Cc: atull@kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

From: Alan Tull <atull@kernel.org>

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
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/fpga-region.c    | 1 -
 drivers/fpga/of-fpga-region.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index edab2a2e03ef..ebe1f872810d 100644
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
index 119ff75522f1..35e7e8c4a0cb 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -438,6 +438,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 		goto eprobe_mgr_put;
 
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
+	dev_set_drvdata(dev, region);
 
 	dev_info(dev, "FPGA Region probed\n");
 
-- 
2.16.2
