Return-Path: <SRS0=WRnb=QF=gmail.com=simon.k.r.goldschmidt@kernel.org>
Return-Path: <SRS0=WRnb=QF=gmail.com=simon.k.r.goldschmidt@kernel.org>
From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: [PATCH] ARM: socfpga: fix base address of SDR controller
Date: Tue, 29 Jan 2019 21:08:58 +0100
Message-Id: <20190129200858.19773-1-goldsimon@gmx.de>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alan Tull <atull@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-fpga@vger.kernel.org>

From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>

The documentation for socfpga gen5 says the base address of the sdram
controller is 0xffc20000, while the current devicetree says it is at
0xffc25000.

While this is not a problem for Linux, as it only accesses the registers
above 0xffc25000, it *is* a problem for U-Boot because the lower registers
are used during DDR calibration (up to now, the U-Boot driver does not use
the dts address, but that should change).

To keep Linux and U-Boot devicetrees in sync, this patch changes the base
address to 0xffc20000 and adapts the 2 files where it is currently used.

This patch changes the dts and 2 drivers with one commit to prevent
breaking the code if dts change and driver change would be split.

Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
---

 arch/arm/boot/dts/socfpga.dtsi       | 4 ++--
 arch/arm/mach-socfpga/self-refresh.S | 4 ++--
 drivers/fpga/altera-fpga2sdram.c     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index f365003f0..8f6c1a5d6 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -788,9 +788,9 @@
 			reg = <0xfffec000 0x100>;
 		};
 
-		sdr: sdr@ffc25000 {
+		sdr: sdr@ffc20000 {
 			compatible = "altr,sdr-ctl", "syscon";
-			reg = <0xffc25000 0x1000>;
+			reg = <0xffc20000 0x6000>;
 		};
 
 		sdramedac {
diff --git a/arch/arm/mach-socfpga/self-refresh.S b/arch/arm/mach-socfpga/self-refresh.S
index f2d7f883e..bd7759357 100644
--- a/arch/arm/mach-socfpga/self-refresh.S
+++ b/arch/arm/mach-socfpga/self-refresh.S
@@ -19,8 +19,8 @@
 #define MAX_LOOP_COUNT		1000
 
 /* Register offset */
-#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x54
-#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x58
+#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x5054
+#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x5058
 
 /* Bitfield positions */
 #define SELFRSHREQ_POS                  3
diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
index a78e49c63..30767c254 100644
--- a/drivers/fpga/altera-fpga2sdram.c
+++ b/drivers/fpga/altera-fpga2sdram.c
@@ -30,7 +30,7 @@
 #include <linux/of_platform.h>
 #include <linux/regmap.h>
 
-#define ALT_SDR_CTL_FPGAPORTRST_OFST		0x80
+#define ALT_SDR_CTL_FPGAPORTRST_OFST		0x5080
 #define ALT_SDR_CTL_FPGAPORTRST_PORTRSTN_MSK	0x00003fff
 #define ALT_SDR_CTL_FPGAPORTRST_RD_SHIFT	0
 #define ALT_SDR_CTL_FPGAPORTRST_WR_SHIFT	4
-- 
2.17.1
