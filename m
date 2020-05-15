Return-Path: <SRS0=R7Bo=65=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=R7Bo=65=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv2] fpga: stratix10-soc: remove the pre-set reconfiguration condition
Date: Fri, 15 May 2020 09:35:03 -0500
Message-Id: <1589553303-7341-1-git-send-email-richard.gong@linux.intel.com>
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
v2: define and use constant values
---
 drivers/fpga/stratix10-soc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 44b7c56..4d52a80 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -14,9 +14,13 @@
 /*
  * FPGA programming requires a higher level of privilege (EL3), per the SoC
  * design.
+ * SoC firmware supports full and partial reconfiguration.
  */
 #define NUM_SVC_BUFS	4
 #define SVC_BUF_SIZE	SZ_512K
+#define FULL_RECONFIG_FLAG	0
+#define PARTIAL_RECONFIG_FLAG	1
+
 
 /* Indicates buffer is in use if set */
 #define SVC_BUF_LOCK	0
@@ -182,12 +186,12 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	uint i;
 	int ret;
 
-	ctype.flags = 0;
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
 		dev_dbg(dev, "Requesting partial reconfiguration.\n");
-		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
+		ctype.flags = PARTIAL_RECONFIG_FLAG;
 	} else {
 		dev_dbg(dev, "Requesting full reconfiguration.\n");
+		ctype.flags = FULL_RECONFIG_FLAG;
 	}
 
 	reinit_completion(&priv->status_return_completion);
@@ -210,6 +214,7 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 
 	ret = 0;
 	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
+		dev_err(dev, "RECONFIG_REQUEST failed\n");
 		ret = -ETIMEDOUT;
 		goto init_done;
 	}
-- 
2.7.4
