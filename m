Return-Path: <SRS0=AzDW=P2=softplc.com=dick@kernel.org>
Return-Path: <SRS0=AzDW=P2=softplc.com=dick@kernel.org>
From: Dick Hollenbeck <dick@softplc.com>
Subject: [PATCH] Add Cyclone-10 support to altera-ps-spi.c.
Message-ID: <55c8234e-7ea1-589b-11dc-dac931f586bb@softplc.com>
Date: Fri, 18 Jan 2019 15:41:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
To: Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

 Add Cyclone-10 support to altera-ps-spi.c.
 Invert logic involving nCONFIG, nSTATUS, and CONFIG_DONE so it matches datasheets
 by going with GPIO_ACTIVE_HIGH instead of GPIO_ACTIVE_LOW in the device tree.  Add
 optional devicetree properties spi-lsb-first and write-block-size.

Signed-off-by: Dick Hollenbeck <dick@softplc.com>
---
 .../bindings/fpga/altera-passive-serial.txt   |  71 +++++--
 drivers/fpga/altera-ps-spi.c                  | 200 ++++++++++++------
 include/linux/fpga/fpga-mgr.h                 |   5 +-
 3 files changed, 189 insertions(+), 87 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/altera-passive-serial.txt
b/Documentation/devicetree/bindings/fpga/altera-passive-serial.txt
index 48478bc07..2cffc8c0a 100644
--- a/Documentation/devicetree/bindings/fpga/altera-passive-serial.txt
+++ b/Documentation/devicetree/bindings/fpga/altera-passive-serial.txt
@@ -8,22 +8,67 @@ circuits in order to play nicely with other SPI slaves on the same bus.
 See https://www.altera.com/literature/hb/cyc/cyc_c51013.pdf

 Required properties:
-- compatible: Must be one of the following:
-	"altr,fpga-passive-serial",
-	"altr,fpga-arria10-passive-serial"
-- reg: SPI chip select of the FPGA
-- nconfig-gpios: config pin (referred to as nCONFIG in the manual)
-- nstat-gpios: status pin (referred to as nSTATUS in the manual)
+- compatible:		Must be one of the following:
+				"altr,fpga-passive-serial",
+				"altr,fpga-arria10-passive-serial"
+				"altr,fpga-cyclone10-passive-serial"
+- reg:			SPI chip select of the FPGA
+- nconfig-gpios:		nCONFIG pin
+- nstat-gpios:		nSTATUS pin

 Optional properties:
-- confd-gpios: confd pin (referred to as CONF_DONE in the manual)
+- confd-gpios:		CONF_DONE pin
+- write-block-size:	Number of bytes to write each time through a loop.
+			Can set to 0xffffffff to perform in a single write.

 Example:
