Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7723EA8E;
	Fri, 12 Dec 2025 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538165; cv=none; b=aYjmximqh1lRUJVX8DznvbzuH8BLZXBTl5pKLt8SsQpeA82NEvyApM3VfYYHf7hMEeh2eA3KuIZm0XgYDcwzGb3shaUHNwKIS4KwovTNR2wuGW175jzdMtl1ft5RKnZ0wdyNiTZ+icJgg3XgptQhitSvk4pfu3MJc9wsdj+KzbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538165; c=relaxed/simple;
	bh=E9DxA+WVnBPjhvpzyGCHqusnyIlxrYm6SnS1VojP4u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxTO1xWo98w3brI0xY0xLGFW/vjgbZWNlmL45VzVF43oDUFjJRmfjnsQN3EZVzGiynXIwNHblfrR/PdPgb/CjjKIFFWydYUKH2oVpoN0VhvF4Mq0OpmgiLjcRf3Ta7EhbJCd4rNr0eQG4qtORkhU1ZX8ri7l7uaaEmRedXZHBbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dD7i52gX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dD7i52gX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765538164; x=1797074164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=E9DxA+WVnBPjhvpzyGCHqusnyIlxrYm6SnS1VojP4u4=;
  b=dD7i52gXdsaRW7rKhqpqT+kB/KofgJIXnBG4tYZ7X+1Osers+5aE1npU
   G4iTd3asFhAep92jktwrr6YJ8DVckhtCkXCDFDxxAZuguj+wXuH3Gplxg
   lS3evWchmr3mGLI/2ScQsc4MlPx3y/f16d48ui2hcgMxk+qbSNTP7QKLy
   zeWnh0f5gi4P3QNncr3yS5bIv1PB2uBk9qfi8lWxo7RLP5pygQmsdCKAI
   Y/Qg77xNSeT/0aNUvqzs8wPunUisq7LfYKt5Ug2tQhEX9O/BJMlASSGaW
   eHxzj2E9rnuQ395MOb0mbXLGvlWW/QFXY1PcvVGapQchq+eD212XivAWt
   w==;
X-CSE-ConnectionGUID: gMNd3B1vRC2MMduefjdOSg==
X-CSE-MsgGUID: V6K/VK3kTBGD15X9Fw3WGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67474415"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67474415"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 03:16:03 -0800
X-CSE-ConnectionGUID: JAIMDTkPQ+W/hqAyOTXmXw==
X-CSE-MsgGUID: IdSE8TDmTY+USort89NM3Q==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 03:15:58 -0800
Date: Fri, 12 Dec 2025 19:00:03 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: iansdannapel@gmail.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-fpga@vger.kernel.org, mdf@kernel.org, yilun.xu@intel.com,
	trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de, neil.armstrong@linaro.org,
	mani@kernel.org, kever.yang@rock-chips.com, dev@kael-k.io
Subject: Re: [PATCH v5 3/3] fpga-mgr: Add Efinix SPI programming driver
Message-ID: <aTv1s6ui1/JmBis0@yilunxu-OptiPlex-7050>
References: <20251119184708.566461-1-iansdannapel@gmail.com>
 <20251119184708.566461-4-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119184708.566461-4-iansdannapel@gmail.com>

On Wed, Nov 19, 2025 at 07:47:06PM +0100, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
> 
> Add a new driver for loading binary firmware to configuration
> RAM using "SPI passive mode" on Efinix FPGAs.
> 
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> ---
>  drivers/fpga/Kconfig      |   7 ++
>  drivers/fpga/Makefile     |   1 +
>  drivers/fpga/efinix-spi.c | 256 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 264 insertions(+)
>  create mode 100644 drivers/fpga/efinix-spi.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 37b35f58f0df..b5d60ba62900 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -83,6 +83,13 @@ config FPGA_MGR_XILINX_SPI
>  	  FPGA manager driver support for Xilinx FPGA configuration
>  	  over slave serial interface.
>  
> +config FPGA_MGR_EFINIX_SPI
> +	tristate "Efinix FPGA configuration over SPI"
> +	depends on SPI
> +	help
> +	  FPGA manager driver support for Efinix FPGAs configuration over SPI
> +	  (passive mode only).
> +

Any reason insert it here? If no add it at tail.

>  config FPGA_MGR_ICE40_SPI
>  	tristate "Lattice iCE40 SPI"
>  	depends on OF && SPI
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index aeb89bb13517..adbd51d2cd1e 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_CORE)	+= xilinx-core.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)	+= xilinx-selectmap.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
> +obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)	+= efinix-spi.o

Ditto, maybe add it at tail of "FPGA Manager Drivers"?

