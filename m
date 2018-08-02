Return-Path: <SRS0=41fD=KR=oracle.com=dan.carpenter@kernel.org>
Return-Path: <SRS0=41fD=KR=oracle.com=dan.carpenter@kernel.org>
Date: Thu, 2 Aug 2018 11:29:31 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] fpga: dfl: fme: error pointer vs NULL bug
Message-ID: <20180802082931.6nfcgaztkxbkrgh7@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Wu Hao <hao.wu@intel.com>, Kang Luwei <luwei.kang@intel.com>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The dfl_fme_create_region() function doesn't return NULL pointers, it
returns error pointers.

Fixes: 29de76240e86 ("fpga: dfl: fme: add partial reconfiguration sub feature support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index fc9fd2d0482f..0b840531ef33 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -420,7 +420,7 @@ static int pr_mgmt_init(struct platform_device *pdev,
 		/* Create region for each port */
 		fme_region = dfl_fme_create_region(pdata, mgr,
 						   fme_br->br, i);
-		if (!fme_region) {
+		if (IS_ERR(fme_region)) {
 			ret = PTR_ERR(fme_region);
 			goto destroy_region;
 		}
