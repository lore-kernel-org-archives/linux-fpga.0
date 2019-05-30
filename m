Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 1/1] fpga: zynqmp-fpga: Correctly handle error pointer
Date: Thu, 30 May 2019 09:52:59 -0500
Message-Id: <20190530145259.4189-2-atull@kernel.org>
In-Reply-To: <20190530145259.4189-1-atull@kernel.org>
References: <20190530145259.4189-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Moritz Fischer <mdf@kernel.org>

Fixes the following static checker errors:

drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
error: 'eemi_ops' dereferencing possible ERR_PTR()

drivers/fpga/zynqmp-fpga.c:84 zynqmp_fpga_ops_state()
error: 'eemi_ops' dereferencing possible ERR_PTR()

Note: This does not handle the EPROBE_DEFER value in a
      special manner.

Fixes commit c09f7471127e ("fpga manager: Adding FPGA Manager support for
Xilinx zynqmp")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/zynqmp-fpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index f7cbaadf49ab..b8a88d21d038 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -47,7 +47,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 	char *kbuf;
 	int ret;
 
-	if (!eemi_ops || !eemi_ops->fpga_load)
+	if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_load)
 		return -ENXIO;
 
 	priv = mgr->priv;
@@ -81,7 +81,7 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
 	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 	u32 status;
 
-	if (!eemi_ops || !eemi_ops->fpga_get_status)
+	if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_get_status)
 		return FPGA_MGR_STATE_UNKNOWN;
 
 	eemi_ops->fpga_get_status(&status);
-- 
2.21.0
