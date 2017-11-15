Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v6 17/18] fpga: clean up fpga Kconfig
Date: Wed, 15 Nov 2017 14:20:27 -0600
Message-Id: <1510777228-4291-18-git-send-email-atull@kernel.org>
In-Reply-To: <1510777228-4291-1-git-send-email-atull@kernel.org>
References: <1510777228-4291-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The fpga menuconfig has gotten messy.  The bridges and managers are
mixed together.

* Separate the bridges and things dependent on CONFIG_FPGA_BRIDGE
  from the managers.
* Group the managers by vendor in order that they were added
  to the kernel.

The following is what the menuconfig ends up looking like more or less
(platform dependencies are hiding some of these on any given
platform).

    --- FPGA Configuration Framework
    <*>   Altera SOCFPGA FPGA Manager
    <*>   Altera SoCFPGA Arria10
    <*>   Altera Partial Reconfiguration IP Core
    <*>     Platform support of Altera Partial Reconfiguration IP Core
    <*>   Altera FPGA Passive Serial over SPI
    <*>   Altera Arria-V/Cyclone-V/Stratix-V CvP FPGA Manager
    <*>   Xilinx Zynq FPGA
    <*>   Xilinx Configuration over Slave Serial (SPI)
    <*>   Lattice iCE40 SPI
    <*>   Technologic Systems TS-73xx SBC FPGA Manager
    <*>   FPGA Bridge Framework
    <*>     Altera SoCFPGA FPGA Bridges
    <*>     Altera FPGA Freeze Bridge
    <*>     Xilinx LogiCORE PR Decoupler
    <*>     FPGA Region
    <*>       FPGA Region Device Tree Overlay Support

Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v4: Patch added to patchset in v4
v5: s/mixxed/mixed/
v6: Add Moritz' ack
---
 drivers/fpga/Kconfig | 108 +++++++++++++++++++++++++--------------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 12bd1c7..f47ef84 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -11,33 +11,30 @@ menuconfig FPGA
 
 if FPGA
 
-config FPGA_REGION
-	tristate "FPGA Region"
-	depends on FPGA_BRIDGE
+config FPGA_MGR_SOCFPGA
+	tristate "Altera SOCFPGA FPGA Manager"
+	depends on ARCH_SOCFPGA || COMPILE_TEST
 	help
-	  FPGA Region common code.  A FPGA Region controls a FPGA Manager
-	  and the FPGA Bridges associated with either a reconfigurable
-	  region of an FPGA or a whole FPGA.
+	  FPGA manager driver support for Altera SOCFPGA.
 
-config OF_FPGA_REGION
-	tristate "FPGA Region Device Tree Overlay Support"
-	depends on OF && FPGA_REGION
+config FPGA_MGR_SOCFPGA_A10
+	tristate "Altera SoCFPGA Arria10"
+	depends on ARCH_SOCFPGA || COMPILE_TEST
+	select REGMAP_MMIO
 	help
-	  Support for loading FPGA images by applying a Device Tree
-	  overlay.
+	  FPGA manager driver support for Altera Arria10 SoCFPGA.
 
-config FPGA_MGR_ICE40_SPI
-	tristate "Lattice iCE40 SPI"
-	depends on OF && SPI
-	help
-	  FPGA manager driver support for Lattice iCE40 FPGAs over SPI.
+config ALTERA_PR_IP_CORE
+        tristate "Altera Partial Reconfiguration IP Core"
+        help
+          Core driver support for Altera Partial Reconfiguration IP component
 
-config FPGA_MGR_ALTERA_CVP
-	tristate "Altera Arria-V/Cyclone-V/Stratix-V CvP FPGA Manager"
-	depends on PCI
+config ALTERA_PR_IP_CORE_PLAT
+	tristate "Platform support of Altera Partial Reconfiguration IP Core"
+	depends on ALTERA_PR_IP_CORE && OF && HAS_IOMEM
 	help
-	  FPGA manager driver support for Arria-V, Cyclone-V, Stratix-V
-	  and Arria 10 Altera FPGAs using the CvP interface over PCIe.
+	  Platform driver support for Altera Partial Reconfiguration IP
+	  component
 
 config FPGA_MGR_ALTERA_PS_SPI
 	tristate "Altera FPGA Passive Serial over SPI"
@@ -46,25 +43,19 @@ config FPGA_MGR_ALTERA_PS_SPI
 	  FPGA manager driver support for Altera Arria/Cyclone/Stratix
 	  using the passive serial interface over SPI.
 
