Return-Path: <SRS0=zWuL=4X=analog.com=alexandru.Ardelean@kernel.org>
Return-Path: <SRS0=zWuL=4X=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] arch: nios2: rename 'altr,gpio-bank-width' -> 'altr,ngpio'
Date: Fri, 6 Mar 2020 13:54:49 +0200
Message-ID: <20200306115450.3352-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
To: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nios2-dev@lists.rocketboards.org
Cc: ley.foon.tan@intel.com, robh+dt@kernel.org, mdf@kernel.org, Alexandru Ardelean <alexandru.ardelean@analog.com>
List-ID: <linux-fpga@vger.kernel.org>

There is no more 'altr,gpio-bank-width' in the 'altr,pio-1.0' driver.
There is a 'altr,ngpio' which is  what the property wants to configure.

This change updates all occurrences of 'altr,gpio-bank-width' to
'altr,ngpio'.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 Documentation/devicetree/bindings/fpga/fpga-region.txt | 4 ++--
 arch/nios2/boot/dts/10m50_devboard.dts                 | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index 90c44694a30b..b0dacb6a3390 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -263,7 +263,7 @@ Overlay contains:
 			gpio@10040 {
 				compatible = "altr,pio-1.0";
 				reg = <0x10040 0x20>;
-				altr,gpio-bank-width = <4>;
+				altr,ngpio = <4>;
 				#gpio-cells = <2>;
 				clocks = <2>;
 				gpio-controller;
@@ -468,7 +468,7 @@ programming is the FPGA based bridge of fpga_region1.
 				compatible = "altr,pio-1.0";
 				reg = <0x10040 0x20>;
 				clocks = <0x2>;
-				altr,gpio-bank-width = <0x4>;
+				altr,ngpio = <0x4>;
 				resetvalue = <0x0>;
 				#gpio-cells = <0x2>;
 				gpio-controller;
diff --git a/arch/nios2/boot/dts/10m50_devboard.dts b/arch/nios2/boot/dts/10m50_devboard.dts
index 5e4ab032c1e8..739ad96a6cc1 100644
--- a/arch/nios2/boot/dts/10m50_devboard.dts
+++ b/arch/nios2/boot/dts/10m50_devboard.dts
@@ -179,7 +179,7 @@
 		led_pio: gpio@180014d0 {
 			compatible = "altr,pio-1.0";
 			reg = <0x180014d0 0x00000010>;
-			altr,gpio-bank-width = <4>;
+			altr,ngpio = <4>;
 			resetvalue = <15>;
 			#gpio-cells = <2>;
 			gpio-controller;
@@ -190,7 +190,7 @@
 			reg = <0x180014c0 0x00000010>;
 			interrupt-parent = <&cpu>;
 			interrupts = <6>;
-			altr,gpio-bank-width = <3>;
+			altr,ngpio = <3>;
 			altr,interrupt-type = <2>;
 			edge_type = <1>;
 			level_trigger = <0>;
-- 
2.20.1
