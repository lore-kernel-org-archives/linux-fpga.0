Return-Path: <SRS0=hO1J=4C=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=hO1J=4C=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv1 5/7] arm64: dts: agilex: correct service layer driver's compatible value
Date: Fri, 14 Feb 2020 10:00:50 -0600
Message-Id: <1581696052-11540-6-git-send-email-richard.gong@linux.intel.com>
In-Reply-To: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
To: gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

Correct the compatible property value for Intel Service Layer driver
on Intel Agilex SoC platform.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 8c29853..d48218c 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -539,7 +539,7 @@
 
 		firmware {
 			svc {
-				compatible = "intel,stratix10-svc";
+				compatible = "intel,agilex-svc";
 				method = "smc";
 				memory-region = <&service_reserved>;
 
-- 
2.7.4
