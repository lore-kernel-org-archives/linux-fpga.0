Return-Path: <SRS0=rIZR=VW=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=rIZR=VW=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:55232 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389463AbfGYCzc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 24 Jul 2019 22:55:32 -0400
From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 1/1] fpga: altera-ps-spi: Fix getting of optional confd gpio
Date: Thu, 25 Jul 2019 10:48:45 +0800
Message-Id: <1564022925-40402-1-git-send-email-preid@electromag.com.au>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: atull@kernel.org, mdf@kernel.org, colin.king@canonical.com, agust@denx.de, preid@electromag.com.au, linux-fpga@vger.kernel.org

Currently the driver does not handle EPROBE_DEFER for the confd gpio.
Use devm_gpiod_get_optional() instead of devm_gpiod_get() and return
error codes from altera_ps_probe().

Fixes: 5692fae0742d ("fpga manager: Add altera-ps-spi driver for Altera FPGAs")
Signed-off-by: Phil Reid <preid@electromag.com.au>
---

Notes:
    Compile tested only. I currently don't have hardware to test.
    I was reviewing the driver prior to a board design and noticed
    the problem.

 drivers/fpga/altera-ps-spi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 678d0115f840..a02b88d63f89 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -213,7 +213,7 @@ static int altera_ps_write_complete(struct fpga_manager *mgr,
 		return -EIO;
 	}
 
-	if (!IS_ERR(conf->confd)) {
+	if (conf->confd) {
 		if (!gpiod_get_raw_value_cansleep(conf->confd)) {
 			dev_err(&mgr->dev, "CONF_DONE is inactive!\n");
 			return -EIO;
@@ -292,10 +292,13 @@ static int altera_ps_probe(struct spi_device *spi)
 		return PTR_ERR(conf->status);
 	}
 
-	conf->confd = devm_gpiod_get(&spi->dev, "confd", GPIOD_IN);
+	conf->confd = devm_gpiod_get_optional(&spi->dev, "confd", GPIOD_IN);
 	if (IS_ERR(conf->confd)) {
-		dev_warn(&spi->dev, "Not using confd gpio: %ld\n",
-			 PTR_ERR(conf->confd));
+		dev_err(&spi->dev, "Failed to get confd gpio: %ld\n",
+			PTR_ERR(conf->confd));
+		return PTR_ERR(conf->confd);
+	} else if (!conf->confd) {
+		dev_warn(&spi->dev, "Not using confd gpio");
 	}
 
 	/* Register manager with unique name */
-- 
1.8.3.1
