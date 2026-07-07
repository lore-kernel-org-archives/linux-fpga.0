Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05209288C2D;
	Tue,  7 Jul 2026 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411372; cv=none; b=aFYlD73WcPThFz9oah9KEht7ApWI7N5lZ/J04EZUxO8BhDUGr5uylbb8Qoy6A6UAudMrtwg9c5WjyQ0XFCRrBf8Zli5tL5dKlQMpnaoHqB0KudOGFS9jVRFUJ/04zDOhRHwY+W3TngU4uVPUgXbfH00xwPw+cdqZ7vkjWXTNMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411372; c=relaxed/simple;
	bh=ox31VUoxRh2OiQxBEhmxyfDscwceoKTftKiArTYjGm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+e+I/PLiT77d4YPukAHxqShEovsi0dt7KS1C33hbUJcO7X2Ww0FQLmXmwhJkQS0wvOCd9v078GOD4SNFbyZloUbfFQ7N2oSht4H1h8DFD7ucLa/rgRZiYHBgz8Tsgbb/dFmnWAHS44XnMth78TZ9xI72BGO3prdikOGc+s6dD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AURCGTEc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AURCGTEc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783411371; x=1814947371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ox31VUoxRh2OiQxBEhmxyfDscwceoKTftKiArTYjGm8=;
  b=AURCGTEcozULu6ZYHPKaG2wMC0jZEXZiwsIPGloUP5W6Qn9uqI6+7yPH
   g8QoMdfSetAx5ZfM20Q1JmZY8UlIUy+JbcvQoGmszZ5XgLNzEdb6aT1f+
   mO2M/PLkJ72pkY9Xb7T4Hv5YIiv5q3MeU2wZH+41uxArVsLOBBdLo9jQM
   fIQ8VO8C0gxwR/5dPfNlOsb2WmlEkOnY24JX7yz2pgZOTVrKehzdHj5+H
   WGd0fr0rey6dpK9/PazKWeetgW33bx2I3boTXfP+9MkF31tnW6DPZLHeJ
   DGOAfg4EKzv9dEhonMvsFRruDwY8nk52x3kk0V5UHje5TQU6qLp89iFgh
   Q==;
X-CSE-ConnectionGUID: ex4CLUHtSQi6Az/DwJF2Sg==
X-CSE-MsgGUID: mPKjC59WRQOK1UKAvIFMtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="101478112"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="101478112"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 01:02:51 -0700
X-CSE-ConnectionGUID: FaKCDsM1Tn6hJh2yNSySXA==
X-CSE-MsgGUID: fjOD+LOFTimc/j1Gj1SOqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="251263449"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 07 Jul 2026 01:02:49 -0700
Date: Tue, 7 Jul 2026 16:02:47 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marco.pagani@linux.dev>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
Message-ID: <akyyp1GCecWj2Bk2@yilunxu-OptiPlex-7050>
References: <20260608164247.1998417-1-marco.pagani@linux.dev>
 <aj53joym0YpoYXWQ@yilunxu-OptiPlex-7050>
 <97739313-fc97-4b11-b2e2-d680621a7fe1@linux.dev>
 <akPZoGCyQW+6+hDX@yilunxu-OptiPlex-7050>
 <5dbd4ac8-a532-4889-bae1-f0bab9a99267@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dbd4ac8-a532-4889-bae1-f0bab9a99267@linux.dev>

> My understanding is that Nava's RFC already scopes the configuration to
> /sys/kernel/config/fpga_region/. However, that would still leave the
> attack vector open. A malevolent userspace component could still load a
> malicious DT overlay with a rogue "ranges" property to access kernel
> memory or a rouge "dma-ranges" property to hijack a legitimate IP for
> the same purpose, or it can mess with the clock configuration. It also
> worth considering that DT changes are applied to the global kernel
> hardware configuration and cannot be sandboxed to the specific FPGA
> region. The root of the problem is that we cannot check and guarantee
> at runtime that an arbitrary DT overlay is sane and affects only its
> specific FPGA region.

I see. So your concern is the DT overlay can impact the outside world by
referencing global nodes. My idea is, if we could statically specify the
fpga-region with these assigned resources, no updating of these static
properties, and don't allow global referencing phandle, we are good?

I mean we don't have to verbose on every combination of hardware that a
user might load. We harden the boundaries of the resources (ranges,
dma-ranges, ...) that are initially designed for the fpga-region in base
DT. To me, this seems to be more aligned to "DT describes the HW" and
how the FPGA works.

How do you think?
