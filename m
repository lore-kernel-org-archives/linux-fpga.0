Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8150B8B2;
	Fri, 18 Sep 2026 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748441; cv=none; b=VTrnFfsRCskmxudesLqi4DL9Q1D8sYE6QiyMUvZB2yo5jLUGAT1hvU/aUg9ayp5exkQXNhGjTF0vRr2iGUHUCykBwlgP4iImSElqfAhasOKwnUEtk9uCZ6uGTqS9ia41IPWg6ic6wOfrK/imRdm4S0JSpJ2P2kNQLTK/E0smiy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748441; c=relaxed/simple;
	bh=4djSnnE8LHSvuIWChsZNA6rJeO1kVt9fIDqJ3xZZlt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeUHSBJIR/txdxkaw1ZQxYv6SLj19DLO1Q2nVl1YSf0V8zO3XyHcvRZCfLdWVaU2LdS8fHnHObQKcMs9IKCxik1jcYfTt4wS5uIQ/ZnlJvPF8HaZRCdhpMOcLwgdG/wztOP+Hy3/OU0MmvjCR7rC7wx4FP2AuoLhwaOaSKSiNEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HT4sl0pU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HT4sl0pU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789748439; x=1821284439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4djSnnE8LHSvuIWChsZNA6rJeO1kVt9fIDqJ3xZZlt8=;
  b=HT4sl0pUx3eq1ZQZA+scdhCD7bvCMXd98xFd1ckqeEDwvnr7iApC7qRo
   NxHy96xM2AEFXN81B1fjmRE6gQlhHBHhModQORSZWbAuQQU8eeCIFid+B
   mZtgwl7PIq3824Go1k5mXpDNzEYAdv7LAEdRnQj2zfvI7jtF3GbVJn+e5
   sgCD/f1+BXH85ko6voNMSY7dsVHRHM9SNPWiESELwzTeVUydAw0mv10oL
   FFIwpUPPzYA1rif0lrjlO8CgqfMM76v582OJPgxbppEMS16tssmRCLNCd
   H1wwcXT43LBX7yzQLm5e7OGjGo1DT758IeO+9ya8isQ9C/K/M4ItXU+Re
   A==;
X-CSE-ConnectionGUID: ZeoVLRYgTQ6eDCW2IyQCZA==
X-CSE-MsgGUID: I26FS0uqQ4WNG3t815jyHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90398002"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="90398002"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 09:20:38 -0700
X-CSE-ConnectionGUID: AJZIHhFXSm6nS/LH7M5ZBQ==
X-CSE-MsgGUID: 8EW7TYFNSMudkTYpY4fi6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="268211319"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa009.fm.intel.com with ESMTP; 18 Sep 2026 09:20:37 -0700
Date: Sat, 19 Sep 2026 00:20:12 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: altera-cvp: Retry teardown and reset CVP state
 on failure
Message-ID: <aq1kvDQyIWUjBciz@yilunxu-OptiPlex-7050>
References: <20260915062734.42964-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915062734.42964-1-muhammad.nazim.amirul.nazle.asmade@altera.com>

> +static int altera_cvp_recovery(struct fpga_manager *mgr,
> +			       struct fpga_image_info *info)
> +{
> +	struct altera_cvp_conf *conf = mgr->priv;
> +	int ret, retry;
> +
> +	ret = altera_cvp_teardown(mgr, info);
> +	for (retry = 0; ret && retry < CVP_TEARDOWN_MAX_RETRY; retry++) {
> +		altera_cvp_disable_cvp_mode(conf);
> +		ret = altera_cvp_teardown(mgr, info);
> +	}

If one retry is sufficient, no need to define CVP_TEARDOWN_MAX_RETRY, no
need to loop.

	if (ret) {
		/*
		 * IIUC, say something like CVP_STATUS may stuck and you
		 * re-activate the CVP_STATUS then try teardown again.
		 * Please re-org the word.
		 */
		altera_cvp_disable_cvp_mode(conf);
		ret = altera_cvp_teardown(mgr, info);
	}

> +
> +	if (ret)
> +		dev_err(&mgr->dev, "Tear-down failed after %d retries\n",
> +			CVP_TEARDOWN_MAX_RETRY);

You always retry once when failure, no need to tell I've retried.

> +	else
> +		dev_info(&mgr->dev, "Tear-down successful\n");

Only speak up when something goes wrong or suspicious.

>  
>  	return ret;
>  }
