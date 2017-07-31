Return-Path: <SRS0=+i6n=7C=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=+i6n=7C=ettus.com=moritz.fischer@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2] MAINTAINERS: fpga: Update email and add patchwork URL
Date: Mon, 31 Jul 2017 09:55:30 -0700
Message-Id: <1501520130-24707-1-git-send-email-mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: chehab@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Add Q: entry for patchwork and update my email address.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-By: Alan Tull <atull@kernel.org>
Cc: Alan Tull <atull@kernel.org>
Cc: linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Changes from v1:
- Don't mess up the email address

---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f42daf7..8f90a3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5213,10 +5213,11 @@ K:	fmc_d.*register
 
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
