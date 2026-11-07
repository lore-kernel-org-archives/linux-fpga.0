Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794052923;
	b=3Tc2mnwi31so/nBIYOMVrhqYy7sKHmJvXZWAZfTU4soC7NKgydyuzaVVgA2ZC44FZeQz
	 RfK0lX5Zeb+dVcFkucvnnZB9IYhwz+GOuFVYc3WPLfzInuaF033oYCHGk3WElw22XyBji
	 lUSeWe6A6JujG3bsQpB6frAPTPL5MnN9vsGgGAdYaDyp5rMixZQUJ8Oj5o3ZO2byZpPGu
	 vNO/A2yvdpojjee/opI2n6QCfE/u7okx3siCRnF7OsK4EBOBxoM9oaBIUKA/gsr2yDlMZ
	 SYJV8Sjeti7tpPsB7xpi4EgZhvRUYzlU1eZcnQY/vQJsXppypVOToaDGmMpHLRcECDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794052923;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6l29ITgxWRP/RPIDL1S17WPdPIKKgSBKzLqNTQ1cETo=;
	b=WJmHzg4xIjNwZMKV/PjuoUkS1u/yv5BrCPzsjTOh8lqh1N8PhEK5ZOIN7uSpkuZiL6ai
	 5mM/830RbtRgX10faElABftkL7GYBnVWB/1sHshm28nhsBUVRJ7bQNlQITGglhGnQIuBj
	 fXpLgY0GOURqIQJv+CbuJonUGuHZmezKnFwIedXCZySSUMtdaLVkRazZ9RFAHU/1oWyej
	 gFRpzEq7PxTS/eMfFLTaDIrPMMPF2m4YDP/q6dn7co38cF2KRTLSFRKTGoetNQ5xe/Yu6
	 dcYD97K9fE+0PLYHPtvJT70xNnaJU64ZWO4NJruR9riUheJOtJpC1C1mfygZPDiUy2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UAxvM2vU;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995A606A32C;
	Sat,  7 Nov 2026 12:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B995A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UAxvM2vU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794052923; x=1825588923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A0vDV6UDV2S8kIMrzEXy7j7XiMNIdXowu/T8xtzthiw=;
  b=UAxvM2vUlO8mnFwvFQHSjNm8i+qMbjhOpawv9NrsHNFhqeTi/WkX1lwO
   6mpdEB+F6kcyZwZXLopH5SdWvuHVIL/1roYkjUlXmsyQZwdKoiC00f63U
   FMXSXEKux1MA6L4p4x4JuYQYTxCaIGRQf9pIZ1mDYY56JhAn99meLYLj6
   QgM/BJlsIGs2CkEGaR3yHrabDkX+djjpE7OjRJyhppxRjtH1roRBKJRl2
   ReZdiG2q6rOh4jSB2kQRyh+u6wiq1kw56dIb9mLQ/+56unqi49l7fpoZS
   DlMtvyrAth6K56pI7QtQloujFFXK8W1LNw/NEvxAkC7/QkClXov07OXkQ
   A==;
X-CSE-ConnectionGUID: UfEs/KqVRuq8/uUVUXPX7w==
X-CSE-MsgGUID: i3uXcEIOQlOIMMHkxvkq1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2752855"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2752855"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 04:02:02 -0800
X-CSE-ConnectionGUID: 4HZYybmyQ5aDdyX7j7LcEQ==
X-CSE-MsgGUID: zsA6wVQ+T9yrH/E5QiJ5rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7377976"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa005.jf.intel.com with ESMTP; 07 Nov 2026 04:02:00 -0800
Date: Sat, 7 Nov 2026 19:54:35 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-hps2fpga: Fix reset control leak
Message-ID: <au8Re5V0ZRhSQCMy@yilunxu-OptiPlex-7050>
References: <20261103014240.1194-1-laixiangwu@cmss.chinamobile.com>
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
In-Reply-To: <20261103014240.1194-1-laixiangwu@cmss.chinamobile.com>

On Tue, Nov 03, 2026 at 09:42:40AM +0800, Xiangwu Lai wrote:
> alt_fpga_bridge_probe() acquires the bridge reset control with
> of_reset_control_get_exclusive_by_index(), which is not
> device-managed.  None of the probe error paths (l3regs lookup
> failure, missing clock, clock enable failure, bridge registration
> failure)

Remove these examples, they are just noise that hurts reading.

> release it, and alt_fpga_bridge_remove() does not call
> reset_control_put() either, so the reset control reference leaks both
> on a failed probe and on every bind/unbind cycle.
> 
> Use devm_reset_control_get_exclusive_by_index() so the reset control
> is released automatically when the driver is unbound or the probe
> fails.
> 
> Fixes: e5f8efa5c8bf ("ARM: socfpga: fpga bridge driver support")

Cc stable please

> Signed-off-by: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>

Otherwise it's a good fix. Looking forward a v2.

> ---
>  drivers/fpga/altera-hps2fpga.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
> index f2f125068..6d9798bb9 100644
> --- a/drivers/fpga/altera-hps2fpga.c
> +++ b/drivers/fpga/altera-hps2fpga.c
> @@ -134,8 +134,7 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>  
>  	priv = (struct altera_hps2fpga_data *)device_get_match_data(dev);
>  
> -	priv->bridge_reset = of_reset_control_get_exclusive_by_index(dev->of_node,
> -								     0);
> +	priv->bridge_reset = devm_reset_control_get_exclusive_by_index(dev, 0);
>  	if (IS_ERR(priv->bridge_reset)) {
>  		dev_err(dev, "Could not get %s reset control\n", priv->name);
>  		return PTR_ERR(priv->bridge_reset);
> 
> 
> 
