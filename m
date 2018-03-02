Return-Path: <SRS0=ZSq7=FY=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=ZSq7=FY=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv2 5/7] arm64: dts: stratix10: add fpga manager and region
Date: Thu,  1 Mar 2018 18:19:33 -0600
Message-Id: <1519949975-13548-6-git-send-email-richard.gong@linux.intel.com>
In-Reply-To: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
To: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, yves.vandervennet@linux.intel.com, richard.gong@linux.intel.com
List-ID: <linux-fpga@vger.kernel.org>

From: Alan Tull <atull@kernel.org>

Add the Stratix10 FPGA manager and a FPGA region to the
device tree.

Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: this patch is added in patch set version 2
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 4395e76..2f0067e 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -107,6 +107,14 @@
 		interrupt-parent = <&intc>;
 		ranges = <0 0 0 0xffffffff>;
 
+		base_fpga_region {
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+
+			compatible = "fpga-region";
+			fpga-mgr = <&fpga_mgr>;
+		};
+
 		clkmgr: clock-controller@ffd10000 {
 			compatible = "intel,stratix10-clkmgr";
 			reg = <0xffd10000 0x1000>;
@@ -138,6 +146,10 @@
 			};
 		};
 
+		fpga_mgr: fpga-mgr@0 {
+			compatible = "intel,stratix10-soc-fpga-mgr";
+		};
+
 		gmac0: ethernet@ff800000 {
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
 			reg = <0xff800000 0x2000>;
-- 
2.7.4
