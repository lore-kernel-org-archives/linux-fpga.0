Return-Path: <SRS0=KCYC=57=xilinx.com=navam@kernel.org>
Return-Path: <SRS0=KCYC=57=xilinx.com=navam@kernel.org>
From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 1/2] fpga: doc: Add binding doc for the afi config driver
Date: Wed, 15 Apr 2020 15:54:49 +0530
Message-Id: <1586946290-7280-1-git-send-email-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
To: mdf@kernel.org, michal.simek@xilinx.com, linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chinnikishore369@gmail.com
Cc: Nava kishore Manne <nava.manne@xilinx.com>
List-ID: <linux-fpga@vger.kernel.org>

This patch adds the binding document for the afi
config driver.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 .../devicetree/bindings/fpga/xlnx,zynq-afi-fpga.txt   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynq-afi-fpga.txt

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynq-afi-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynq-afi-fpga.txt
new file mode 100644
index 0000000..e00942c
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,zynq-afi-fpga.txt
@@ -0,0 +1,19 @@
+Xilinx Zynq AFI interface Manager
+
+The Zynq Processing System core provides access from PL masters to PS
+internal peripherals, and memory through AXI FIFO interface
+(AFI) interfaces.
+
+Required properties:
+-compatible:	Should contain "xlnx,zynq-afi-fpga"
+-reg:	Physical base address and size of the controller's register area.
+-xlnx,afi-buswidth :	Size of the afi bus width.
+			0: 64-bit AXI data width,
+			1: 32-bit AXI data width,
+
+Example:
+afi0: afi0 {
+	compatible = "xlnx,zynq-afi-fpga";
+	reg = <0xf8008000 0x1000>;
+	xlnx,afi-buswidth = <1>;
+};
-- 
2.7.4
