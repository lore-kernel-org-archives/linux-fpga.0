Return-Path: <SRS0=Tyjd=FP=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Tyjd=FP=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-cys01nam02on0059.outbound.protection.outlook.com ([104.47.37.59]:35840
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751168AbeBUErV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Feb 2018 23:47:21 -0500
From: <shubhrajyoti.datta@gmail.com>
Subject: [PATCH 2/2] fpga: reset bridge: Add the reset bridge
Date: Wed, 21 Feb 2018 10:23:46 +0530
Message-ID: <1519188826-2047-2-git-send-email-shubhrajyoti.datta@gmail.com>
In-Reply-To: <1519188826-2047-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1519188826-2047-1-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org
Cc: atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org, michal.simek@xilinx.com, devicetree@vger.kernel.org, shubhrajyoti.datta@gmail.com, nofooter@xilinx.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Adds the reset bridge. After the bitstream load the reset
bridge helps in reseting the programable logic. The 
reset lines depends on the design. 

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/fpga/Kconfig             |   8 ++++
 drivers/fpga/Makefile            |   1 +
 drivers/fpga/xilinx-rst-bridge.c | 100 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 drivers/fpga/xilinx-rst-bridge.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index ad5448f..752a907 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -117,4 +117,12 @@ config XILINX_PR_DECOUPLER
 	  region of the FPGA from the busses while that region is
 	  being reprogrammed during partial reconfig.
 
+config XILINX_RST_BRIDGE
+	tristate "Xilinx Reset bridge"
+	depends on FPGA_BRIDGE
+	help
+	  Say Y to enable drivers for Xilinx Reset bridge.
+	  After writing the bitstream there has to be a reset.
+	  The reset lines are design specific.
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index f98dcf1..c1b0d13 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
 obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
 obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+= altera-freeze-bridge.o
 obj-$(CONFIG_XILINX_PR_DECOUPLER)	+= xilinx-pr-decoupler.o
+obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= xilinx-rst-bridge.o
 
 # High Level Interfaces
 obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
diff --git a/drivers/fpga/xilinx-rst-bridge.c b/drivers/fpga/xilinx-rst-bridge.c
new file mode 100644
index 0000000..8062283
--- /dev/null
+++ b/drivers/fpga/xilinx-rst-bridge.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx FPGA reset bridge.
+ * Copyright (c) 2018 Xilinx Inc.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/fpga/fpga-bridge.h>
+#include <linux/reset.h>
+
+struct xlnx_rst_bridge_priv {
+	struct device *dev;
+	bool enable;
+};
+
+static int xlnx_rst_bridge_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct xlnx_rst_bridge_priv *priv = bridge->priv;
+	struct device *dev = priv->dev;
+	struct reset_control *rstc;
+	int ret = 0;
+
+	if (enable) {
+		rstc = of_reset_control_array_get(dev->of_node, false, false);
+		if (IS_ERR(rstc))
+			return PTR_ERR(rstc);
+
+		ret = reset_control_reset(rstc);
+
+		reset_control_put(rstc);
+
+		if (ret)
+			dev_err(dev, "Reset failed\n");
+	} else {
+		dev_dbg(dev, "Bridge disabled\n");
+	}
+
+	if (!ret)
+		priv->enable = enable;
+
+	return ret;
+}
+
+static int xlnx_rst_bridge_enable_show(struct fpga_bridge *bridge)
+{
+	struct xlnx_rst_bridge_priv *priv = bridge->priv;
+
+	return priv->enable;
+}
+
+static struct fpga_bridge_ops xlnx_rst_bridge_ops = {
+	.enable_set = xlnx_rst_bridge_enable_set,
+	.enable_show = xlnx_rst_bridge_enable_show,
+};
+
+static int xlnx_rst_bridge_probe(struct platform_device *pdev)
+{
+	struct xlnx_rst_bridge_priv *priv;
+	struct device *dev = &pdev->dev;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	return fpga_bridge_register(dev, "xlnx_rst_bridge",
+				    &xlnx_rst_bridge_ops, priv);
+}
+
+static int xlnx_rst_bridge_remove(struct platform_device *pdev)
+{
+	fpga_bridge_unregister(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id xlnx_rst_bridge_of_match[] = {
+	{ .compatible = "xlnx,rst-bridge", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xlnx_rst_bridge_of_match);
+
+static struct platform_driver xlnx_rst_bridge_driver = {
+	.probe = xlnx_rst_bridge_probe,
+	.remove = xlnx_rst_bridge_remove,
+	.driver = {
+		.name	= "xlnx_rst_bridge",
+		.of_match_table = of_match_ptr(xlnx_rst_bridge_of_match),
+	},
+};
+
+module_platform_driver(xlnx_rst_bridge_driver);
+
+MODULE_DESCRIPTION("Xilinx reset Bridge");
+MODULE_AUTHOR("Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.1.1

