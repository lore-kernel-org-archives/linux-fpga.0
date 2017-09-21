Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 1/1] fpga: make xlnx_pr_decoupler_br_ops const
Date: Thu, 21 Sep 2017 09:52:41 -0500
Message-Id: <20170921145241.2869-2-atull@kernel.org>
In-Reply-To: <20170921145241.2869-1-atull@kernel.org>
References: <20170921145241.2869-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Bhumika Goyal <bhumirks@gmail.com>, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

From: Bhumika Goyal <bhumirks@gmail.com>

Make this const as it is only passed to a const argument of the function
fpga_bridge_register.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/xilinx-pr-decoupler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index e359930bebc8..0d7743089414 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -79,7 +79,7 @@ static int xlnx_pr_decoupler_enable_show(struct fpga_bridge *bridge)
 	return !status;
 }
 
-static struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
+static const struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
 	.enable_set = xlnx_pr_decoupler_enable_set,
 	.enable_show = xlnx_pr_decoupler_enable_show,
 };
-- 
2.11.0
