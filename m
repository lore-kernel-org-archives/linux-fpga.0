Return-Path: <SRS0=3af1=E3=denx.de=agust@kernel.org>
Return-Path: <SRS0=3af1=E3=denx.de=agust@kernel.org>
From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH] fpga-manager: altera-ps-spi: preserve nCONFIG state
Date: Thu,  1 Feb 2018 23:20:04 +0100
Message-Id: <20180201222004.15949-1-agust@denx.de>
To: linux-fpga@vger.kernel.org
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Joshua Clayton <stillcompiling@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

If the driver module is loaded when FPGA is configured, the FPGA
is reset because nconfig is pulled low (low-active gpio inited
with GPIOD_OUT_HIGH activates the signal which means setting its
value to low). Init nconfig with GPIOD_OUT_LOW to prevent this.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/fpga/altera-ps-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index c593f33d8db9..6891933d072d 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -258,7 +258,7 @@ static int altera_ps_probe(struct spi_device *spi)
 	}
 
 	conf->spi = spi;
-	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_HIGH);
+	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
 	if (IS_ERR(conf->config)) {
 		dev_err(&spi->dev, "Failed to get config gpio: %ld\n",
 			PTR_ERR(conf->config));
-- 
2.11.0
