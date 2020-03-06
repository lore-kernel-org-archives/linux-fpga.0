Return-Path: <SRS0=zWuL=4X=analog.com=alexandru.Ardelean@kernel.org>
Return-Path: <SRS0=zWuL=4X=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] arch: nios2: remove 'resetvalue' property
Date: Fri, 6 Mar 2020 13:54:50 +0200
Message-ID: <20200306115450.3352-2-alexandru.ardelean@analog.com>
In-Reply-To: <20200306115450.3352-1-alexandru.ardelean@analog.com>
References: <20200306115450.3352-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
To: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nios2-dev@lists.rocketboards.org
Cc: ley.foon.tan@intel.com, robh+dt@kernel.org, mdf@kernel.org, Alexandru Ardelean <alexandru.ardelean@analog.com>
List-ID: <linux-fpga@vger.kernel.org>

The 'altr,pio-1.0' driver does not handle the 'resetvalue', so remove it.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 -
 arch/nios2/boot/dts/10m50_devboard.dts                 | 2 --
 2 files changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index b0dacb6a3390..8ab19d1d3f9a 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -469,7 +469,6 @@ programming is the FPGA based bridge of fpga_region1.
 				reg = <0x10040 0x20>;
 				clocks = <0x2>;
 				altr,ngpio = <0x4>;
-				resetvalue = <0x0>;
 				#gpio-cells = <0x2>;
 				gpio-controller;
 			};
diff --git a/arch/nios2/boot/dts/10m50_devboard.dts b/arch/nios2/boot/dts/10m50_devboard.dts
index 739ad96a6cc1..56339bef3247 100644
--- a/arch/nios2/boot/dts/10m50_devboard.dts
+++ b/arch/nios2/boot/dts/10m50_devboard.dts
@@ -180,7 +180,6 @@
 			compatible = "altr,pio-1.0";
 			reg = <0x180014d0 0x00000010>;
 			altr,ngpio = <4>;
-			resetvalue = <15>;
 			#gpio-cells = <2>;
 			gpio-controller;
 		};
@@ -194,7 +193,6 @@
 			altr,interrupt-type = <2>;
 			edge_type = <1>;
 			level_trigger = <0>;
-			resetvalue = <0>;
 			#gpio-cells = <2>;
 			gpio-controller;
 		};
-- 
2.20.1
