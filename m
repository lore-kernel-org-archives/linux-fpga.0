Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A3C175A93;
	Sun,  2 Aug 2026 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685720; cv=none; b=tGfIp3EchmTDW7caCihcaZ4aCLDjCsscfz+iXEfU2ybuA7d5JxDDBx9bHbNLrFj+28csUVUu0Bvrc/sWaiXijAtGwleZkJ0CGVfRrtl3q+VoIA+k22gTTYuijyDhDK0joEGgB49/ntVN+PnpLmiEK32A87Dh91txmKc1x87GtgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685720; c=relaxed/simple;
	bh=bGrOQ+CY7EkKESDzSdb+8OxxFKFT0DD6Txi0F3XW9x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDSlsp/smf9jSlgzhiktsv059mKdz2s1dk7gkhmEeaaLeNYjQl375PYlzPlKv+fwVUXri9xFW1sBeIc+qZHolhdRV4Jxy5Mp1+G8vYixBdp2ufw8YziRc9njRmOteIU9pNZzewu5AVr8XtPzE5lhHJ2v2GeEZ3MGqG7RUwpdbK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrmAonmw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrmAonmw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785685718; x=1817221718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bGrOQ+CY7EkKESDzSdb+8OxxFKFT0DD6Txi0F3XW9x0=;
  b=KrmAonmwC2KnykxcKWE8Sp2FQg1B0aXL5MH6guxavjQdQwdh740tz+++
   AksTrTltqdU9aLvDGzR9ABDXKMho2ChT3At8/SjFKtmuPpsd6tIqRDt/L
   hnd/dbGGU5WDa3xCn2ahTpxu+pDjEpZtvgRjvz58W3jTIStNsIKA0qbEO
   LR1dXh9VyFi3mRygQ7cdgKPxnruD5Cau2nKN2HBILMtNNkwO0eqfjiLdR
   wu6MNyBpzKNDxoFXbj3BZMZ4R6hjeNG3jvsL3S8I5E64G4UfctlwrBnLr
   uoFBHGxe0/3VX4A9FMRlYW/1ORGzrKfqxdPgVRkNaURepPRQcQJKmmA+B
   A==;
X-CSE-ConnectionGUID: iauxihUoQW+MTsTpNDCyGg==
X-CSE-MsgGUID: s3NmgQOxTxaavDswUMo1YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="86442137"
X-IronPort-AV: E=Sophos;i="6.25,200,1779174000"; 
   d="scan'208";a="86442137"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 08:48:37 -0700
X-CSE-ConnectionGUID: i31RhG3aR4mFVqtIDOP2bw==
X-CSE-MsgGUID: 7rPvqHDCSs6Sk392WM6cgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,200,1779174000"; 
   d="scan'208";a="261064494"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 02 Aug 2026 08:48:35 -0700
Date: Sun, 2 Aug 2026 23:48:34 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
	Xu Yilun <yilun.xu@intel.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3] driver: fpga: xilinx-selectmap: add csi and rdwr
 support
Message-ID: <am9m0pGSUYKaRRDI@yilunxu-OptiPlex-7050>
References: <20260727052218.4079979-1-hs@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727052218.4079979-1-hs@nabladev.com>

On Mon, Jul 27, 2026 at 07:22:10AM +0200, Heiko Schocher wrote:
> The current driver requests the optional CSI_B and RDWR_B GPIOs but
> only configures their initial output state and never changes them
> afterwards. As a result, CSI_B and RDWR_B remain inactive throughout
> the configuration process.

Then how the existing configuration process work if the control signals
are always *INACTIVE*?

> 
> This may work on systems with a single FPGA where these signals do not
> need to be controlled by software,

Is this always the case today? Then why does the existing driver bother
doing the devm_gpiod_get_optional()?

> but it does not support systems
> with multiple FPGAs sharing a SelectMAP interface.
> 
> On systems with multiple FPGAs sharing the same SelectMAP data bus,
> the driver must actively control these signals during configuration.
> 
> CSI_B (Chip Select, active low) selects the target FPGA. It is asserted
> before configuration data is transferred and deasserted afterwards so
> that only the intended device responds to bus transactions.

I still don't understand, only one Chip Select pin defined for each
selectmap device, how could it select between multiple FPGAs?

