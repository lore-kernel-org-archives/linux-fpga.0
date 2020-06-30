Return-Path: <SRS0=WJZw=AL=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=WJZw=AL=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25770 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726119AbgF3SuD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 30 Jun 2020 14:50:03 -0400
Received: by mail-qv1-f69.google.com with SMTP id em19so8731157qvb.14
        for <linux-fpga@vger.kernel.org>; Tue, 30 Jun 2020 11:50:00 -0700 (PDT)
From: trix@redhat.com
Subject: [RFC v2] fpga: dfl: RFC PCI config
Date: Tue, 30 Jun 2020 11:49:50 -0700
Message-Id: <20200630184950.950-1-trix@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net
Cc: linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>

From: Tom Rix <trix@redhat.com>

Create some top level configs the map to dfl pci cards.

Autoselect the parts of fpga that are needed to run these cards
as well as the defining the other subsystem dependencies.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 v1 change subsystem selects to depends

 Documentation/fpga/dfl.rst | 30 ++++++++++++++++++++++++++++++
 drivers/fpga/Kconfig       | 27 +++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index d7648d7c7eee..c1ae6b539f08 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -500,6 +500,36 @@ Developer only needs to provide a sub feature driver with matched feature id.
 FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
 could be a reference.
 
+Kernel configuration
+====================
+
+While it is possible to manually setup a configuration to match your device,
+there are some top level configurations that collect configurations for
+some reference PCI cards.  Below describes these configuration as well as
+what other kernel configs are needed for proper configuration.
+
+FPGA_DFL_PAC10
+Intel Arria 10 GX PCI card, PCI id 0X09C4
+Depends on
+  SPI_ALTERA
+  MFD_INTEL_M10_BMC
+  SENSORS_INTEL_M10_BMC_HWMON
+
+FPGA_DFL_D5005
+Intel Stratix 10, D5005 PCI card, PCI id 0X0B2B
+Depends on
+  SPI_ALTERA
+  MFD_INTEL_M10_BMC
+  SENSORS_INTEL_M10_BMC_HWMON
+  INTEL_S10_PHY
+
+FPGA_DFL_N3000
+Intel Network Accelerator, N3000 PCI card, PCI id 0X0B30
+Depends on
+  SPI_ALTERA
+  MFD_INTEL_M10_BMC
+  SENSORS_INTEL_M10_BMC_HWMON
+  INTEL_LL_10G_MAC
 
 Open discussion
 ===============
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 9d53bd9094e2..96603b1f6ff5 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -138,6 +138,33 @@ config OF_FPGA_REGION
 	  Support for loading FPGA images by applying a Device Tree
 	  overlay.
 
+config FPGA_DFL_PAC10
+	tristate "Intel Arria 10 GX PCI card"
+	depends on SPI_ALTERA
+	depends on SENSORS_INTEL_M10_BMC_HWMON
+	depends on MFD_INTEL_M10_BMC
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
+	depends on INTEL_S10_PHY
+	select FPGA_DFL_PAC10
+	select FPGA_DFl_HSSI
+
+config FPGA_DFL_N3000
+	tristate "Intel Network Accelerator, N3000 PCI card"
+	depends on INTEL_LL_10G_MAC
+	select FPGA_DFL_PAC10
+	select FPGA_DFL_N3000_NIOS
+
 config FPGA_DFL
 	tristate "FPGA Device Feature List (DFL) support"
 	select FPGA_BRIDGE
-- 
2.18.1
