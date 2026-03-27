Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B8390996
	for <linux-fpga@vger.kernel.org>; Fri, 27 Mar 2026 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612138; cv=none; b=EIotOOzTAH7s5FbwXXylm67oGBwwmnC97GEFfSQIjAf7Yzk7QMeP2s59W1EMM2b86FKW4mLnWf4Q5/opyU956l4nOqKGpNkRb0yer1+cwmespP5xWsIA2/kmJVC0S3njYHrthMj3hIlLOEaULQkedAbtP93RGbsmCuUGIzBNMGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612138; c=relaxed/simple;
	bh=KVNBLzsJSlo69J81bVVT04FUHX00uKtaPw+6RZMH99o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmKTOLIhwzApRbEpAsVkqaGMHuxdTdWp2jodaIoAdyF6p8vvWcAlfq+43upTYqnTeUEQ/6uqfLDvk2o+LNEzcAJrLpX8MTcFkn/0xgMGBs1goKVBWuoE8MVGQfRHUulMUr7IRqOt2hUTYbA5uLktPiaqiwJ7mTRr55dz1ONvjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXA7dLMR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXA7dLMR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483487335c2so21872545e9.2
        for <linux-fpga@vger.kernel.org>; Fri, 27 Mar 2026 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774612135; x=1775216935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFBGm0691jNrch3w/l7G28yS+4rdPlF/SBkrUrWasg8=;
        b=DXA7dLMR1k6tw3d1/z1uBZ1oQ9tRXkDwMtpkoJWSC8PsLSV4qVuzw9AMFI00kZ8pmk
         /U1lq8Lc68Webbdup3Tazy6byCUtScb7lUOMQV4pvI2P/7i6VDiNboRTSzf8888D5gEC
         A2+SsgtDBbDpvTIVFPCGTzJlQmvAcMGlFZGOXC9vryTix06w+5pVweAIpQjIE9L+FYp4
         SiwFS0hgMrn2H+6TT09jz17HeVE75PGrHC72pSy0KSrtoaxJB/I05FzbpuHa5Sa2lLXW
         YqJg2xnpRT+nM1c1iDZA+egAHTZwLvz7o/JOauQSyw4BXyU7DR/XuqbQmaql+mY7r/NX
         sCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774612135; x=1775216935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JFBGm0691jNrch3w/l7G28yS+4rdPlF/SBkrUrWasg8=;
        b=aYg/HUav9OnYiZYePk1nZRaYctGsB15lWU4pf4X8Mykk118yuyuoF+OOoanHGcJ8R7
         f7W8SD6lKg1jFX3vFyhBfFPLj2y/gb/2+BC4zgHL3jjrkFz215iTSOn3RnRe+k9NEHxK
         6n68/xqIixXp6uOdCFPsfeRR+TApqBRaOlC4olYXrFtVQZ1wsLe1UmZf49MjspTh/XmT
         PAOBRbnHajtfbyfJvCUSkijZVfjwHrhvSQpvxR9b+sin/eRe3+mXa2QM0zxzoMuTxHd8
         NpyA8VrSJLAWN8UyFjjBy4Zvy7s3reJIvXuuFQFYkDSc6HIown5f+ZDQUItS/TumL47s
         UTuA==
X-Gm-Message-State: AOJu0YyzLTbPEThJgq1sDb8Kjq0b+tLwonRzWgcnoQL+jLL0YGlRjUM0
	y20MpdGli31wAMrf4RWcWSlmK5HK9GNOkF+OQ17JSJzQQCObgpNekPSLzGG/hTt+
