Return-Path: <SRS0=WTWj=GY=gmail.com=p.pisati@kernel.org>
Return-Path: <SRS0=WTWj=GY=gmail.com=p.pisati@kernel.org>
From: Paolo Pisati <p.pisati@gmail.com>
Subject: [PATCH v10 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
Date: Tue,  3 Apr 2018 21:02:32 +0200
Message-Id: <1522782152-27300-3-git-send-email-p.pisati@gmail.com>
In-Reply-To: <1522782152-27300-1-git-send-email-p.pisati@gmail.com>
References: <1522782152-27300-1-git-send-email-p.pisati@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

This patch adds support to the FPGA manager for programming
MachXO2 device’s internal flash memory, via slave SPI.

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 drivers/fpga/Kconfig       |   7 +
 drivers/fpga/Makefile      |   1 +
 drivers/fpga/machxo2-spi.c | 413 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 421 insertions(+)
 create mode 100644 drivers/fpga/machxo2-spi.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index f47ef84..53d3f55 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -70,6 +70,13 @@ config FPGA_MGR_ICE40_SPI
 	help
 	  FPGA manager driver support for Lattice iCE40 FPGAs over SPI.
 
+config FPGA_MGR_MACHXO2_SPI
+	tristate "Lattice MachXO2 SPI"
+	depends on SPI
+	help
+	  FPGA manager driver support for Lattice MachXO2 configuration
+	  over slave SPI interface.
+
 config FPGA_MGR_TS73XX
 	tristate "Technologic Systems TS-73xx SBC FPGA Manager"
 	depends on ARCH_EP93XX && MACH_TS72XX
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 3cb276a..f9803da 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_FPGA)			+= fpga-mgr.o
 obj-$(CONFIG_FPGA_MGR_ALTERA_CVP)	+= altera-cvp.o
 obj-$(CONFIG_FPGA_MGR_ALTERA_PS_SPI)	+= altera-ps-spi.o
 obj-$(CONFIG_FPGA_MGR_ICE40_SPI)	+= ice40-spi.o
+obj-$(CONFIG_FPGA_MGR_MACHXO2_SPI)	+= machxo2-spi.o
 obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
 obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
 obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
