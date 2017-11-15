Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 1/3] fpga: fpga-mgr: remove unnecessary code in __fpga_mgr_get
Date: Wed, 15 Nov 2017 16:33:10 -0600
Message-Id: <1510785192-10123-2-git-send-email-atull@kernel.org>
In-Reply-To: <1510785192-10123-1-git-send-email-atull@kernel.org>
References: <1510785192-10123-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-ID: <linux-fpga@vger.kernel.org>

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>

Notice that mgr = to_fpga_manager(dev); expands to:

mgr = container_of(dev, struct fpga_manager, dev);

and container_of is never null, so this null check is
unnecessary.

Addresses-Coverity-ID: 1397916
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/fpga-mgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 1fd5494..0b7664d 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -412,8 +412,6 @@ static struct fpga_manager *__fpga_mgr_get(struct device *dev)
 	struct fpga_manager *mgr;
 
 	mgr = to_fpga_manager(dev);
-	if (!mgr)
-		goto err_dev;
 
 	if (!try_module_get(dev->parent->driver->owner))
 		goto err_dev;
-- 
2.7.4
