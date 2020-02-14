Return-Path: <SRS0=hO1J=4C=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=hO1J=4C=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv1 1/7] dt-bindings: fpga: add compatible value to Stratix10 SoC FPGA manager binding
Date: Fri, 14 Feb 2020 10:00:46 -0600
Message-Id: <1581696052-11540-2-git-send-email-richard.gong@linux.intel.com>
In-Reply-To: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
To: gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

Add a compatible property value to Stratix10 SoC FPGA manager binding file

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt          | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
index 6e03f79..0f87413 100644
--- a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
+++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
@@ -4,7 +4,8 @@ Required properties:
 The fpga_mgr node has the following mandatory property, must be located under
 firmware/svc node.
 
-- compatible : should contain "intel,stratix10-soc-fpga-mgr"
+- compatible : should contain "intel,stratix10-soc-fpga-mgr" or
+	       "intel,agilex-soc-fpga-mgr"
 
 Example:
 
-- 
2.7.4
