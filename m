Return-Path: <SRS0=iI+h=6T=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=iI+h=6T=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:35415 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgEEOA6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 5 May 2020 10:00:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] fpga: zynqmp: fix modular build
Date: Tue,  5 May 2020 16:00:11 +0200
Message-Id: <20200505140041.231844-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <mdf@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rajan Vaja <rajan.vaja@xilinx.com>, Jolly Shah <jolly.shah@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org

Two symbols need to be exported to allow the zynqmp-fpga module
to get loaded dynamically:

ERROR: modpost: "zynqmp_pm_fpga_load" [drivers/fpga/zynqmp-fpga.ko] undefined!
ERROR: modpost: "zynqmp_pm_fpga_get_status" [drivers/fpga/zynqmp-fpga.ko] undefined!

To ensure this is done correctly, also fix the Kconfig dependency
to only allow building the fpga driver when the firmware driver is
either disabled, or when it is reachable. With that, the dependency
on the SoC itself can be removed, and there are no surprises when
the fpga driver is built-in but the firmware a module.

Fixes: 4db8180ffe7c ("firmware: xilinx: Remove eemi ops for fpga related APIs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/fpga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index b2408a710662..7cd5a29fc437 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -208,7 +208,7 @@ config FPGA_DFL_PCI
 
 config FPGA_MGR_ZYNQMP_FPGA
 	tristate "Xilinx ZynqMP FPGA"
-	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on ZYNQMP_FIRMWARE || (!ZYNQMP_FIRMWARE && COMPILE_TEST)
 	help
 	  FPGA manager driver support for Xilinx ZynqMP FPGAs.
 	  This driver uses the processor configuration port(PCAP)
-- 
2.26.0
