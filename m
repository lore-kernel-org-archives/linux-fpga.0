Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9C20458A;
	Fri, 19 Dec 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766156453; cv=none; b=IAsPo2j8qv7gNW+jq1suw8WZuFmYFftl8zkNePl8NIQ2pGkz/QblrKECEfGzU3KqGRhiMOq9bN498MnrRL8YJP2tqqusQLuXW/3Hcaf0RyxvRP7fA5rN0O1C9jR8FmW8454BK1egEHdIy1VJlASsCj62N3zkqsGuEzbGsspA0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766156453; c=relaxed/simple;
	bh=g4/zSNqqhyxFHCI9MSvjv6YzY82DKUSIKh1YWe3Ho1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsG5+GjUyffrlicsxAJ1T/PVB6JvmONIiNE+kIM67OwT7LQ04Bd19x7pd9rbdu+GulciOI938TUpbaJDaAbavNhAKjUVSmGCXksfj8IK+kVr7Ck9tPz/Mjg55JIAqtesXXBP5rV+nUhAjxisItWMKQcFehCEeaP848mB7B92WKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6cfgenw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6cfgenw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766156451; x=1797692451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g4/zSNqqhyxFHCI9MSvjv6YzY82DKUSIKh1YWe3Ho1A=;
  b=O6cfgenwlxBZTmGByI1cRl8Eiki2dEVMxrO/mqzIyUWf49QCIsdywrVC
   n48rBvbv8inKK20zzat+7+q/Oq+KKSG4gVjLpzUE5OoWyPkTMPlv44RzD
   5zj3vF8wTC9Rd07J8uhCoWOC5crEt0wQEKILIUQqdjmpGntsvzGRgoQAz
   Bzut+JeMuUfIPEkqnr17doBHmzrmNPA+SCEFrgBwEE8Zv5HPXewWmoT3Y
   5Ku9lz/+5gYAbOlupYKn0krYWGnDIL2wwti3g9B8Iy/f4HnyyofMYNzry
   mPBnJ6S81JU6UNPmz42EstHU4rq4PPDBLOpUFmg2Rsr7P+VmFI8fv2yI7
   g==;
X-CSE-ConnectionGUID: yHfulgjzS5SOzuqQVCDgIw==
X-CSE-MsgGUID: 3alrdfjuQtWZ5Wmk3M/S2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="93590542"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="93590542"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 07:00:47 -0800
X-CSE-ConnectionGUID: KSw+fH0uRTCbHZcTvAK39A==
X-CSE-MsgGUID: osLSls+JT6WvaU0myLkh1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="229566070"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 19 Dec 2025 07:00:45 -0800
Date: Fri, 19 Dec 2025 22:44:29 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: adrianhoyin.ng@altera.com
Cc: dinguyen@kernel.org, mdf@kernel.org, yilun.xu@intel.com,
	trix@redhat.com, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: stratix10-svc: Add SMMU support for Agilex5
Message-ID: <aUVkzV447+NDmLg1@yilunxu-OptiPlex-7050>
References: <20251217055632.1776206-1-adrianhoyin.ng@altera.com>
 <20251217055632.1776206-2-adrianhoyin.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217055632.1776206-2-adrianhoyin.ng@altera.com>

> @@ -1907,8 +1988,52 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>  	controller->genpool = genpool;
>  	controller->task = NULL;
>  	controller->invoke_fn = invoke_fn;
> +	controller->is_smmu_enabled = false;
> +	controller->sdm_dma_addr_offset = 0x0;
>  	init_completion(&controller->complete_status);
>  
> +	if (of_device_is_compatible(node, "intel,agilex5-svc")) {
> +		if (device_iommu_mapped(&pdev->dev)) {
> +			controller->is_smmu_enabled = true;
> +			controller->sdm_dma_addr_offset = AGILEX5_SDM_DMA_ADDR_OFFSET;
> +			pr_debug("Intel Service Layer Driver: IOMMU Present\n");
> +			controller->domain = iommu_get_dma_domain(dev);
> +
> +			if (!controller->domain) {
> +				pr_warn("Intel Service Layer Driver: Error IOMMU domain\n");
> +				ret = -ENODEV;
> +				goto err_destroy_pool;
> +			} else {
> +				ret = iova_cache_get();
> +				if (ret < 0) {
> +					pr_warn("Intel Service Layer Driver: IOVA cache failed\n");
> +					iommu_domain_free(controller->domain);
> +					ret = -ENODEV;
> +					goto err_destroy_pool;
> +				}
> +				ret = iommu_attach_device(controller->domain, dev);

I don't understand why you retrieved device's default domain and set it
back to the same device. Seems nothing changed?

> +				if (ret) {
> +					pr_warn("Intel Service Layer Driver: Error IOMMU attach failed\n");
> +					iova_cache_put();
> +					iommu_domain_free(controller->domain);
> +					ret = -ENODEV;
> +					goto err_destroy_pool;
> +				}
> +			}
> +
> +			order = __ffs(controller->domain->pgsize_bitmap);
> +			init_iova_domain(&controller->carveout.domain, 1UL << order,
> +					 IOMMU_STARTING_ADDR);

And why you have to carveout an iova space? The requirement is just the
device can only accept 24bit iova address, that's normal requrement for
many devices, can we just do:

  dma_set_mask(dev, DMA_BIT_MASK(24));
  dma_set_coherent_mask(dev, DMA_BIT_MASK(24));

  dma_map_single(...)

instead of manipulating iova && iommu mapping by your own?

Another thing is why we should bifurcate direct dma & iommu mapped dma
in the driver, DMA APIs take care of these 2 cases.

Thanks,
Yilun
