Return-Path: <SRS0=Tyjd=FP=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Tyjd=FP=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-co1nam03on0076.outbound.protection.outlook.com ([104.47.40.76]:55533
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751168AbeBUErS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Feb 2018 23:47:18 -0500
From: <shubhrajyoti.datta@gmail.com>
Subject: [PATCH 1/2] doc: fpga: Add reset bridge support
Date: Wed, 21 Feb 2018 10:23:45 +0530
Message-ID: <1519188826-2047-1-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org
Cc: atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org, michal.simek@xilinx.com, devicetree@vger.kernel.org, shubhrajyoti.datta@gmail.com, nofooter@xilinx.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add reset bridge support. Once this bridge is enabled.
The reset line(s) will be toggled. Generally it will be
called after the bitstream load to reset the PL.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 .../devicetree/bindings/fpga/xlnx,rst-bridge.txt   | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt b/Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt
new file mode 100644
index 0000000..6f1bfc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt
@@ -0,0 +1,22 @@
+Xilinx fpga reset bridge
+
+The Xilinx reset bridge toggles the reset line to the PL
+in Zynqmp Ultrascale plus.
+
+
+Required properties:
+- compatible	: Should contain "xlnx,rst-bridge"
+- reset		: reset phandles
+
+Optional properties:
+- bridge-enable		: 0 if driver should disable bridge at startup
+			  1 if driver should enable bridge at startup
+			  Default is to leave bridge in current state.
+
+See Documentation/devicetree/bindings/fpga/fpga-region.txt for generic bindings.
+
+Example:
+fpga_rst_bridge: fpga_rst_bridge {
+	compatible = "xlnx,rst-bridge";
+	resets = <&rst 115>;
+};
-- 
2.1.1

