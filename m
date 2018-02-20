Return-Path: <SRS0=ps2+=FO=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=ps2+=FO=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-dm3nam03on0082.outbound.protection.outlook.com ([104.47.41.82]:4313
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750732AbeBTIdi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Feb 2018 03:33:38 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/2] doc: fpga: Add reset bridge support
Date: Tue, 20 Feb 2018 14:10:02 +0530
Message-ID: <1519116003-6967-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org
Cc: atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org, michal.simek@xilinx.com, devicetree@vger.kernel.org, shubhrajyoti.datta@gmail.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add reset bridge support. Once this bridge is enabled.
The reset line(s) will be toggled. Generally it will be
called after the bitstream load to reset the PL.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 .../devicetree/bindings/fpga/xlnx,rst-bridge.txt   | 22 ++++++++++++++++++=
++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.=
txt

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt b/D=
ocumentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt
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
+- compatible   : Should contain "xlnx,rst-bridge"
+- reset                : reset phandles
+
+Optional properties:
+- bridge-enable                : 0 if driver should disable bridge at star=
tup
+                         1 if driver should enable bridge at startup
+                         Default is to leave bridge in current state.
+
+See Documentation/devicetree/bindings/fpga/fpga-region.txt for generic bin=
dings.
+
+Example:
+fpga_rst_bridge: fpga_rst_bridge {
+       compatible =3D "xlnx,rst-bridge";
+       resets =3D <&rst 115>;
+};
--
2.1.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
