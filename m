Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH] fpga: stratix10-soc: fix wrong of_node_put() in init function
Date: Sat, 26 Jan 2019 10:38:29 -0600
Message-Id: <20190126163829.4998-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
List-ID: <linux-fpga@vger.kernel.org>

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

After finding a "firmware" dt node stratix10 tries to match it's
compatible string with it. To do so it's calling of_find_matching_node()
which already takes care of decreasing the refcount on the "firmware"
node. We are then incorrectly decreasing the refcount on that node
again.

This patch removes the unwarranted call to of_node_put().

Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
[atull: remove unnecessary braces]
---
 drivers/fpga/stratix10-soc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index a1a09e04fab8..13851b3d1c56 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -508,14 +508,11 @@ static int __init s10_init(void)
 		return -ENODEV;
 
 	np = of_find_matching_node(fw_np, s10_of_match);
-	if (!np) {
-		of_node_put(fw_np);
+	if (!np)
 		return -ENODEV;
-	}
 
 	of_node_put(np);
 	ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
-	of_node_put(fw_np);
 	if (ret)
 		return ret;
 
-- 
2.20.1
