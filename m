Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBE526296;
	Sun,  6 Sep 2026 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710556; cv=none; b=jhqYU38A5i6Bm8nQGi/FJtr3NaMacrsoT5OxnPP/kj5tuYNxbvUzcbakRII4G8jIFVF/fX+TlpucM00aOyHKifJQsqOIjKnzjqk6Z2hzaqt64hPTlcwpDjZELUAY7EcUG2ZPsweWsp3vvOOgMQjGkb4CRov2bIQAsFEpm3VKwpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710556; c=relaxed/simple;
	bh=di/G6jarqfvI8rhnkV4MtBIEga/N4imM7zedtrq4318=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HILm+n4EzLUY900Fys6rcb8wS9lT6Ei9T3321UNibDrVY5neGrqHGBYOIsFAMo9rYfdWz46Wp/I8u70SmSe8D19k8aNFmhScTO8HJmoPaCve+UQEh7hAvZ+j2xPuIU0AJXqdUf+II1XwOIVFXOSD8Yk1G+bLTsVZ45/BNTrq5AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqDzNy+n; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqDzNy+n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788710554; x=1820246554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=di/G6jarqfvI8rhnkV4MtBIEga/N4imM7zedtrq4318=;
  b=cqDzNy+nX01JfZDPG/Tf9CZkXZETNG+3qa3aIuf4h4O5MR/A7O4hEER4
   BlAldGkOmcJpfWkgSqb/7t+VwQdscJkRT5yGHBqG2oJGoV19dl+O7a+C/
   3vU43lpYBmIvv0GWmZxN/rHynG8fv3OiEfDpwhyuT1bFaAIJxELpYXlmo
   n6pZePl6G6NvwI/xPgJMZQVzlz+EiDCQPayqWc/F0apRbjKc8q7OZqKDA
   eJpgm3nu5S/r5/uz57y+kJ1LSKyU0q/fluHDewBvkpmioFd0/uHyIv7Ul
   L18c4PwFuGhEUrGqC9D7wefR6Ss57qjeQD2/bF2f93UWC3eYlXnThDq2w
   g==;
X-CSE-ConnectionGUID: OFUOE4cFSrKm8AqzW6oZQg==
X-CSE-MsgGUID: q57CBPmYTtCK7agGWTj/0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89341387"
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; 
   d="scan'208";a="89341387"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 09:02:34 -0700
X-CSE-ConnectionGUID: 0T4UX8NYS/WMjVpa5sawLg==
X-CSE-MsgGUID: l4VMONq2QKKMC7FVq7bGQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; 
   d="scan'208";a="267934215"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa008.fm.intel.com with ESMTP; 06 Sep 2026 09:02:31 -0700
Date: Mon, 7 Sep 2026 00:02:30 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Pengpeng Hou <hppiscas@163.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Alan Tull <atull@opensource.altera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: socfpga-a10: Propagate DCLK completion timeouts
Message-ID: <ap2OljjMRZehVISA@yilunxu-OptiPlex-7050>
References: <20260906033900.84849-1-hppiscas@163.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906033900.84849-1-hppiscas@163.com>

On Sun, Sep 06, 2026 at 11:39:00AM +0800, Pengpeng Hou wrote:
> socfpga_a10_fpga_generate_dclks() waits for the generated DCLK count to
> complete but discards the poll result. Configuration can therefore continue
> after the hardware did not acknowledge a required DCLK sequence.

The process can fail on multiple operations, breaking out only on
xx_generate_dclks() doesn't make much sense. I think if the final checks
can be the last safety net, then it is fine.

Do you find any real issue at runtime?

