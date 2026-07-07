Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C301029D265;
	Tue,  7 Jul 2026 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399641; cv=none; b=t3dDqhdPMShU4XR+KpIDqgcExsWdUu3RlVGvgq5kxjXDFYYgZ6pdUavC9e9UwMV9+BryRpqUXWEGykrJ2gur4chNmaCfETOKw2zMSPjUqhprLpm/hfuglxqNbDnhSpo8NEf7Z823Y+V834RbXJ5ztwBi3d+hIrPCpkymhOYD18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399641; c=relaxed/simple;
	bh=lYiOxqHOpJJiI5SobcPBudJVh24imKuNYZQ2He99RGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxoRdwYmynKn0oqPw3EQuWMIbdKkJMI0nv8bYM35SM0FH6EeUYUIrLwEdv+kmGOp2FC8WLpsvFU/DFxjm6ojM0nS1ukDFPiUaWChwPMQoUVuFiDwwoHfp/Ox1e0blEGQ9Txn6v8XUOvdcWD0KQ/6gpHMxjAcv0TflauF/XW1ylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hweXTGp3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hweXTGp3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783399640; x=1814935640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lYiOxqHOpJJiI5SobcPBudJVh24imKuNYZQ2He99RGA=;
  b=hweXTGp3Zzx0Rh6gfgkkwo1BZtejP4ziFL2it6ZESF5qHhpItH0yuAJ3
   q71o/iFvB7VPFpPUawrHTZEXHpQbq1FGorbki47HS6IR4MzOqY2YFuFA8
   rphTIeno+cSjmnVJ8b3UmvneA1z8f21hfGRM/b7axLWK+DqpvYEUf5Z0l
   3poyu55hX2b7XkDdn1xJSk8lgYjnTS2BcpP9Rl22lqm7oIaPMo5KBsJ33
   +i+1B5LeTemyr5y2xZb73PvSg6WtjtNfaocPXMYeKSyFfBx7Xf1C0oPow
   2RC6TQNI37Do0fSWz5LejHQgMYlIGGpVltIMETBWzPjWMI5ChBoaBKFKP
   Q==;
X-CSE-ConnectionGUID: 9ui+IMfZROeD70TneWMHJw==
X-CSE-MsgGUID: AcbVJpnBQk2Ucilk9uEoLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="86587381"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="86587381"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 21:47:19 -0700
X-CSE-ConnectionGUID: lI3+jU7QR1GAG6wgorlbbA==
X-CSE-MsgGUID: ADeHf08kRDeVB8lZn8OqIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="258211792"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 06 Jul 2026 21:47:17 -0700
Date: Tue, 7 Jul 2026 12:47:16 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	stable <stable@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: dfl: fme: add error handling
Message-ID: <akyE1DyCAdtxbwqr@yilunxu-OptiPlex-7050>
References: <2026070620-unwired-clay-f6cc@gregkh>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026070620-unwired-clay-f6cc@gregkh>

On Mon, Jul 06, 2026 at 04:58:21PM +0200, Greg Kroah-Hartman wrote:
> From: Griffin Kroah-Hartman <griffin@kroah.com>
> 
> Add error handling to devm_kasprint in fme_perf_pmu_register().

Actually perf_pmu_register() will handle the !name, but good to change
it for readability.

> 
> Assisted-by: gkh_clanker_2000

Fixes: 724142f8c42a ("fpga: dfl: fme: add performance reporting support")

> Cc: stable <stable@kernel.org>

Changed to Cc: stable@kernel.org, or checkpatch will complain.

> Cc: Xu Yilun <yilun.xu@intel.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

I fixed the tags inplace, and applied to for-next.

Thanks,
Yilun

> ---
>  drivers/fpga/dfl-fme-perf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> index 7422d2bc6f37..db56d52411ef 100644
> --- a/drivers/fpga/dfl-fme-perf.c
> +++ b/drivers/fpga/dfl-fme-perf.c
> @@ -925,6 +925,8 @@ static int fme_perf_pmu_register(struct platform_device *pdev,
>  				PERF_PMU_CAP_NO_EXCLUDE;
>  
>  	name = devm_kasprintf(priv->dev, GFP_KERNEL, "dfl_fme%d", pdev->id);
> +	if (!name)
> +		return -ENOMEM;
>  
>  	ret = perf_pmu_register(pmu, name, -1);
>  	if (ret)
> -- 
> 2.55.0
> 
> 
