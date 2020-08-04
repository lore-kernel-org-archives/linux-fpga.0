Return-Path: <SRS0=IFE+=BO=analog.com=alexandru.Ardelean@kernel.org>
Return-Path: <SRS0=IFE+=BO=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 5/6] include: fpga: adi-axi-common.h: add definitions for supported FPGAs
Date: Tue, 4 Aug 2020 14:06:57 +0300
Message-ID: <20200804110658.40911-6-alexandru.ardelean@analog.com>
In-Reply-To: <20200804110658.40911-1-alexandru.ardelean@analog.com>
References: <20200804110658.40911-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, mdf@kernel.org, "Mircea Caprioru  <mircea.caprioru@analog.com>, Alexandru Ardelean" <alexandru.ardelean@analog.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Mircea Caprioru <mircea.caprioru@analog.com>

All (newer) FPGA IP cores supported by Analog Devices, store information in
the synthesized designs. This information describes various parameters,
including the family of boards on which this is deployed, speed-grade, and
so on.

Currently, some of these definitions are deployed mostly on Xilinx boards,
but they have been considered also for FPGA boards from other vendors.

The register definitions are described at this link:
  https://wiki.analog.com/resources/fpga/docs/hdl/regmap
(the 'Base (common to all cores)' section).

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/fpga/adi-axi-common.h | 37 +++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
index 141ac3f251e6..7cca2d62cc45 100644
--- a/include/linux/fpga/adi-axi-common.h
+++ b/include/linux/fpga/adi-axi-common.h
@@ -13,6 +13,9 @@
 
 #define ADI_AXI_REG_VERSION			0x0000
 
+#define ADI_AXI_REG_FPGA_INFO			0x001C
+#define ADI_AXI_REG_FPGA_VOLTAGE		0x0140
+
 #define ADI_AXI_PCORE_VER(major, minor, patch)	\
 	(((major) << 16) | ((minor) << 8) | (patch))
 
@@ -20,4 +23,38 @@
 #define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
 #define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
 
+#define ADI_AXI_INFO_FPGA_VOLTAGE(val)		((val) & 0xffff)
+
+#define ADI_AXI_INFO_FPGA_TECH(info)		(((info) >> 24) & 0xff)
+#define ADI_AXI_INFO_FPGA_FAMILY(info)		(((info) >> 16) & 0xff)
+#define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)	(((info) >> 8) & 0xff)
+
+enum adi_axi_fgpa_technology {
+	ADI_AXI_FPGA_TECH_UNKNOWN = 0,
+	ADI_AXI_FPGA_TECH_SERIES7,
+	ADI_AXI_FPGA_TECH_ULTRASCALE,
+	ADI_AXI_FPGA_TECH_ULTRASCALE_PLUS,
+};
+
+enum adi_axi_fpga_family {
+	ADI_AXI_FPGA_FAMILY_UNKNOWN = 0,
+	ADI_AXI_FPGA_FAMILY_ARTIX,
+	ADI_AXI_FPGA_FAMILY_KINTEX,
+	ADI_AXI_FPGA_FAMILY_VIRTEX,
+	ADI_AXI_FPGA_FAMILY_ZYNQ,
+};
+
+enum adi_axi_fpga_speed_grade {
+	ADI_AXI_FPGA_SPEED_UNKNOWN	= 0,
+	ADI_AXI_FPGA_SPEED_1		= 10,
+	ADI_AXI_FPGA_SPEED_1L		= 11,
+	ADI_AXI_FPGA_SPEED_1H		= 12,
+	ADI_AXI_FPGA_SPEED_1HV		= 13,
+	ADI_AXI_FPGA_SPEED_1LV		= 14,
+	ADI_AXI_FPGA_SPEED_2		= 20,
+	ADI_AXI_FPGA_SPEED_2L		= 21,
+	ADI_AXI_FPGA_SPEED_2LV		= 22,
+	ADI_AXI_FPGA_SPEED_3		= 30,
+};
+
 #endif /* ADI_AXI_COMMON_H_ */
-- 
2.17.1
