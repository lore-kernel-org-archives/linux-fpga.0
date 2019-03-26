Return-Path: <SRS0=lrpB=R5=xilinx.com=navam@kernel.org>
Return-Path: <SRS0=lrpB=R5=xilinx.com=navam@kernel.org>
From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v5 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
Date: Tue, 26 Mar 2019 20:01:29 +0530
Message-ID: <20190326143129.2608-7-nava.manne@xilinx.com>
In-Reply-To: <20190326143129.2608-1-nava.manne@xilinx.com>
References: <20190326143129.2608-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
To: atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com, jollys@xilinx.com, nava.manne@xilinx.com, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chinnikishore369@gmail.com
List-ID: <linux-fpga@vger.kernel.org>

Add documentation to describe Xilinx ZynqMP fpga driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v5:
		-Moved pcap node as a child to firwmare
		 node as suggested by Rob.
Changes for v4:
		-Modified binding description as suggested by Moritz Fischer.
Changes for v3:
		-Removed PCAP as a child node to the FW and Created
		 an independent node since PCAP driver is a consumer
		 not a provider.

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
new file mode 100644
index 000000000000..3052bf619dd5
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
@@ -0,0 +1,25 @@
+Devicetree bindings for Zynq Ultrascale MPSoC FPGA Manager.
+The ZynqMP SoC uses the PCAP (Processor configuration Port) to configure the
+Programmable Logic (PL). The configuration uses  the firmware interface.
+
+Required properties:
+- compatible: should contain "xlnx,zynqmp-pcap-fpga"
+
+Example for full FPGA configuration:
+
+	fpga-region0 {
+		compatible = "fpga-region";
+		fpga-mgr = <&zynqmp_pcap>;
+		#address-cells = <0x1>;
+		#size-cells = <0x1>;
+	};
+
+	firmware {
+		zynqmp_firmware: zynqmp-firmware {
+			compatible = "xlnx,zynqmp-firmware";
+			method = "smc";
+			zynqmp_pcap: pcap {
+				compatible = "xlnx,zynqmp-pcap-fpga";
+			};
+		};
+	};
-- 
2.18.0
