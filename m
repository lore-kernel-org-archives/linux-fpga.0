Return-Path: <SRS0=gngh=62=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=gngh=62=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv1] fpga: stratix10-soc: remove the pre-set reconfiguration condition
Date: Tue, 12 May 2020 08:27:31 -0500
Message-Id: <1589290051-30246-1-git-send-email-richard.gong@linux.intel.com>
To: mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, dinguyen@kernel.org, richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

The reconfiguration mode is pre-set by driver as the full reconfiguration.
As a result, user have to change code and recompile the drivers if he or
she wants to perform a partial reconfiguration. Removing the pre-set
reconfiguration condition so that user can select full or partial
reconfiguration via overlay device tree without recompiling the drivers.

Also add an error message if the configuration request is failure.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 drivers/fpga/stratix10-soc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 44b7c56..2da8a40 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -182,12 +182,12 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	uint i;
 	int ret;
 
-	ctype.flags = 0;
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
 		dev_dbg(dev, "Requesting partial reconfiguration.\n");
-		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
+		ctype.flags = 1;
 	} else {
 		dev_dbg(dev, "Requesting full reconfiguration.\n");
+		ctype.flags = 0;
 	}
 
 	reinit_completion(&priv->status_return_completion);
@@ -210,6 +210,7 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 
 	ret = 0;
 	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
+		dev_err(dev, "RECONFIG_REQUEST failed\n");
 		ret = -ETIMEDOUT;
 		goto init_done;
 	}
-- 
2.7.4
