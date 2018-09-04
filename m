Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v2 5/8] dt-bindings: fpga: fix freeze controller compatible in region doc
Date: Tue,  4 Sep 2018 16:22:34 -0500
Message-Id: <20180904212237.3078-6-atull@kernel.org>
In-Reply-To: <20180904212237.3078-1-atull@kernel.org>
References: <20180904212237.3078-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Documentation/devicetree/bindings/fpga/fpga-region.txt has an error
regarding the freeze controller bridge, secifically:

 compatible = "altr,freeze-bridge";

The compatibility string should be "altr,freeze-bridge-controller"
as set forth in altera-freeze-bridge.txt.

Signed-off-by: Alan Tull <atull@kernel.org>
Reported-by: Dalon Westergreen <dalon.westergreen@intel.com>
---
v2: no change in v2 of patchset
---
 Documentation/devicetree/bindings/fpga/fpga-region.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index 6db8aed..90c4469 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -415,7 +415,7 @@ DT Overlay contains:
 			firmware-name = "base.rbf";
 
 			fpga-bridge@4400 {
-				compatible = "altr,freeze-bridge";
+				compatible = "altr,freeze-bridge-controller";
 				reg = <0x4400 0x10>;
 
 				fpga_region1: fpga-region1 {
@@ -427,7 +427,7 @@ DT Overlay contains:
 			};
 
 			fpga-bridge@4420 {
-				compatible = "altr,freeze-bridge";
+				compatible = "altr,freeze-bridge-controller";
 				reg = <0x4420 0x10>;
 
 				fpga_region2: fpga-region2 {
-- 
2.7.4
