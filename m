Return-Path: <SRS0=ps2+=FO=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=ps2+=FO=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-bn3nam01on0078.outbound.protection.outlook.com ([104.47.33.78]:16512
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750858AbeBTIdi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Feb 2018 03:33:38 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/2] fpga: reset bridge: Add the reset bridge
Date: Tue, 20 Feb 2018 14:10:03 +0530
Message-ID: <1519116003-6967-2-git-send-email-shubhrajyoti.datta@xilinx.com>
In-Reply-To: <1519116003-6967-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1519116003-6967-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org
Cc: atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org, michal.simek@xilinx.com, devicetree@vger.kernel.org, shubhrajyoti.datta@gmail.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Adds the reset bridge. After the bitstream load the reset
bridge helps in reseting the programable logic. The
reset lines depends on the design.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/fpga/Kconfig             |   8 ++++
 drivers/fpga/Makefile            |   1 +
 drivers/fpga/xilinx-rst-bridge.c | 100 +++++++++++++++++++++++++++++++++++=
++++
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
+       tristate "Xilinx Reset bridge"
+       depends on FPGA_BRIDGE
+       help
+         Say Y to enable drivers for Xilinx Reset bridge.
+         After writing the bitstream there has to be a reset.
+         The reset lines are design specific.
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index f98dcf1..c1b0d13 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_FPGA_BRIDGE)             +=3D fpga-bridge.o
 obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)      +=3D altera-hps2fpga.o altera-fpga2=
sdram.o
 obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)     +=3D altera-freeze-bridge.o
 obj-$(CONFIG_XILINX_PR_DECOUPLER)      +=3D xilinx-pr-decoupler.o
+obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)     +=3D xilinx-rst-bridge.o

 # High Level Interfaces
 obj-$(CONFIG_FPGA_REGION)              +=3D fpga-region.o
diff --git a/drivers/fpga/xilinx-rst-bridge.c b/drivers/fpga/xilinx-rst-bri=
dge.c
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
+       struct device *dev;
+       bool enable;
+};
+
+static int xlnx_rst_bridge_enable_set(struct fpga_bridge *bridge, bool ena=
ble)
+{
+       struct xlnx_rst_bridge_priv *priv =3D bridge->priv;
+       struct device *dev =3D priv->dev;
+       struct reset_control *rstc;
+       int ret =3D 0;
+
+       if (enable) {
+               rstc =3D of_reset_control_array_get(dev->of_node, false, fa=
lse);
+               if (IS_ERR(rstc))
+                       return PTR_ERR(rstc);
+
+               ret =3D reset_control_reset(rstc);
+
+               reset_control_put(rstc);
+
+               if (ret)
+                       dev_err(dev, "Reset failed\n");
+       } else {
+               dev_dbg(dev, "Bridge disabled\n");
+       }
+
+       if (!ret)
+               priv->enable =3D enable;
+
+       return ret;
+}
+
+static int xlnx_rst_bridge_enable_show(struct fpga_bridge *bridge)
+{
+       struct xlnx_rst_bridge_priv *priv =3D bridge->priv;
+
+       return priv->enable;
+}
+
+static struct fpga_bridge_ops xlnx_rst_bridge_ops =3D {
+       .enable_set =3D xlnx_rst_bridge_enable_set,
+       .enable_show =3D xlnx_rst_bridge_enable_show,
+};
+
+static int xlnx_rst_bridge_probe(struct platform_device *pdev)
+{
+       struct xlnx_rst_bridge_priv *priv;
+       struct device *dev =3D &pdev->dev;
+
+       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+       if (!priv)
+               return -ENOMEM;
+
+       priv->dev =3D dev;
+
+       return fpga_bridge_register(dev, "xlnx_rst_bridge",
+                                   &xlnx_rst_bridge_ops, priv);
+}
+
+static int xlnx_rst_bridge_remove(struct platform_device *pdev)
+{
+       fpga_bridge_unregister(&pdev->dev);
+
+       return 0;
+}
+
+static const struct of_device_id xlnx_rst_bridge_of_match[] =3D {
+       { .compatible =3D "xlnx,rst-bridge", },
+       {},
+};
+MODULE_DEVICE_TABLE(of, xlnx_rst_bridge_of_match);
+
+static struct platform_driver xlnx_rst_bridge_driver =3D {
+       .probe =3D xlnx_rst_bridge_probe,
+       .remove =3D xlnx_rst_bridge_remove,
+       .driver =3D {
+               .name   =3D "xlnx_rst_bridge",
+               .of_match_table =3D of_match_ptr(xlnx_rst_bridge_of_match),
+       },
+};
+
+module_platform_driver(xlnx_rst_bridge_driver);
+
+MODULE_DESCRIPTION("Xilinx reset Bridge");
+MODULE_AUTHOR("Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>");
+MODULE_LICENSE("GPL v2");
--
2.1.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
