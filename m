Return-Path: <SRS0=dz0a=TH=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=dz0a=TH=ettus.com=moritz.fischer@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] fpga: zynqmp-fpga: Correctly handle error pointer
Date: Tue,  7 May 2019 10:02:57 -0700
Message-Id: <20190507170257.25451-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-fpga@vger.kernel.org
Cc: atull@kernel.org, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org, Moritz Fischer <mdf@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-ID: <linux-fpga@vger.kernel.org>

Fixes the following static checker error:

drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
error: 'eemi_ops' dereferencing possible ERR_PTR()

Note: This does not handle the EPROBE_DEFER value in a
      special manner.

Fixes commit c09f7471127e ("fpga manager: Adding FPGA Manager support for
Xilinx zynqmp")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/zynqmp-fpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index f7cbaadf49ab..abcb0b2e75bf 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -47,7 +47,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 	char *kbuf;
 	int ret;
 
-	if (!eemi_ops || !eemi_ops->fpga_load)
+	if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_load)
 		return -ENXIO;
 
 	priv = mgr->priv;
-- 
2.21.0
