Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 1/5] fpga: Convert to using %pOF instead of full_name
Date: Tue,  1 Aug 2017 21:20:51 -0500
Message-Id: <1501640455-2719-2-git-send-email-atull@kernel.org>
In-Reply-To: <1501640455-2719-1-git-send-email-atull@kernel.org>
References: <1501640455-2719-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Rob Herring <robh@kernel.org>, Moritz Fischer <moritz.fischer@ettus.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Rob Herring <robh@kernel.org>

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <moritz.fischer@ettus.com>
Cc: linux-fpga@vger.kernel.org
Acked-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/fpga-region.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 3b6b2f4..d9ab7c7 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -319,8 +319,8 @@ static int child_regions_with_firmware(struct device_node *overlay)
 	of_node_put(child_region);
 
 	if (ret)
-		pr_err("firmware-name not allowed in child FPGA region: %s",
-		       child_region->full_name);
+		pr_err("firmware-name not allowed in child FPGA region: %pOF",
+		       child_region);
 
 	return ret;
 }
-- 
2.7.4
