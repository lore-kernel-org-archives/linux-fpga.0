Return-Path: <SRS0=Hdhx=GG=gmail.com=p.pisati@kernel.org>
Return-Path: <SRS0=Hdhx=GG=gmail.com=p.pisati@kernel.org>
From: Paolo Pisati <p.pisati@gmail.com>
Subject: [PATCH 1/2] dt: bindings: fpga: add lattice machxo2 slave spi binding description
Date: Fri, 16 Mar 2018 16:54:28 +0100
Message-Id: <1521215669-23874-2-git-send-email-p.pisati@gmail.com>
In-Reply-To: <1521215669-23874-1-git-send-email-p.pisati@gmail.com>
References: <1521215669-23874-1-git-send-email-p.pisati@gmail.com>
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Add dt binding documentation details for Lattice MachXO2 FPGA configuration
over Slave SPI interface.

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/fpga/lattice-machxo2-spi.txt          | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt

diff --git a/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt b/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
new file mode 100644
index 0000000..a8c362e
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
@@ -0,0 +1,29 @@
+Lattice MachXO2 Slave SPI FPGA Manager
+
+Lattice MachXO2 FPGAs support a method of loading the bitstream over
+'slave SPI' interface.
+
+See 'MachXO2ProgrammingandConfigurationUsageGuide.pdf' on www.latticesemi.com
+
+Required properties:
+- compatible: should contain "lattice,machxo2-slave-spi"
+- reg: spi chip select of the FPGA
+
+Example for full FPGA configuration:
+
+	fpga-region0 {
+		compatible = "fpga-region";
+		fpga-mgr = <&fpga_mgr_spi>;
+		#address-cells = <0x1>;
+		#size-cells = <0x1>;
+	};
+
+	spi1: spi@2000 {
+        ...
+
+		fpga_mgr_spi: fpga-mgr@0 {
+			compatible = "lattice,machxo2-slave-spi";
+			spi-max-frequency = <8000000>;
+			reg = <0>;
+		};
+	};
-- 
2.7.4
