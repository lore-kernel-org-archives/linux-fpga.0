Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A4D3DE448
	for <linux-fpga@vger.kernel.org>; Thu, 16 Apr 2026 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350575; cv=none; b=qAwOfjsbk1EFQwGXCZsDVNYcOgdsMwXYYqiMVR49CejOBOuLsdbyRAga0Puaq9jRNjxGnydoG9uesnAiArH5j7gXL2EMJTAzezPrzWt7V2baMNWTKPxLxdvYz8wbBJjlMGKfnNgewncwKr2J0TUjwUYoeeDZ634LoLZKEZxveuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350575; c=relaxed/simple;
	bh=/uDCrP20+RBLonFnmFHSKcrJz/plgbzxI5gtj236sBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2P8otE09QrU7km2dhWOMSMqRoNINiYUEMDzUUo8dqwdpbbdBFr5Z2KRXSxJjP6vluaDttE1hHKxAE/T0WLC5DEUFagYLKjIDgeKmmOV46kOwHR5uCcBtJWl2S+BuzHBtsoVKq5IxOSPBr9HWHLaNtbOYNDbDmpzydyYXLB/e5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS4ONn07; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS4ONn07"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9d9971d059so862981266b.2
        for <linux-fpga@vger.kernel.org>; Thu, 16 Apr 2026 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776350572; x=1776955372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pcCmYhJDdOosRH1EaiacreI0Vn1NfK5R9o/k5rgKLY=;
        b=CS4ONn07TcW+Lv3TDZj4fawfxXZrN4v7mDvBgZc+DEZuKZerNcb6EfzepqugOplzxN
         5ZBxMzLF3NE7Tz1L/UEIsr/mgkvT5Ph06y7dOvAtahd3JKFArD0SR3vmpFKgHHML1py1
         vFfTSZxcT892jBSNaxqPI4APtmhs0kAkeudYnytk6ndy/KI3pbs4XvexA05Aiwz36CK6
         tnowmYASz/qn7usBXt80kF9BqgHVr17WnkW8rfnu48rj8MxLzkk1+jIRtEwVeLwMdJwg
         ykWdrHo7Thbz3trFMq9gJNqJaD8RSga2cfqhZsQ/KS4P9q2ap4W1431nl8AFab4EFXZO
         M2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776350572; x=1776955372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6pcCmYhJDdOosRH1EaiacreI0Vn1NfK5R9o/k5rgKLY=;
        b=Ik7PRhyjdD8kEwoxCV/vnZgrSFblmdIysNlj7DKU3LZi/jHCMw6K94zJnoQJmXOA7J
         95A2LDh9ohbn523VMUR8+vbK9rGOk5zLYGvsmVuvubz/MM9WQcUA6fykxFwciUyOReOj
         fvfUpXclXirqJQKgiUMqStXIraxMYHs4WHCYgqrDVc2CKNFrmaFQxh7798tsm74jxyJU
         dWFj0lfPiuVe9iA76QSERRHUhEMhoyRhehT/tRHUUPTvE4oHttrdSaJCbVTEp9vHvpVp
         r8Z6RUwaw3bqvVMHtvPzxrjKMnn2l5gHtU/0qU6IUvEvl23rTpzlFEvaY9/FAyxUl673
         VH0g==
X-Gm-Message-State: AOJu0Yzb6pUdN36XNOGhIoPSkt6uf97yT7hkXUn43Akf5raX6MrnRFfo
	ie5QNt4Y5Br4efE0M36oz8Jmffr1nP/SJAdv0+6LsoudF/63bj80MjaxsBhxj6nv
X-Gm-Gg: AeBDiesat+raNOCuXTt8V8YtnuDCSYmSkdf+z90ws2b5AcTd45TmhQcO042yPHccR5v
	+CPylX9nCS+zy4V3TGfJyUM9hWb6RzPNcCuaicnPEhJg2ckihV8kbX9o5HMloJqL37PSkuBfAqZ
	D5xAksLwhxh3TPqsquQAC669Ts1CZ3aSv5OsskCebkJV3v97IL3chlnq/LxDha6f+pOq6tk7J02
	8xRy4abUcatl19IBbQU53+usmIUdtHjyq85DPmp1UgpPgKkzvNK87PcOB4AsorQrAqJLLwVoZV5
	uCoJoIlfpsormxDZmmMMY8GucYDnM1s144jplMgEJXwlNYA7FOOQbGPrzj+zsO1qKE1tuv3WogM
	aNtiiPq6clH9V4LnUsNP2mJMyY4/Pi5OAOlASY+0YUkhWiCskuPjArFX+bGrW8YxIK8BTxA968M
	cfh69XPAaHvgpF24ZlbUrm7CNnE+ekqORlWwSn
X-Received: by 2002:a17:907:a604:b0:b9d:1a1c:a664 with SMTP id a640c23a62f3a-b9d72991a2dmr1691584266b.40.1776350571983;
        Thu, 16 Apr 2026 07:42:51 -0700 (PDT)
Received: from iris-Ian.. ([2a00:20:636a:3838:3bf9:3a9b:8000:4975])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba2a112cc9csm90502766b.40.2026.04.16.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 07:42:51 -0700 (PDT)
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
Subject: [PATCH v7 3/3] fpga-mgr: Add Efinix SPI programming driver
Date: Thu, 16 Apr 2026 16:42:36 +0200
Message-ID: <20260416144237.373852-4-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416144237.373852-1-iansdannapel@gmail.com>
References: <20260416144237.373852-1-iansdannapel@gmail.com>
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
 drivers/fpga/efinix-spi.c | 260 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)
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
index aeb89bb13517..6f5798b27e0d 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG)	+= lattice-sysconfig.o
 obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI)	+= lattice-sysconfig-spi.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
+obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)	+= efinix-spi.o
 
 # FPGA Secure Update Drivers
 obj-$(CONFIG_FPGA_M10_BMC_SEC_UPDATE)	+= intel-m10-bmc-sec-update.o
diff --git a/drivers/fpga/efinix-spi.c b/drivers/fpga/efinix-spi.c
new file mode 100644
index 000000000000..ed9a41232a32
--- /dev/null
+++ b/drivers/fpga/efinix-spi.c
@@ -0,0 +1,260 @@
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
+	struct efinix_spi_conf *conf = mgr->priv;
+	struct spi_transfer assert_cs = {
+		/* Keep CS asserted across configuration. */
+		.cs_change = 1,
+	};
+	struct spi_message message;
+	int ret;
+
+	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
+		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
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
+	struct spi_transfer write_xfer = {
+		.tx_buf = buf,
+		.len = count,
+		.cs_change = 1,
+	};
+	struct efinix_spi_conf *conf = mgr->priv;
+	struct spi_message message;
+	int ret;
+
+	spi_message_init_with_transfers(&message, &write_xfer, 1);
+	ret = spi_sync_locked(conf->spi, &message);
+	if (ret) {
+		dev_err(&mgr->dev, "SPI error in firmware write: %d\n", ret);
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

