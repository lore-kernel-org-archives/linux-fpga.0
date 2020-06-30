Return-Path: <SRS0=eHqO=AL=redhat.com=trix@kernel.org>
Return-Path: <SRS0=eHqO=AL=redhat.com=trix@kernel.org>
From: trix@redhat.com
Subject: [RFC 1/1] fpga: dfl: RFC PCI config
Date: Tue, 30 Jun 2020 10:16:56 -0700
Message-Id: <20200630171656.20151-2-trix@redhat.com>
In-Reply-To: <20200630171656.20151-1-trix@redhat.com>
References: <20200630171656.20151-1-trix@redhat.com>
Content-Type: text/plain; charset=US-ASCII
To: hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net
Cc: linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Tom Rix <trix@redhat.com>

Create some top level configs the map to dfl pci cards.

Autoselect the parts of fpga that are needed to run these cards
as well as the other subsystem configs to the card's subdevices.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 Documentation/fpga/dfl.rst | 33 +++++++++++++++++++++++++++++++++
 drivers/fpga/Kconfig       | 28 ++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index d7648d7c7eee..3a872bc8e3d3 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -500,6 +500,39 @@ Developer only needs to provide a sub feature driver with matched feature id.
 FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
 could be a reference.
 
+Kernel configuration
+====================
+
+While it is possible to manually setup a configuration to match your device,
+there are some top level configurations that collect configuations for
+some reference pci cards.  Below descibes these configuration as well as
+what other kernel configs are needed for proper configuration.
+
+FPGA_DFL_PAC10
+Intel Arria 10 GX PCI card, PCI id 0X09C4
+Depends on
+  SPI_ALTERA
+  MFD_INTEL_M10_BMC
+  MFD_INTEL_M10_BMC_SECURE
+  SENSORS_INTEL_M10_BMC_HWMON
+
+FPGA_DFL_D5005
+Intel Stratix 10, D5005 PCI card, PCI id 0X0B2B
+Depends on
+  SPI_ALTERA
+  MFD_INTEL_M10_BMC
+  MFD_INTEL_M10_BMC_SECURE
+  SENSORS_INTEL_M10_BMC_HWMON
+  INTEL_S10_PHY
+
+FPGA_DFL_N3000
+Intel Network Accelerator, N3000 PCI card, PCI id 0X0B30
+Depends on
+  SPI_ALTERA
+  MFD_INTEL_M10_BMC
+  MFD_INTEL_M10_BMC_SECURE
+  SENSORS_INTEL_M10_BMC_HWMON
+  INTEL_LL_10G_MAC
 
 Open discussion
 ===============
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 9d53bd9094e2..b657de20bc98 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -138,6 +138,34 @@ config OF_FPGA_REGION
 	  Support for loading FPGA images by applying a Device Tree
 	  overlay.
 
+config FPGA_DFL_PAC10
+	tristate "Intel Arria 10 GX PCI card"
+	select SPI_ALTERA
+	select MFD_INTEL_M10_BMC
+	select MFD_INTEL_M10_BMC_SECURE
+	select SENSORS_INTEL_M10_BMC_HWMON
+	select FPGA_DFL
+	select FPGA_DFL_FME
+	select FPGA_DFL_FME_MGR
+	select FPGA_DFL_FME_BRIDGE
+	select FPGA_DFL_FME_REGION
+	select FPGA_DFL_AFU
+	select FPGA_DFL_SPI_ALTERA
+	select FPGA_DFL_PCI
+	select IFPGA_SEC_MGR
+
+config FPGA_DFL_D5005
+	tristate "Intel Stratix 10, D5005 PCI card"
+	select FPGA_DFL_PAC10
+	select INTEL_S10_PHY
+	select FPGA_DFl_HSSI
+
+config FPGA_DFL_N3000
+	tristate "Intel Network Accelerator, N3000 PCI card"
+	select FPGA_DFL_PAC10
+	select INTEL_LL_10G_MAC
+	select FPGA_DFL_N3000_NIOS
+
 config FPGA_DFL
 	tristate "FPGA Device Feature List (DFL) support"
 	select FPGA_BRIDGE
-- 
2.18.1
