Return-Path: <SRS0=lgA+=M7=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=lgA+=M7=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-eopbgr720079.outbound.protection.outlook.com ([40.107.72.79]:12641
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbeJSQy5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 19 Oct 2018 12:54:57 -0400
From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
Date: Sat, 20 Oct 2018 14:18:04 +0530
Message-ID: <20181020084805.29103-3-nava.manne@xilinx.com>
In-Reply-To: <20181020084805.29103-1-nava.manne@xilinx.com>
References: <20181020084805.29103-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com, jollys@xilinx.com, nava.manne@xilinx.com, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chinnikishore369@gmail.com

Add documentation to describe Xilinx ZynqMP fpga driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v1:
                Created a Seperate(New) DT binding file as
                suggested by Rob.

Changes for RFC-V2:
                -Moved pcap node as a child to firwmare
                 node as suggested by Rob.

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
new file mode 100644
index 000000000000..248ff0ee60a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
@@ -0,0 +1,17 @@
+--------------------------------------------------------------------------
+Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC controlled
+using ZynqMP SoC firmware interface
+--------------------------------------------------------------------------
+For Bitstream configuration on ZynqMp Soc uses processor configuration
+port(PCAP) to configure the programmable logic(PL) through PS by using
+FW interface.
+
+Required properties:
+- compatible: should contain "xlnx,zynqmp-pcap-fpga"
+
+-------
+Example
+-------
+	zynqmp_pcap: pcap {
+		compatible = "xlnx,zynqmp-pcap-fpga";
+	};
-- 
2.18.0
