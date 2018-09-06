Return-Path: <SRS0=ymJF=LU=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=ymJF=LU=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbeIFWie (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 6 Sep 2018 18:38:34 -0400
From: Alan Tull <atull@kernel.org>
Subject: [PATCH] dt-bindings: fpga: fix freeze controller compatible in region doc
Date: Thu,  6 Sep 2018 13:01:52 -0500
Message-Id: <20180906180152.3620-1-atull@kernel.org>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Moritz Fischer <mdf@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>

Documentation/devicetree/bindings/fpga/fpga-region.txt has an error
regarding the freeze controller bridge, secifically:

 compatible = "altr,freeze-bridge";

The compatibility string should be "altr,freeze-bridge-controller"
as set forth in altera-freeze-bridge.txt.

Signed-off-by: Alan Tull <atull@kernel.org>
Reported-by: Dalon Westergreen <dalon.westergreen@intel.com>
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
