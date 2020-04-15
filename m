Return-Path: <SRS0=KCYC=57=xilinx.com=navam@kernel.org>
Return-Path: <SRS0=KCYC=57=xilinx.com=navam@kernel.org>
From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 2/2] fpga: zynq: Add AFI config driver
Date: Wed, 15 Apr 2020 15:54:50 +0530
Message-Id: <1586946290-7280-2-git-send-email-nava.manne@xilinx.com>
In-Reply-To: <1586946290-7280-1-git-send-email-nava.manne@xilinx.com>
References: <1586946290-7280-1-git-send-email-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
To: mdf@kernel.org, michal.simek@xilinx.com, linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chinnikishore369@gmail.com
Cc: Nava kishore Manne <nava.manne@xilinx.com>
List-ID: <linux-fpga@vger.kernel.org>

This patch Adds AFI config driver. This is useful for
the PS to PL configuration for the fpga manager On zynq
platform.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/Kconfig    |  8 +++++
 drivers/fpga/Makefile   |  1 +
 drivers/fpga/zynq-afi.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 drivers/fpga/zynq-afi.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 474f304e..60982a0 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -214,4 +214,12 @@ config FPGA_MGR_ZYNQMP_FPGA
 	  to configure the programmable logic(PL) through PS
 	  on ZynqMP SoC.
 
+config FPGA_MGR_ZYNQ_AFI_FPGA
+	bool "Xilinx AFI FPGA"
+	depends on FPGA_MGR_ZYNQ_FPGA
+	help
+	  Zynq AFI driver support for writing to the AFI registers
+	  for configuring the PS_PL interface. For some of the bitstream
+	  or designs to work the PS to PL interfaces need to be configured
+	  like the data bus-width etc.
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 312b937..d115e29 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
 obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
 obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+= altera-freeze-bridge.o
 obj-$(CONFIG_XILINX_PR_DECOUPLER)	+= xilinx-pr-decoupler.o
+obj-$(CONFIG_FPGA_MGR_ZYNQ_AFI_FPGA)	+= zynq-afi.o
 
 # High Level Interfaces
 obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
diff --git a/drivers/fpga/zynq-afi.c b/drivers/fpga/zynq-afi.c
new file mode 100644
index 0000000..7ce0d08
--- /dev/null
+++ b/drivers/fpga/zynq-afi.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx FPGA AFI driver.
+ * Copyright (c) 2018 Xilinx Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+/* Registers and special values for doing register-based operations */
+#define AFI_RDCHAN_CTRL_OFFSET	0x00
+#define AFI_WRCHAN_CTRL_OFFSET	0x14
+
+#define AFI_BUSWIDTH_MASK	0x01
+
+/**
+ * struct afi_fpga - AFI register description
+ * @membase:	pointer to register struct
+ * @afi_width:	AFI bus width to be written
+ */
+struct zynq_afi_fpga {
+	void __iomem	*membase;
+	u32		afi_width;
+};
+
+static int zynq_afi_fpga_probe(struct platform_device *pdev)
+{
+	struct zynq_afi_fpga *afi_fpga;
+	struct resource *res;
+	u32 reg_val;
+	u32 val;
+
+	afi_fpga = devm_kzalloc(&pdev->dev, sizeof(*afi_fpga), GFP_KERNEL);
+	if (!afi_fpga)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	afi_fpga->membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(afi_fpga->membase))
+		return PTR_ERR(afi_fpga->membase);
+
+	val = device_property_read_u32(&pdev->dev, "xlnx,afi-width",
+				       &afi_fpga->afi_width);
+	if (val) {
+		dev_err(&pdev->dev, "Fail to get the afi bus width\n");
+		return -EINVAL;
+	}
+
+	reg_val = readl(afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
+	reg_val &= ~AFI_BUSWIDTH_MASK;
+	writel(reg_val | afi_fpga->afi_width,
+	       afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
+	reg_val = readl(afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
+	reg_val &= ~AFI_BUSWIDTH_MASK;
+	writel(reg_val | afi_fpga->afi_width,
+	       afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
+
+	return 0;
+}
+
+static const struct of_device_id zynq_afi_fpga_ids[] = {
+	{ .compatible = "xlnx,zynq-afi-fpga" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, zynq_afi_fpga_ids);
+
+static struct platform_driver zynq_afi_fpga_driver = {
+	.driver = {
+		.name = "zynq-afi-fpga",
+		.of_match_table = zynq_afi_fpga_ids,
+	},
+	.probe = zynq_afi_fpga_probe,
+};
+module_platform_driver(zynq_afi_fpga_driver);
+
+MODULE_DESCRIPTION("ZYNQ FPGA AFI module");
+MODULE_AUTHOR("Nava kishore Manne <nava.manne@xilinx.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
