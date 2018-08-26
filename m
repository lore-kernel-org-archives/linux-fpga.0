Return-Path: <SRS0=CNYI=LJ=canonical.com=colin.king@kernel.org>
Return-Path: <SRS0=CNYI=LJ=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] fpga: dfl: fme-mgr: fix spelling mistake "Invaild" -> "Invalid"
Date: Sun, 26 Aug 2018 23:13:55 +0100
Message-Id: <20180826221355.12661-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Wu Hao <hao.wu@intel.com>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/fpga/dfl-fme-mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index b5ef405b6d88..9f045d058cfd 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -201,7 +201,7 @@ static int fme_mgr_write(struct fpga_manager *mgr,
 		}
 
 		if (count < 4) {
-			dev_err(dev, "Invaild PR bitstream size\n");
+			dev_err(dev, "Invalid PR bitstream size\n");
 			return -EINVAL;
 		}
 
-- 
2.17.1
