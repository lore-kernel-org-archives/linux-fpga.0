Return-Path: <mdf@kernel.org>
Return-Path: <mdf@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] fpga: altera_freeze_bridge: Constify ops
Date: Fri, 17 Mar 2017 13:15:32 -0700
Message-Id: <1489781732-31518-1-git-send-email-mdf@kernel.org>
To: linux-fpga@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The ops are not changing, make them const.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fpga@vger.kernel.org
---
 drivers/fpga/altera-freeze-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
index 8dcd9fb..8c1bc7e 100644
--- a/drivers/fpga/altera-freeze-bridge.c
+++ b/drivers/fpga/altera-freeze-bridge.c
@@ -203,7 +203,7 @@ static int altera_freeze_br_enable_show(struct fpga_bridge *bridge)
 	return priv->enable;
 }
 
-static struct fpga_bridge_ops altera_freeze_br_br_ops = {
+static const struct fpga_bridge_ops altera_freeze_br_br_ops = {
 	.enable_set = altera_freeze_br_enable_set,
 	.enable_show = altera_freeze_br_enable_show,
 };
-- 
2.7.4
