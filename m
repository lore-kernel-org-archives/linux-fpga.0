Return-Path: <SRS0=RBas=NM=denx.de=agust@kernel.org>
Return-Path: <SRS0=RBas=NM=denx.de=agust@kernel.org>
From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3] fpga: mgr: altera-ps-spi: enable usage on non-dt platforms
Date: Thu,  1 Nov 2018 22:22:31 +0100
Message-Id: <20181101212231.9125-1-agust@denx.de>
To: linux-fpga@vger.kernel.org
Cc: atull@kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Driver probing fails on non-dt platforms since of_match_device()
always returns NULL here. Add device names and matching driver
data to the spi_device_id table. This allows driver binding to
dynamically added PS-SPI devices (e.g. added via spi_new_device()
after hot-plugging).

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
Changes in v3:
 - don't use pointers to device data struct in driver_data

Changes in v2:
 - removed not necessary braces {}
 - dropped not needed !id check

 drivers/fpga/altera-ps-spi.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 33aafda50af5..78d809194b7d 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -75,6 +75,11 @@ static struct altera_ps_data a10_data = {
 	.t_st2ck_us = 10, /* min(t_ST2CK) */
 };
 
+static const struct altera_ps_data *altera_ps_data_map[] = {
+	&c5_data,
+	&a10_data,
+};
+
 static const struct of_device_id of_ef_match[] = {
 	{ .compatible = "altr,fpga-passive-serial", .data = &c5_data },
 	{ .compatible = "altr,fpga-arria10-passive-serial", .data = &a10_data },
@@ -234,6 +239,19 @@ static const struct fpga_manager_ops altera_ps_ops = {
 	.write_complete = altera_ps_write_complete,
 };
 
+static const struct altera_ps_data *id_to_data(const struct spi_device_id *id)
+{
+	const struct altera_ps_data *data;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(altera_ps_data_map); i++) {
+		data = altera_ps_data_map[i];
+		if (data && data->devtype == id->driver_data)
+			return data;
+	}
+	return NULL;
+}
+
 static int altera_ps_probe(struct spi_device *spi)
 {
 	struct altera_ps_conf *conf;
@@ -244,11 +262,17 @@ static int altera_ps_probe(struct spi_device *spi)
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
+		conf->data = id_to_data(spi_get_device_id(spi));
+		if (!conf->data)
+			return -ENODEV;
+	}
 
-	conf->data = of_id->data;
 	conf->spi = spi;
 	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
 	if (IS_ERR(conf->config)) {
@@ -294,7 +318,9 @@ static int altera_ps_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id altera_ps_spi_ids[] = {
-	{"cyclone-ps-spi", 0},
+	{ "cyclone-ps-spi", CYCLONE5 },
+	{ "fpga-passive-serial", CYCLONE5 },
+	{ "fpga-arria10-passive-serial", ARRIA10 },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, altera_ps_spi_ids);
-- 
2.17.1
