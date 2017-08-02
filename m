Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 5/5] MAINTAINERS: fpga: Update email and add patchwork URL
Date: Tue,  1 Aug 2017 21:20:55 -0500
Message-Id: <1501640455-2719-6-git-send-email-atull@kernel.org>
In-Reply-To: <1501640455-2719-1-git-send-email-atull@kernel.org>
References: <1501640455-2719-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

From: Moritz Fischer <mdf@kernel.org>

Add Q: entry for patchwork and update my email address.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-By: Alan Tull <atull@kernel.org>
Cc: Alan Tull <atull@kernel.org>
Cc: linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4348288..4f3f2c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5357,10 +5357,11 @@ K:	fmc_d.*register
 
 FPGA MANAGER FRAMEWORK
 M:	Alan Tull <atull@kernel.org>
-R:	Moritz Fischer <moritz.fischer@ettus.com>
+R:	Moritz Fischer <mdf@kernel.org>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
+Q:	http://patchwork.kernel.org/project/linux-fpga/list/
 F:	Documentation/fpga/
 F:	Documentation/devicetree/bindings/fpga/
 F:	drivers/fpga/
-- 
2.7.4
