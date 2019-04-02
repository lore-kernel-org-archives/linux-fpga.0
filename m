Return-Path: <SRS0=CwsY=SE=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=CwsY=SE=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60183 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfDBWQT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 2 Apr 2019 18:16:19 -0400
From: richard.gong@linux.intel.com
Subject: [PATCHv1] fpga: mgr: add FPGA configuration log
Date: Tue,  2 Apr 2019 17:25:43 -0500
Message-Id: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: atull@kernel.org, mdf@kernel.org
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>

From: Richard Gong <richard.gong@intel.com>

Add a log for user to know FPGA configuration is successful

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 drivers/fpga/fpga-mgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index c386681..559e046 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -151,6 +151,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
 	}
 	mgr->state = FPGA_MGR_STATE_OPERATING;
 
+	dev_info(&mgr->dev, "Successfully programming FPGA\n");
 	return 0;
 }
 
-- 
2.7.4
