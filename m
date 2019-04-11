Return-Path: <SRS0=y/MW=SN=rockwellcollins.com=brandon.maier@kernel.org>
Return-Path: <SRS0=y/MW=SN=rockwellcollins.com=brandon.maier@kernel.org>
From: Brandon Maier <brandon.maier@rockwellcollins.com>
Subject: [PATCH] fpga: mgr: Use devicetree /alias to assign FPGA IDs
Date: Thu, 11 Apr 2019 17:11:09 -0500
Message-Id: <20190411221109.173242-1-brandon.maier@rockwellcollins.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: atull@kernel.org, mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, clayton.shotwell@rockwellcollins.com, Brandon Maier <brandon.maier@rockwellcollins.com>
List-ID: <linux-fpga@vger.kernel.org>

The fpga-mgr assigns device IDs based on the order each driver calls
fpga_mgr_register(). This is fine for systems with one FPGA, but if
multiple FPGAs are in use, the device ID can change as probe order
changes across reboots or configuration changes.

This makes it difficult to use the sysfs attributes, as the device path
may change. Instead allow a static ID to be set by adding fpgaX props
to the devicetree /aliases. Falling back to incrementing IDs if none are
provided.

This is based on the function rtc_device_get_id() in drivers/rtc/class.c
(9d2b7e532da8 rtc: honor device tree /alias entries when assigning IDs).

Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>
---
 drivers/fpga/fpga-mgr.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index c3866816456a..d8b7e7a61117 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -551,6 +551,26 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
 
+static int fpga_mgr_get_id(struct device *dev)
+{
+	int of_id = -1, id = -1;
+
+	if (dev->of_node)
+		of_id = of_alias_get_id(dev->of_node, "fpga");
+
+	if (of_id >= 0) {
+		id = ida_simple_get(&fpga_mgr_ida, of_id, of_id + 1,
+				    GFP_KERNEL);
+		if (id < 0)
+			dev_warn(dev, "/aliases ID %d not available\n", of_id);
+	}
+
+	if (id < 0)
+		id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
+
+	return id;
+}
+
 /**
  * fpga_mgr_create - create and initialize a FPGA manager struct
  * @dev:	fpga manager device from pdev
@@ -586,7 +606,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	if (!mgr)
 		return NULL;
 
-	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
+	id = fpga_mgr_get_id(dev);
 	if (id < 0) {
 		ret = id;
 		goto error_kfree;
-- 
2.20.1