new file mode 100644
index 0000000..3482d48
--- /dev/null
+++ b/drivers/fpga/machxo2-spi.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lattice MachXO2 Slave SPI Driver
+ *
+ * Manage Lattice FPGA firmware that is loaded over SPI using
+ * the slave serial configuration interface.
+ *
+ * Copyright (C) 2018 Paolo Pisati <p.pisati@gmail.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+
+/* MachXO2 Programming Guide - sysCONFIG Programming Commands */
+#define IDCODE_PUB		{0xe0, 0x00, 0x00, 0x00}
+#define ISC_ENABLE		{0xc6, 0x08, 0x00, 0x00}
+#define ISC_ERASE		{0x0e, 0x04, 0x00, 0x00}
+#define ISC_PROGRAMDONE		{0x5e, 0x00, 0x00, 0x00}
+#define LSC_INITADDRESS		{0x46, 0x00, 0x00, 0x00}
+#define LSC_PROGINCRNV		{0x70, 0x00, 0x00, 0x01}
+#define LSC_READ_STATUS		{0x3c, 0x00, 0x00, 0x00}
+#define LSC_REFRESH		{0x79, 0x00, 0x00, 0x00}
+
+/*
+ * Max CCLK in Slave SPI mode according to 'MachXO2 Family Data
+ * Sheet' sysCONFIG Port Timing Specifications (3-36)
+ */
+#define MACHXO2_MAX_SPEED		66000000
+
+#define MACHXO2_LOW_DELAY_USEC		5
+#define MACHXO2_HIGH_DELAY_USEC		200
+#define MACHXO2_REFRESH_USEC		4800
+#define MACHXO2_MAX_BUSY_LOOP		128
+#define MACHXO2_MAX_REFRESH_LOOP	16
+
+#define MACHXO2_PAGE_SIZE		16
+#define MACHXO2_BUF_SIZE		(MACHXO2_PAGE_SIZE + 4)
+
+/* Status register bits, errors and error mask */
+#define BUSY	12
+#define DONE	8
+#define DVER	27
+#define ENAB	9
+#define ERRBITS	23
+#define ERRMASK	7
+#define FAIL	13
+
+#define ENOERR	0 /* no error */
+#define EID	1
+#define ECMD	2
+#define ECRC	3
+#define EPREAM	4 /* preamble error */
+#define EABRT	5 /* abort error */
+#define EOVERFL	6 /* overflow error */
+#define ESDMEOF	7 /* SDM EOF */
+
+static inline u8 get_err(unsigned long *status)
+{
+	return (*status >> ERRBITS) & ERRMASK;
+}
+
+static int get_status(struct spi_device *spi, unsigned long *status)
+{
+	struct spi_message msg;
+	struct spi_transfer rx, tx;
+	static const u8 cmd[] = LSC_READ_STATUS;
+	int ret;
+
+	memset(&rx, 0, sizeof(rx));
+	memset(&tx, 0, sizeof(tx));
+	tx.tx_buf = cmd;
+	tx.len = sizeof(cmd);
+	rx.rx_buf = status;
+	rx.len = 4;
+	spi_message_init(&msg);
+	spi_message_add_tail(&tx, &msg);
+	spi_message_add_tail(&rx, &msg);
+	ret = spi_sync(spi, &msg);
+	if (ret)
+		return ret;
+
+	*status = be32_to_cpu(*status);
+
+	return 0;
+}
+
+#ifdef DEBUG
+static const char *get_err_string(u8 err)
+{
+	switch (err) {
+	case ENOERR:	return "No Error";
+	case EID:	return "ID ERR";
+	case ECMD:	return "CMD ERR";
+	case ECRC:	return "CRC ERR";
+	case EPREAM:	return "Preamble ERR";
+	case EABRT:	return "Abort ERR";
+	case EOVERFL:	return "Overflow ERR";
+	case ESDMEOF:	return "SDM EOF";
+	}
+
+	return "Default switch case";
+}
+#endif
+
+static void dump_status_reg(unsigned long *status)
+{
+#ifdef DEBUG
+	pr_debug("machxo2 status: 0x%08lX - done=%d, cfgena=%d, busy=%d, fail=%d, devver=%d, err=%s\n",
+		 *status, test_bit(DONE, status), test_bit(ENAB, status),
+		 test_bit(BUSY, status), test_bit(FAIL, status),
+		 test_bit(DVER, status), get_err_string(get_err(status)));
+#endif
+}
+
+static int wait_until_not_busy(struct spi_device *spi)
+{
+	unsigned long status;
+	int ret, loop = 0;
+
+	do {
+		ret = get_status(spi, &status);
+		if (ret)
+			return ret;
+		if (++loop >= MACHXO2_MAX_BUSY_LOOP)
+			return -EBUSY;
+	} while (test_bit(BUSY, &status));
+
+	return 0;
+}
+
+static int machxo2_cleanup(struct fpga_manager *mgr)
+{
+	struct spi_device *spi = mgr->priv;
+	struct spi_message msg;
+	struct spi_transfer tx[2];
+	static const u8 erase[] = ISC_ERASE;
+	static const u8 refresh[] = LSC_REFRESH;
+	int ret;
+
+	memset(tx, 0, sizeof(tx));
+	spi_message_init(&msg);
+	tx[0].tx_buf = &erase;
+	tx[0].len = sizeof(erase);
+	spi_message_add_tail(&tx[0], &msg);
+	ret = spi_sync(spi, &msg);
+	if (ret)
+		goto fail;
+
+	ret = wait_until_not_busy(spi);
+	if (ret)
+		goto fail;
+
+	spi_message_init(&msg);
+	tx[1].tx_buf = &refresh;
+	tx[1].len = sizeof(refresh);
+	tx[1].delay_usecs = MACHXO2_REFRESH_USEC;
+	spi_message_add_tail(&tx[1], &msg);
+	ret = spi_sync(spi, &msg);
+	if (ret)
+		goto fail;
+
+	return 0;
+fail:
+	dev_err(&mgr->dev, "Cleanup failed\n");
+
+	return ret;
+}
+
+static enum fpga_mgr_states machxo2_spi_state(struct fpga_manager *mgr)
+{
+	struct spi_device *spi = mgr->priv;
+	unsigned long status;
+
+	get_status(spi, &status);
+	if (!test_bit(BUSY, &status) && test_bit(DONE, &status) &&
+	    get_err(&status) == ENOERR)
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static int machxo2_write_init(struct fpga_manager *mgr,
+			      struct fpga_image_info *info,
+			      const char *buf, size_t count)
+{
+	struct spi_device *spi = mgr->priv;
+	struct spi_message msg;
+	struct spi_transfer tx[3];
+	static const u8 enable[] = ISC_ENABLE;
+	static const u8 erase[] = ISC_ERASE;
+	static const u8 initaddr[] = LSC_INITADDRESS;
+	unsigned long status;
+	int ret;
+
+	if ((info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
+		dev_err(&mgr->dev,
+			"Partial reconfiguration is not supported\n");
+		return -ENOTSUPP;
+	}
+
+	get_status(spi, &status);
+	dump_status_reg(&status);
+	memset(tx, 0, sizeof(tx));
+	spi_message_init(&msg);
+	tx[0].tx_buf = &enable;
+	tx[0].len = sizeof(enable);
+	tx[0].delay_usecs = MACHXO2_LOW_DELAY_USEC;
+	spi_message_add_tail(&tx[0], &msg);
+
+	tx[1].tx_buf = &erase;
+	tx[1].len = sizeof(erase);
+	spi_message_add_tail(&tx[1], &msg);
+	ret = spi_sync(spi, &msg);
+	if (ret)
+		goto fail;
+
+	ret = wait_until_not_busy(spi);
+	if (ret)
+		goto fail;
+
+	get_status(spi, &status);
+	if (test_bit(FAIL, &status))
+		goto fail;
+	dump_status_reg(&status);
+
+	spi_message_init(&msg);
+	tx[2].tx_buf = &initaddr;
+	tx[2].len = sizeof(initaddr);
+	spi_message_add_tail(&tx[2], &msg);
+	ret = spi_sync(spi, &msg);
+	if (ret)
+		goto fail;
+
+	get_status(spi, &status);
+	dump_status_reg(&status);
+
+	return 0;
+fail:
+	dev_err(&mgr->dev, "Error during FPGA init.\n");
+
+	return ret;
+}
+
+static int machxo2_write(struct fpga_manager *mgr, const char *buf,
+			 size_t count)
+{
+	struct spi_device *spi = mgr->priv;
+	struct spi_message msg;
+	struct spi_transfer tx;
+	static const u8 progincr[] = LSC_PROGINCRNV;
+	u8 payload[MACHXO2_BUF_SIZE];
+	unsigned long status;
+	int i, ret;
+
+	if (count % MACHXO2_PAGE_SIZE != 0) {
+		dev_err(&mgr->dev, "Malformed payload.\n");
+		return -EINVAL;
+	}
+	get_status(spi, &status);
+	dump_status_reg(&status);
+	memcpy(payload, &progincr, sizeof(progincr));
+	for (i = 0; i < count; i += MACHXO2_PAGE_SIZE) {
+		memcpy(&payload[sizeof(progincr)], &buf[i], MACHXO2_PAGE_SIZE);
+		memset(&tx, 0, sizeof(tx));
+		spi_message_init(&msg);
+		tx.tx_buf = payload;
+		tx.len = MACHXO2_BUF_SIZE;
+		tx.delay_usecs = MACHXO2_HIGH_DELAY_USEC;
+		spi_message_add_tail(&tx, &msg);
+		ret = spi_sync(spi, &msg);
+		if (ret) {
+			dev_err(&mgr->dev, "Error loading the bitstream.\n");
+			return ret;
+		}
+	}
+	get_status(spi, &status);
+	dump_status_reg(&status);
+
+	return 0;
+}
+
+static int machxo2_write_complete(struct fpga_manager *mgr,
+				  struct fpga_image_info *info)
+{
+	struct spi_device *spi = mgr->priv;
+	struct spi_message msg;
+	struct spi_transfer tx[2];
+	static const u8 progdone[] = ISC_PROGRAMDONE;
+	static const u8 refresh[] = LSC_REFRESH;
+	unsigned long status;
+	int ret, refreshloop = 0;
+
+	memset(tx, 0, sizeof(tx));
+	spi_message_init(&msg);
+	tx[0].tx_buf = &progdone;
+	tx[0].len = sizeof(progdone);
+	spi_message_add_tail(&tx[0], &msg);
+	ret = spi_sync(spi, &msg);
+	if (ret)
+		goto fail;
+	ret = wait_until_not_busy(spi);
+	if (ret)
+		goto fail;
+
+	get_status(spi, &status);
+	dump_status_reg(&status);
+	if (!test_bit(DONE, &status)) {
+		machxo2_cleanup(mgr);
+		goto fail;
+	}
+
+	do {
+		spi_message_init(&msg);
+		tx[1].tx_buf = &refresh;
+		tx[1].len = sizeof(refresh);
+		tx[1].delay_usecs = MACHXO2_REFRESH_USEC;
+		spi_message_add_tail(&tx[1], &msg);
+		ret = spi_sync(spi, &msg);
+		if (ret)
+			goto fail;
+
+		/* check refresh status */
+		get_status(spi, &status);
+		dump_status_reg(&status);
+		if (!test_bit(BUSY, &status) && test_bit(DONE, &status) &&
+		    get_err(&status) == ENOERR)
+			break;
+		if (++refreshloop == MACHXO2_MAX_REFRESH_LOOP) {
+			machxo2_cleanup(mgr);
+			goto fail;
+		}
+	} while (1);
+
+	get_status(spi, &status);
+	dump_status_reg(&status);
+
+	return 0;
+fail:
+	dev_err(&mgr->dev, "Refresh failed.\n");
+
+	return ret;
+}
+
+static const struct fpga_manager_ops machxo2_ops = {
+	.state = machxo2_spi_state,
+	.write_init = machxo2_write_init,
+	.write = machxo2_write,
+	.write_complete = machxo2_write_complete,
+};
+
+static int machxo2_spi_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct fpga_manager *mgr;
+
+	if (spi->max_speed_hz > MACHXO2_MAX_SPEED) {
+		dev_err(dev, "Speed is too high\n");
+		return -EINVAL;
+	}
+
+	mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
+	if (!mgr)
+		return -ENOMEM;
+
+	mgr->parent = dev;
+	mgr->name = "Lattice MachXO2 SPI FPGA Manager";
+	mgr->mops = &machxo2_ops;
+	mgr->priv = spi;
+	spi_set_drvdata(spi, mgr);
+
+	return fpga_mgr_register(mgr);
+}
+
+static int machxo2_spi_remove(struct spi_device *spi)
+{
+	struct fpga_manager *mgr = spi_get_drvdata(spi);
+
+	fpga_mgr_unregister(mgr);
+
+	return 0;
+}
+
+static const struct of_device_id of_match[] = {
+	{ .compatible = "lattice,machxo2-slave-spi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_match);
+
+static const struct spi_device_id lattice_ids[] = {
+	{ "machxo2-slave-spi", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, lattice_ids);
+
+static struct spi_driver machxo2_spi_driver = {
+	.driver = {
+		.name = "machxo2-slave-spi",
+		.of_match_table = of_match_ptr(of_match),
+	},
+	.probe = machxo2_spi_probe,
+	.remove = machxo2_spi_remove,
+	.id_table = lattice_ids,
+};
+
+module_spi_driver(machxo2_spi_driver)
+
+MODULE_AUTHOR("Paolo Pisati <p.pisati@gmail.com>");
+MODULE_DESCRIPTION("Load Lattice FPGA firmware over SPI");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