X-Gm-Gg: ATEYQzycfEaQfnwjxcRgleBi9/yfqJakKLMfodGLw9dXDrTKdsiKVha5mnNGAd1js3s
	U5WxWqw9uzTNcuK7vbjdJ8wPWHD+yDFb+sU2DlAtwabT1LL9G2cSksPIKF4JsulRkksb/69cUhG
	LViu8+ukS9Y+iYCz5HENZ1jbs+BUGsCV4yt9TYqFlfwbpFrgJhx6c281UhzcacRyQyrSnRwt3md
	Taba6RiodI+QJvLeyVysKX+eUEEHsXifElcc4OVwuviUUVZowuDkTpeBIhuzZiw5zLV2LZmnTiD
	+VzlW4UFQ67P/7cbzIV2wCFSR1Y1/fSzkVFKREC6ytbYFZ1xT0/RQJ6opNpUQKOevDGj3TCJGn4
	z9VLRM9uVSsHqYXlQTjHNSY3oDYdXQnqtp9q4H0WUqJNxy2sUbg9bZAiKXJexlo6NPAfbWvXDws
	3Cg589Jg3XKLNWiBZ3M1UNceSYewrJEPVxM1OY56nxflDBc1vR8fMU4mFaTamLSqBQ1p6zTs2QF
	Gr/Sx/bWN1e9uIZiwBJMacDOw==
X-Received: by 2002:a05:600c:4e0d:b0:487:1c2:6a4f with SMTP id 5b1f17b1804b1-487280c2c50mr37164825e9.31.1774612134818;
        Fri, 27 Mar 2026 04:48:54 -0700 (PDT)
Received: from iris-Ian.fritz.box (p200300eb5f28a7005a7787565d4257d0.dip0.t-ipconnect.de. [2003:eb:5f28:a700:5a77:8756:5d42:57d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d49c18sm90506115e9.14.2026.03.27.04.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 04:48:54 -0700 (PDT)
From: iansdannapel@gmail.com
To: linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mdf@kernel.org,
	yilun.xu@intel.com,
	trix@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	heiko@sntech.de,
	marex@nabladev.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	dev@kael-k.io,
	Ian Dannapel <iansdannapel@gmail.com>
Subject: [PATCH v6 3/3] fpga-mgr: Add Efinix SPI programming driver
Date: Fri, 27 Mar 2026 12:48:41 +0100
Message-ID: <20260327114842.1300284-4-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327114842.1300284-1-iansdannapel@gmail.com>
References: <20260327114842.1300284-1-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ian Dannapel <iansdannapel@gmail.com>

Add a new driver for loading binary firmware to configuration
RAM using "SPI passive mode" on Efinix FPGAs.

Efinix passive SPI configuration requires chip select to remain asserted
from reset until the complete bitstream and trailing idle clocks have
been transferred, so the driver keeps CS active with cs_change and locks
the SPI bus for the duration of configuration.

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
---
 drivers/fpga/Kconfig      |   7 +
 drivers/fpga/Makefile     |   1 +
 drivers/fpga/efinix-spi.c | 263 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 271 insertions(+)
 create mode 100644 drivers/fpga/efinix-spi.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 37b35f58f0df..748fc210c135 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -288,6 +288,13 @@ config FPGA_MGR_LATTICE_SYSCONFIG_SPI
 	  FPGA manager driver support for Lattice FPGAs programming over slave
 	  SPI sysCONFIG interface.
 
+config FPGA_MGR_EFINIX_SPI
+	tristate "Efinix FPGA configuration over SPI"
+	depends on SPI
+	help
+	  FPGA manager driver support for Efinix FPGAs configuration over SPI
+	  (passive mode only).
+
 source "drivers/fpga/tests/Kconfig"
 
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index aeb89bb13517..21eb0ef1fc2e 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
 obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI)	+= microchip-spi.o
 obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG)	+= lattice-sysconfig.o
 obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI)	+= lattice-sysconfig-spi.o
+obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)	+= efinix-spi.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
 
