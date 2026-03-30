Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D2391848;
	Mon, 30 Mar 2026 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868394; cv=none; b=mikBGaHhXiLoaN/8vsp9nzgI8O7DqPE6s8OnR3e5zmlQRpS7BcOEHE7jinaHtywpx4owwgE69lWW4YfxKkwvNTcHCpWS0EdjBhOrOAU/FEN5SDweQCzew9/4M3TlM9NWAxrJwOH2Cch8lBKqbf1Q2XDcV2MFQ5WbpA0pedMi7as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868394; c=relaxed/simple;
	bh=TP/ijlT8VPaNoReM01g+AkVQTYxK9b6XLtwbT0XD5gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5hG7hqo/VVRNwDA8E7jbOhYeiH5Nj4MDyipwggurYWsaNhPrdRGdgG6Nh4p8YiI4ZDg5ULO8LAUoiw6kIMF8tyFRIVsHYg/aXJxdsH8phMeLENj+poo51XXtxg6woxYVunkfyNJYjewBlcEYiESkM0ZmQkE2u+9O51J39rMHXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nu2yKKMU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nu2yKKMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774868392; x=1806404392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TP/ijlT8VPaNoReM01g+AkVQTYxK9b6XLtwbT0XD5gs=;
  b=nu2yKKMUdqzmtR5u3YZqbMfceb+M/jbWVHuFxBEf01bYdyNgSPw27Gvi
   IOLNkUwMFLfEBOeMhSTz0lHbxBK7DuGDhiViOW12+Qa+LfobQ/8m5fxPZ
   SvXRNVlaykzErOp/wLXldrMl8Q0zLEGdG49ItY7ZkM2t5OM6YylVSy20I
   GVLpnS73KdN9vuK8+K7JBJS+gjndQJ41cx9L2Hg/N4IiTWqcIr0VCReUq
   XtymbZUny4Zyjvv+R7/RkNdWHSP/ta4d1XQqsosaP5k7oHuvIP/jyPosb
   fBJty05G7p05JtD/5G2lT63dJ2YdEcY5QsCv/YXuB5EdruMeDr+LKxR1d
   A==;
X-CSE-ConnectionGUID: 94yMWFnVT4y+hwt+w/Bzng==
X-CSE-MsgGUID: NpwBV17DQbafTMOW+xuvdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="76048859"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="76048859"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:59:50 -0700
X-CSE-ConnectionGUID: E5vAM/GSTPu25opRSjP9HA==
X-CSE-MsgGUID: kT/JKLwZT+KiWFjsn0SOCQ==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 30 Mar 2026 03:59:47 -0700
Date: Mon, 30 Mar 2026 18:38:40 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: iansdannapel@gmail.com
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, mdf@kernel.org, yilun.xu@intel.com,
	trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, neil.armstrong@linaro.org, heiko@sntech.de,
	marex@nabladev.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	dev@kael-k.io
Subject: Re: [PATCH v6 0/3] Add Efinix FPGA configuration support
Message-ID: <acpSsCQtCPvLlXsL@yilunxu-OptiPlex-7050>
References: <20260327114842.1300284-1-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327114842.1300284-1-iansdannapel@gmail.com>

On Fri, Mar 27, 2026 at 12:48:38PM +0100, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
> 
> Hi all,
> 
> This is v6 of the series adding support for programming Efinix FPGAs
> over SPI using the fpga-mgr subsystem.

Sorry, I'm on vacation and cannot make it in v7.0-rc, though I assume it
should be neat as a v6.

Will try to merge it in v7.1-rc, thanks.
