Return-Path: <moritz.fischer@ettus.com>
Return-Path: <moritz.fischer@ettus.com>
From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: [PATCH 1/2] MAINTAINERS: Update fpga-mgr entry with new linux-fpga mailing list
Date: Mon, 21 Nov 2016 13:49:01 -0800
Message-Id: <1479764942-14321-1-git-send-email-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: marex@denx.de, mbrugger@suse.com, jgunthorpe@obsidianresearch.com, mike.looijmans@topic.nl, michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org, Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@opensource.altera.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <monstr@monstr.eu>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, "David S . Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Andrew Morton <akpm@linux-foundation.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Update the fpga-mgr framework entry with new linux-fpga@vger.kernel.org
mailing list.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@opensource.altera.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Hi all,

Alan & me have been talking about this during Plumbers, so I went ahead
and worked on getting it all set up.

The list is now up and running & you can sign up if you're interested,
we'll be using it in parallel to LKML in the beginning I think.

I'm currently working on getting a list archive setup over at marc.info.

If you have comments or suggestions on alternatives, send me an email.

Cheers,

Moritz
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e25ba1..19527a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5005,6 +5005,7 @@ K:	fmc_d.*register
 FPGA MANAGER FRAMEWORK
 M:	Alan Tull <atull@opensource.altera.com>
 R:	Moritz Fischer <moritz.fischer@ettus.com>
+L:	linux-fpga@vger.kernel.org
 S:	Maintained
 F:	drivers/fpga/
 F:	include/linux/fpga/fpga-mgr.h
-- 
2.7.4
