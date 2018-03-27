Return-Path: <SRS0=zGHA=GR=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=zGHA=GR=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv3 4/7] dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
Date: Tue, 27 Mar 2018 15:20:11 -0500
Message-Id: <1522182014-7338-5-git-send-email-richard.gong@linux.intel.com>
In-Reply-To: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
References: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
To: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, yves.vandervennet@linux.intel.com, richard.gong@linux.intel.com, richard.gong@intel.com
List-ID: <linux-fpga@vger.kernel.org>

From: Alan Tull <atull@kernel.org>

Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.

Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: this patch is added in patch set version 2
v3: change to put fpga_mgr node under firmware/svc node
---
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt

diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
new file mode 100644
index 0000000..be7cd96
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
@@ -0,0 +1,17 @@
+Intel Stratix10 SoC FPGA Manager
+
+Required properties:
+The fpga_mgr node has the following mandatory property, must be located under
+firmware/svc node.
+
+- compatible : should contain "intel,stratix10-soc-fpga-mgr"
+
+Example:
+
+	firmware {
+		svc {
+			fpga_mgr: fpga-mgr@0 {
+				compatible = "intel,stratix10-soc-fpga-mgr";
+			};
+		};
+	};
-- 
2.7.4
