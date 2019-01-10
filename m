Return-Path: <SRS0=PsL9=PS=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=PsL9=PS=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbfAJXGg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jan 2019 18:06:36 -0500
From: Alan Tull <atull@kernel.org>
Subject: [PATCH] fpga: altera_freeze_bridge: remove restriction to socfpga
Date: Thu, 10 Jan 2019 17:06:26 -0600
Message-Id: <20190110230626.4130-1-atull@kernel.org>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <mdf@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org

The Altera Freeze Bridge should not be restricted to ARCH_SOCFPGA
since it can be used on other platforms such as Stratix10.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 0bb7b5c..0bdbd3d 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -104,7 +104,7 @@ config SOCFPGA_FPGA_BRIDGE
 
 config ALTERA_FREEZE_BRIDGE
 	tristate "Altera FPGA Freeze Bridge"
-	depends on ARCH_SOCFPGA && FPGA_BRIDGE
+	depends on FPGA_BRIDGE
 	help
 	  Say Y to enable drivers for Altera FPGA Freeze bridges.  A
 	  freeze bridge is a bridge that exists in the FPGA fabric to
-- 
2.7.4
