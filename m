Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053262;
	b=2Ans0vtdOx3dgWJsnji/7AXvedA8M2xw5ImJ1txFcZenOigpHnpEkM3OQS7L6VVSg7TL
	 oznaJLNxt/x4xkpuoe73N+xgoIL2XnZndqy6UYu7CORTv+PAZ4S03yPUCecT9FTv8UA9O
	 VuI4NrpqAvYmmAVlCVSjOVQpId0omIqvZ7qIKzCg53Js7K13R46O+44AsH4TE9eBU3hxe
	 ib1qbVoFS9ftKhGnJv84nWuROGexNSTUbTTFeuSzK60MzRCdb0nNHFNoNmc0xr4xJ1CGU
	 88+QLNWS8qApVA5C8omax5euc8pLHuYo1GUYSQrEY7PtBJPu2x6XYzdirddhE8aWNjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053262;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=CygT9NaBxgqevpwUDpOAwsQIEdMgdyKTPiwU2omG2qc=;
	b=BKR2lTh5kuPSK2ByUvbmzmBSEgD2iRlQOvp8mpVxGnLxRSa02okURZT5t6jcSudkj/y5
	 D/3K5KKDDhvN/+fQ4SqGVN6ZMbIy8VAvqsIDS3etIsC1LHTbK9lFRejRgSynzzS/vRq+F
	 2GnQOTaTkgQtTh504ZrvEQQqF5tR8YZ0mVQDxaSGWRTRdySQaVET9Tuv+PaNImYWkQO93
	 //OSEujz4weNkckImuZgVjPmILuHI41KKbQstyiiPnlMBloxUvavPRr2QQ2i6XcZ1wcRX
	 G7MPKMXuHcA3ZZ8XrxFT6iAU1ZapIMQZ/RTwlIBEbJYhWsB/fjXMKsDwnvdKr2V9Vzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CNyFbb4Z;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D261B606A32D;
	Sat,  7 Nov 2026 12:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D261B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CNyFbb4Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794053262; x=1825589262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=shD6Fdf1eUPGxpYe75r0xFnqIlOzCnHsMjQZrMOlGtY=;
  b=CNyFbb4Z4BNi0W4RF1IjymQpVUm8N6WuwrxMJxbbt/4cTKvglI3Uprjy
   RNs1oQpvw9CZslCFb3bm3CqlAqlaQWqDLaywWc2U7dWwKtzdhljLB0zmQ
   k/mTBP8voYLIs9JmmHPcZPnicIjQl/wQebOGMBvfDZL1nXq9JQ9CuWklB
   eAAbDuwQZfKci30HZHneTGvyvcUM9ugtn5T6cQIjI250y1/2ajP5QJ7X1
   hBc70UAPKQB9pfnw5P5z3cHbuJwbPXPH/hqg5bYRZ9vVCD+PW0Pyv6CUg
   KiLmeqC764h1m0Cv82LhljKlj7/VcHkLEq5LjV3XKHLI+w3b4/u6oUD6w
   g==;
X-CSE-ConnectionGUID: lg/WBqSTSVGX/2wVO4tR/g==
X-CSE-MsgGUID: 977EWUgoTt28mDtV0AEc6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2843818"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2843818"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 04:07:42 -0800
X-CSE-ConnectionGUID: Ndor18ljTVyK31tRwg0xWQ==
X-CSE-MsgGUID: 3njacIjVQ3ClIPrWicbqkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7354268"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa007.jf.intel.com with ESMTP; 07 Nov 2026 04:07:40 -0800
Date: Sat, 7 Nov 2026 20:00:14 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-hps2fpga: do not request reset by index
Message-ID: <au8Szj1uhBsP++es@yilunxu-OptiPlex-7050>
References: <20261106-reset-deindex-fpga-v1-1-5672928ba5f6@pengutronix.de>
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
In-Reply-To: <20261106-reset-deindex-fpga-v1-1-5672928ba5f6@pengutronix.de>

On Fri, Nov 06, 2026 at 04:43:19PM +0100, Philipp Zabel wrote:
> There is no need to request a single reset by index.
> Use of_reset_control_get_exclusive() to request the first and only
> reset.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/fpga/altera-hps2fpga.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
> index f2f1250689cb..9b7f5b8191b8 100644
> --- a/drivers/fpga/altera-hps2fpga.c
> +++ b/drivers/fpga/altera-hps2fpga.c
> @@ -134,8 +134,7 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>  
>  	priv = (struct altera_hps2fpga_data *)device_get_match_data(dev);
>  
> -	priv->bridge_reset = of_reset_control_get_exclusive_by_index(dev->of_node,
> -								     0);
> +	priv->bridge_reset = of_reset_control_get_exclusive(dev->of_node, NULL);

Saved a 0 arg but add a NULL arg, Any benifit to justify the code churn?

>  	if (IS_ERR(priv->bridge_reset)) {
>  		dev_err(dev, "Could not get %s reset control\n", priv->name);
>  		return PTR_ERR(priv->bridge_reset);
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261106-reset-deindex-fpga-f203618612b1
> 
> Best regards,
> --  
> Philipp Zabel <p.zabel@pengutronix.de>
> 
> 
