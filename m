Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A1851B161;
	Fri, 18 Sep 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753107; cv=none; b=GRylwTsgHVW5aiHzfG9sy3poU0ZPF9Z+Qf3dfijY8OhTYYG9Bm3jROwTcgWHAnaGIidFYU+i1Rc6yjIuMVCES7dLa+JhBqg4FGEdh74W7uDXf5hBGA0xByD83f/8dJv2x5cZerjix/bvh9/xYukUk6jguJ5Uhcn+Q5TU6Z6K7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753107; c=relaxed/simple;
	bh=J3bYaEWyyYv31Nix/vTbMEEAr9eEVvvLHflmIWHKVJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d99GsZrDfa+luvPP5UvBm4X9IuMFfgN5vitNeAjZY/sJR4VXdpKSiuCTlb0b9o9jO1DI7JCzpl1p/68lWgwFDejS0cms4nE0bbvqHQ69ZvBvKhYCucIX0rnHfhfft3MhmZR9mKGWgTJGCOV33e7hvI/bDYkDTy0wq3/QpjnxFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kI4eT2+f; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kI4eT2+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789753104; x=1821289104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J3bYaEWyyYv31Nix/vTbMEEAr9eEVvvLHflmIWHKVJ8=;
  b=kI4eT2+feKJKqVVBzVPA2vu0FNxpFjveeqVjp1DXr1OAOBNF0yg86ZQ+
   krROOyMa5LM8KCTTaR6PjC8bN0xuVRrvQs4wWnEAnl7jgXgrd6uaf7HPv
   3wvsqhsugmFnzOqwqCV4fGf0SgTAAK+iyEDDBrFWkAexZWXQ+nZEyyTFN
   ZIdosVXPH4eVsFUSmmaQfuBJdkr9JLGxwW24FX8bMPuEPVHV/Be79M9nT
   quMOzCbNLVxKBNYW3MPCKrUU9C+gvXaOfPfEj9D+1ODyEXWZ07lBG8cAh
   i00xidxO1cNsq9BwhUvVbacxJLSa2thLIlGzhsTJfWdRKMJWS8pEmHHfT
   w==;
X-CSE-ConnectionGUID: mxiVi5UBQ+e1L4wqKNoLYw==
X-CSE-MsgGUID: 6xiQ1ztHRK6B7ruaaqK8iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="788109"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="788109"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 10:38:19 -0700
X-CSE-ConnectionGUID: FHUY+oYITFKMtiG9ag3XJw==
X-CSE-MsgGUID: dSSX9EITS2WMVXmCCZaTYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270796387"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 10:38:16 -0700
Date: Sat, 19 Sep 2026 01:37:51 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
	Xu Yilun <yilun.xu@intel.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5] fpga: xilinx-selectmap: control CSI_B and RDWR_B
 during configuration
Message-ID: <aq1270NA95AERKQp@yilunxu-OptiPlex-7050>
References: <20260909112200.13256-1-hs@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909112200.13256-1-hs@nabladev.com>

On Wed, Sep 09, 2026 at 01:21:54PM +0200, Heiko Schocher wrote:
> The driver requests the optional CSI_B and RDWR_B GPIOs with
> GPIOD_OUT_HIGH and never touches them again. That flag carries a
> logical value, so both signals end up asserted from probe on, whatever
> polarity the device tree states, and they stay asserted for the
> lifetime of the device.
> 
> Neither signal belongs to the driver's lifetime. CSI_B (Chip Select)
> selects the device on the SelectMAP port, RDWR_B (Read/Write) selects
> the transfer direction, so both belong to the data transfer. A device
> that is never deselected never lets go of the port, and a port pinned
> to write mode cannot be read back.
> 
> Keep the two descriptors in the driver private data, request them
> deasserted, and assert them only around the configuration data
> transfer. RDWR_B is asserted first, UG470 describes in chapter
> "SelectMAP ABORT" that changing it while the device is selected aborts
> the configuration on the next CCLK.
> 
> Signed-off-by: Heiko Schocher <hs@nabladev.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.
