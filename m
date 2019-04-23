Return-Path: <SRS0=d31k=SZ=zte.com.cn=wen.yang99@kernel.org>
Return-Path: <SRS0=d31k=SZ=zte.com.cn=wen.yang99@kernel.org>
From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH] fpga: stratix10-soc: fix use-after-free on s10_init()
Date: Wed, 24 Apr 2019 07:32:05 +0800
Message-Id: <1556062325-26141-1-git-send-email-wen.yang99@zte.com.cn>
To: linux-kernel@vger.kernel.org
Cc: wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

The refcount of fw_np has already been decreased by of_find_matching_node()
so it shouldn't be used anymore.
This patch adds an of_node_get() before of_find_matching_node() to avoid
the use-after-free problem.

Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/fpga/stratix10-soc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 13851b3..215d337 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -507,12 +507,16 @@ static int __init s10_init(void)
 	if (!fw_np)
 		return -ENODEV;
 
+	of_node_get(fw_np);
 	np = of_find_matching_node(fw_np, s10_of_match);
-	if (!np)
+	if (!np) {
+		of_node_put(fw_np);
 		return -ENODEV;
+	}
 
 	of_node_put(np);
 	ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
+	of_node_put(fw_np);
 	if (ret)
 		return ret;
 
-- 
2.9.5
