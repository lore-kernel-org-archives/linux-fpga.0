Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 1/4] fpga: stratix10-soc: fix use-after-free on s10_init()
Date: Thu,  9 May 2019 16:08:26 -0500
Message-Id: <20190509210829.31815-2-atull@kernel.org>
In-Reply-To: <20190509210829.31815-1-atull@kernel.org>
References: <20190509210829.31815-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
List-ID: <linux-fpga@vger.kernel.org>

From: Wen Yang <wen.yang99@zte.com.cn>

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
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/stratix10-soc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 13851b3d1c56..215d33789c74 100644
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
2.21.0
