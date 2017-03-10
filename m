Return-Path: <mdf@kernel.org>
Return-Path: <mdf@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 2/2] fpga: Add support for Xilinx LogiCORE PR Decoupler
Date: Fri, 10 Mar 2017 13:30:35 -0800
Message-Id: <1489181435-3151-2-git-send-email-mdf@kernel.org>
In-Reply-To: <1489181435-3151-1-git-send-email-mdf@kernel.org>
References: <1489181435-3151-1-git-send-email-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: linux-fpga@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, Moritz Fischer <mdf@kernel.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

This adds support for the Xilinx LogiCORE PR Decoupler
soft-ip that does decoupling of PR regions in the FPGA
fabric during partial reconfiguration.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 drivers/fpga/Kconfig               |   9 +++
 drivers/fpga/Makefile              |   1 +
 drivers/fpga/xilinx-pr-decoupler.c | 156 +++++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)
 create mode 100644 drivers/fpga/xilinx-pr-decoupler.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 967cda4..e42c7dc 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -69,6 +69,15 @@ config ALTERA_FREEZE_BRIDGE
 	  isolate one region of the FPGA from the busses while that
 	  region is being reprogrammed.
 
+config XILINX_PR_DECOUPLER
+	tristate "Xilinx LogiCORE PR Decoupler"
+	depends on FPGA_BRIDGE
+	help
+	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler.
+	  The PR Decoupler exists in the FPGA fabric to isolate one
+	  region of the FPGA from the busses while that region is
+	  being reprogrammed during partial reconfig.
+
 endif # FPGA
 
 endmenu
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index cc0d364..3f04bcf 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
 obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
 obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
 obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+= altera-freeze-bridge.o
+obj-$(CONFIG_XILINX_PR_DECOUPLER)	+= xilinx-pr-decoupler.o
 
 # High Level Interfaces
 obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
new file mode 100644
index 0000000..07afdd6
--- /dev/null
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -0,0 +1,156 @@
+/*
+ * Copyright (c) 2017, National Instruments Corp.
+ *
+ * FPGA Bridge Driver for the Xilinx LogiCORE Partial Reconfiguration
+ * Decoupler IP Core.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of_device.h>
+#include <linux/module.h>
+#include <linux/fpga/fpga-bridge.h>
+
+#define CTRL_OFFSET 0x00
+#define STATUS_OFFSET 0x00
+
+#define CTRL_CMD_MASK		BIT(0)
+#define CTRL_CMD_DECOUPLE	BIT(0)
+#define CTRL_CMD_COUPLE		~BIT(0)
+
+#define STATUS_STATE_MASK	BIT(0)
+#define STATUS_STATE_COUPLED	~BIT(0)
+#define STATUS_STATE_DECOUPLED	BIT(0)
+
+struct xlnx_pr_decoupler_data {
+	void __iomem *io_base;
+	struct clk *clk;
+	bool enable;
+};
+
+static inline void xlnx_pr_decoupler_write(struct xlnx_pr_decoupler_data *p,
+					   u32 offset, u32 val)
+{
+	writel(val, p->io_base + offset);
+}
+
+static inline u32 xlnx_pr_decoupler_read(const struct xlnx_pr_decoupler_data *p,
+					 u32 offset)
+{
+	return readl(p->io_base + offset);
+}
+
+static int xlnx_pr_decoupler_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	int err;
+	struct xlnx_pr_decoupler_data *priv = bridge->priv;
+
+	if (priv->enable != enable) {
+		err = clk_enable(priv->clk);
+		if (err)
+			return err;
+
+		xlnx_pr_decoupler_write(priv, CTRL_OFFSET,
+					enable ? CTRL_CMD_COUPLE :
+					CTRL_CMD_DECOUPLE);
+
+		clk_disable(priv->clk);
+	}
+
+	return 0;
+}
+
+static int xlnx_pr_decoupler_enable_show(struct fpga_bridge *bridge)
+{
+	const struct xlnx_pr_decoupler_data *p = bridge->priv;
+
+	return p->enable;
+}
+
+static struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
+	.enable_set = xlnx_pr_decoupler_enable_set,
+	.enable_show = xlnx_pr_decoupler_enable_show,
+};
+
+static const struct of_device_id xlnx_pr_decoupler_of_match[] = {
+	{ .compatible = "xlnx,pr-decoupler-1.00", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xlnx_pr_decoupler_of_match);
+
+static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
+{
+	struct xlnx_pr_decoupler_data *priv;
+	u32 status;
+	int err;
+	struct resource *res;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->io_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->io_base))
+		return PTR_ERR(priv->io_base);
+
+	priv->clk = devm_clk_get(&pdev->dev, "ref_clk");
+	if (IS_ERR(priv->clk)) {
+		dev_err(&pdev->dev, "input clock not found\n");
+		return PTR_ERR(priv->clk);
+	}
+
+	err = clk_prepare_enable(priv->clk);
+	if (err) {
+		dev_err(&pdev->dev, "unable to enable clock\n");
+		return err;
+	}
+
+	status = xlnx_pr_decoupler_read(priv, STATUS_OFFSET);
+	priv->enable = !!(status & STATUS_STATE_MASK);
+
+	clk_disable(priv->clk);
+
+	err = fpga_bridge_register(&pdev->dev, "Xilinx PR Decoupler",
+				   &xlnx_pr_decoupler_br_ops, priv);
+
+	if (err) {
+		dev_err(&pdev->dev, "unable to register Xilinx PR Decoupler");
+		clk_unprepare(priv->clk);
+		return err;
+	}
+
+	return 0;
+}
+
+static int xlnx_pr_decoupler_remove(struct platform_device *pdev)
+{
+	fpga_bridge_unregister(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver xlnx_pr_decoupler_driver = {
+	.probe = xlnx_pr_decoupler_probe,
+	.remove = xlnx_pr_decoupler_remove,
+	.driver = {
+		.name = "xlnx_pr_decoupler",
+		.of_match_table = of_match_ptr(xlnx_pr_decoupler_of_match),
+	},
+};
+
+module_platform_driver(xlnx_pr_decoupler_driver);
+
+MODULE_DESCRIPTION("Xilinx Partial Reconfiguration Decoupler");
+MODULE_AUTHOR("Moritz Fischer <mdf@kernel.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