> 
> Return the poll result and stop write initialization on failure. During
> write completion, retain the existing cleanup sequence and return the
> earlier PR error in preference to a later DCLK error.
> 
> The issue was found by our static-analysis tool and manually reviewed.
> 
> Fixes: acbb910ae04b ("fpga-manager: Add Socfpga Arria10 support")
> Assisted-by: gpt 5
> Signed-off-by: Pengpeng Hou <hppiscas@163.com>
> ---
>  drivers/fpga/socfpga-a10.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
> index 0165a3c86932..f707c2bdc189 100644
> --- a/drivers/fpga/socfpga-a10.c
> +++ b/drivers/fpga/socfpga-a10.c
> @@ -124,10 +124,11 @@ static void socfpga_a10_fpga_set_cfg_width(struct a10_fpga_priv *priv,
>  			   A10_FPGAMGR_IMGCFG_CTL_02_CFGWIDTH, width);
>  }
>  
> -static void socfpga_a10_fpga_generate_dclks(struct a10_fpga_priv *priv,
> -					    u32 count)
> +static int socfpga_a10_fpga_generate_dclks(struct a10_fpga_priv *priv,
> +					   u32 count)
>  {
>  	u32 val;
> +	int ret;
>  
>  	/* Clear any existing DONE status. */
>  	regmap_write(priv->regmap, A10_FPGAMGR_DCLKSTAT_OFST,
> @@ -137,12 +138,15 @@ static void socfpga_a10_fpga_generate_dclks(struct a10_fpga_priv *priv,
>  	regmap_write(priv->regmap, A10_FPGAMGR_DCLKCNT_OFST, count);
>  
>  	/* wait till the dclkcnt done */
> -	regmap_read_poll_timeout(priv->regmap, A10_FPGAMGR_DCLKSTAT_OFST, val,
> -				 val, 1, 100);
> +	ret = regmap_read_poll_timeout(priv->regmap,
> +				       A10_FPGAMGR_DCLKSTAT_OFST, val,
> +				       val, 1, 100);
>  
>  	/* Clear DONE status. */
>  	regmap_write(priv->regmap, A10_FPGAMGR_DCLKSTAT_OFST,
>  		     A10_FPGAMGR_DCLKSTAT_DCLKDONE);
> +
> +	return ret;
>  }
>  
>  #define RBF_ENCRYPTION_MODE_OFFSET		69
> @@ -334,7 +338,9 @@ static int socfpga_a10_fpga_write_init(struct fpga_manager *mgr,
>  			   A10_FPGAMGR_IMGCFG_CTL_01_S2F_NENABLE_CONFIG, 0);
>  
>  	/* Send some clocks to clear out any errors */
> -	socfpga_a10_fpga_generate_dclks(priv, 256);
> +	ret = socfpga_a10_fpga_generate_dclks(priv, 256);
> +	if (ret)
> +		return ret;
>  
>  	/* Assert pr_request */
>  	regmap_update_bits(priv->regmap, A10_FPGAMGR_IMGCFG_CTL_01_OFST,
> @@ -342,7 +348,9 @@ static int socfpga_a10_fpga_write_init(struct fpga_manager *mgr,
>  			   A10_FPGAMGR_IMGCFG_CTL_01_S2F_PR_REQUEST);
>  
>  	/* Provide 2048 DCLKs before starting the config data streaming. */
> -	socfpga_a10_fpga_generate_dclks(priv, 0x7ff);
> +	ret = socfpga_a10_fpga_generate_dclks(priv, 0x7ff);
> +	if (ret)
> +		return ret;
>  
>  	/* Wait for pr_ready */
>  	return socfpga_a10_fpga_wait_for_pr_ready(priv);
> @@ -393,7 +401,7 @@ static int socfpga_a10_fpga_write_complete(struct fpga_manager *mgr,
>  {
>  	struct a10_fpga_priv *priv = mgr->priv;
>  	u32 reg;
> -	int ret;
> +	int dclk_ret, ret;
>  
>  	/* Wait for pr_done */
>  	ret = socfpga_a10_fpga_wait_for_pr_done(priv);
> @@ -403,7 +411,7 @@ static int socfpga_a10_fpga_write_complete(struct fpga_manager *mgr,
>  			   A10_FPGAMGR_IMGCFG_CTL_01_S2F_PR_REQUEST, 0);
>  
>  	/* Send some clocks to clear out any errors */
> -	socfpga_a10_fpga_generate_dclks(priv, 256);
> +	dclk_ret = socfpga_a10_fpga_generate_dclks(priv, 256);
>  
>  	/* Disable s2f dclk and data */
>  	regmap_update_bits(priv->regmap, A10_FPGAMGR_IMGCFG_CTL_02_OFST,
> @@ -422,6 +430,8 @@ static int socfpga_a10_fpga_write_complete(struct fpga_manager *mgr,
>  	/* Return any errors regarding pr_done or pr_error */
>  	if (ret)
>  		return ret;
> +	if (dclk_ret)
> +		return dclk_ret;
>  
>  	/* Final check */
>  	reg = socfpga_a10_fpga_read_stat(priv);
> -- 
> 2.50.1 (Apple Git-155)
> 
> 
