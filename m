Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B62368288;
	Fri, 19 Dec 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159768; cv=none; b=lcbgPG/p8+MN4AZYmtfNPEF7DVqWK8SEpkv3HSNpgBpVPqxR0B+8fcUvmLmTlBW7nqHBFN5agArDhPxxnuSiYp2uZ/vJkq6EAImtCGMQPOsE9tcXyedMMN97gQ6E4EyCzGC/isXQ2V0iIcYdECdOsr1sSZD2+9cFDrjT3/fCFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159768; c=relaxed/simple;
	bh=I7pLAuwcqz3wE8jzwPrwjWiRpkie2TiKdjsuovAC/SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVN44qUsR+hjL6amuyjx1ZJ+/Hq2R0xpaSUQNGoSTnbZ6gNXKDKmXKSCO3p1ZhhcKg+cjhA9f3EcJJxaze9JzKZZLikZT29LiV1ejPRscy08Tf+ozuq9yEaUVpZY8cG6/P9yUwL+JBItYpgVnys8VyKBx0qisdMhbDnKEBIVZk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M93D8mTe; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M93D8mTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766159766; x=1797695766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I7pLAuwcqz3wE8jzwPrwjWiRpkie2TiKdjsuovAC/SY=;
  b=M93D8mTeb961kKPfv7DHf2wiU91bTm1fYZWoCgnyJ4orlVwtj3AodyHE
   xCULj3K9+6AGeIZmsqAsIffNEO+H2uVgPeTBkCVADyPj9/ngktXBCydIv
   d556Jq0MDkOupqhUCdwcGdJgndMR2KnJCDxnfHrqDqdu9xhNiowj2Zp+n
   6FjkCmqnq/G1PqBUbIaqKu6kLZxrO5IKZnd6+1K++DUiG4luXVw6xwokS
   7J0nepla8b8SiU+WqjGjO6GKiI/Bfc+SA8qOKh9qog8sxMAqocFEenaFE
   eKtyyKsVv0ICXrpXoWX/vAnsMaF+2u0SHxeaVFidKsidLAdPrYjQEd12M
   g==;
X-CSE-ConnectionGUID: J9B3e6J9Qp+2+8bc1N7JNw==
X-CSE-MsgGUID: YAiQEAJoQsi63HXRcj3cjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="68015453"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="68015453"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 07:56:05 -0800
X-CSE-ConnectionGUID: 9IUlVKuERK2MNBpXVYs3rw==
X-CSE-MsgGUID: NccCJhsBQ6yWd0vzVHijAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198792736"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 19 Dec 2025 07:56:03 -0800
Date: Fri, 19 Dec 2025 23:39:47 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: of-fpga-region: Fail if any bridge is missing
Message-ID: <aUVxw7+24cLfEbIB@yilunxu-OptiPlex-7050>
References: <20251127-of-fpga-region-fail-if-bridges-not-found-v1-1-ca674f8d07eb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127-of-fpga-region-fail-if-bridges-not-found-v1-1-ca674f8d07eb@bootlin.com>

On Thu, Nov 27, 2025 at 04:58:48PM +0100, Romain Gantois wrote:
> When parsing the region bridge list from the "fpga-bridges" device tree
> property, the of-fpga-region driver will silently ignore bridges which fail
> to be obtained, for example due to a missing bridge driver or invalid
> phandle.
> 
> This can lead to hardware issues if a region bridge stays coupled when
> partial programming is performed.
> 
> Fail if any of the bridges specified in "fpga-bridges" cannot be obtained.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next, thanks.
