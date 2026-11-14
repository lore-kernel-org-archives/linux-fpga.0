Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669870;
	b=Fpih6Nr5UFQdoIHp54h+l0FJGgWA3ufwTXbI9FLLW/DqXioSkDtf229iSlB5KSED7WgM
	 ihlO0sHD6YW4mCoIxo92PdrHBPjN2KhV6jBZGcBtk/YJg1104RVaPg5l/RtPFtm4oAf42
	 1dRRJkNd1m/GwLctyyLrWkvajnbSX2UQ24NK4Eai+yQ1onWuMKgptCBCfHvY26Yr0CD7K
	 uuKR1fr6tSVkQxK/A8LRam7TiCnLPYaNuG8xSCbrxXLUwYzZwlDrimBCYvQFWLpGW+POQ
	 TrYTzpk/snyrDP/kmU0nnSXIxPPfsoeJ30J/tYsSwvPTVGu7/4YrD52Pz1M6y2T6lyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669870;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=wB2/mY1hI/FP6krMFsfp9X4isJEktY4s4V/dObdFvaU=;
	b=j0UNwkvQwrKDb8yqvIfJ8gkd962wxsnyYQMxil07cNXNcZGO+kNa08Dg4wkZnIJJszHn
	 pHupkgiJKs126mQ+6BPiozY2EQoUCXYZnEfqcpYMVSOm8Ign8ZmCfrhgVrYdn60PtGBj9
	 uNKIPZtCCJhubyKkIpQ3i/7xkJz4tcqWmetgvbJsJb+jAuvrbIFOl1HSQx5z919FktJaQ
	 scf8OAlNZfUpvgXZuuReXWv7jqnZPYVZ0p0WJKnyWYh2dMOPPbe1hTGEz4RQxTcY/e1Rf
	 jGvgybsJSDcZNDfoCYlbaAqq39OaxnXvU5GECqY6qOK8vPXtthRWpiMIP3SB+jOQzgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hotiR5Iu;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F88606A32E;
	Sat, 14 Nov 2026 15:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19F88606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hotiR5Iu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794669871; x=1826205871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sFCx/UlTuNfHeReZ+lEDKJrfA3XlgiO0qj+REvOutXs=;
  b=hotiR5Iukx88jVRDatNdZgZCZ8BmjkqGZ+o74+zIsa8PPwetOAXMDOCx
   pto6ud2KOC61OUokEAzDMd24DTcxmG2wNDzVp7kX6nEc1w7YBYqIdCCGz
   7wW3vegPJfQWwsfmrywQid7v1XDM/S41YAPzNVtO3Yek23IgQMvPmlfw4
   iU15szuWV8NUl7apoQUQb+NYrvLjR9BONFVhJLVxmDC1hKes5QbzfReRh
   HE+EICBzE4r4UcPuO5n3+/3zloTEDGUP7JiLrWpyVPFTPlzPr5OB8UNbX
   O2NgGamvumZ5hPRiEvJjKg8Ki3sO0l0ahT76DkEcvVi0JviOMsmQxQOqM
   A==;
X-CSE-ConnectionGUID: 6zpYLCXNRweYaQcHPV+40w==
X-CSE-MsgGUID: tfqe7P84QBemFDGvz9mwjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3495013"
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="3495013"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2026 07:24:30 -0800
X-CSE-ConnectionGUID: WJ5HzYWASxi86XPtIRVp5g==
X-CSE-MsgGUID: W4h8D2PPTlKSeyYiFMYiPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="9414840"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa008.fm.intel.com with ESMTP; 14 Nov 2026 07:24:27 -0800
Date: Sat, 14 Nov 2026 23:16:02 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: tze.yee.ng@altera.com
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muhammad.nazim.amirul.nazle.asmade@altera.com
Subject: Re: [PATCH v3] fpga: altera-cvp: Add Agilex5 CVP credit register
 support
Message-ID: <avh7MpEbEdpHj59q@yilunxu-OptiPlex-7050>
References: <a4d8640c6e758baa8a3b6c8a5643ebedd86c4d5e.1794533564.git.tze.yee.ng@altera.com>
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d8640c6e758baa8a3b6c8a5643ebedd86c4d5e.1794533564.git.tze.yee.ng@altera.com>

