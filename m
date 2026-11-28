Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795875969;
	b=neS8bzTH21DJNcnq7ouGyne4FSUCVJ8Q94+mh3yyZDvZOhQzOegUmTeyyrDzb2PCH2hN
	 +79OmNc/q3s/6DRgD2C1Be47w4TvJPNoC14BAs9OzVqRv0ZknsdXLx3jZyeJA+iOqNIZj
	 Ogrx0ThtPJMpyI7/jPoThpj7mJ8Iq4+i7ebeEydeiXGN613Gtjv5uwoX+Wa3A/z3bR4Wo
	 4/AVOocodLEEZEIhTrU8sISe0Bsf/swgKXk+P8PEWIVMcszNfrk/fLkAYZXdJ+i7Hd0zg
	 vNCtlEnzIBQo5PpPSFybHGOdTJnrnpjNVtykcjzfW2OAJveMXW0rkhFa3HWGVm7ptyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875969;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=MY2uFTiPHrQMA4/9MXt16v0yoXdkAqWzROWuYVrR1UQ=;
	b=ZZy2uGNKwbrQXn6QxyQiqKMzjbU+V4rSZkv5fqktHHH9+SSjCpCVM/8leQQuIlqyyfyK
	 E5506Nz5CI1eHHVgW4dAc7fqelN3evOZ/CFkw2ZQlspkKMeEAH+lrmdfOnsShFoafKurs
	 uL0nbDWGxCf5XoZEFGoeYX6JEy8PT7KqHrB6uUk5lVrGJuMxeqmnMB0Ugi0kcZeh3QocJ
	 UvRZHbCbzzgEvAQmfmUAImHlj4I/FjaKih6HQLpYVjR1xCeokvHcZZBgF2hqdrL9uZO8d
	 m9NWs8uj8Aq6HHjocGkgEZmv96kq5ry+Ysj1vNrPeVLVsMootNKyMyeHCRDqPUBsJ9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H1IQPEsW;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDF5606A31F;
	Sat, 28 Nov 2026 14:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBDF5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H1IQPEsW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795875969; x=1827411969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WuqgJ38tny/WpKpeTa0Yrp3OJgllRuWAxpM8lrzahPk=;
  b=H1IQPEsW6INnMz5ytewY/MYXdvInQXbVegad4d03UW7KK8ohQU0u3GM9
   gVzL4/rNnnrePV3xDHq6DiYqavZd+p5RyI0K6W3/AtmQclxNWwqN+/lDb
   6YBtw7JmSh5YS+3IehfIrRTlRJrlLhuP+S2SvjPcxI/M+eFIrKnvmMInd
   ASn1aHkAmu4Or2m5lWisyujv8YYEgP6cJTxinhdG8UuQBSD6IuXT4TObb
   JUOP32C7nANGu89CeNZDDcxR/azvE0WLHAzRqVS2Na9Ly29yJ2NcWMDRy
   w+XXLARnTSS0g/B0n4+tslOCEQJQWaNKiHv5redgyfU0LOejBlbrY3KoL
   Q==;
X-CSE-ConnectionGUID: sdUwH1uYQtmrIW6mE2U6qQ==
X-CSE-MsgGUID: G+8HnaRwT0mos5YtC0MKtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11980"; a="4664035"
X-IronPort-AV: E=Sophos;i="6.27,238,1787036400"; 
   d="scan'208";a="4664035"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2026 06:26:08 -0800
X-CSE-ConnectionGUID: X1gJXZarTMycwgwdP9EMpQ==
X-CSE-MsgGUID: x3RALWu1ScKjXOgtfqpnhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,238,1787036400"; 
   d="scan'208";a="12819257"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa003.fm.intel.com with ESMTP; 28 Nov 2026 06:26:06 -0800
Date: Sat, 28 Nov 2026 22:15:43 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: tze.yee.ng@altera.com
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: altera-cvp: Handle truncated bitstream with
 padding buffer
