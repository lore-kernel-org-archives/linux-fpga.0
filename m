Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 3/3] fpga: mgr: altera-ps-spi: make array dummy static, shrinks object size
Date: Thu, 24 Jan 2019 14:45:54 -0600
Message-Id: <20190124204554.5438-4-atull@kernel.org>
In-Reply-To: <20190124204554.5438-1-atull@kernel.org>
References: <20190124204554.5438-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Colin Ian King <colin.king@canonical.com>
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
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/altera-ps-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 8c18bee..678d011 100644
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
2.7.4
