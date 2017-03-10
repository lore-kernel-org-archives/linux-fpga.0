Return-Path: <mdf@kernel.org>
Return-Path: <mdf@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] fpga: bridge: Replace open-coded list_for_each + list_entry
Date: Fri, 10 Mar 2017 12:47:11 -0800
Message-Id: <1489178831-17934-1-git-send-email-mdf@kernel.org>
To: linux-fpga@vger.kernel.org
Cc: moritz.fischer@ettus.com, gregkh@linuxfoundation.org, Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Replaces open-coded list_for_each() + list_entry() with macro
list_for_each_entry()

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>
Cc: linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/fpga/fpga-bridge.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 33ee83e..cfacd2e 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -146,11 +146,9 @@ EXPORT_SYMBOL_GPL(fpga_bridge_put);
 int fpga_bridges_enable(struct list_head *bridge_list)
 {
 	struct fpga_bridge *bridge;
-	struct list_head *node;
 	int ret;
 
-	list_for_each(node, bridge_list) {
-		bridge = list_entry(node, struct fpga_bridge, node);
+	list_for_each_entry(bridge, bridge_list, node) {
 		ret = fpga_bridge_enable(bridge);
 		if (ret)
 			return ret;
@@ -172,11 +170,9 @@ EXPORT_SYMBOL_GPL(fpga_bridges_enable);
 int fpga_bridges_disable(struct list_head *bridge_list)
 {
 	struct fpga_bridge *bridge;
-	struct list_head *node;
 	int ret;
 
-	list_for_each(node, bridge_list) {
-		bridge = list_entry(node, struct fpga_bridge, node);
+	list_for_each_entry(bridge, bridge_list, node) {
 		ret = fpga_bridge_disable(bridge);
 		if (ret)
 			return ret;
@@ -196,13 +192,10 @@ EXPORT_SYMBOL_GPL(fpga_bridges_disable);
  */
 void fpga_bridges_put(struct list_head *bridge_list)
 {
-	struct fpga_bridge *bridge;
-	struct list_head *node, *next;
+	struct fpga_bridge *bridge, *next;
 	unsigned long flags;
 
-	list_for_each_safe(node, next, bridge_list) {
-		bridge = list_entry(node, struct fpga_bridge, node);
-
+	list_for_each_entry_safe(bridge, next, bridge_list, node) {
 		fpga_bridge_put(bridge);
 
 		spin_lock_irqsave(&bridge_list_lock, flags);
-- 
2.7.4