> 
> RDWR_B (Read/Write, active low) controls the transfer direction on the
> SelectMAP interface. A low level selects write cycles, while a high
> level selects read cycles. During FPGA configuration the driver drives
> RDWR_B low before transferring the bitstream and restores it to its
> reading (high state) afterwards.
> 
> Store the optional GPIO descriptors and toggle both signals around the
> configuration data transfer, allowing multiple FPGAs to safely share a
> single SelectMAP interface.
> 
> Tested on an AM625 based board with two Xilinx FPGAs connected to the
> GPMC bus.

What is GPMC bus, anything to do with "SelectMAP data bus"?

> 
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> ---
> 
> Changes in v3:
> - use 0 (deasserted state) and 1 (asserted state) in gpio_set_value()
>   as commented from Micahl
> - rewrite commit message as requested from Xu Yilun
>   - describe what rdwr_b and csi_b do, and why this change is needed
>     for more than one FPGA.
> - add comment before asserting the signals, why they are asserted
>   in this order.
> 
> Changes in v2:
> - add comments from Michal
>   - skip check if gpio descriptor variables csi_b/rdwr_b are valid,
>     as validate_desc() checks this in gpiod_set_value() call.
>   - initialize the gpio variables csi_b/rdwr_b immediately with
>     the return value from devm_gpiod_get_optional(), so we can
>     drop local gpio variable at all
> 
>  drivers/fpga/xilinx-selectmap.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
> index d0cbb5fdfe3a..35078206a3a3 100644
> --- a/drivers/fpga/xilinx-selectmap.c
> +++ b/drivers/fpga/xilinx-selectmap.c
> @@ -19,6 +19,8 @@
>  struct xilinx_selectmap_conf {
>  	struct xilinx_fpga_core core;
>  	void __iomem *base;
> +	struct gpio_desc *csi_b;
> +	struct gpio_desc *rdwr_b;
>  };
>  
>  #define to_xilinx_selectmap_conf(obj) \
> @@ -30,16 +32,30 @@ static int xilinx_selectmap_write(struct xilinx_fpga_core *core,
>  	struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
>  	size_t i;
>  
> +	/*
> +	 * Assert CSI_B and select write mode.
> +	 *
> +	 * UG570 states in note 4 in Figure "Continuous x8 SelectMAP Data
> +	 * Loading", RDWR_B should be asserted before CSI_B to avoid
> +	 * causing an ABORT on the next CCLK.
> +	 *
> +	 * To be sure, set first RDWR_B pin before activate CSI_B
> +	 */
> +	gpiod_set_value(conf->rdwr_b, 1);
> +	gpiod_set_value(conf->csi_b, 1);
> +
>  	for (i = 0; i < count; ++i)
>  		writeb(buf[i], conf->base);
>  
> +	gpiod_set_raw_value(conf->csi_b, 0);
> +	gpiod_set_raw_value(conf->rdwr_b, 0);

I don't see why you do gpiod_set_raw_value() here, they seems change nothing.

  Function (example)                 line property          physical line
  gpiod_set_raw_value(desc, 0);      don't care             low
  ...
  gpiod_set_value(desc, 1);          active low             low

> +
>  	return 0;
>  }
>  
>  static int xilinx_selectmap_probe(struct platform_device *pdev)
>  {
>  	struct xilinx_selectmap_conf *conf;
> -	struct gpio_desc *gpio;
>  	void __iomem *base;
>  
>  	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
> @@ -56,15 +72,17 @@ static int xilinx_selectmap_probe(struct platform_device *pdev)
>  	conf->base = base;
>  
>  	/* CSI_B is active low */
> -	gpio = devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
> -	if (IS_ERR(gpio))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
> +	conf->csi_b = devm_gpiod_get_optional(&pdev->dev, "csi",
> +					      GPIOD_OUT_HIGH);

You've changed this from v2, why? Why keep the initial state active?

> +	if (IS_ERR(conf->csi_b))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(conf->csi_b),
>  				     "Failed to get CSI_B gpio\n");
>  
>  	/* RDWR_B is active low */
> -	gpio = devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_HIGH);
> -	if (IS_ERR(gpio))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
> +	conf->rdwr_b = devm_gpiod_get_optional(&pdev->dev, "rdwr",
> +					       GPIOD_OUT_HIGH);
> +	if (IS_ERR(conf->rdwr_b))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(conf->rdwr_b),
>  				     "Failed to get RDWR_B gpio\n");
>  
>  	return xilinx_core_probe(&conf->core);
> ---
> base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
> 
> -- 
> 2.55.0
> 
> 
