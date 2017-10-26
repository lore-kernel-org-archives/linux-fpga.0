Return-Path: <SRS0=BGzE=BZ=embeddedor.com=garsilva@kernel.org>
Return-Path: <SRS0=BGzE=BZ=embeddedor.com=garsilva@kernel.org>
Date: Thu, 26 Oct 2017 18:02:30 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] fpga: fpga-mgr: remove unnecessary code in __fpga_mgr_get
Message-ID: <20171026230230.GA4904@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-ID: <linux-fpga@vger.kernel.org>

Notice that mgr = to_fpga_manager(dev); expands to:

mgr = container_of(dev, struct fpga_manager, dev);

and container_of is never null, so this null check is
unnecessary.

Addresses-Coverity-ID: 1397916
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/fpga/fpga-mgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 188ffef..33063ca 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -367,8 +367,6 @@ static struct fpga_manager *__fpga_mgr_get(struct device *dev)
 	int ret = -ENODEV;
 
 	mgr = to_fpga_manager(dev);
-	if (!mgr)
-		goto err_dev;
 
 	/* Get exclusive use of fpga manager */
 	if (!mutex_trylock(&mgr->ref_mutex)) {
-- 
2.7.4
