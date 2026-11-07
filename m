Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794056288;
	b=IoqYKev3xsmJcd1PM1BlceKxg707wihCiJXl595LTEIYvP9WqVI3g54iA12iOD3i+wxl
	 VYaTGkmNsvOdnr9dn+y5/R1QA+N11xU+HVwCoxwNpmEivESyjfF1DPD85XgagrGeKpFty
	 Mb1XFht8xGY+4awr3TIqLwYy5eKKOhUGj3jiJknZeCB7gNvOrL6MBISCDZL6iGh+pQXM2
	 V+DKSzK0Fwino48tvkGaldX+As34hLsDNDbeeCY3jO6ldzV1yOzr9d85oS9cV1wapOP8T
	 hTaBABH0BNSOodUkLxythqGAUOXDvNd2bLcDrVI73W04nBJ5oENOZ+wyOZEI45AZ6Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794056288;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=azVrG+P6xL596olvAnT6FD+0b9UQ5x/qTtrlSUIzTZI=;
	b=IL63p+ZPsJAyu6SFKZx4LjOSP8hE94B+apmsiY51rV7s75Cy4qU+ss1owBqI19X9tTGw
	 grNZTPg7aHt1raC6iElSgx0NnXIpbf0+PdjDsejh4MY1xMXkL3+ul7z+L2nriVdEu28pJ
	 Dianj2UyOU3vg+iJYjqUSDGtHCO2Ax+KVAFA34+I1+QSkD1vA2vLFU0mbEjjw4e9iUXo0
	 q2gLrDU1chpkxmtundtB+1eExPH96amSJRybVrsrXmW7dwuoLH779yl6vRw6FeidK/G43
	 NypaDkqYE7IiOAVrMGPfzkPg6FYdJiXHSOMaYZktrvvoaaK29OCcNGF7BIXEXm96hvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DXgzOJsD;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED72606A326;
	Sat,  7 Nov 2026 12:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ED72606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DXgzOJsD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794056288; x=1825592288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RsywGWtVLQ6VWz4c//J88dDgnFMTE03mfX5b9nPPQvA=;
  b=DXgzOJsDBgATPW4CBAquvz/lCxPHo+ZMnJph54eUkgSnQUo46q2ywx1b
   3UNeeFwBW/hSgtS5hEpjg1rNw8riUx6D8LfSGPltkYWSU6BCy4BjJtdbc
   igiUoGj+yY2z9KgViUp50glGTqqCnkRNbeSjrFpDTvIoqBy5Se4Q0p7e8
   jEGjm2lHAuAbYsIgfLGzAggKnvwChxozugGUxJXSXphvBEij05Q4e74eP
   te62Wf2yNFoYUb2no30rNzbPPNN/XzrCZpWmixaAHXX4C3xezb0jHrZyU
   ZD97OG2W9YlaDtWigvglHgwWHta6IOmDLdXmdPy85vqlndEge98/S9MXN
   Q==;
X-CSE-ConnectionGUID: ivQkGfn8RNurGsxHTzSCgA==
X-CSE-MsgGUID: I6EyNmJnTVKxpcqWw5Hhiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2754150"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2754150"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 04:58:07 -0800
X-CSE-ConnectionGUID: yWMjxIY4RtulG66mvNwjbg==
X-CSE-MsgGUID: 4yBJLPcVQ+SoPAQF7dbrDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7618705"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa009.jf.intel.com with ESMTP; 07 Nov 2026 04:58:05 -0800
Date: Sat, 7 Nov 2026 20:50:39 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: tze.yee.ng@altera.com
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muhammad.nazim.amirul.nazle.asmade@altera.com
Subject: Re: [PATCH v2] fpga: altera-cvp: Add Agilex5 CVP credit register
 support
Message-ID: <au8en9qjdw7VfdAl@yilunxu-OptiPlex-7050>
References: <20261028104019.21225-1-tze.yee.ng@altera.com>
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
In-Reply-To: <20261028104019.21225-1-tze.yee.ng@altera.com>

> +static int altera_cvp_v2_read_credit(struct altera_cvp_conf *conf,
> +				     u32 *credits)
> +{
> +	u8 val;
> +	int ret;
> +
> +	ret = altera_read_config_byte(conf, VSE_CVP_TX_CREDITS, &val);
> +	if (!ret)
> +		*credits = val;
> +
> +	return ret;
> +}
> +
> +static int altera_cvp_ag5_read_credit(struct altera_cvp_conf *conf,
> +				      u32 *credits)
> +{
> +	return altera_read_config_dword(conf, VSE_CVP_AG5_TX_CREDITS, credits);
> +}
> +
>  static int altera_cvp_v2_wait_for_credit(struct fpga_manager *mgr,
>  					 u32 blocks)
>  {
>  	u32 timeout = V2_CREDIT_TIMEOUT_US / V2_CHECK_CREDIT_US;
>  	struct altera_cvp_conf *conf = mgr->priv;
> +	u32 mask = conf->priv->credit_mask;
>  	int ret;
> -	u8 val;
> +	u32 val;
>  
>  	do {
> -		ret = altera_read_config_byte(conf, VSE_CVP_TX_CREDITS, &val);
> +		ret = conf->priv->read_credit(conf, &val);
>  		if (ret) {
>  			dev_err(&conf->pci_dev->dev,
>  				"Error reading CVP Credit Register\n");
>  			return ret;
>  		}
>  
> +		val &= mask;

How about including the masking inside .read_credit()?

> +
>  		/* Return if there is space in FIFO */
> -		if (val - (u8)conf->sent_packets)
> +		if (val - (conf->sent_packets & mask))

Any reason to mask sent_packets here? The value would be bigger than the
mask? If so, why is it safe to mask it?

I'm wondering if we could remove the mask in this function, then we
don't need a .credit_mask in cvp_priv.

>  			return 0;
>  
>  		ret = altera_cvp_chk_error(mgr, blocks * ALTERA_CVP_V2_SIZE);
> @@ -559,6 +587,18 @@ static const struct cvp_priv cvp_priv_v1 = {
>  static const struct cvp_priv cvp_priv_v2 = {
>  	.clear_state	= altera_cvp_v2_clear_state,
>  	.wait_credit	= altera_cvp_v2_wait_for_credit,
> +	.read_credit	= altera_cvp_v2_read_credit,
> +	.credit_mask	= VSE_CVP_TX_CREDITS_MASK,
> +	.block_size	= ALTERA_CVP_V2_SIZE,
> +	.poll_time_us	= V2_POLL_TIMEOUT_US,
> +	.user_time_us	= V2_USER_TIMEOUT_US,
> +};
> +
> +static const struct cvp_priv cvp_priv_agilex5 = {
> +	.clear_state	= altera_cvp_v2_clear_state,
> +	.wait_credit	= altera_cvp_v2_wait_for_credit,
> +	.read_credit	= altera_cvp_ag5_read_credit,

We have same .wait_credit across, so the only point of it is to indicate
whether the credit can be read. The .read_credit can do the same job,
is it?

I think we can remove .wait_credit

> +	.credit_mask	= VSE_CVP_AG5_TX_CREDITS_MASK,
>  	.block_size	= ALTERA_CVP_V2_SIZE,
>  	.poll_time_us	= V2_POLL_TIMEOUT_US,
>  	.user_time_us	= V2_USER_TIMEOUT_US,
> @@ -658,10 +698,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
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
