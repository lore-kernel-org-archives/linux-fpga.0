Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4248033A9CF;
	Sun,  6 Sep 2026 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713165; cv=none; b=UDP8kOeb4vFvlnN8RklTGIVpT3Od6OT3V6zmLfpF7Me4EBf4seEs7r00cz23bqABA2ulPTqV8YrwcQZrf5NiAWuDrLPIOLrkfo4Iq+JUarVp6/B5G1yvwg+N5sZWc4WoZzLszBWhyCpVi0b8HWGtuQO2gI7uxmv69maAxghLmpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713165; c=relaxed/simple;
	bh=Ihmr8oeQnM8FYh1NYQcgFGPk2IsSRVmBaFkBqvvUTuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mibGPe/p3+wAlrMQbcA/u3MujovmINvlC/ejisVI8QHQoU7VsZPA+YK1UxgdZvqng2ntPl7zpsolRsDDob7DASBd4HA0ZJPRR4PmvvsFkHOJ+hbamwDT0LWiu3MABTL4Ja25JSlnf1JnEVDbnwT6dLC78y5vx3oFISHIMq3USE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=US/YOl85; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="US/YOl85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788713163; x=1820249163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ihmr8oeQnM8FYh1NYQcgFGPk2IsSRVmBaFkBqvvUTuM=;
  b=US/YOl85J0mhrAhMNHzEsHt9zVVYo6gVtPrXlPKzOHp4U/PTx82DH8M8
   Iey5ESq5QV1nEwiIepdFZxuHhRvv/280N1Dwpso9M0law1C4464WBhhAm
   kSUvwZVbgqG2avI8i3SEXgTPhcKmQojPtotqEb/pfb/uVEB51BIZfBidQ
   ZIF0tTn8I4ypTemTfdzR7uy+fB3zo/Yy5DahzqmFb3LLZ0DETx5VmOT2d
   YsEwxbQ/cmRYIOnlLnwoCTnfNKmrJ1SwpGLZROQN+ncdS5Ra9NiBF7GfM
   7LNihqSihB/cldHKLz3jJRFVkkh5iklDs1R/wkmpYDbeI+8YovhE+fWxg
   g==;
X-CSE-ConnectionGUID: Bq47t7KQRKqdWrh47fpvAw==
X-CSE-MsgGUID: 0b5fe1BbRwKhP3/dscWItw==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="114676041"
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; 
   d="scan'208";a="114676041"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 09:46:02 -0700
X-CSE-ConnectionGUID: PQbWxNL0TQCgZDGvaBFE3w==
X-CSE-MsgGUID: YupSYtInT7aDAONy3HsGeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; 
   d="scan'208";a="264315586"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa009.fm.intel.com with ESMTP; 06 Sep 2026 09:45:59 -0700
Date: Mon, 7 Sep 2026 00:45:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
	Xu Yilun <yilun.xu@intel.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4] driver: fpga: xilinx-selectmap: add csi and rdwr
 support
Message-ID: <ap2Yx8oACWfBKOep@yilunxu-OptiPlex-7050>
References: <20260810062105.299808-1-hs@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810062105.299808-1-hs@nabladev.com>

On Mon, Aug 10, 2026 at 08:20:51AM +0200, Heiko Schocher wrote:
> The current driver requests the optional CSI_B and RDWR_B GPIOs but
> only configures their initial output state and never changes them
> afterwards. As a result, CSI_B and RDWR_B remain inactive or active

I got even confused, the old code explicitly set them GPIOD_OUT_HIGH,
why "inactive or active"? And I also confused by your comments in v3,
why "inactive or active" depends on DTS?

Do you want to activate or inactivate the GPIOs in your code? You can't
say don't know, go check the DTS, is it?

> throughout the configuration process.
> 
> This may work on systems with a single FPGA where these signals do not
> need to be controlled by software, or where the signals are configured
> to their active state.

Could you just tell the actual problem, as you said in v3 "The gpios are
never used in mainline".

> But this does not not support systems with
> multiple FPGAs sharing a SelectMAP interface.
> 
> On systems with multiple FPGAs sharing the same SelectMAP data bus,
> the driver must deassert this signals in probe, and actively control
> them during configuration.
> 
> CSI_B (Chip Select, active low) selects the target FPGA. It is asserted
> before configuration data is transferred and deasserted afterwards so
> that only the intended device responds to bus transactions.
> 
> RDWR_B (Read/Write, active low) controls the transfer direction on the
> SelectMAP interface. A low level selects write cycles, while a high
> level selects read cycles. During FPGA configuration the driver drives
> RDWR_B low before transferring the bitstream and restores it to its
> reading (high state) afterwards.
> 
> With that info from the datasheet the driver is now changed to:
> 
> - deassert the CSI_B and RDWR_B pin on probe and store the
>   optional GPIO descriptors in private driver data.
> 
> - toggle both signals around the configuration data transfer
> 
> This allows multiple FPGAs to safely share a single SelectMAP interface.
> 
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> ---
> 
> Changes in v4:
> - add comments from Xu Yulin
>   replace wrong gpiod_set_raw_value() with gpiod_set_value()
>   deassert CSI_B and RDWR_B in probe as in patch version 2
>   rework commit message (correct the description what current
>   driver do on probe), why this is not a problem with one
>   FPGA, and why it needs a change if you have N FPGAs
>   sharing the same selectmap Interface (clk and data pins).
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
>  drivers/fpga/xilinx-selectmap.c | 36 ++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
> index d0cbb5fdfe3a..e9b1d15ca054 100644
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
> +	gpiod_set_value(conf->csi_b, 0);
> +	gpiod_set_value(conf->rdwr_b, 0);
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
> @@ -55,16 +71,18 @@ static int xilinx_selectmap_probe(struct platform_device *pdev)
>  				     "ioremap error\n");
>  	conf->base = base;
>  
> -	/* CSI_B is active low */
> -	gpio = devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
> -	if (IS_ERR(gpio))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
> +	/* CSI_B is active low, deassert signal */

I'm not sure "active low" does any help here, it just makes more
confusion.

At first glance, "active low" && "deassert" => "set it high", then you
should use GPIOD_OUT_HIGH?? You are not reasoning your change.

Please elaborate on how these flags work before you send v5, thanks.

> +	conf->csi_b = devm_gpiod_get_optional(&pdev->dev, "csi",
> +					      GPIOD_OUT_LOW);
> +	if (IS_ERR(conf->csi_b))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(conf->csi_b),
>  				     "Failed to get CSI_B gpio\n");
>  
> -	/* RDWR_B is active low */
> -	gpio = devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_HIGH);
> -	if (IS_ERR(gpio))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(gpio),
> +	/* RDWR_B is active low, deassert signal */

Same concern

> +	conf->rdwr_b = devm_gpiod_get_optional(&pdev->dev, "rdwr",
> +					       GPIOD_OUT_LOW);
> +	if (IS_ERR(conf->rdwr_b))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(conf->rdwr_b),
>  				     "Failed to get RDWR_B gpio\n");
>  
>  	return xilinx_core_probe(&conf->core);
> ---
> base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> 
> -- 
> 2.55.0
> 
> 