diff --git a/drivers/fpga/efinix-spi.c b/drivers/fpga/efinix-spi.c
new file mode 100644
index 000000000000..5cd6de0c5411
--- /dev/null
+++ b/drivers/fpga/efinix-spi.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FPGA Manager Driver for Efinix
+ *
+ * Copyright (C) 2025 iris-GmbH infrared & intelligent sensors
+ *
+ * Ian Dannapel <iansdannapel@gmail.com>
+ *
+ * Load Efinix FPGA firmware over SPI using the serial configuration interface.
+ *
+ * Note: Only passive mode (host initiates transfer) is currently supported.
+ */
+
+#include <linux/delay.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+
+/*
+ * 13 dummy bytes generate 104 SPI clock cycles (8 bits each).
+ * Used to meet the requirement for >100 clock cycles idle sequence.
+ */
+#define EFINIX_SPI_IDLE_CYCLES_BYTES 13
+
+/*
+ * tDMIN: Minimum time between deassertion of CRESET_N to first
+ * valid configuration data. (32 µs)
+ */
+#define EFINIX_TDMIN_US_MIN    35
+#define EFINIX_TDMIN_US_MAX    40
+
+/*
+ * tCRESET_N: Minimum CRESET_N low pulse width required to
+ * trigger re-configuration. (320 ns)
+ */
+#define EFINIX_TCRESETN_DELAY_MIN_US  1
+#define EFINIX_TCRESETN_DELAY_MAX_US  2
+
+/*
+ * tUSER: Minimum configuration duration after CDONE goes high
+ * before entering user mode. (25 µs)
+ */
+#define EFINIX_TUSER_US_MIN    30
+#define EFINIX_TUSER_US_MAX    35
+
+struct efinix_spi_conf {
+	struct spi_device *spi;
+	struct gpio_desc *cdone;
+	struct gpio_desc *reset;
+};
+
+static void efinix_spi_reset(struct efinix_spi_conf *conf)
+{
+	gpiod_set_value(conf->reset, 1);
+	usleep_range(EFINIX_TCRESETN_DELAY_MIN_US, EFINIX_TCRESETN_DELAY_MAX_US);
+	gpiod_set_value(conf->reset, 0);
+	usleep_range(EFINIX_TDMIN_US_MIN, EFINIX_TDMIN_US_MAX);
+}
+
+static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+
+	if (conf->cdone && gpiod_get_value(conf->cdone) == 1)
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static int efinix_spi_write_init(struct fpga_manager *mgr,
+				 struct fpga_image_info *info,
+				 const char *buf, size_t count)
+{
+	struct device *dev = &mgr->dev;
+	struct efinix_spi_conf *conf = mgr->priv;
+	struct spi_transfer assert_cs = {
+		.cs_change = 1,
+	};
+	struct spi_message message;
+	int ret;
+
+	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
+		dev_err(dev, "Partial reconfiguration not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * Efinix passive SPI configuration requires chip select to stay
+	 * asserted from reset until the bitstream is fully clocked in.
+	 * Lock the SPI bus so no other device can toggle CS between the
+	 * reset pulse and the write/complete transfers.
+	 */
+	spi_bus_lock(conf->spi->controller);
+	spi_message_init_with_transfers(&message, &assert_cs, 1);
+	ret = spi_sync_locked(conf->spi, &message);
+	if (ret) {
+		spi_bus_unlock(conf->spi->controller);
+		return ret;
+	}
+
+	/* Reset with CS asserted */
+	efinix_spi_reset(conf);
+
+	return 0;
+}
+
+static int efinix_spi_write(struct fpga_manager *mgr, const char *buf,
+			    size_t count)
+{
+	struct device *dev = &mgr->dev;
+	struct spi_transfer write_xfer = {
+		.tx_buf = buf,
+		.len = count,
+		.cs_change = 1, /* Keep CS asserted */
+	};
+	struct efinix_spi_conf *conf = mgr->priv;
+	struct spi_message message;
+	int ret;
+
+	spi_message_init_with_transfers(&message, &write_xfer, 1);
+	ret = spi_sync_locked(conf->spi, &message);
+	if (ret) {
+		dev_err(dev, "SPI error in firmware write: %d\n", ret);
+		spi_bus_unlock(conf->spi->controller);
+	}
+
+	return ret;
+}
+
+static int efinix_spi_write_complete(struct fpga_manager *mgr,
+				     struct fpga_image_info *info)
+{
+	unsigned long timeout =
+		jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
+	struct spi_transfer clk_cycles = {
+		.len = EFINIX_SPI_IDLE_CYCLES_BYTES,
+		/* Release CS after the trailing idle clocks are sent. */
+		.cs_change = 0,
+	};
+	struct efinix_spi_conf *conf = mgr->priv;
+	struct spi_message message;
+	int done, ret;
+	bool expired = false;
+	u8 *dummy_buf;
+
+	dummy_buf = kzalloc(EFINIX_SPI_IDLE_CYCLES_BYTES, GFP_KERNEL);
+	if (!dummy_buf) {
+		ret = -ENOMEM;
+		goto unlock_spi;
+	}
+
+	/*
+	 * Keep the bus locked while sending the trailing idle clocks, then
+	 * let this final transfer deassert CS to terminate configuration.
+	 */
+	clk_cycles.tx_buf = dummy_buf;
+	spi_message_init_with_transfers(&message, &clk_cycles, 1);
+	ret = spi_sync_locked(conf->spi, &message);
+	if (ret) {
+		dev_err(&mgr->dev, "SPI error in write complete: %d\n", ret);
+		goto free_buf;
+	}
+
+	if (conf->cdone) {
+		while (!expired) {
+			done = gpiod_get_value(conf->cdone);
+			if (done < 0) {
+				ret = done;
+				goto free_buf;
+			}
+			if (done)
+				break;
+
+			usleep_range(10, 20);
+			expired = time_after(jiffies, timeout);
+		}
+
+		if (expired) {
+			dev_err(&mgr->dev, "Timeout waiting for CDONE\n");
+			ret = -ETIMEDOUT;
+			goto free_buf;
+		}
+	}
+
+	usleep_range(EFINIX_TUSER_US_MIN, EFINIX_TUSER_US_MAX);
+
+free_buf:
+	kfree(dummy_buf);
+unlock_spi:
+	spi_bus_unlock(conf->spi->controller);
+
+	return ret;
+}
+
+static const struct fpga_manager_ops efinix_spi_ops = {
+	.state = efinix_spi_state,
+	.write_init = efinix_spi_write_init,
+	.write = efinix_spi_write,
+	.write_complete = efinix_spi_write_complete,
+};
+
+static int efinix_spi_probe(struct spi_device *spi)
+{
+	struct efinix_spi_conf *conf;
+	struct fpga_manager *mgr;
+
+	if (!(spi->mode & SPI_CPHA) || !(spi->mode & SPI_CPOL))
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "Unsupported SPI mode, set CPHA and CPOL\n");
+
+	conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
+	if (!conf)
+		return -ENOMEM;
+
+	conf->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->reset))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->reset),
+				     "Failed to get RESET gpio\n");
+
+	conf->cdone = devm_gpiod_get_optional(&spi->dev, "cdone", GPIOD_IN);
+	if (IS_ERR(conf->cdone))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->cdone),
+				     "Failed to get CDONE gpio\n");
+
+	conf->spi = spi;
+
+	mgr = devm_fpga_mgr_register(&spi->dev,
+				     "Efinix FPGA Manager",
+				     &efinix_spi_ops, conf);
+
+	return PTR_ERR_OR_ZERO(mgr);
+}
+
+static const struct of_device_id efinix_spi_of_match[] = {
+	{ .compatible = "efinix,trion-config", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, efinix_spi_of_match);
+
+static const struct spi_device_id efinix_ids[] = {
+	{ "trion-config", 0 },
+	{ "titanium-config", 0 },
+	{ "topaz-config", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, efinix_ids);
+
+static struct spi_driver efinix_spi_driver = {
+	.driver = {
+		.name = "efinix-spi",
+		.of_match_table = efinix_spi_of_match,
+	},
+	.probe = efinix_spi_probe,
+	.id_table = efinix_ids,
+};
+
+module_spi_driver(efinix_spi_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ian Dannapel <iansdannapel@gmail.com>");
+MODULE_DESCRIPTION("Efinix FPGA SPI Programming Driver");
-- 
2.43.0

