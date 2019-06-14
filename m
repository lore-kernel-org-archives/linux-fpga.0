Return-Path: <SRS0=naif=UN=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=naif=UN=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfFNU3A (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 14 Jun 2019 16:29:00 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 17/59] fpga: dfl: expand minor range when registering chrdev region
Date: Fri, 14 Jun 2019 16:28:01 -0400
Message-Id: <20190614202843.26941-17-sashal@kernel.org>
In-Reply-To: <20190614202843.26941-1-sashal@kernel.org>
References: <20190614202843.26941-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Chengguang Xu <cgxu519@gmx.com>, Wu Hao <hao.wu@intel.com>, Alan Tull <atull@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-fpga@vger.kernel.org

From: Chengguang Xu <cgxu519@gmx.com>

[ Upstream commit de9a7f6f5f1967d275311cca9163b4a3ffe9b0ae ]

Actually, total amount of available minor number
for a single major is MINORMASK + 1. So expand
minor range when registering chrdev region.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/dfl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index c25217cde5ca..4b66aaa32b5a 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -322,7 +322,7 @@ static void dfl_chardev_uinit(void)
 	for (i = 0; i < DFL_FPGA_DEVT_MAX; i++)
 		if (MAJOR(dfl_chrdevs[i].devt)) {
 			unregister_chrdev_region(dfl_chrdevs[i].devt,
-						 MINORMASK);
+						 MINORMASK + 1);
 			dfl_chrdevs[i].devt = MKDEV(0, 0);
 		}
 }
@@ -332,8 +332,8 @@ static int dfl_chardev_init(void)
 	int i, ret;
 
 	for (i = 0; i < DFL_FPGA_DEVT_MAX; i++) {
-		ret = alloc_chrdev_region(&dfl_chrdevs[i].devt, 0, MINORMASK,
-					  dfl_chrdevs[i].name);
+		ret = alloc_chrdev_region(&dfl_chrdevs[i].devt, 0,
+					  MINORMASK + 1, dfl_chrdevs[i].name);
 		if (ret)
 			goto exit;
 	}
-- 
2.20.1