>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
>  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
> diff --git a/drivers/fpga/efinix-spi.c b/drivers/fpga/efinix-spi.c
> new file mode 100644
> index 000000000000..953cf94f1f03
> --- /dev/null
> +++ b/drivers/fpga/efinix-spi.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * FPGA Manager Driver for Efinix
> + *
> + * Copyright (C) 2025 iris-GmbH infrared & intelligent sensors
> + *
> + * Ian Dannapel <iansdannapel@gmail.com>
> + *
> + * Load Efinix FPGA firmware over SPI using the serial configuration interface.
> + *
> + * Note: Only passive mode (host initiates transfer) is currently supported.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/spi/spi.h>
> +
> +/* 13 dummy bytes → 104 SPI clock cycles (8 bits each)

Wrong format for multi-line comments, please see:

  Documentation/process/coding-style.rst

> + * Used to meet the requirement for >100 clock cycles idle sequence.
> + */
> +#define EFINIX_SPI_IDLE_CYCLES_BYTES 13
> +
> +/* tDMIN: Minimum time between deassertion of CRESET_N to first

ditto, please go through the entire patch for this.

> + * valid configuration data. (32 µs)
> + */
> +#define EFINIX_TDMIN_US_MIN    35
> +#define EFINIX_TDMIN_US_MAX    40
> +
> +/* tCRESET_N: Minimum CRESET_N low pulse width required to
> + * trigger re-configuration. (320 ns)
> + */
> +#define EFINIX_TCRESETN_DELAY_MIN_US  1
> +#define EFINIX_TCRESETN_DELAY_MAX_US  2
> +
> +/* tUSER: Minimum configuration duration after CDONE goes high
> + * before entering user mode. (25 µs)
> + */
> +#define EFINIX_TUSER_US_MIN    30
> +#define EFINIX_TUSER_US_MAX    35
> +
> +struct efinix_spi_conf {
> +	struct spi_device *spi;
> +	struct gpio_desc *cdone;
> +	struct gpio_desc *reset;
> +	bool bus_locked;
> +};
> +
> +static void efinix_spi_reset(struct efinix_spi_conf *conf)
> +{
> +	gpiod_set_value(conf->reset, 1);
> +	usleep_range(EFINIX_TCRESETN_DELAY_MIN_US, EFINIX_TCRESETN_DELAY_MAX_US);
> +	gpiod_set_value(conf->reset, 0);
> +	usleep_range(EFINIX_TDMIN_US_MIN, EFINIX_TDMIN_US_MAX);
> +}
> +
> +static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
> +{
> +	struct efinix_spi_conf *conf = mgr->priv;
> +
> +	if (conf->cdone && gpiod_get_value(conf->cdone) == 1)
> +		return FPGA_MGR_STATE_OPERATING;
> +
> +	return FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static int efinix_spi_write_init(struct fpga_manager *mgr,
> +				 struct fpga_image_info *info,
> +				 const char *buf, size_t count)
> +{
> +	struct efinix_spi_conf *conf = mgr->priv;
> +	struct spi_transfer assert_cs = {
> +		.cs_change = 1,

You've addressed an important concern, please briefly describe in this
function & changelog: what's the HW requirement, how to solve it by
cs_change & spi_bus_lock().

> +	};
> +	struct spi_message message;
> +	int ret;
> +
> +	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> +		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	spi_bus_lock(conf->spi->controller);
> +	conf->bus_locked = true;
> +	spi_message_init_with_transfers(&message, &assert_cs, 1);
> +	ret = spi_sync_locked(conf->spi, &message);
> +	if (ret) {
> +		spi_bus_unlock(conf->spi->controller);
> +		conf->bus_locked = false;
> +		return ret;
> +	}
> +
> +	/* Reset with CS asserted */
> +	efinix_spi_reset(conf);
> +
> +	return 0;
> +}
> +
> +static int efinix_spi_write(struct fpga_manager *mgr, const char *buf,
> +			    size_t count)
> +{
> +	struct spi_transfer write_xfer = {
> +		.tx_buf = buf,
> +		.len = count,
> +		.cs_change = 1, /* Keep CS asserted */
> +	};
> +	struct efinix_spi_conf *conf = mgr->priv;
> +	struct spi_message message;
> +	int ret;
> +
> +	spi_message_init_with_transfers(&message, &write_xfer, 1);
> +	ret = spi_sync_locked(conf->spi, &message);
> +	if (ret) {
> +		dev_err(&mgr->dev, "SPI error in firmware write: %d\n", ret);
> +		if (conf->bus_locked) {

Do we really need this flag? If we failed to lock bus on write_init(),
we can't get here, is it?

> +			spi_bus_unlock(conf->spi->controller);
> +			conf->bus_locked = false;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int efinix_spi_write_complete(struct fpga_manager *mgr,
> +				     struct fpga_image_info *info)
> +{
> +	unsigned long timeout =
> +		jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
> +	struct spi_transfer clk_cycles = {
> +		.len = EFINIX_SPI_IDLE_CYCLES_BYTES,

Here we also release the cs, is it? Please add comments here.

> +	};
> +	struct efinix_spi_conf *conf = mgr->priv;
> +	struct spi_message message;
> +	int ret = -1, done = 0;

Why initialize these 2 variables, IIUC they are all re-assigned before
any usage.

> +	bool expired = false;
> +	u8 *dummy_buf;
> +
> +	dummy_buf = kzalloc(EFINIX_SPI_IDLE_CYCLES_BYTES, GFP_KERNEL);
> +	if (!dummy_buf) {
> +		ret = -ENOMEM;
> +		goto unlock_spi;
> +	}
> +
> +	clk_cycles.tx_buf = dummy_buf;
> +	spi_message_init_with_transfers(&message, &clk_cycles, 1);
> +	ret = spi_sync_locked(conf->spi, &message);
> +	if (ret) {
> +		dev_err(&mgr->dev, "SPI error in write complete: %d\n", ret);
> +		goto free_buf;
> +	}
> +
> +	if (conf->cdone) {
> +		while (!expired) {
> +			done = gpiod_get_value(conf->cdone);
> +			if (done < 0) {
> +				ret = done;
> +				goto free_buf;
> +			}
> +			if (done)
> +				break;
> +
> +			usleep_range(10, 20);
> +			expired = time_after(jiffies, timeout);
> +		}
> +
> +		if (expired) {
> +			dev_err(&mgr->dev, "Timeout waiting for CDONE\n");
> +			ret = -ETIMEDOUT;
> +			goto free_buf;
> +		}
> +	}
> +
> +	usleep_range(EFINIX_TUSER_US_MIN, EFINIX_TUSER_US_MAX);
> +
> +free_buf:
> +	kfree(dummy_buf);
> +unlock_spi:
> +	if (conf->bus_locked) {
> +		spi_bus_unlock(conf->spi->controller);
> +		conf->bus_locked = false;
> +	}
> +	return ret;
> +}
> +
> +static const struct fpga_manager_ops efinix_spi_ops = {
> +	.state = efinix_spi_state,
> +	.write_init = efinix_spi_write_init,
> +	.write = efinix_spi_write,
> +	.write_complete = efinix_spi_write_complete,
> +};
> +
> +static int efinix_spi_probe(struct spi_device *spi)
> +{
> +	struct efinix_spi_conf *conf;
> +	struct fpga_manager *mgr;
> +
> +	conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
> +	if (!conf)
> +		return -ENOMEM;
> +
> +	conf->spi = spi;
> +
> +	conf->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(conf->reset))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->reset),
> +				     "Failed to get RESET gpio\n");
> +
> +	if (!(spi->mode & SPI_CPHA) || !(spi->mode & SPI_CPOL))
> +		return dev_err_probe(&spi->dev, -EINVAL,
> +				     "Unsupported SPI mode, set CPHA and CPOL\n");
> +
> +	conf->cdone = devm_gpiod_get_optional(&spi->dev, "cdone", GPIOD_IN);
> +	if (IS_ERR(conf->cdone))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->cdone),
> +				     "Failed to get CDONE gpio\n");
> +
> +	mgr = devm_fpga_mgr_register(&spi->dev,
> +				     "Efinix FPGA Manager",
> +				     &efinix_spi_ops, conf);

