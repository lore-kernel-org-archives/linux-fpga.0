Return-Path: <SRS0=Bvgt=KD=huawei.com=weiyongjun1@kernel.org>
Return-Path: <SRS0=Bvgt=KD=huawei.com=weiyongjun1@kernel.org>
From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] fpga: dfl: fme: fix return value check in in pr_mgmt_init()
Date: Thu, 19 Jul 2018 13:16:54 +0000
Message-ID: <1532006214-104930-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
To: Wu Hao <hao.wu@intel.com>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Kang Luwei <luwei.kang@intel.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

In case of error, the function dfl_fme_create_region() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: 29de76240e86 ("fpga: dfl: fme: add partial reconfiguration sub feature support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/fpga/dfl-fme-pr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index fc9fd2d..0b84053 100644
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
