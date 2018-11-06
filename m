Return-Path: <SRS0=Jnos=NR=denx.de=agust@kernel.org>
Return-Path: <SRS0=Jnos=NR=denx.de=agust@kernel.org>
From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH] fpga: altera-cvp: output expected CvP VSE_PCIE_EXT_CAP_ID in error case
Date: Tue,  6 Nov 2018 22:58:38 +0100
Message-Id: <20181106215838.5212-1-agust@denx.de>
To: linux-fpga@vger.kernel.org
Cc: atull@kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Output VSE_PCIE_EXT_CAP_ID register address and expected register
value in error message to give more info when analyzing issues
with loaded periphery image.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/fpga/altera-cvp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 381d0c42450f..08c0080092da 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -413,7 +413,10 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	 */
 	pci_read_config_word(pdev, VSE_PCIE_EXT_CAP_ID, &val);
 	if (val != VSE_PCIE_EXT_CAP_ID_VAL) {
-		dev_err(&pdev->dev, "Wrong EXT_CAP_ID value 0x%x\n", val);
+		dev_err(&pdev->dev,
+			"Wrong VSE_PCIE_EXT_CAP_ID value 0x%04x at 0x%x, "
+			"expected: 0x%04x\n",
+			val, VSE_PCIE_EXT_CAP_ID, VSE_PCIE_EXT_CAP_ID_VAL);
 		return -ENODEV;
 	}
 
-- 
2.17.1
