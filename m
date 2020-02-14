Return-Path: <SRS0=hO1J=4C=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=hO1J=4C=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv1 4/7] dt-bindings, firmware: add compatible value Intel Stratix10 service layer binding
Date: Fri, 14 Feb 2020 10:00:49 -0600
Message-Id: <1581696052-11540-5-git-send-email-richard.gong@linux.intel.com>
In-Reply-To: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
To: gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

A a compatible property value to Intel Stratix10 service layer binding

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
index 1fa6606..6eff1af 100644
--- a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
@@ -23,7 +23,7 @@ Required properties:
 The svc node has the following mandatory properties, must be located under
 the firmware node.
 
-- compatible: "intel,stratix10-svc"
+- compatible: "intel,stratix10-svc" or "intel,agilex-svc"
 - method: smc or hvc
         smc - Secure Monitor Call
         hvc - Hypervisor Call
-- 
2.7.4