On Fri, Nov 13, 2026 at 12:07:44PM +0800, tze.yee.ng@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Agilex5 uses a different VSEC layout from earlier SoC FPGA variants:
> the VSEC length is 0x60 and the CVP TX credit register moves to
> offset 0x5C, a dword register holding 12-bit credits, instead of the
> 8-bit register at offset 0x49.
> 
> Describe the credit register differences in struct cvp_priv by adding
> an avail_credit() callback, and add a cvp_priv for Agilex5 using it.
> The callback reads the credit register and returns the number of
> credits left, computed modulo the width of the hardware counter, which
> wraps while sent_packets keeps counting. Existing devices keep their
> 8-bit byte read, so their behaviour is unchanged. Credit throttling is
> enabled when avail_credit() is provided, so drop the redundant
> wait_credit() callback.
> 
> At probe time, read the standard PCIe VSEC header and select the
> Agilex5 cvp_priv when the VSEC length is 0x60.
> 
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next, thanks

> ---
> Changes in v3:
> - Move credit masking into the per-variant ->avail_credit() callbacks,
>   which now return the credits left; drop credit_mask from struct
>   cvp_priv (Yilun)
> - Drop ->wait_credit and use ->avail_credit to enable credit
>   throttling (Yilun)
> - Add a short comment explaining the modulo credit computation
> - Update the commit message accordingly
> 
> Changes in v2:
> - Use PCI_VNDR_HEADER/PCI_VNDR_HEADER_LEN() from pci_regs.h instead of
>   private VSEC header macros
> - Describe the Agilex5 credit register via struct cvp_priv
>   (read_credit(), credit_mask, cvp_priv_agilex5); drop
>   device_family_type and the SOCFPGA_CVP_* macros
> - Keep the sent_packets comparison width-limited via credit_mask; no
>   longer described as a fix
> - Drop the dev_notice() messages
> - Rewrite the commit message
> 
> v2: https://lore.kernel.org/all/20261028104019.21225-1-tze.yee.ng@altera.com/ 
> ---
>  drivers/fpga/altera-cvp.c | 72 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 60 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index d736f9fa1898..04c1314a37a7 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -23,6 +23,7 @@
>  #define TIMEOUT_US	2000	/* CVP STATUS timeout for USERMODE polling */
>  
>  /* Vendor Specific Extended Capability Registers */
> +#define AGILEX5_VSEC_LENGTH		0x60	/* VSEC length, Agilex5 only */
>  #define VSE_CVP_STATUS			0x1c	/* 32bit */
>  #define VSE_CVP_STATUS_CFG_RDY		BIT(18)	/* CVP_CONFIG_READY */
>  #define VSE_CVP_STATUS_CFG_ERR		BIT(19)	/* CVP_CONFIG_ERROR */
> @@ -49,6 +50,9 @@
>  #define V1_VSEC_OFFSET			0x200	/* Vendor Specific Offset V1 */
>  /* V2 Defines */
>  #define VSE_CVP_TX_CREDITS		0x49	/* 8bit */
> +#define VSE_CVP_TX_CREDITS_MASK		GENMASK(7, 0)
> +#define VSE_CVP_AG5_TX_CREDITS		0x5c	/* 12bit credits for Agilex5 */
> +#define VSE_CVP_AG5_TX_CREDITS_MASK	GENMASK(11, 0)
>  
>  #define V2_CREDIT_TIMEOUT_US		40000
>  #define V2_CHECK_CREDIT_US		10
> @@ -84,7 +88,7 @@ struct altera_cvp_conf {
>  struct cvp_priv {
>  	void	(*switch_clk)(struct altera_cvp_conf *conf);
>  	int	(*clear_state)(struct altera_cvp_conf *conf);
> -	int	(*wait_credit)(struct fpga_manager *mgr, u32 blocks);
> +	int	(*avail_credit)(struct altera_cvp_conf *conf, u32 *credits);
>  	size_t	block_size;
>  	int	poll_time_us;
>  	int	user_time_us;
> @@ -223,16 +227,47 @@ static int altera_cvp_v2_clear_state(struct altera_cvp_conf *conf)
>  				      conf->priv->poll_time_us);
>  }
>  
> +/*
> + * The HW credit counter wraps at its register width, so compute the
> + * available credits against sent_packets modulo that width.
> + */
> +static int altera_cvp_v2_avail_credit(struct altera_cvp_conf *conf,
> +				      u32 *credits)
> +{
> +	u8 val;
> +	int ret;
> +
> +	ret = altera_read_config_byte(conf, VSE_CVP_TX_CREDITS, &val);
> +	if (!ret)
> +		*credits = (val - conf->sent_packets) & VSE_CVP_TX_CREDITS_MASK;
> +
> +	return ret;
> +}
> +
> +static int altera_cvp_ag5_avail_credit(struct altera_cvp_conf *conf,
> +				       u32 *credits)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret = altera_read_config_dword(conf, VSE_CVP_AG5_TX_CREDITS, &val);
> +	if (!ret)
> +		*credits = (val - conf->sent_packets) &
> +			   VSE_CVP_AG5_TX_CREDITS_MASK;
> +
> +	return ret;
> +}
> +
>  static int altera_cvp_v2_wait_for_credit(struct fpga_manager *mgr,
>  					 u32 blocks)
>  {
>  	u32 timeout = V2_CREDIT_TIMEOUT_US / V2_CHECK_CREDIT_US;
>  	struct altera_cvp_conf *conf = mgr->priv;
>  	int ret;
> -	u8 val;
> +	u32 credits;
>  
>  	do {
> -		ret = altera_read_config_byte(conf, VSE_CVP_TX_CREDITS, &val);
> +		ret = conf->priv->avail_credit(conf, &credits);
>  		if (ret) {
>  			dev_err(&conf->pci_dev->dev,
>  				"Error reading CVP Credit Register\n");
> @@ -240,14 +275,14 @@ static int altera_cvp_v2_wait_for_credit(struct fpga_manager *mgr,
>  		}
>  
>  		/* Return if there is space in FIFO */
> -		if (val - (u8)conf->sent_packets)
> +		if (credits)
>  			return 0;
>  
>  		ret = altera_cvp_chk_error(mgr, blocks * ALTERA_CVP_V2_SIZE);
>  		if (ret) {
>  			dev_err(&conf->pci_dev->dev,
> -				"CE Bit error credit reg[0x%x]:sent[0x%x]\n",
> -				val, conf->sent_packets);
> +				"CE Bit error with no credit:sent[0x%x]\n",
> +				conf->sent_packets);
>  			return -EAGAIN;
>  		}
>  
> @@ -473,8 +508,8 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
>  
>  	while (remaining) {
>  		/* Use credit throttling if available */
> -		if (conf->priv->wait_credit) {
> -			status = conf->priv->wait_credit(mgr, done);
> +		if (conf->priv->avail_credit) {
> +			status = altera_cvp_v2_wait_for_credit(mgr, done);
>  			if (status) {
>  				dev_err(&conf->pci_dev->dev,
>  					"Wait Credit ERR: 0x%x\n", status);
> @@ -558,7 +593,15 @@ static const struct cvp_priv cvp_priv_v1 = {
>  
>  static const struct cvp_priv cvp_priv_v2 = {
>  	.clear_state	= altera_cvp_v2_clear_state,
> -	.wait_credit	= altera_cvp_v2_wait_for_credit,
> +	.avail_credit	= altera_cvp_v2_avail_credit,
> +	.block_size	= ALTERA_CVP_V2_SIZE,
> +	.poll_time_us	= V2_POLL_TIMEOUT_US,
> +	.user_time_us	= V2_USER_TIMEOUT_US,
> +};
> +
> +static const struct cvp_priv cvp_priv_agilex5 = {
> +	.clear_state	= altera_cvp_v2_clear_state,
> +	.avail_credit	= altera_cvp_ag5_avail_credit,
>  	.block_size	= ALTERA_CVP_V2_SIZE,
>  	.poll_time_us	= V2_POLL_TIMEOUT_US,
>  	.user_time_us	= V2_USER_TIMEOUT_US,
> @@ -658,10 +701,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  	conf->pci_dev = pdev;
>  	conf->write_data = altera_cvp_write_data_iomem;
>  
> -	if (conf->vsec_offset == V1_VSEC_OFFSET)
> +	if (conf->vsec_offset == V1_VSEC_OFFSET) {
>  		conf->priv = &cvp_priv_v1;
> -	else
> -		conf->priv = &cvp_priv_v2;
> +	} else {
> +		pci_read_config_dword(pdev, offset + PCI_VNDR_HEADER, &regval);
> +		if (PCI_VNDR_HEADER_LEN(regval) == AGILEX5_VSEC_LENGTH)
> +			conf->priv = &cvp_priv_agilex5;
> +		else
> +			conf->priv = &cvp_priv_v2;
> +	}
>  
>  	conf->map = pci_iomap(pdev, CVP_BAR, 0);
>  	if (!conf->map) {
> -- 
> 2.43.7
> 
> 
