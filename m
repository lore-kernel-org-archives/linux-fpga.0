Return-Path: <SRS0=xl3R=BS=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=xl3R=BS=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:52874 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbdJSWPM (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 19 Oct 2017 18:15:12 -0400
From: matthew.gerlach@linux.intel.com
Subject: [PATCH v3 2/2] mtd: spi-nor: Altera ASMI Parallel II IP Core
Date: Thu, 19 Oct 2017 15:14:50 -0700
Message-Id: <1508451290-26426-3-git-send-email-matthew.gerlach@linux.intel.com>
In-Reply-To: <1508451290-26426-1-git-send-email-matthew.gerlach@linux.intel.com>
References: <1508451290-26426-1-git-send-email-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: vndao@altera.com, dwmw2@infradead.org, computersforpeace@gmail.com, boris.brezillon@free-electrons.com, marek.vasut@gmail.com, richard@nod.at, cyrille.pitchen@wedev4u.fr, robh+dt@kernel.org, mark.rutland@arm.com, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, davem@davemloft.net, mchehab@kernel.org, linux-fpga@vger.kernel.org, tien.hock.loh@intel.com, hean.loong.ong@intel.com
Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patch adds support for a spi-nor, platform driver for the
Altera ASMI Parallel II IP Core.  The intended use case is to be able
to update the flash used to load a FPGA at power up with mtd-utils.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v2:
    minor checkpatch fixing by Wu Hao <hao.wu@intel.com>
    Use read_dummy value as suggested by Cyrille Pitchen.
    Don't assume 4 byte addressing (Cryille Pichecn and Marek Vasut).
    Fixed #define indenting as suggested by Marek Vasut.
    Added units to timer values as suggested by Marek Vasut.
    Use io(read|write)8_rep() as suggested by Marek Vasut.
    Renamed function prefixed with __ as suggested by Marek Vasut.

v3: make timeout a function of clock frequency (Marek Vasut)
---
 MAINTAINERS                         |   7 +
 drivers/mtd/spi-nor/Kconfig         |   6 +
 drivers/mtd/spi-nor/Makefile        |   1 +
 drivers/mtd/spi-nor/altera-asmip2.c | 494 ++++++++++++++++++++++++++++++++++++
 include/linux/mtd/altera-asmip2.h   |  25 ++
 5 files changed, 533 insertions(+)
 create mode 100644 drivers/mtd/spi-nor/altera-asmip2.c
 create mode 100644 include/linux/mtd/altera-asmip2.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0630482..620d151 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -656,6 +656,13 @@ ALPS PS/2 TOUCHPAD DRIVER
 R:	Pali Rohár <pali.rohar@gmail.com>
 F:	drivers/input/mouse/alps.*
 
+ALTERA ASMI Parallel II Driver
+M:      Matthew Gerlach <matthew.gerlach@linux.intel.com>
+L:      linux-mtd@lists.infradead.org
+S:      Maintained
+F:      drivers/mtd/spi-nor/altera-asmip2.c
+F:      inclulde/linux/mtd/altera-asmip2.h
+
 ALTERA I2C CONTROLLER DRIVER
 M:	Thor Thayer <thor.thayer@linux.intel.com>
 S:	Maintained
diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index f26aaa6..b441e45 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -129,4 +129,10 @@ config SPI_STM32_QUADSPI
 	  This enables support for the STM32 Quad SPI controller.
 	  We only connect the NOR to this controller.
 
+config SPI_ALTERA_ASMIP2
+        tristate "Altera ASMI Parallel II IP"
+        depends on OF && HAS_IOMEM
+        help
+          Enable support for Altera ASMI Parallel II.
+
 endif # MTD_SPI_NOR
diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 7d84c51..1c79324 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
+obj-$(CONFIG_SPI_ALTERA_ASMIP2)	+= altera-asmip2.o
 obj-$(CONFIG_SPI_ASPEED_SMC)	+= aspeed-smc.o
 obj-$(CONFIG_SPI_ATMEL_QUADSPI)	+= atmel-quadspi.o
 obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= cadence-quadspi.o
diff --git a/drivers/mtd/spi-nor/altera-asmip2.c b/drivers/mtd/spi-nor/altera-asmip2.c
new file mode 100644
index 0000000..6bd7cd2
--- /dev/null
+++ b/drivers/mtd/spi-nor/altera-asmip2.c
@@ -0,0 +1,494 @@
+/*
+ * Copyright (C) 2017 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mtd/altera-asmip2.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/spi-nor.h>
+#include <linux/of_device.h>
+
+#define QSPI_ACTION_REG			0
+#define QSPI_ACTION_RST			BIT(0)
+#define QSPI_ACTION_EN			BIT(1)
+#define QSPI_ACTION_SC			BIT(2)
+#define QSPI_ACTION_CHIP_SEL_SFT	4
+#define QSPI_ACTION_DUMMY_SFT		8
+#define QSPI_ACTION_READ_BACK_SFT	16
+
+#define QSPI_FIFO_CNT_REG		4
+#define QSPI_FIFO_DEPTH			0x200
+#define QSPI_FIFO_CNT_MSK		0x3ff
+#define QSPI_FIFO_CNT_RX_SFT		0
+#define QSPI_FIFO_CNT_TX_SFT		12
+
+#define QSPI_DATA_REG			0x8
+
+#define QSPI_POLL_INTERVAL_US		5
+
+struct altera_asmip2 {
+	u64 clk_hz;
+	void __iomem *csr_base;
+	u32 num_flashes;
+	struct device *dev;
+	struct altera_asmip2_flash *flash[ALTERA_ASMIP2_MAX_NUM_FLASH_CHIP];
+	struct mutex bus_mutex;
+};
+
+struct altera_asmip2_flash {
+	struct spi_nor nor;
+	struct altera_asmip2 *q;
+};
+
+static u64 altera_asmip2_calc_to(struct altera_asmip2 *q, int num_bytes)
+{
+	u64 ms;
+
+	ms = 2 * 1000 * num_bytes;
+	do_div(ms, q->clk_hz);
+	ms += ms + 200;
+	ms *= 1000;
+        return ms;
+}
+
+static int altera_asmip2_write_reg(struct spi_nor *nor, u8 opcode, u8 *val,
+				    int len)
+{
+	struct altera_asmip2_flash *flash = nor->priv;
+	struct altera_asmip2 *q = flash->q;
+	u32 reg;
+	int ret;
+
+	if ((len + 1) > QSPI_FIFO_DEPTH) {
+		dev_err(q->dev, "%s bad len %d > %d\n",
+			__func__, len + 1, QSPI_FIFO_DEPTH);
+		return -EINVAL;
+	}
+
+	writeb(opcode, q->csr_base + QSPI_DATA_REG);
+
+	iowrite8_rep(q->csr_base + QSPI_DATA_REG, val, len);
+
+	reg = QSPI_ACTION_EN | QSPI_ACTION_SC;
+
+	writel(reg, q->csr_base + QSPI_ACTION_REG);
+
+	ret = readl_poll_timeout(q->csr_base + QSPI_FIFO_CNT_REG, reg,
+				 (((reg >> QSPI_FIFO_CNT_TX_SFT) &
+				 QSPI_FIFO_CNT_MSK) == 0),
+				 QSPI_POLL_INTERVAL_US,
+				 altera_asmip2_calc_to(q, 1 + len));
+	if (ret)
+		dev_err(q->dev, "%s timed out\n", __func__);
+
+	reg = QSPI_ACTION_EN;
+
+	writel(reg, q->csr_base + QSPI_ACTION_REG);
+
+	return ret;
+}
+
+static int altera_asmip2_read_reg(struct spi_nor *nor, u8 opcode, u8 *val,
+				   int len)
+{
+	struct altera_asmip2_flash *flash = nor->priv;
+	struct altera_asmip2 *q = flash->q;
+	u32 reg;
+	int ret;
+
+	if (len > QSPI_FIFO_DEPTH) {
+		dev_err(q->dev, "%s bad len %d > %d\n",
+			__func__, len, QSPI_FIFO_DEPTH);
+		return -EINVAL;
+	}
+
+	writeb(opcode, q->csr_base + QSPI_DATA_REG);
+
+	reg = QSPI_ACTION_EN | QSPI_ACTION_SC |
+		(len << QSPI_ACTION_READ_BACK_SFT);
+
+	writel(reg, q->csr_base + QSPI_ACTION_REG);
+
+	ret = readl_poll_timeout(q->csr_base + QSPI_FIFO_CNT_REG, reg,
+				 ((reg & QSPI_FIFO_CNT_MSK) == len),
+				 QSPI_POLL_INTERVAL_US,
+				 altera_asmip2_calc_to(q, 1 + len));
+
+	if (!ret)
+		ioread8_rep(q->csr_base + QSPI_DATA_REG, val, len);
+	else
+		dev_err(q->dev, "%s timeout\n", __func__);
+
+	writel(QSPI_ACTION_EN, q->csr_base + QSPI_ACTION_REG);
+
+	return ret;
+}
+
+static inline void altera_asmip2_push_offset(struct altera_asmip2 *q,
+					     struct spi_nor *nor,
+					     loff_t offset)
+{
+	int i;
+	u32 val;
+
+	for (i = (nor->addr_width - 1) * 8; i >= 0; i -= 8) {
+		val = (offset & (0xff << i)) >> i;
+		writeb(val, q->csr_base + QSPI_DATA_REG);
+	}
+}
+
+static ssize_t altera_asmip2_read(struct spi_nor *nor, loff_t from, size_t len,
+				   u_char *buf)
+{
+	struct altera_asmip2_flash *flash = nor->priv;
+	struct altera_asmip2 *q = flash->q;
+	size_t bytes_to_read;
+	u32 reg;
+	int ret;
+	u64 time;
+
+	bytes_to_read = min_t(size_t, len, QSPI_FIFO_DEPTH);
+
+	writeb(nor->read_opcode, q->csr_base + QSPI_DATA_REG);
+
+	altera_asmip2_push_offset(q, nor, from);
+
+	reg = QSPI_ACTION_EN | QSPI_ACTION_SC |
+		(10 << QSPI_ACTION_DUMMY_SFT) |
+		(bytes_to_read << QSPI_ACTION_READ_BACK_SFT);
+
+	time= altera_asmip2_calc_to(q, 1 + nor->addr_width + bytes_to_read);
+
+	writel(reg, q->csr_base + QSPI_ACTION_REG);
+
+	ret = readl_poll_timeout(q->csr_base + QSPI_FIFO_CNT_REG, reg,
+				 ((reg & QSPI_FIFO_CNT_MSK) ==
+				 bytes_to_read), QSPI_POLL_INTERVAL_US,
+				 time);
+	if (ret) {
+		dev_err(q->dev, "%s timed out\n", __func__);
+		bytes_to_read = 0;
+	} else
+		ioread8_rep(q->csr_base + QSPI_DATA_REG, buf, bytes_to_read);
+
+	writel(QSPI_ACTION_EN, q->csr_base + QSPI_ACTION_REG);
+
+	return bytes_to_read;
+}
+
+static ssize_t altera_asmip2_write(struct spi_nor *nor, loff_t to,
+				    size_t len, const u_char *buf)
+{
+	struct altera_asmip2_flash *flash = nor->priv;
+	struct altera_asmip2 *q = flash->q;
+	size_t bytes_to_write;
+	u32 reg;
+	int ret;
+	u64 time;
+
+	bytes_to_write = min_t(size_t, len,
+			       (QSPI_FIFO_DEPTH - (nor->addr_width + 1)));
+
+	writeb(nor->program_opcode, q->csr_base + QSPI_DATA_REG);
+
+	altera_asmip2_push_offset(q, nor, to);
+
+	iowrite8_rep(q->csr_base + QSPI_DATA_REG, buf, bytes_to_write);
+
+	reg = QSPI_ACTION_EN | QSPI_ACTION_SC;
+
+	time = altera_asmip2_calc_to(q, 1 + nor->addr_width + bytes_to_write);
+
+	writel(reg, q->csr_base + QSPI_ACTION_REG);
+
+	ret = readl_poll_timeout(q->csr_base + QSPI_FIFO_CNT_REG, reg,
+				 (((reg >> QSPI_FIFO_CNT_TX_SFT) &
+				 QSPI_FIFO_CNT_MSK) == 0),
+				 QSPI_POLL_INTERVAL_US, time);
+
+	if (ret) {
+		dev_err(q->dev,
+			"%s timed out waiting for fifo to clear\n",
+			__func__);
+		bytes_to_write = 0;
+	}
+
+	writel(QSPI_ACTION_EN, q->csr_base + QSPI_ACTION_REG);
+
+	return bytes_to_write;
+}
+
+static int altera_asmip2_prep(struct spi_nor *nor, enum spi_nor_ops ops)
+{
+	struct altera_asmip2_flash *flash = nor->priv;
+	struct altera_asmip2 *q = flash->q;
+
+	mutex_lock(&q->bus_mutex);
+
+	return 0;
+}
+
+static void altera_asmip2_unprep(struct spi_nor *nor, enum spi_nor_ops ops)
+{
+	struct altera_asmip2_flash *flash = nor->priv;
+	struct altera_asmip2 *q = flash->q;
+
+	mutex_unlock(&q->bus_mutex);
+}
+
+static int altera_asmip2_setup_banks(struct device *dev,
+				      u32 bank, struct device_node *np)
+{
+	const struct spi_nor_hwcaps hwcaps = {
+		.mask = SNOR_HWCAPS_READ |
+			SNOR_HWCAPS_READ_FAST |
+			SNOR_HWCAPS_PP,
+	};
+	struct altera_asmip2 *q = dev_get_drvdata(dev);
+	struct altera_asmip2_flash *flash;
+	struct spi_nor *nor;
+	int ret = 0;
+
+	if (bank > q->num_flashes - 1)
+		return -EINVAL;
+
+	flash = devm_kzalloc(q->dev, sizeof(*flash), GFP_KERNEL);
+	if (!flash)
+		return -ENOMEM;
+
+	q->flash[bank] = flash;
+	flash->q = q;
+
+	nor = &flash->nor;
+	nor->dev = dev;
+	nor->priv = flash;
+	nor->mtd.priv = nor;
+	spi_nor_set_flash_node(nor, np);
+
+	/* spi nor framework*/
+	nor->read_reg = altera_asmip2_read_reg;
+	nor->write_reg = altera_asmip2_write_reg;
+	nor->read = altera_asmip2_read;
+	nor->write = altera_asmip2_write;
+	nor->prepare = altera_asmip2_prep;
+	nor->unprepare = altera_asmip2_unprep;
+
+	ret = spi_nor_scan(nor, NULL, &hwcaps);
+	if (ret) {
+		dev_err(nor->dev, "flash not found\n");
+		return ret;
+	}
+
+	ret =  mtd_device_register(&nor->mtd, NULL, 0);
+
+	return ret;
+}
+
+static int altera_asmip2_create(struct device *dev, void __iomem *csr_base,
+				u64 clk_hz)
+{
+	struct altera_asmip2 *q;
+	u32 reg;
+
+	q = devm_kzalloc(dev, sizeof(*q), GFP_KERNEL);
+	if (!q)
+		return -ENOMEM;
+
+	q->dev = dev;
+	q->clk_hz = clk_hz;
+	q->csr_base = csr_base;
+
+	mutex_init(&q->bus_mutex);
+
+	dev_set_drvdata(dev, q);
+
+	reg = readl(q->csr_base + QSPI_ACTION_REG);
+	if (!(reg & QSPI_ACTION_RST)) {
+		writel((reg | QSPI_ACTION_RST), q->csr_base + QSPI_ACTION_REG);
+		dev_info(dev, "%s asserting reset\n", __func__);
+		udelay(10);
+	}
+
+	writel((reg & ~QSPI_ACTION_RST), q->csr_base + QSPI_ACTION_REG);
+	udelay(10);
+
+	return 0;
+}
+
+static int altera_asmip2_add_bank(struct device *dev,
+			 u32 bank, struct device_node *np)
+{
+	struct altera_asmip2 *q = dev_get_drvdata(dev);
+
+	if (q->num_flashes >= ALTERA_ASMIP2_MAX_NUM_FLASH_CHIP)
+		return -ENOMEM;
+
+	q->num_flashes++;
+
+	return altera_asmip2_setup_banks(dev, bank, np);
+}
+
+static int altera_asmip2_remove_banks(struct device *dev)
+{
+	struct altera_asmip2 *q = dev_get_drvdata(dev);
+	struct altera_asmip2_flash *flash;
+	int i;
+	int ret = 0;
+
+	if (!q)
+		return -EINVAL;
+
+	/* clean up for all nor flash */
+	for (i = 0; i < q->num_flashes; i++) {
+		flash = q->flash[i];
+		if (!flash)
+			continue;
+
+		/* clean up mtd stuff */
+		ret = mtd_device_unregister(&flash->nor.mtd);
+		if (ret) {
+			dev_err(dev, "error removing mtd\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int altera_asmip2_probe_with_pdata(struct platform_device *pdev,
+			     struct altera_asmip2_plat_data *qdata)
+{
+	struct device *dev = &pdev->dev;
+	int ret, i;
+
+	ret = altera_asmip2_create(dev, qdata->csr_base, qdata->clk_hz);
+
+	if (ret) {
+		dev_err(dev, "failed to create qspi device %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < qdata->num_chip_sel; i++) {
+		ret = altera_asmip2_add_bank(dev, i, NULL);
+		if (ret) {
+			dev_err(dev, "failed to add qspi bank %d\n", ret);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int altera_asmip2_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct altera_asmip2_plat_data *qdata;
+	struct resource *res;
+	void __iomem *csr_base;
+	u32 bank;
+	int ret;
+	struct device_node *pp;
+	struct clk *clk;
+
+	qdata = dev_get_platdata(dev);
+
+	if (qdata)
+		return altera_asmip2_probe_with_pdata(pdev, qdata);
+
+	if (!np) {
+		dev_err(dev, "no device tree found %p\n", pdev);
+		return -ENODEV;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	csr_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(csr_base)) {
+		dev_err(dev, "%s: ERROR: failed to map csr base\n", __func__);
+		return PTR_ERR(csr_base);
+	}
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	ret = altera_asmip2_create(dev, csr_base, clk_get_rate(clk));
+
+	if (ret) {
+		dev_err(dev, "failed to create qspi device\n");
+		return ret;
+	}
+
+	for_each_available_child_of_node(np, pp) {
+		of_property_read_u32(pp, "reg", &bank);
+		if (bank >= ALTERA_ASMIP2_MAX_NUM_FLASH_CHIP) {
+			dev_err(dev, "bad reg value %u >= %u\n", bank,
+				ALTERA_ASMIP2_MAX_NUM_FLASH_CHIP);
+			goto error;
+		}
+
+		if (altera_asmip2_add_bank(dev, bank, pp)) {
+			dev_err(dev, "failed to add bank %u\n", bank);
+			goto error;
+		}
+	}
+
+	return 0;
+error:
+	altera_asmip2_remove_banks(dev);
+	return -EIO;
+}
+
+static int altera_asmip2_remove(struct platform_device *pdev)
+{
+	struct altera_asmip2 *q = dev_get_drvdata(&pdev->dev);
+	struct clk *clk;
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (!IS_ERR(clk)){
+		clk_put(clk);
+		clk_disable_unprepare(clk);
+	}
+
+	mutex_destroy(&q->bus_mutex);
+
+	return altera_asmip2_remove_banks(&pdev->dev);
+}
+
+static const struct of_device_id altera_asmip2_id_table[] = {
+	{ .compatible = "altr,asmi-parallel2-spi-nor",},
+	{}
+};
+MODULE_DEVICE_TABLE(of, altera_asmip2_id_table);
+
+static struct platform_driver altera_asmip2_driver = {
+	.driver = {
+		.name = ALTERA_ASMIP2_DRV_NAME,
+		.of_match_table = altera_asmip2_id_table,
+	},
+	.probe = altera_asmip2_probe,
+	.remove = altera_asmip2_remove,
+};
+module_platform_driver(altera_asmip2_driver);
+
+MODULE_AUTHOR("Matthew Gerlach <matthew.gerlach@linux.intel.com>");
+MODULE_DESCRIPTION("Altera ASMI Parallel II");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" ALTERA_ASMIP2_DRV_NAME);
diff --git a/include/linux/mtd/altera-asmip2.h b/include/linux/mtd/altera-asmip2.h
new file mode 100644
index 0000000..3e2392a
--- /dev/null
+++ b/include/linux/mtd/altera-asmip2.h
@@ -0,0 +1,25 @@
+/*
+ *
+ * Copyright 2017 Intel Corporation, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __ALTERA_QUADSPI_H
+#define __ALTERA_QUADSPI_H
+
+#include <linux/device.h>
+
+#define ALTERA_ASMIP2_DRV_NAME "altr-asmip2"
+#define ALTERA_ASMIP2_MAX_NUM_FLASH_CHIP 3
+#define ALTERA_ASMIP2_RESOURCE_SIZE 0x10
+
+struct altera_asmip2_plat_data {
+	u64 clk_hz;
+	void __iomem *csr_base;
+	u32 num_chip_sel;
+};
+
+#endif
-- 
2.7.4