-config FPGA_MGR_SOCFPGA
-	tristate "Altera SOCFPGA FPGA Manager"
-	depends on ARCH_SOCFPGA || COMPILE_TEST
-	help
-	  FPGA manager driver support for Altera SOCFPGA.
-
-config FPGA_MGR_SOCFPGA_A10
-	tristate "Altera SoCFPGA Arria10"
-	depends on ARCH_SOCFPGA || COMPILE_TEST
-	select REGMAP_MMIO
+config FPGA_MGR_ALTERA_CVP
+	tristate "Altera Arria-V/Cyclone-V/Stratix-V CvP FPGA Manager"
+	depends on PCI
 	help
-	  FPGA manager driver support for Altera Arria10 SoCFPGA.
+	  FPGA manager driver support for Arria-V, Cyclone-V, Stratix-V
+	  and Arria 10 Altera FPGAs using the CvP interface over PCIe.
 
-config FPGA_MGR_TS73XX
-	tristate "Technologic Systems TS-73xx SBC FPGA Manager"
-	depends on ARCH_EP93XX && MACH_TS72XX
+config FPGA_MGR_ZYNQ_FPGA
+	tristate "Xilinx Zynq FPGA"
+	depends on ARCH_ZYNQ || COMPILE_TEST
+	depends on HAS_DMA
 	help
-	  FPGA manager driver support for the Altera Cyclone II FPGA
-	  present on the TS-73xx SBC boards.
+	  FPGA manager driver support for Xilinx Zynq FPGAs.
 
 config FPGA_MGR_XILINX_SPI
 	tristate "Xilinx Configuration over Slave Serial (SPI)"
@@ -73,12 +64,18 @@ config FPGA_MGR_XILINX_SPI
 	  FPGA manager driver support for Xilinx FPGA configuration
 	  over slave serial interface.
 
-config FPGA_MGR_ZYNQ_FPGA
-	tristate "Xilinx Zynq FPGA"
-	depends on ARCH_ZYNQ || COMPILE_TEST
-	depends on HAS_DMA
+config FPGA_MGR_ICE40_SPI
+	tristate "Lattice iCE40 SPI"
+	depends on OF && SPI
 	help
-	  FPGA manager driver support for Xilinx Zynq FPGAs.
+	  FPGA manager driver support for Lattice iCE40 FPGAs over SPI.
+
+config FPGA_MGR_TS73XX
+	tristate "Technologic Systems TS-73xx SBC FPGA Manager"
+	depends on ARCH_EP93XX && MACH_TS72XX
+	help
+	  FPGA manager driver support for the Altera Cyclone II FPGA
+	  present on the TS-73xx SBC boards.
 
 config FPGA_BRIDGE
 	tristate "FPGA Bridge Framework"
@@ -102,18 +99,6 @@ config ALTERA_FREEZE_BRIDGE
 	  isolate one region of the FPGA from the busses while that
 	  region is being reprogrammed.
 
-config ALTERA_PR_IP_CORE
-        tristate "Altera Partial Reconfiguration IP Core"
-        help
-          Core driver support for Altera Partial Reconfiguration IP component
-
-config ALTERA_PR_IP_CORE_PLAT
-	tristate "Platform support of Altera Partial Reconfiguration IP Core"
-	depends on ALTERA_PR_IP_CORE && OF && HAS_IOMEM
-	help
-	  Platform driver support for Altera Partial Reconfiguration IP
-	  component
-
 config XILINX_PR_DECOUPLER
 	tristate "Xilinx LogiCORE PR Decoupler"
 	depends on FPGA_BRIDGE
@@ -124,4 +109,19 @@ config XILINX_PR_DECOUPLER
 	  region of the FPGA from the busses while that region is
 	  being reprogrammed during partial reconfig.
 
+config FPGA_REGION
+	tristate "FPGA Region"
+	depends on FPGA_BRIDGE
+	help
+	  FPGA Region common code.  A FPGA Region controls a FPGA Manager
+	  and the FPGA Bridges associated with either a reconfigurable
+	  region of an FPGA or a whole FPGA.
+
+config OF_FPGA_REGION
+	tristate "FPGA Region Device Tree Overlay Support"
+	depends on OF && FPGA_REGION
+	help
+	  Support for loading FPGA images by applying a Device Tree
+	  overlay.
+
 endif # FPGA
-- 
2.7.4
