Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 2/3] fpga: fpga-bridge: remove unnecessary null check in of_fpga_bridge_get
Date: Wed, 15 Nov 2017 16:33:11 -0600
Message-Id: <1510785192-10123-3-git-send-email-atull@kernel.org>
In-Reply-To: <1510785192-10123-1-git-send-email-atull@kernel.org>
References: <1510785192-10123-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-ID: <linux-fpga@vger.kernel.org>

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>

Notice that bridge = to_fpga_bridge(dev); expands to:

bridge = container_of(dev, struct fpga_bridge, dev);

and container_of is never null, so this null check is
unnecessary.

Addresses-Coverity-ID: 1397912
Reported-by: Alan Tull <atull@kernel.org>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/fpga-bridge.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 4c48dd6..038b10b 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -78,8 +78,6 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
 	int ret = -ENODEV;
 
 	bridge = to_fpga_bridge(dev);
-	if (!bridge)
-		goto err_dev;
 
 	bridge->info = info;
 
-- 
2.7.4
