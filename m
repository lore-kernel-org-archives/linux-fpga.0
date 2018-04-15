Return-Path: <SRS0=fXmM=HE=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=fXmM=HE=ettus.com=moritz.fischer@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] fpga-manager: altera-ps-spi: preserve nCONFIG state
Date: Sun, 15 Apr 2018 11:33:08 -0700
Message-Id: <20180415183308.31402-1-mdf@kernel.org>
To: gregkh@linuxfoundation.org
Cc: atull@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

From: Anatolij Gustschin <agust@denx.de>

If the driver module is loaded when FPGA is configured, the FPGA
is reset because nconfig is pulled low (low-active gpio inited
with GPIOD_OUT_HIGH activates the signal which means setting its
value to low). Init nconfig with GPIOD_OUT_LOW to prevent this.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Hi Greg,

as discussed. Can you please take this bugfix for 4.17?
I rebased it against next.

Thanks,

Moritz

PS: Sorry for late submission
---
 drivers/fpga/altera-ps-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 14f14efdf0d5..06d212a3d49d 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -249,7 +249,7 @@ static int altera_ps_probe(struct spi_device *spi)
 
 	conf->data = of_id->data;
 	conf->spi = spi;
-	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_HIGH);
+	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
 	if (IS_ERR(conf->config)) {
 		dev_err(&spi->dev, "Failed to get config gpio: %ld\n",
 			PTR_ERR(conf->config));
-- 
2.17.0
