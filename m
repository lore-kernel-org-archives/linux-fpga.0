Return-Path: <SRS0=IFE+=BO=analog.com=alexandru.Ardelean@kernel.org>
Return-Path: <SRS0=IFE+=BO=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 6/6] clk: axi-clkgen: Add support for FPGA info
Date: Tue, 4 Aug 2020 14:06:58 +0300
Message-ID: <20200804110658.40911-7-alexandru.ardelean@analog.com>
In-Reply-To: <20200804110658.40911-1-alexandru.ardelean@analog.com>
References: <20200804110658.40911-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, mdf@kernel.org, Mircea Caprioru <mircea.caprioru@analog.com>, Alexandru Ardelean <alexandru.ardelean@analog.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Mircea Caprioru <mircea.caprioru@analog.com>

This patch adds support for vco maximum and minimum ranges in accordance
with fpga speed grade, voltage, device package, technology and family. This
new information is extracted from two new registers implemented in the ip
core: ADI_REG_FPGA_INFO and ADI_REG_FPGA_VOLTAGE, which are stored in the
'include/linux/fpga/adi-axi-common.h' file as they are common to all ADI
FPGA cores.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 67 +++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 6ffc19e9d850..51c890103dad 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -8,6 +8,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/clk-provider.h>
+#include <linux/fpga/adi-axi-common.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -49,6 +50,7 @@
 struct axi_clkgen {
 	void __iomem *base;
 	struct clk_hw clk_hw;
+	unsigned int pcore_version;
 };
 
 static uint32_t axi_clkgen_lookup_filter(unsigned int m)
@@ -101,15 +103,15 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
 }
 
 #ifdef ARCH_ZYNQMP
-static const unsigned int fpfd_min = 10000;
-static const unsigned int fpfd_max = 450000;
-static const unsigned int fvco_min = 800000;
-static const unsigned int fvco_max = 1600000;
+static unsigned int fpfd_min = 10000;
+static unsigned int fpfd_max = 450000;
+static unsigned int fvco_min = 800000;
+static unsigned int fvco_max = 1600000;
 #else
-static const unsigned int fpfd_min = 10000;
-static const unsigned int fpfd_max = 300000;
-static const unsigned int fvco_min = 600000;
-static const unsigned int fvco_max = 1200000;
+static unsigned int fpfd_min = 10000;
+static unsigned int fpfd_max = 300000;
+static unsigned int fvco_min = 600000;
+static unsigned int fvco_max = 1200000;
 #endif
 
 static void axi_clkgen_calc_params(unsigned long fin, unsigned long fout,
@@ -229,6 +231,49 @@ static void axi_clkgen_read(struct axi_clkgen *axi_clkgen,
 	*val = readl(axi_clkgen->base + reg);
 }
 
+static void axi_clkgen_setup_ranges(struct axi_clkgen *axi_clkgen)
+{
+	unsigned int reg_value;
+	unsigned int tech, family, speed_grade, voltage;
+
+	axi_clkgen_read(axi_clkgen, ADI_AXI_REG_FPGA_INFO, &reg_value);
+	tech = ADI_AXI_INFO_FPGA_TECH(reg_value);
+	family = ADI_AXI_INFO_FPGA_FAMILY(reg_value);
+	speed_grade = ADI_AXI_INFO_FPGA_SPEED_GRADE(reg_value);
+
+	axi_clkgen_read(axi_clkgen, ADI_AXI_REG_FPGA_VOLTAGE, &reg_value);
+	voltage = ADI_AXI_INFO_FPGA_VOLTAGE(reg_value);
+
+	switch (speed_grade) {
+	case ADI_AXI_FPGA_SPEED_1 ... ADI_AXI_FPGA_SPEED_1LV:
+		fvco_max = 1200000;
+		fpfd_max = 450000;
+		break;
+	case ADI_AXI_FPGA_SPEED_2 ... ADI_AXI_FPGA_SPEED_2LV:
+		fvco_max = 1440000;
+		fpfd_max = 500000;
+		if ((family == ADI_AXI_FPGA_FAMILY_KINTEX) |
+		    (family == ADI_AXI_FPGA_FAMILY_ARTIX)) {
+			if (voltage < 950) {
+				fvco_max = 1200000;
+				fpfd_max = 450000;
+			}
+		}
+		break;
+	case ADI_AXI_FPGA_SPEED_3:
+		fvco_max = 1600000;
+		fpfd_max = 550000;
+		break;
+	default:
+		break;
+	};
+
+	if (tech == ADI_AXI_FPGA_TECH_ULTRASCALE_PLUS) {
+		fvco_max = 1600000;
+		fvco_min = 800000;
+	}
+}
+
 static int axi_clkgen_wait_non_busy(struct axi_clkgen *axi_clkgen)
 {
 	unsigned int timeout = 10000;
@@ -524,6 +569,12 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 	if (IS_ERR(axi_clkgen->base))
 		return PTR_ERR(axi_clkgen->base);
 
+	axi_clkgen_read(axi_clkgen, ADI_AXI_REG_VERSION,
+			&axi_clkgen->pcore_version);
+
+	if (ADI_AXI_PCORE_VER_MAJOR(axi_clkgen->pcore_version) > 0x04)
+		axi_clkgen_setup_ranges(axi_clkgen);
+
 	init.num_parents = of_clk_get_parent_count(pdev->dev.of_node);
 	if (init.num_parents < 1 || init.num_parents > 2)
 		return -EINVAL;
-- 
2.17.1
