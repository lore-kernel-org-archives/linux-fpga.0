Return-Path: <SRS0=LHYr=SE=xilinx.com=navam@kernel.org>
Return-Path: <SRS0=LHYr=SE=xilinx.com=navam@kernel.org>
From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v4 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
Date: Tue, 2 Apr 2019 18:01:22 +0530
Message-ID: <20190402123123.915-3-nava.manne@xilinx.com>
In-Reply-To: <20190402123123.915-1-nava.manne@xilinx.com>
References: <20190402123123.915-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
To: atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com, jollys@xilinx.com, nava.manne@xilinx.com, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chinnikishore369@gmail.com
List-ID: <linux-fpga@vger.kernel.org>

Add documentation to describe Xilinx ZynqMP fpga driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
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
