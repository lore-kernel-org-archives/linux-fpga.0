Return-Path: <SRS0=10uA=AY=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=10uA=AY=intel.com=yilun.xu@kernel.org>
From: Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Date: Mon, 13 Jul 2020 09:47:46 +0800
Message-Id: <1594604866-30877-1-git-send-email-yilun.xu@intel.com>
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com, Wu Hao <hao.wu@intel.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, Russ Weight <russell.h.weight@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

Add PCIe Device ID for Intel FPGA PAC N3000.

Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Wu Hao <hao.wu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/dfl-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 73b5153..e220bec 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
 #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
 #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
 #define PCIE_DEVICE_ID_PF_DSC_1_X	0x09C4
+#define PCIE_DEVICE_ID_INTEL_PAC_N3000	0x0B30
 /* VF Device */
 #define PCIE_DEVICE_ID_VF_INT_5_X	0xBCBF
 #define PCIE_DEVICE_ID_VF_INT_6_X	0xBCC1
@@ -76,6 +77,7 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_INT_6_X),},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_DSC_1_X),},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_DSC_1_X),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_N3000),},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
-- 
2.7.4
