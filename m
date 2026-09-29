Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1738F511E72;
	Tue, 29 Sep 2026 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677778; cv=none; b=IQ7L066B4g3YKotdBid42jgec9UAOFoMmtNLv/1YRG2rpoaB+faBShK4o4Q+JV4k8GhYMKeQHHd/xkwYEGDHbhzUsDq/9QXuK0q2oltdDYlLj8n7ZAX+k20hMsVb1EHjzXVHnLaRDAt3MK64lOjTBgspstmWGAV4InbsUXL2iw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677778; c=relaxed/simple;
	bh=d2W3/qzfEYYJuhYv9gJnONJFnesGnNML5adOkSwhP4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwoZJg/phKaCzuzMXSTJTmTdAzqExGCyGVS5evYnGRL3WQ7j/hMBqaEsub+OBErdgIyLmCB3NcE76VudF8W9J4fFPlaDWGsXBtDs42I/aFNFVG+jCOmN91v1zPD0atEdto/1pxCIn40UL4RLe/54/xLvbg842LFV59TCQDb83+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fF4LG7Ou; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fF4LG7Ou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790677768; x=1822213768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d2W3/qzfEYYJuhYv9gJnONJFnesGnNML5adOkSwhP4o=;
  b=fF4LG7OuDd9EEqHEtavVadvm63FudoIfX4K2+C63YnPi1P/3QLCwNZ/t
   wPQ+CAvR79RVFq4VgPdU4zGsHXWlUWcf7uS2MRxp0sSMQ2Hx6POrN+O9h
   +7U1zZ7kIOYuAjJ2f2rgU9EQBSzIBbwDlzUf7KTCnPlQgJecEeTOu+/Le
   lSc7BPOMHuPo1uuI2IaADkmCsF91/7S5yn0aROz5omKIkQrQokepvfFJW
   wasFU1cwpyMcyKtzIR9Xsx9WOVkYaPSSjagQ4U1Z9pJl/g4ogI4jb9YqX
   yrv2g0vfKWXZbfOdNe+Z/FQKHlGM4khddYDKKDYtvdoEuaNbzVKtN5Shj
   g==;
X-CSE-ConnectionGUID: b5tmIZL8T3GE/7/7Rv9DNg==
X-CSE-MsgGUID: 63uCUlNcSSGobNsbqX1tHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101962120"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="101962120"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 03:29:22 -0700
X-CSE-ConnectionGUID: YKRWtUV1ThaSOfThBpKgIw==
X-CSE-MsgGUID: 7snmeH+mTzaV+muwLXcIcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="301613493"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa002.fm.intel.com with ESMTP; 29 Sep 2026 03:29:21 -0700
Date: Tue, 29 Sep 2026 18:27:25 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] fpga: altera-cvp: Retry teardown on CFG_RDY
 timeout
Message-ID: <aruSjQeo+sR6jNez@yilunxu-OptiPlex-7050>
References: <20260923053233.10890-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923053233.10890-1-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Tue, Sep 22, 2026 at 10:32:31PM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> After a bad bitstream, the CFG_RDY poll at the end of teardown can time
> out because CVP_STATUS gets stuck. This series exits CvP mode to switch
> back the clock feeding CVP_STATUS and retries the teardown once.
> 
> Patch 1 factors out the existing CVP_MODE/HIP_CLK_SEL clearing into a
> helper. Patch 2 uses it in the new teardown recovery path.
> 
> v2: https://lore.kernel.org/linux-fpga/20260915062734.42964-1-muhammad.nazim.amirul.nazle.asmade@altera.com/
> v1: https://lore.kernel.org/linux-fpga/20260618112410.303-1-muhammad.nazim.amirul.nazle.asmade@altera.com/
> 
> Changes in v3:
> - Split altera_cvp_disable_cvp_mode() into a preparatory patch and use
>   it for STEP 17 in altera_cvp_write_complete()
> - Drop CVP_TEARDOWN_MAX_RETRY and the loop; retry once directly
> - Add a comment explaining why the retry is done
> - Drop the retry count from the failure message
> - Drop the success message
> 
> Changes in v2:
> - Rewrite commit message to explain CFG_RDY timeout, HIP clock switch,
>   and why one retry is enough
> - Move CvP mode/HIP clock cleanup into recovery via
>   altera_cvp_disable_cvp_mode() helper
> - Reduce retries to 1 (first teardown + one retry after cleanup)
> - Use dev_warn for per-teardown CFG_RDY timeout; one final
>   success/failure message from recovery
> 
> Nazim Amirul (2):
>   fpga: altera-cvp: Add helper to disable CvP mode
>   fpga: altera-cvp: Retry teardown and reset CVP state on failure
> 
>  drivers/fpga/altera-cvp.c | 43 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 36 insertions(+), 7 deletions(-)

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next. Thanks.

> 
> -- 
> 2.43.7
> 
> 