Message-ID: <awriD1uAiBgmq0Rk@yilunxu-OptiPlex-7050>
References: <3c1bb384cb9cd5bb35b3c7e68a4feab95ef4ad60.1794987679.git.tze.yee.ng@altera.com>
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
In-Reply-To: <3c1bb384cb9cd5bb35b3c7e68a4feab95ef4ad60.1794987679.git.tze.yee.ng@altera.com>

On Wed, Nov 18, 2026 at 03:43:15PM +0800, tze.yee.ng@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> The AIB CvP firmware requires a minimum transfer size of 4096 bytes.
> When a bitstream smaller than this is sent, the firmware DMA engine

Only when < 4096? E.g. if a bitstream is 4096 + 1, it is good?

> stalls waiting for the remaining data, causing a hang.
> 
> Allocate a 4096-byte send_buf at probe time and copy host data into
> it before each block transfer, ensuring the full block size is always
> sent regardless of the actual data length. Also improve error
> detection in write_complete() by checking VSE_CVP_STATUS_CFG_ERR
> instead of VSE_UNCOR_ERR_CVP_CFG_ERR to catch truncated or
> mismatched bitstream errors.

What VSE_CVP_STATUS_CFG_ERR checks? and what VSE_UNCOR_ERR_CVP_CFG_ERR
checks? why it is an improvement? Please specify in log.

> 
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
> Note: I am taking over this patch from Nazim Amirul, who is no longer
> working on it. Nazim is kept as the author.
> 
> Changes in v2:
> - Rebase from linux-fpga/for-next without code changes.

I'm wondering if you agree with all his code/log so you don't change, or
you just wait for me to find all the issues anyway.

> 
> v1: https://lore.kernel.org/all/20260619040811.20038-1-muhammad.nazim.amirul.nazle.asmade@altera.com/
> ---
>  drivers/fpga/altera-cvp.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 103446465e0c..c9357cbe7fc0 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -82,6 +82,7 @@ struct altera_cvp_conf {
>  	u8			numclks;
>  	u32			sent_packets;
>  	u32			vsec_offset;
> +	u8			*send_buf;
>  	const struct cvp_priv	*priv;
>  };
>  
> @@ -518,7 +519,9 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
>  		}
>  
>  		len = min(conf->priv->block_size, remaining);
> -		altera_cvp_send_block(conf, data, len);
> +		memcpy(conf->send_buf, data, len);

So you copied the whole bitstream just because of some bytes of unalignment?

Frankly speaking, I really think the image or the firmware should fix,
you can't produce a image that the FW can't handle.

> +		altera_cvp_send_block(conf, (const u32 *)conf->send_buf,
> +				      conf->priv->block_size);
>  		data += len / sizeof(u32);
>  		done += len;
>  		remaining -= len;
> @@ -557,10 +560,10 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
>  	if (ret)
>  		return ret;
>  
> -	/* STEP 16 - check CVP_CONFIG_ERROR_LATCHED bit */
> -	altera_read_config_dword(conf, VSE_UNCOR_ERR_STATUS, &val);
> -	if (val & VSE_UNCOR_ERR_CVP_CFG_ERR) {
> -		dev_err(&mgr->dev, "detected CVP_CONFIG_ERROR_LATCHED!\n");
> +	/* STEP 16 - check CVP_CONFIG_ERROR bit */
> +	ret = altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
> +	if (ret || (val & VSE_CVP_STATUS_CFG_ERR)) {
> +		dev_err(&mgr->dev, "CVP_CONFIG_ERROR!\n");

Why we don't check the ret before and now we do check? Why there are
many other reads that don't check?

And I find nearly exact the same 5 lines, any reason to duplicate them.

>  		return -EPROTO;
>  	}
>  
> @@ -729,6 +732,11 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  
>  	pci_set_drvdata(pdev, mgr);
>  
> +	conf->send_buf = devm_kzalloc(&pdev->dev, conf->priv->block_size, GFP_KERNEL);
> +	if (!conf->send_buf) {
> +		ret = -ENOMEM;
> +		goto err_unmap;
> +	}
>  	return 0;
>  
>  err_unmap:
> -- 
> 2.43.7
> 
> 
