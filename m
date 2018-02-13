Return-Path: <SRS0=DkGj=FH=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=DkGj=FH=intel.com=hao.wu@kernel.org>
From: Wu Hao <hao.wu@intel.com>
Subject: [PATCH v4 17/24] fpga: dfl: add fpga bridge platform driver for FME
Date: Tue, 13 Feb 2018 17:24:46 +0800
Message-Id: <1518513893-4719-18-git-send-email-hao.wu@intel.com>
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com, yi.z.zhang@intel.com, hao.wu@intel.com, Tim Whisonant <tim.whisonant@intel.com>, Enno Luebbers <enno.luebbers@intel.com>, Shiva Rao <shiva.rao@intel.com>, Christopher Rauer <christopher.rauer@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

This patch adds fpga bridge platform driver for FPGA Management Engine.
It implements the enable_set call back for fpga bridge.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v3: rename driver to fpga-dfl-fme-br
    remove useless dev_dbg in probe function.
    rebased due to fpga api change.
v4: rename to dfl-fme-br and fix SPDX license issue
    include dfl-fme-pr.h instead of dfl-fme.h
    add Acked-by from Alan and Moritz
---
 drivers/fpga/Kconfig      |  6 ++++
 drivers/fpga/Makefile     |  1 +
 drivers/fpga/dfl-fme-br.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 drivers/fpga/dfl-fme-br.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 89f76e8..a8f939a 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -156,6 +156,12 @@ config FPGA_DFL_FME_MGR
 	help
 	  Say Y to enable FPGA Manager driver for FPGA Management Engine.
 
+config FPGA_DFL_FME_BRIDGE
+	tristate "FPGA DFL FME Bridge Driver"
+	depends on FPGA_DFL_FME
+	help
+	  Say Y to enable FPGA Bridge driver for FPGA Management Engine.
+
 config FPGA_DFL_PCI
 	tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index f82814a..75096e9 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
 obj-$(CONFIG_FPGA_DFL)			+= dfl.o
 obj-$(CONFIG_FPGA_DFL_FME)		+= dfl-fme.o
 obj-$(CONFIG_FPGA_DFL_FME_MGR)		+= dfl-fme-mgr.o
+obj-$(CONFIG_FPGA_DFL_FME_BRIDGE)	+= dfl-fme-br.o
 
 dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
 
diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
new file mode 100644
index 0000000..46cee30
--- /dev/null
+++ b/drivers/fpga/dfl-fme-br.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FPGA Bridge Driver for FPGA Management Engine (FME)
+ *
+ * Copyright (C) 2017 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Wu Hao <hao.wu@intel.com>
+ *   Joseph Grecco <joe.grecco@intel.com>
+ *   Enno Luebbers <enno.luebbers@intel.com>
+ *   Tim Whisonant <tim.whisonant@intel.com>
+ *   Ananda Ravuri <ananda.ravuri@intel.com>
+ *   Henry Mitchel <henry.mitchel@intel.com>
+ */
+
+#include <linux/module.h>
+#include <linux/fpga/fpga-bridge.h>
+
+#include "dfl.h"
+#include "dfl-fme-pr.h"
+
+static int fme_bridge_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct fme_br_pdata *pdata = bridge->priv;
+	int ret = 0;
+
+	if (enable)
+		fpga_port_enable(pdata->port);
+	else
+		ret = fpga_port_disable(pdata->port);
+
+	return ret;
+}
+
+static const struct fpga_bridge_ops fme_bridge_ops = {
+	.enable_set = fme_bridge_enable_set,
+};
+
+static int fme_br_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct fme_br_pdata *pdata = dev_get_platdata(dev);
+	struct fpga_bridge *br;
+	int ret;
+
+	br = devm_kzalloc(dev, sizeof(*br), GFP_KERNEL);
+	if (!br)
+		return -ENOMEM;
+
+	br->name = "FPGA FME Bridge";
+	br->br_ops = &fme_bridge_ops;
+	br->priv = pdata;
+	br->parent = dev;
+	platform_set_drvdata(pdev, br);
+
+	ret = fpga_bridge_register(br);
+	if (ret)
+		dev_err(dev, "unable to register FPGA Bridge\n");
+
+	return ret;
+}
+
+static int fme_br_remove(struct platform_device *pdev)
+{
+	struct fpga_bridge *br = platform_get_drvdata(pdev);
+
+	fpga_bridge_unregister(br);
+
+	return 0;
+}
+
+static struct platform_driver fme_br_driver = {
+	.driver	= {
+		.name    = FPGA_DFL_FME_BRIDGE,
+	},
+	.probe   = fme_br_probe,
+	.remove  = fme_br_remove,
+};
+
+module_platform_driver(fme_br_driver);
+
+MODULE_DESCRIPTION("FPGA Bridge for DFL FPGA Management Engine");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:dfl-fme-bridge");
-- 
2.7.4
