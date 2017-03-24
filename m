Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 1/8] fpga: altera_freeze_bridge: Constify ops
Date: Thu, 23 Mar 2017 19:34:24 -0500
Message-Id: <1490315671-5076-2-git-send-email-atull@kernel.org>
In-Reply-To: <1490315671-5076-1-git-send-email-atull@kernel.org>
References: <1490315671-5076-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

From: Moritz Fischer <mdf@kernel.org>

The ops are not changing, make them const.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fpga@vger.kernel.org
Acked-by: Alan Tull <atull@kernel.org>
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
