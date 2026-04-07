Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C8627603F;
	Tue,  7 Apr 2026 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543631; cv=none; b=mx5tBWnQd0tEa6CDNRPgZjASSlpftZTjD39Pd0n+4jONgNAHmZ7Es8Erq28WlZKJcumVJA/P99YcEpSTWWpJRNXo/wT9gYqgSGv8+0oFykGUCzLtZRcBVn0nlw1zwuNtoWQEec9o9KFCYlTPvaqkMpUAVxBsvGPIIfxIklIH3uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543631; c=relaxed/simple;
	bh=T5h74tB/Q5FJWZ4+H/MHro7MeZftIgIUpgl8lATfw88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYrS4sYfTydgR5P17LgwEFaJCs1MhaoykojbZoTlUZMlNHqOatRsMt3ONpct2fBFdDGU0m5O4hjBuL1VPtvPTNsSJWsZqzi4QL6yg74z9bf3XZuGXojcpHblwKMdSEA+DYUzVBDHJDCWgc43q25lGeSUBuPMriJfT8Pp9fIzNbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjfGPqa9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjfGPqa9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775543630; x=1807079630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T5h74tB/Q5FJWZ4+H/MHro7MeZftIgIUpgl8lATfw88=;
  b=fjfGPqa9OP/A4sU5I3dnfPNgZXdJfjYJxR3fp6lS7orRlkNh7g4D0InT
   gQn95HK/atR0CQ7uIjbroqdITlKfNPtsdDtoEWVZ1ADR5E6hLsg4HXZ4t
   qo0+ougHN2Ci8FQ6kSb70xbJUad13SoRGl1gfjYcbGdBdigdTytB6AqSJ
   MkpxjgIuomyih1D0dM1cI5WI+sRaxw60V/LWHXLWODdUpaJDcx+JKkS/V
   OAvjBsADEf3db1r9r7sHJXxTnhBBq9SKWFNO2ib0yM4z/e+8AFIhf8G17
   9gT1kniWaT05Ke1VxHbiZZ4qVbYiBA5QQhGjtPrsiEkfjpCbxDZ5A2kzZ
   g==;
X-CSE-ConnectionGUID: saMwdfTBSvSreN1O98HYLQ==
X-CSE-MsgGUID: QHBcIAJgSoGRv8oUCr20EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="93888889"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="93888889"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 23:33:50 -0700
X-CSE-ConnectionGUID: mkQ39qN4SnGLbQdnqzrcsw==
X-CSE-MsgGUID: 1+Axy45lTg6PePz7YDRM2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="228024139"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 06 Apr 2026 23:33:45 -0700
Date: Tue, 7 Apr 2026 14:12:16 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: iansdannapel@gmail.com
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, mdf@kernel.org, yilun.xu@intel.com,
	trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, neil.armstrong@linaro.org, heiko@sntech.de,
	marex@nabladev.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	dev@kael-k.io
Subject: Re: [PATCH v6 3/3] fpga-mgr: Add Efinix SPI programming driver
Message-ID: <adSgQJa/8ZPlzPbO@yilunxu-OptiPlex-7050>
References: <20260327114842.1300284-1-iansdannapel@gmail.com>
 <20260327114842.1300284-4-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327114842.1300284-4-iansdannapel@gmail.com>

> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index aeb89bb13517..21eb0ef1fc2e 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
>  obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI)	+= microchip-spi.o
>  obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG)	+= lattice-sysconfig.o
>  obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI)	+= lattice-sysconfig-spi.o
> +obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)	+= efinix-spi.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o

This is the tail of "FPGA Manager Drivers", move it here.

...

> +static int efinix_spi_write_init(struct fpga_manager *mgr,
> +				 struct fpga_image_info *info,
> +				 const char *buf, size_t count)
> +{
> +	struct device *dev = &mgr->dev;

Why do you make this change? This is just one-time usage, and in some
other functions you don't make the same change. Please delete it.

> +	struct efinix_spi_conf *conf = mgr->priv;
> +	struct spi_transfer assert_cs = {
> +		.cs_change = 1,
> +	};
> +	struct spi_message message;
> +	int ret;
> +
> +	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> +		dev_err(dev, "Partial reconfiguration not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/*
> +	 * Efinix passive SPI configuration requires chip select to stay
> +	 * asserted from reset until the bitstream is fully clocked in.
> +	 * Lock the SPI bus so no other device can toggle CS between the
> +	 * reset pulse and the write/complete transfers.
> +	 */
> +	spi_bus_lock(conf->spi->controller);
> +	spi_message_init_with_transfers(&message, &assert_cs, 1);
> +	ret = spi_sync_locked(conf->spi, &message);
> +	if (ret) {
> +		spi_bus_unlock(conf->spi->controller);
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
> +	struct device *dev = &mgr->dev;

ditto.

> +	struct spi_transfer write_xfer = {
> +		.tx_buf = buf,
> +		.len = count,
> +		.cs_change = 1, /* Keep CS asserted */

Move this comment to its first appearance.

...

> +static const struct of_device_id efinix_spi_of_match[] = {
> +	{ .compatible = "efinix,trion-config", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, efinix_spi_of_match);
> +
> +static const struct spi_device_id efinix_ids[] = {
> +	{ "trion-config", 0 },
> +	{ "titanium-config", 0 },
> +	{ "topaz-config", 0 },

Since you've trimmed of_match_table, any reason to keep 3
spi_device_ids? IIUC you could keep them in sync.