The initialization sequence is quite random...

1. if (!(spi->mode & SPI_CPHA) || !(spi->mode & SPI_CPOL))
2. conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
3. conf->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_HIGH);
4. conf->cdone = devm_gpiod_get_optional(&spi->dev, "cdone", GPIOD_IN);
5. Initialize other fields in conf.
6. mgr = devm_fpga_mgr_register()
7. return PTR_ERR_OR_ZERO(mgr);

Is it better?

Thanks,
Yilun

> +
> +	conf->bus_locked = false;
> +
> +	return PTR_ERR_OR_ZERO(mgr);
> +}
> +
> +static const struct of_device_id efinix_spi_of_match[] = {
> +	{ .compatible = "efinix,trion-spi", },
> +	{ .compatible = "efinix,titanium-spi", },
> +	{ .compatible = "efinix,topaz-spi", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, efinix_spi_of_match);
> +
> +static const struct spi_device_id efinix_ids[] = {
> +	{ "trion-spi", 0 },
> +	{ "titanium-spi", 0 },
> +	{ "topaz-spi", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(spi, efinix_ids);
> +
> +static struct spi_driver efinix_spi_driver = {
> +	.driver = {
> +		.name = "efinix-spi",
> +		.of_match_table = efinix_spi_of_match,
> +	},
> +	.probe = efinix_spi_probe,
> +	.id_table = efinix_ids,
> +};
> +
> +module_spi_driver(efinix_spi_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Ian Dannapel <iansdannapel@gmail.com>");
> +MODULE_DESCRIPTION("Efinix FPGA SPI Programming Driver");
> -- 
> 2.43.0
> 
> 
