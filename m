Return-Path: <SRS0=gN2n=VW=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=gN2n=VW=ettus.com=moritz.fischer@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] MAINTAINERS: Move linux-fpga tree to new location
Date: Thu, 25 Jul 2019 10:45:17 -0700
Message-Id: <20190725174517.10516-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Move the linux-fpga tree to new location at:
 git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 783569e3c4b4..c3b5e3dbc74e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6339,7 +6339,7 @@ FPGA MANAGER FRAMEWORK
 M:	Moritz Fischer <mdf@kernel.org>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
 Q:	http://patchwork.kernel.org/project/linux-fpga/list/
 F:	Documentation/fpga/
 F:	Documentation/driver-api/fpga/
-- 
2.22.0
