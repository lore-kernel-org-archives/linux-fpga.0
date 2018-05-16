Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 14/14] MAINTAINERS: Add driver-api/fpga path
Date: Wed, 16 May 2018 18:50:07 -0500
Message-Id: <20180516235007.3951-15-atull@kernel.org>
In-Reply-To: <20180516235007.3951-1-atull@kernel.org>
References: <20180516235007.3951-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Add Documentation/driver-api/fpga path to MAINTAINERS file
for fpga.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ce5062..febeecd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5612,6 +5612,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
 Q:	http://patchwork.kernel.org/project/linux-fpga/list/
 F:	Documentation/fpga/
+F:	Documentation/driver-api/fpga/
 F:	Documentation/devicetree/bindings/fpga/
 F:	drivers/fpga/
 F:	include/linux/fpga/
-- 
2.7.4
