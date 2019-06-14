Return-Path: <sashal@kernel.org>
Return-Path: <sashal@kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 14/59] fpga: stratix10-soc: fix use-after-free on s10_init()
Date: Fri, 14 Jun 2019 16:27:58 -0400
Message-Id: <20190614202843.26941-14-sashal@kernel.org>
In-Reply-To: <20190614202843.26941-1-sashal@kernel.org>
References: <20190614202843.26941-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Wen Yang <wen.yang99@zte.com.cn>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-fpga@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit f5dd87326fefe42a4b1a4b1a1a695060c33a88d6 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.20.1
