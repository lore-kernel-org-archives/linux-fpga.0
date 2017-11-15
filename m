Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v6 05/18] fpga: region: remove unneeded of_node_get and put
Date: Wed, 15 Nov 2017 14:20:15 -0600
Message-Id: <1510777228-4291-6-git-send-email-atull@kernel.org>
In-Reply-To: <1510777228-4291-1-git-send-email-atull@kernel.org>
References: <1510777228-4291-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Remove of_node_get/put in fpga_region_get/put.  Not
needed and will get in the way when I separate out
the common FPGA region code from Device Tree support
code.

Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v2: split out from another patch
v3: Add Moritz' ack
v4: no change to this patch in this version of patchset
v5: no change to this patch in this version of patchset
v6: no change to this patch in this version of patchset
---
 drivers/fpga/fpga-region.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 6b4f9ab..352661f 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -94,9 +94,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
 	}
 
 	get_device(dev);
-	of_node_get(dev->of_node);
 	if (!try_module_get(dev->parent->driver->owner)) {
-		of_node_put(dev->of_node);
 		put_device(dev);
 		mutex_unlock(&region->mutex);
 		return ERR_PTR(-ENODEV);
@@ -119,7 +117,6 @@ static void fpga_region_put(struct fpga_region *region)
 	dev_dbg(dev, "put\n");
 
 	module_put(dev->parent->driver->owner);
-	of_node_put(dev->of_node);
 	put_device(dev);
 	mutex_unlock(&region->mutex);
 }
-- 
2.7.4
