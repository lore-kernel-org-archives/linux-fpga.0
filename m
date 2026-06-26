Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C31288C3D;
	Fri, 26 Jun 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485202; cv=none; b=C5g4p3BNkkuwdrwnJl8XWyxQ8gwOlc+gLtjJmITYAEQrfocmbTSgwYFi8Hq9Vqj4GdtwoTeFBnwUFkNfC6/BeYfV3k01+5i8IFYRlT0dbKCc1mgweY0rYqCYEddinowY4Kk8lBpjRRP4icO/vtUY8uA4tRHSH7uTOcddahO8iCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485202; c=relaxed/simple;
	bh=ua9Mq+ymtf5OKVddIBbi0vXzo+Qds0McCA/iH3z8ll8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJgHUWbRwfMBbxut+frnyBMgD9mq0U1C9ZyTWv6yOv/BXqatvZK6rmaXUZ4jhioSODuMFfqfA2aKSF6+OBvM05TpB24DrAlDLncbh3UEVhKYlPZvPZadJOhgWJuyveKR1OwqbFWsrezA10rr8UrLedL4gfsM55SE9tG4YBRCGmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3woudqf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3woudqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782485200; x=1814021200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ua9Mq+ymtf5OKVddIBbi0vXzo+Qds0McCA/iH3z8ll8=;
  b=I3woudqfQ5Jye/gEZmccMzGBtRFOJP8O1/RWc2IGVYjMjixxdA6zKsGe
   roSU2/lPaKcptlREGHuSJgUpcnDfwwvJjO57kq1kcxiWXOO8Jivi2WN/n
   0EQKyCOkS+tABJIQh0jxs53gHBUCGJY/HjH1NtMO/rQvJfKIqg8n2pGxi
   zvhnnGRaggCOmCkwBqoHM07onEZBtUKwbEjCjpWbhn61DT7rjoYN5PcaO
   iwVtfPZrqJwmMeZM8NCDuVUSc7ycEKaWRaaR4BwJjV1d94kB6NtaXUlbg
   wdoFjTpQqXPqfK2dRfs1X10VwrVKnQIVeiAUJjEVFKfhOXUXRzW0/XHYX
   g==;
X-CSE-ConnectionGUID: va0btl/SSGWLUFqVuiIvoQ==
X-CSE-MsgGUID: wirgzv/pQ2GO+XD5bZb7mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="83288282"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="83288282"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 07:46:40 -0700
X-CSE-ConnectionGUID: a8uGBl9IRZ2ZRGuqprPh6Q==
X-CSE-MsgGUID: +YMBu4VeRKKFVqp0SpkhYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="249673624"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 26 Jun 2026 07:46:38 -0700
Date: Fri, 26 Jun 2026 22:46:36 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: mdf@kernel.org, yilun.xu@intel.com, trix@redhat.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-cvp: Retry teardown and reset CVP state on
 failure
Message-ID: <aj6QzEdhvYm7JIYv@yilunxu-OptiPlex-7050>
References: <20260618112410.303-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618112410.303-1-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Thu, Jun 18, 2026 at 04:24:10AM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> If an incorrect bitstream is sent, the teardown may fail due to a
> CFG_RDY timeout. When this happens, reset CVP_MODE and HIP_CLK_SEL

Please don't just tell the register name, tell us what is the hardware
mechanism in nature English.

> bits to clean up the hardware state and return -EAGAIN, allowing the

Please help me understand why the teardown fails and why a clean up save
the world.

> caller to retry. Introduce altera_cvp_recovery() to wrap this retry
> logic with a maximum of CVP_TEARDOWN_MAX_RETRY attempts.

Why should we retry multiple times?

> 
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> ---
>  drivers/fpga/altera-cvp.c | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 44badfd11e1b..29faf6f5bde1 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -63,6 +63,8 @@
>  #define ALTERA_CVP_V1_SIZE	4
>  #define ALTERA_CVP_V2_SIZE	4096
>  
> +/* Tear-down retry */
> +#define CVP_TEARDOWN_MAX_RETRY 10
>  /* Optional CvP config error status check for debugging */
>  static bool altera_cvp_chkcfg;
>  
> @@ -305,12 +307,40 @@ static int altera_cvp_teardown(struct fpga_manager *mgr,
>  	/* STEP 15 - poll CVP_CONFIG_READY bit for 0 with 10us timeout */
>  	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY, 0,
>  				     conf->priv->poll_time_us);
> -	if (ret)
> +	if (ret) {
>  		dev_err(&mgr->dev, "CFG_RDY == 0 timeout\n");
> +		goto error_path;
> +	}
>  
>  	return ret;
> +
> +error_path:
> +	/* reset CVP_MODE and HIP_CLK_SEL bit */
> +	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
> +	val &= ~VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
> +	val &= ~VSE_CVP_MODE_CTRL_CVP_MODE;
> +	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);

Put the reset in your recovery loop.

And if the code block does a meaningful job, don't copy and paste it
everywhere, make a helper.

> +
> +	return -EAGAIN;
> +
>  }
>  
> +static int altera_cvp_recovery(struct fpga_manager *mgr,
> +			      struct fpga_image_info *info)
> +{
> +	int ret = 0, retry = 0;

Try not to initialize local variables that will always be overwritten
later.

> +
> +	for (retry = 0; retry < CVP_TEARDOWN_MAX_RETRY; retry++) {
> +		ret = altera_cvp_teardown(mgr, info);
> +		if (!ret)
> +			break;

Nothing to do on success, just return 0;

> +		dev_warn(&mgr->dev,
> +				 "%s: [%d] Tear-down failed. Retrying\n",
> +				 __func__,
> +				 retry);

You do dev_err() in altera_cvp_teardown(), does the warn proper print
level?

And not sure if the 10-times retry is expected or not, if yes, you
really don't have to yell out again and again. If not, please find
decent solution.
