Return-Path: <SRS0=zKh1=OI=canonical.com=colin.king@kernel.org>
Return-Path: <SRS0=zKh1=OI=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] fpga: mgr: altera-ps-spi: make array dummy static, shrinks object size
Date: Thu, 29 Nov 2018 23:10:16 +0000
Message-Id: <20181129231016.4580-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const array dummy on the stack but instead
make it static. Makes the object code smaller by 26 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   7371	   2032	      0	   9403	   24bb	drivers/fpga/altera-ps-spi.o

After:
   text	   data	    bss	    dec	    hex	filename
   7281	   2096	      0	   9377	   24a1	drivers/fpga/altera-ps-spi.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/fpga/altera-ps-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 8c18beec6b57..678d0115f840 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -205,7 +205,7 @@ static int altera_ps_write_complete(struct fpga_manager *mgr,
 				    struct fpga_image_info *info)
 {
 	struct altera_ps_conf *conf = mgr->priv;
-	const char dummy[] = {0};
+	static const char dummy[] = {0};
 	int ret;
 
 	if (gpiod_get_value_cansleep(conf->status)) {
-- 
2.19.1
