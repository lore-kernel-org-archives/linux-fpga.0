Return-Path: <SRS0=0za6=6W=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=0za6=6W=ettus.com=moritz.fischer@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] MAINTAINERS: fpga: Update email and add patchwork URL
Date: Wed, 19 Jul 2017 09:37:50 -0700
Message-Id: <1500482270-24280-1-git-send-email-mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mchehab@kernel.org, davem@davemloft.net, Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Add Q: entry for patchwork and update my email address.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>
Cc: linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f42daf7..ea690a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5213,10 +5213,11 @@ K:	fmc_d.*register
 
 FPGA MANAGER FRAMEWORK
 M:	Alan Tull <atull@kernel.org>
-R:	Moritz Fischer <moritz.fischer@ettus.com>
+R:	Moritz Fischer <mdf@kernel.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
+Q:	http://patchwork.kernel.org/project/linux-fpga/list/
 F:	Documentation/fpga/
 F:	Documentation/devicetree/bindings/fpga/
 F:	drivers/fpga/
-- 
2.7.4
