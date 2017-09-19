Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH] MAINTAINERS: add backup maintainer
Date: Tue, 19 Sep 2017 18:25:06 -0500
Message-Id: <20170919232506.2986-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Add Moritz as a maintainer of the kernel FPGA framework.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b87c6989e82d..2d3d855ee6e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5441,7 +5441,7 @@ K:	fmc_d.*register
 
 FPGA MANAGER FRAMEWORK
 M:	Alan Tull <atull@kernel.org>
-R:	Moritz Fischer <mdf@kernel.org>
+M:	Moritz Fischer <mdf@kernel.org>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
-- 
2.11.0
