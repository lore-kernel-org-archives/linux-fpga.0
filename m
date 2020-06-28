Return-Path: <SRS0=4xwK=AJ=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=4xwK=AJ=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20627 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725965AbgF1PSY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 28 Jun 2020 11:18:24 -0400
Received: by mail-qk1-f200.google.com with SMTP id v16so372887qka.18
        for <linux-fpga@vger.kernel.org>; Sun, 28 Jun 2020 08:18:20 -0700 (PDT)
From: trix@redhat.com
Subject: [PATCH] fpga: dfl: improve configuration of dfl pci devices
Date: Sun, 28 Jun 2020 08:18:13 -0700
Message-Id: <20200628151813.7679-1-trix@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>

From: Tom Rix <trix@redhat.com>

To use a dfl pci device, several dfl configs need to be selected.
This is tedious and error prone.

So automagically select the needed configs when FPGA_DFL_PCI
is selected.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/Kconfig | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 7cd5a29fc437..4b9e05af5426 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -138,6 +138,27 @@ config OF_FPGA_REGION
 	  Support for loading FPGA images by applying a Device Tree
 	  overlay.
 
+config FPGA_DFL_PCI
+	tristate "FPGA DFL PCIe Device Driver"
+	depends on PCI
+	select FPGA_DFL
+	select FPGA_DFL_FME
+	select FPGA_DFL_FME_MGR
+	select FPGA_DFL_FME_BRIDGE
+	select FPGA_DFL_FME_REGION
+	select FPGA_DFL_AFU
+	help
+	  Select this option to enable PCIe driver for PCIe-based
+	  Field-Programmable Gate Array (FPGA) solutions which implement
+	  the Device Feature List (DFL). This driver provides interfaces
+	  for userspace applications to configure, enumerate, open and access
+	  FPGA accelerators on the FPGA DFL devices, enables system level
+	  management functions such as FPGA partial reconfiguration, power
+	  management and virtualization with DFL framework and DFL feature
+	  device drivers.
+
+	  To compile this as a module, choose M here.
+
 config FPGA_DFL
 	tristate "FPGA Device Feature List (DFL) support"
 	select FPGA_BRIDGE
@@ -191,21 +212,6 @@ config FPGA_DFL_AFU
 	  to the FPGA infrastructure via a Port. There may be more than one
 	  Port/AFU per DFL based FPGA device.
 
-config FPGA_DFL_PCI
-	tristate "FPGA DFL PCIe Device Driver"
-	depends on PCI && FPGA_DFL
-	help
-	  Select this option to enable PCIe driver for PCIe-based
-	  Field-Programmable Gate Array (FPGA) solutions which implement
-	  the Device Feature List (DFL). This driver provides interfaces
-	  for userspace applications to configure, enumerate, open and access
-	  FPGA accelerators on the FPGA DFL devices, enables system level
-	  management functions such as FPGA partial reconfiguration, power
-	  management and virtualization with DFL framework and DFL feature
-	  device drivers.
-
-	  To compile this as a module, choose M here.
-
 config FPGA_MGR_ZYNQMP_FPGA
 	tristate "Xilinx ZynqMP FPGA"
 	depends on ZYNQMP_FIRMWARE || (!ZYNQMP_FIRMWARE && COMPILE_TEST)
-- 
2.18.1
