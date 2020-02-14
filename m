Return-Path: <SRS0=AOTa=4C=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=AOTa=4C=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:8617 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbgBNPou (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 14 Feb 2020 10:44:50 -0500
From: richard.gong@linux.intel.com
Subject: [PATCHv1 2/7] arm64: dts: agilex: correct FPGA manager driver's compatible value
Date: Fri, 14 Feb 2020 10:00:47 -0600
Message-Id: <1581696052-11540-3-git-send-email-richard.gong@linux.intel.com>
In-Reply-To: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>

From: Richard Gong <richard.gong@intel.com>

Correct the compatible property value for FPGA manager driver on
Intel Agilex SoC platform.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index e1d357e..8c29853 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -544,7 +544,7 @@
 				memory-region = <&service_reserved>;
 
 				fpga_mgr: fpga-mgr {
-					compatible = "intel,stratix10-soc-fpga-mgr";
+					compatible = "intel,agilex-soc-fpga-mgr";
 				};
 			};
 		};
-- 
2.7.4