-	fpga: fpga@0 {
-		compatible = "altr,fpga-passive-serial";
+
+&pio {
+	fpgamgr0_outs: fpgamgr0_outs {
+		pins = "PG8";
+		function = "gpio_out";
+		output-high;
+		drive-strength = <10>;			/* milliamps, down from 20 default */
+	};
+	fpgamgr0_ins: fpgamgr0_ins {
+		pins = "PG6", "PG7";
+		function = "gpio_in";
+	};
+
+	fpgabridge0_outs: fpgabridge0_outs {
+		pins =	"PA0", "PA1", "PA2", "PA3", "PA6", "PA11", "PA12", "PA17", /* data[0:7] */
+			"PA21",				/* ACK */
+			"PA18",				/* WR_DATA */
+			"PA19",				/* RD_DATA */
+			"PA20";				/* WR_ADDR */
+
+		function = "gpio_out";
+		drive-strength = <10>;			/* milliamps, down from 20 default */
+	};
+
+	fpgabridge0_ins: fpgabridge0_ins {
+		pins =	"PA21";				/* ACK */
+		function = "gpio_ins";
+	};
+};
+
+&spi0 {
+	status = "okay";
+
+	fpga_mgr0: fpga-mgr@3 {
+		compatible = "altr,fpga-cyclone10-passive-serial";
 		spi-max-frequency = <20000000>;
-		reg = <0>;
-		nconfig-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
-		nstat-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
-		confd-gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
+		reg = <3>;	/* leave room for spi node addresses 0-2 */
+		pinctrl-names = "default";
+		pinctrl-0 = <	&fpgamgr0_outs
+				&fpgamgr0_ins
+				&fpgabridge0_outs
+				&fpgabridge0_ins
+				>;
+		nconfig-gpios = <&pio 6 8 GPIO_ACTIVE_HIGH>;	/* PG8 */
+		nstat-gpios	  = <&pio 6 7 GPIO_ACTIVE_HIGH>;	/* PG7 */
+		confd-gpios	  = <&pio 6 6 GPIO_ACTIVE_HIGH>;	/* PG6 */
+		spi-lsb-first;	/* SPI controller should send LSbit first to this slave */
+		write-block-size = <0xffffffff>;
 	};
+};
diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 33aafda50..0c6c90d0c 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -12,8 +12,9 @@
  * Manage Altera FPGA firmware that is loaded over SPI using the passive
  * serial configuration method.
  * Firmware must be in binary "rbf" format.
- * Works on Arria 10, Cyclone V and Stratix V. Should work on Cyclone series.
- * May work on other Altera FPGAs.
+ * Works on Arria 10, Cyclone V, Cyclone 10, and Stratix V.
+ * May work on other Altera FPGAs.  For Cyclone 10, additional file formats
+ * of *.hex and *.ttf are allegedly accepted by the FPGA.
  */

 #include <linux/bitrev.h>
@@ -26,8 +27,14 @@
 #include <linux/spi/spi.h>
 #include <linux/sizes.h>

+
+#define FLAGS_SPI_LSB_FIRST	BIT(0)	/* saw "spi-lsb-first" in DTB's SPI FPGA manager slave */
+
+#define WR_BLOCKZ_BYTES		SZ_4K	/* chosen when "write-block-size" not supplied in
devicetree */
+
 enum altera_ps_devtype {
 	CYCLONE5,
+	CYCLONE10,
 	ARRIA10,
 };

@@ -40,24 +47,29 @@ struct altera_ps_data {
 };

 struct altera_ps_conf {
-	struct gpio_desc *config;
+	struct gpio_desc *nconfig;
 	struct gpio_desc *confd;
 	struct gpio_desc *status;
 	struct spi_device *spi;
+	u32 write_block_size;			/* in bytes */
 	const struct altera_ps_data *data;
-	u32 info_flags;
 	char mgr_name[64];
+	u8 image_flags;
+	u8 mgr_flags;
 };

-/*          |   Arria 10  |   Cyclone5  |   Stratix5  |
- * t_CF2ST0 |     [; 600] |     [; 600] |     [; 600] |ns
- * t_CFG    |        [2;] |        [2;] |        [2;] |µs
- * t_STATUS | [268; 3000] | [268; 1506] | [268; 1506] |µs
- * t_CF2ST1 |    [; 3000] |    [; 1506] |    [; 1506] |µs
- * t_CF2CK  |     [3010;] |     [1506;] |     [1506;] |µs
- * t_ST2CK  |       [10;] |        [2;] |        [2;] |µs
- * t_CD2UM  |  [175; 830] |  [175; 437] |  [175; 437] |µs
+/*
+ * See
https://www.intel.com/content/www/us/en/programmable/documentation/sss1412661044400.html
+ *          |   Arria 10  |   Cyclone5  |   Stratix5  |  Cyclone 10 LP  |
+ * t_CF2ST0 |     [; 600] |     [; 600] |     [; 600] |         [; 500] |ns
+ * t_CFG    |        [2;] |        [2;] |        [2;] |          [0.5;] |µs
+ * t_STATUS | [268; 3000] | [268; 1506] | [268; 1506] |       [45; 230] |µs
+ * t_CF2ST1 |    [; 3000] |    [; 1506] |    [; 1506] |         [; 230] |µs
+ * t_CF2CK  |     [3010;] |     [1506;] |     [1506;] |          [230;] |µs
+ * t_ST2CK  |       [10;] |        [2;] |        [2;] |            [2;] |µs
+ * t_CD2UM  |  [175; 830] |  [175; 437] |  [175; 437] |      [300; 650] |µs
  */
+
 static struct altera_ps_data c5_data = {
 	/* these values for Cyclone5 are compatible with Stratix5 */
 	.devtype = CYCLONE5,
@@ -69,15 +81,24 @@ static struct altera_ps_data c5_data = {

 static struct altera_ps_data a10_data = {
 	.devtype = ARRIA10,
-	.status_wait_min_us = 268,  /* min(t_STATUS) */
-	.status_wait_max_us = 3000, /* max(t_CF2ST1) */
-	.t_cfg_us = 2,    /* max { min(t_CFG), max(tCF2ST0) } */
-	.t_st2ck_us = 10, /* min(t_ST2CK) */
+	.status_wait_min_us = 268,	/* min(t_STATUS) */
+	.status_wait_max_us = 3000,	/* max(t_CF2ST1) */
+	.t_cfg_us = 2,			/* max { min(t_CFG), max(tCF2ST0) } */
+	.t_st2ck_us = 10,		/* min(t_ST2CK) */
+};
+
+static struct altera_ps_data c10_data = {
+	.devtype = CYCLONE10,
+	.status_wait_min_us = 45,
+	.status_wait_max_us = 230,
+	.t_cfg_us = 1,
+	.t_st2ck_us = 2,
 };

 static const struct of_device_id of_ef_match[] = {
 	{ .compatible = "altr,fpga-passive-serial", .data = &c5_data },
 	{ .compatible = "altr,fpga-arria10-passive-serial", .data = &a10_data },
+	{ .compatible = "altr,fpga-cyclone10-passive-serial", .data = &c10_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_ef_match);
@@ -86,13 +107,13 @@ static enum fpga_mgr_states altera_ps_state(struct fpga_manager *mgr)
 {
 	struct altera_ps_conf *conf = mgr->priv;

-	if (gpiod_get_value_cansleep(conf->status))
+	if (!gpiod_get_value_cansleep(conf->status))
 		return FPGA_MGR_STATE_RESET;

 	return FPGA_MGR_STATE_UNKNOWN;
 }

-static inline void altera_ps_delay(int delay_us)
+static void altera_ps_delay(unsigned delay_us)
 {
 	if (delay_us > 10)
 		usleep_range(delay_us, delay_us + 5);
@@ -100,51 +121,56 @@ static inline void altera_ps_delay(int delay_us)
 		udelay(delay_us);
 }

+/* wait up to delay_us for a gpio pin to enter a goal state */
+static bool gpio_wait(bool goal, struct gpio_desc *pin, unsigned delay_us)
+{
+	ktime_t deadline = ktime_add_us(ktime_get(), delay_us);
+
+	do {	/* delay at least once, ktime_get() may not have changed */
+		altera_ps_delay(10);
+		if (gpiod_get_value_cansleep(pin) == goal)
+			return true;
+
+		/* as of today, ktime_before() and ktime_after() are badly implemented, not using them
here */
+	} while (ktime_sub(deadline,ktime_get()) > 0);
+
+	return false;
+}
+
 static int altera_ps_write_init(struct fpga_manager *mgr,
-				struct fpga_image_info *info,
+				struct fpga_image_info *image_info,
 				const char *buf, size_t count)
 {
 	struct altera_ps_conf *conf = mgr->priv;
-	int min, max, waits;
-	int i;
-
-	conf->info_flags = info->flags;
+	conf->image_flags = image_info->flags;

-	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
+	if (image_info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
 		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
 		return -EINVAL;
 	}

-	gpiod_set_value_cansleep(conf->config, 1);
+	if (!gpiod_get_value_cansleep(conf->status)) {
+		dev_err(&mgr->dev, "nSTATUS initial state is not hi.\n");
+		return -EIO;
+	}

-	/* wait min reset pulse time */
-	altera_ps_delay(conf->data->t_cfg_us);
+	gpiod_set_value_cansleep(conf->nconfig, 0);

-	if (!gpiod_get_value_cansleep(conf->status)) {
-		dev_err(&mgr->dev, "Status pin failed to show a reset\n");
+	/* wait min reset pulse time */
+	if (!gpio_wait(false, conf->status, conf->data->t_cfg_us)) {
+		dev_err(&mgr->dev, "nSTATUS failed to show a reset\n");
 		return -EIO;
 	}

-	gpiod_set_value_cansleep(conf->config, 0);
-
-	min = conf->data->status_wait_min_us;
-	max = conf->data->status_wait_max_us;
-	waits = max / min;
-	if (max % min)
-		waits++;
-
-	/* wait for max { max(t_STATUS), max(t_CF2ST1) } */
-	for (i = 0; i < waits; i++) {
-		usleep_range(min, min + 10);
-		if (!gpiod_get_value_cansleep(conf->status)) {
-			/* wait for min(t_ST2CK)*/
-			altera_ps_delay(conf->data->t_st2ck_us);
-			return 0;
-		}
+	gpiod_set_value_cansleep(conf->nconfig, 1);
+
+	if (!gpio_wait(true, conf->status, conf->data->status_wait_max_us)) {
+		dev_err(&mgr->dev, "nSTATUS not ready.\n");
+		return -EIO;
 	}

-	dev_err(&mgr->dev, "Status pin not ready.\n");
-	return -EIO;
+	dev_dbg(&mgr->dev, "%s: nSTATUS OK\n", __func__);
+	return 0;
 }

 static void rev_buf(char *buf, size_t len)
@@ -176,12 +202,28 @@ static int altera_ps_write(struct fpga_manager *mgr, const char *buf,
 	const char *fw_data = buf;
 	const char *fw_data_end = fw_data + count;

+	/* u-boot does not loop when doing something similar.  Sometimes there
+	 * can be clock glitches at the edges of these multiple frames depending
+	 * on the quality of the CPU's spi driver.  For that
+	 * reason it is possible to do the writing in one frame by setting the
+	 * write_block_size large enough in the device tree such that this
+	 * "loop" finishes up in one pass through.
+	 */
 	while (fw_data < fw_data_end) {
-		int ret;
-		size_t stride = min_t(size_t, fw_data_end - fw_data, SZ_4K);

-		if (!(conf->info_flags & FPGA_MGR_BITSTREAM_LSB_FIRST))
+		int ret;
+		size_t stride = min_t(size_t, fw_data_end - fw_data, conf->write_block_size);
+
+		/* Does the SPI controller send LSbit first, typically not.
+		 * In any case the FPGA wants LSbit first.  Endian reverse bits in
+		 * byte if needed so that the LSbit of each image byte is sent first,
+		 * in the case where the SPI controller sends the MSbit first
+		 * (of what will now be bit reversed bytes).
+		 */
+		if (!(conf->mgr_flags & FLAGS_SPI_LSB_FIRST)) {
+			dev_dbg(&mgr->dev, "rev_buf() bit swapping\n");
 			rev_buf((char *)fw_data, stride);
+		}

 		ret = spi_write(conf->spi, fw_data, stride);
 		if (ret) {
@@ -192,31 +234,30 @@ static int altera_ps_write(struct fpga_manager *mgr, const char *buf,
 		fw_data += stride;
 	}

+	dev_dbg(&mgr->dev, "%s: OK\n", __func__);
 	return 0;
 }

 static int altera_ps_write_complete(struct fpga_manager *mgr,
-				    struct fpga_image_info *info)
+				    struct fpga_image_info *image_info)
 {
 	struct altera_ps_conf *conf = mgr->priv;
 	const char dummy[] = {0};
 	int ret;

-	if (gpiod_get_value_cansleep(conf->status)) {
-		dev_err(&mgr->dev, "Error during configuration.\n");
+	if (!gpiod_get_value_cansleep(conf->status)) {
+		dev_err(&mgr->dev, "nSTATUS error at end of configuration!\n");
 		return -EIO;
 	}

-	if (!IS_ERR(conf->confd)) {
-		if (!gpiod_get_raw_value_cansleep(conf->confd)) {
-			dev_err(&mgr->dev, "CONF_DONE is inactive!\n");
-			return -EIO;
-		}
+	if (!IS_ERR(conf->confd) && !gpio_wait(true, conf->confd, 500)) {
+		dev_err(&mgr->dev, "CONF_DONE error at end of configuration!\n");
+		return -EIO;
 	}

 	/*
-	 * After CONF_DONE goes high, send two additional falling edges on DCLK
-	 * to begin initialization and enter user mode
+	 * After CONF_DONE goes high, send at least two additional falling
+	 * edges on DCLK to begin initialization and enter user mode.
 	 */
 	ret = spi_write(conf->spi, dummy, 1);
 	if (ret) {
@@ -224,6 +265,7 @@ static int altera_ps_write_complete(struct fpga_manager *mgr,
 		return ret;
 	}

+	dev_dbg(&mgr->dev, "%s: OK\n", __func__);
 	return 0;
 }

@@ -240,44 +282,62 @@ static int altera_ps_probe(struct spi_device *spi)
 	const struct of_device_id *of_id;
 	struct fpga_manager *mgr;

+	dev_dbg(&spi->dev, "altera_ps_probe\n");
+
 	conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
-	if (!conf)
+	if (!conf) {
 		return -ENOMEM;
+	}

 	of_id = of_match_device(of_ef_match, &spi->dev);
-	if (!of_id)
+	if (!of_id) {
+		dev_dbg(&spi->dev, "no of_id\n");
 		return -ENODEV;
+	}

 	conf->data = of_id->data;
 	conf->spi = spi;
-	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
-	if (IS_ERR(conf->config)) {
-		dev_err(&spi->dev, "Failed to get config gpio: %ld\n",
-			PTR_ERR(conf->config));
-		return PTR_ERR(conf->config);
+	conf->nconfig = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->nconfig)) {
+		dev_err(&spi->dev, "Failed to get nCONFIG gpio: %ld\n",
+			PTR_ERR(conf->nconfig));
+		return PTR_ERR(conf->nconfig);
 	}

 	conf->status = devm_gpiod_get(&spi->dev, "nstat", GPIOD_IN);
 	if (IS_ERR(conf->status)) {
-		dev_err(&spi->dev, "Failed to get status gpio: %ld\n",
+		dev_err(&spi->dev, "Failed to get nSTATUS gpio: %ld\n",
 			PTR_ERR(conf->status));
 		return PTR_ERR(conf->status);
 	}

 	conf->confd = devm_gpiod_get(&spi->dev, "confd", GPIOD_IN);
 	if (IS_ERR(conf->confd)) {
-		dev_warn(&spi->dev, "Not using confd gpio: %ld\n",
+		dev_warn(&spi->dev, "Not using CONFIG_DONE gpio: %ld\n",
 			 PTR_ERR(conf->confd));
 	}

+	if (of_find_property(spi->dev.of_node, "spi-lsb-first", NULL)) {
+		dev_dbg(&spi->dev, "SPI is LSbit first");
+		conf->mgr_flags |= FLAGS_SPI_LSB_FIRST;
+	}
+
+	if (of_property_read_u32(spi->dev.of_node, "write-block-size",
+				 &conf->write_block_size))
+		conf->write_block_size = WR_BLOCKZ_BYTES;
+
+	dev_dbg(&spi->dev, "write_block_size:%u\n", conf->write_block_size);
+
 	/* Register manager with unique name */
 	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
 		 dev_driver_string(&spi->dev), dev_name(&spi->dev));

 	mgr = devm_fpga_mgr_create(&spi->dev, conf->mgr_name,
 				   &altera_ps_ops, conf);
-	if (!mgr)
+	if (!mgr) {
+		dev_dbg(&spi->dev, "no mgr\n");
 		return -ENOMEM;
+	}

 	spi_set_drvdata(spi, mgr);

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index e8ca62b2c..7ac77c3ae 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -64,15 +64,12 @@ enum fpga_mgr_states {
  *
  * %FPGA_MGR_ENCRYPTED_BITSTREAM: indicates bitstream is encrypted
  *
- * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
- *
  * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
 #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
-#define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
-#define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
+#define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(3)

 /**
  * struct fpga_image_info - information specific to a FPGA image
-- 
2.17.1
