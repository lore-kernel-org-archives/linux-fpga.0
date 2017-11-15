Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v2 5/5] fpga: region: return NOTIFY_STOP if overlay shoud be accepted
Date: Wed, 15 Nov 2017 14:51:52 -0600
Message-Id: <1510779112-5517-6-git-send-email-atull@kernel.org>
In-Reply-To: <1510779112-5517-1-git-send-email-atull@kernel.org>
References: <1510779112-5517-1-git-send-email-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Recent changes to the Device Tree overlay notifier code have changed
how notifier return codes are interpreted, requiring a NOTIFY_STOP to
signal that the overlay should be accepted.  This commit makes the
appropriate change to the FPGA region's Device Tree overlay notifier.

Fixes: 24789c5ce5a3 ("of: overlay: detect cases where device tree may become corrupt")
Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: Added in v2 of this patchset.  Tested on linux-next/master.
---
 drivers/fpga/of-fpga-region.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 276ffe2..a0c13cb 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -349,7 +349,8 @@ static void of_fpga_region_notify_post_remove(struct fpga_region *region,
  * This notifier handles programming a FPGA when a "firmware-name" property is
  * added to a fpga-region.
  *
- * Returns NOTIFY_OK or error if FPGA programming fails.
+ * Returns NOTIFY_OK if this notification isn't about this region or
+ * NOTIFY_STOP if the overaly is to be accepted or error if FPGA programming fails.
  */
 static int of_fpga_region_notify(struct notifier_block *nb,
 				 unsigned long action, void *arg)
@@ -395,7 +396,7 @@ static int of_fpga_region_notify(struct notifier_block *nb,
 	if (ret)
 		return notifier_from_errno(ret);
 
-	return NOTIFY_OK;
+	return NOTIFY_STOP;
 }
 
 static struct notifier_block fpga_region_of_nb = {
-- 
2.7.4
