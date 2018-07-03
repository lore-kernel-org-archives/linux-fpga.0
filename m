Return-Path: <SRS0=Wyc8=JT=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=Wyc8=JT=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv6 2/8] arm64: dts: stratix10: add stratix10 service driver binding to base dtsi
Date: Tue,  3 Jul 2018 09:46:49 -0500
Message-Id: <1530629215-26990-3-git-send-email-richard.gong@linux.intel.com>
In-Reply-To: <1530629215-26990-1-git-send-email-richard.gong@linux.intel.com>
References: <1530629215-26990-1-git-send-email-richard.gong@linux.intel.com>
To: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, corbet@lwn.net
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, yves.vandervennet@linux.intel.com, richard.gong@linux.intel.com, richard.gong@intel.com
List-ID: <linux-fpga@vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

Add Intel Stratix10 service layer to the device tree

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v2: Change to put service layer driver node under the firmware node
    Change compatible to "intel, stratix10-svc"
v3: No change
v4: s/service driver/stratix10 service driver/ in subject line
v5: No change
v6: Add Moritz's Acked-by
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index e6b05937..1ba9a1c 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -24,6 +24,19 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		service_reserved: svcbuffer@0 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x0 0x0 0x1000000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -466,5 +479,28 @@
 				interrupts = <16 4>, <48 4>;
 			};
 		};
+
+		qspi: spi@ff8d2000 {
+			compatible = "cdns,qspi-nor";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xff8d2000 0x100>,
+			      <0xff900000 0x100000>;
+			interrupts = <0 3 4>;
+			cdns,fifo-depth = <128>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x00000000>;
+			clocks = <&qspi_clk>;
+
+			status = "disabled";
+		};
+
+		firmware {
+			svc {
+				compatible = "intel,stratix10-svc";
+				method = "smc";
+				memory-region = <&service_reserved>;
+			};
+		};
 	};
 };
-- 
2.7.4
