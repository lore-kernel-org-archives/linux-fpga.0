Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B069036DA03;
	Thu, 23 Jul 2026 04:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784781783; cv=none; b=RCaXM830hni/48+2ViqaUM2dXPFJrJJfCGBzLSRRlsji6DZC8N7puIfhBWwh6SKDyXtbmX3iwSc3jAjEFZ/cT/xMGbAo4H8estUqcVnJ+rR/bB4nIip2/zi7XgS3ejWjQ60P85QOHEgc38SiMCsESSZgpvIyAdSTh5ovbQb+8X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784781783; c=relaxed/simple;
	bh=yg3eH/AksYXmLjITuhwy/JXmoWSYo/p5JLciT/L9N6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU+lJHqfuXUzVNBFuGk78ssy1EFOkMVGPOtLsKGCyk97K1w84hbQQ5ps958xinuU8X1MozzDCsLigb/jrHfK49+MxvKWAFantMCeNmr5I1T2V1GvTT+/UTEHWGNKUlkdAU5sFP1vZOaYLCO3gVwASJLAZvD66u71R0s9taz4VdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQxgnU5G; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQxgnU5G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784781769; x=1816317769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yg3eH/AksYXmLjITuhwy/JXmoWSYo/p5JLciT/L9N6A=;
  b=ZQxgnU5GNEHidZNA6X/GewzZSBq+KFAVRAPkNApKzCAVmCIUYEoFEsCz
   kt0yUyFdoVzMjtNGL0styxvdtZbbG43UQaj8xlkwgQCoYwIJ05QHhSXUg
   Ylrjp4wTsUsJ2ImpjjO7urITNP4ys+jvrWNXIOLo+p9lvkORPunX0NUfh
   Q3amMjpi0AKW+1ylwect3bg0lNr7RHbOJbPEcD3VcIbP3y+aTHe6nv/81
   JAPa4tuRexGcdCDfNTvRI1HLnAyTzP1pFsLmF99LTkEtuUs9//pHTkBg1
   /jYZlgrCq4KHa8z/cft3njekMu4Z2aIuawbz5dZv7CGg4ARjKjRb4lfZW
   w==;
X-CSE-ConnectionGUID: x1ishXY9SdijlAIL371xkg==
X-CSE-MsgGUID: Kals1eW7RHeQcRCPWMtOZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89106093"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="89106093"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 21:42:42 -0700
X-CSE-ConnectionGUID: ypeAySwaTf2gSxXcElTkBg==
X-CSE-MsgGUID: kVZ9r4DyRii9OYwzze3NaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="257741144"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 22 Jul 2026 21:42:39 -0700
Date: Thu, 23 Jul 2026 12:42:38 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
	Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v2] driver: fpga: xilinx-selectmap: add csi and rdwr
 support
Message-ID: <amGbvtMWHXjpE35D@yilunxu-OptiPlex-7050>
References: <20260721114258.3324794-1-hs@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721114258.3324794-1-hs@nabladev.com>

On Tue, Jul 21, 2026 at 01:42:52PM +0200, Heiko Schocher wrote:
> Add csi_b and rdwr pin support for the xilinx,selectmap driver.
> 
> In current driver the pins are configured from DTS and set to
> GPIOD_OUT_HIGH. This works in case you have one FPGA.
> 
> Extend this to really implement csi_b and rdwr pin function in
> driver, so it works with more than one FPGA.

Please help specify in changelog: what do csi_b, rdwr pins do? Why they
now work with one FPGA but not with 2 FPGAs? How do you select which FPGA
to reprogram? thanks.

Thanks,
Yilun
