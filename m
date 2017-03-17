Return-Path: <mdf@kernel.org>
Return-Path: <mdf@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v3 1/2] doc: Add bindings document for Xilinx LogiCore PR Decoupler
Date: Fri, 17 Mar 2017 13:11:12 -0700
Message-Id: <1489781473-30772-1-git-send-email-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: linux-fpga@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, Moritz Fischer <mdf@kernel.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

This adds the binding documentation for the Xilinx LogiCORE PR
Decoupler soft core.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
---

Changes from v2:
- Added refence to generic fpga-region bindings
- Fixed up reg property in example
- Added fallback to "xlnx,pr-decoupler" without version

Changes from v1:
- Added clock names & clock to example
- Merged some of the description from Michal's version

---
 .../bindings/fpga/xilinx-pr-decoupler.txt          | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt

diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
new file mode 100644
index 0000000..16141bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
@@ -0,0 +1,35 @@
+Xilinx LogiCORE Partial Reconfig Decoupler Softcore
+
+The Xilinx LogiCORE Partial Reconfig Decoupler manages one or more
+decouplers / fpga bridges.
+The controller can decouple/disable the bridges which prevents signal
+changes from passing through the bridge.  The controller can also
+couple / enable the bridges which allows traffic to pass through the
+bridge normally.
+
+The Driver supports only MMIO handling. A PR region can have multiple
+PR Decouples which can bhe handled independently or chaines via decouple/
+decouple_status signals.
+
+Required properties:
+- compatible		: Should contain "xlnx,pr-decoupler-1.00"
+- regs			: base address and size for decoupler module
+- clocks		: input clock to IP
+- clock-names		: should contain "aclk"
+
+Optional properties:
+- bridge-enable		: 0 if driver should disable bridge at startup
+			  1 if driver should enable bridge at startup
+			  Default is to leave bridge in current state.
+
+See Documentation/devicetree/bindings/fpga/fpga-region.txt for generic bindings.
+
+Example:
+	fpga-bridge@100000450 {
+		compatible = "xlnx,pr-decoupler-1.00",
+			     "xlnx-pr-decoupler";
+		regs = <0x10000045 0x10>;
+		clocks = <&clkc 15>;
+		clock-names = "aclk";
+		bridge-enable = <0>;
+	};
-- 
2.7.4
