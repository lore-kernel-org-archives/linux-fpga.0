Return-Path: <SRS0=BJpF=NJ=denx.de=agust@kernel.org>
Return-Path: <SRS0=BJpF=NJ=denx.de=agust@kernel.org>
From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2] fpga: mgr: altera-ps-spi: enable usage on non-dt platforms
Date: Mon, 29 Oct 2018 15:17:09 +0100
Message-Id: <20181029141709.14749-1-agust@denx.de>
To: atull@kernel.org, mdf@kernel.org
Cc: linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Driver probing fails on non-dt platforms since of_match_device()
always returns NULL here. Add device names and matching driver
data to the spi_device_id table. This allows driver binding to
dynamically added PS-SPI devices (e.g. added via spi_new_device()
after hot-plugging).

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
Changes in v2:
 - removed not necessary braces {}
 - dropped not needed !id check
 
 drivers/fpga/altera-ps-spi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 33aafda50af5..b8136ee49ace 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -238,17 +238,23 @@ static int altera_ps_probe(struct spi_device *spi)
 {
 	struct altera_ps_conf *conf;
 	const struct of_device_id *of_id;
+	const struct spi_device_id *id;
 	struct fpga_manager *mgr;
 
 	conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
 	if (!conf)
 		return -ENOMEM;
 
-	of_id = of_match_device(of_ef_match, &spi->dev);
-	if (!of_id)
-		return -ENODEV;
+	if (spi->dev.of_node) {
+		of_id = of_match_device(of_ef_match, &spi->dev);
+		if (!of_id)
+			return -ENODEV;
+		conf->data = of_id->data;
+	} else {
+		id = spi_get_device_id(spi);
+		conf->data = (struct altera_ps_data *)id->driver_data;
+	}
 
-	conf->data = of_id->data;
 	conf->spi = spi;
 	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
 	if (IS_ERR(conf->config)) {
@@ -294,7 +300,9 @@ static int altera_ps_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id altera_ps_spi_ids[] = {
-	{"cyclone-ps-spi", 0},
+	{"cyclone-ps-spi", (kernel_ulong_t)&c5_data},
+	{"fpga-passive-serial", (kernel_ulong_t)&c5_data},
+	{"fpga-arria10-passive-serial", (kernel_ulong_t)&a10_data},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, altera_ps_spi_ids);
-- 
2.17.1
