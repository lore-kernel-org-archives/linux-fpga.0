Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8CE43C055;
	Tue, 30 Jun 2026 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831526; cv=none; b=sNdaJI35METW5ujmMF7QPGlGkdEbERu32AbvIRGufw6VaCt80FLUSYgamAoI4ijQ6gZG2e+aFJVusNkw3Gt+7Ei9mCGAZSGhGuAK1CEWI2jVIa1KOVXHLBtC+HTxkEVeXU6PcjGf7JJ4p2rY6rr/NzW+8xkVgGUTS8vCiTBQ52s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831526; c=relaxed/simple;
	bh=NvlOWpqGVmjzKco6lHPkwV/OU6DAYjOA+WtqoZY1Zqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrxeLg9B4uITRNl57jPJIj3reRstrFftP8CulN4isMtb4MHJiAWIVwl7TVuPWY8wWgfEv3d4eAmgOciomrtG8Mhdqwu9bcjDQfzqM0VbWdNBcFBtzglBFb6y66NlZ6O3gDWoklaUKEwkhcSdg3TSPPNLLThVSrpkThaKgFs2iCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQMCjV1r; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQMCjV1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782831525; x=1814367525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NvlOWpqGVmjzKco6lHPkwV/OU6DAYjOA+WtqoZY1Zqo=;
  b=jQMCjV1rgzFuo1y7REwpQ11gAJ2fnjBfjR+hjvShMBNe7oWZFUtqtszA
   9CtTs3RNDsi2V+LK9nANw3F7+ouIJSnvl8C+a02Vmbs2SnV7ijk5YT36n
   ZHQhv+fhXHl1Gj4UkrD0InUQc1FJLoDfPD3YGMyJm/O5UvMM8kq2TducG
   0l2wn/+FXmaGHNlZcSm4easFj4FVxx1smRFFnlhmLVoOo79+/uXChqsAz
   100OI/SoOWzYPwPIIKZ4zkGkC5c8iqXrN36LsH76vEjx6wRqfv7FrT/t2
   tvfc99vl9YneX6Yvg6r/Lyw1JlAFgKkKzv8al3G5yO1YoWKckYTGFfcWi
   w==;
X-CSE-ConnectionGUID: 93b9ZIomS9G9GYW9ZhZK0w==
X-CSE-MsgGUID: 64jVMv9YRByjp3CIuGJcZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94929722"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="94929722"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 07:58:44 -0700
X-CSE-ConnectionGUID: bOugypGsTbq9625/Krg7ew==
X-CSE-MsgGUID: LsdbG3CTTB2FOzuHrAL8ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="248920935"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 30 Jun 2026 07:58:42 -0700
Date: Tue, 30 Jun 2026 22:58:40 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marco.pagani@linux.dev>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
Message-ID: <akPZoGCyQW+6+hDX@yilunxu-OptiPlex-7050>
References: <20260608164247.1998417-1-marco.pagani@linux.dev>
 <aj53joym0YpoYXWQ@yilunxu-OptiPlex-7050>
 <97739313-fc97-4b11-b2e2-d680621a7fe1@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97739313-fc97-4b11-b2e2-d680621a7fe1@linux.dev>

On Tue, Jun 30, 2026 at 11:39:50AM +0200, Marco Pagani wrote:
> 
> 
> On 26/06/2026 14:58, Xu Yilun wrote:
> > On Mon, Jun 08, 2026 at 06:42:45PM +0200, Marco Pagani wrote:
> >> This RFC proposes a proof-of-concept implementation of FPGA region
> >> variants, a mechanism that introduces a common way to handle
> >> dynamic partial reconfiguration from userspace. The proposed approach
> > 
> > There are many threads talking about userspace reconfiguration, the
> > latest one is this:
> > 
> > https://lore.kernel.org/linux-fpga/20250519033950.2669858-1-nava.kishore.manne@amd.com/
> > 
> > Before we dive into detail, could you help tell why the previous one
> > won't work so we must switch to the new interface.
> 
> I think that Nava's latest RFC and older proposals for userspace FPGA
> configuration are in effect functionally equivalent to Antoniou's RFC
> for runtime DT changes via ConfigFS. In other words, they get around

I think it is different. Arbitrarily changing any hardware is
problematic, it doesn't align with how the hardware works. But changing
the hardware inside an FPGA region is exactly the functionality of an
FPGA. As long as we stay within the scope of fpga_region, I don't see
the immediate problem.

> the limitations of the current mainline kernel by using a different
> implementation of the same core idea behind Antoniou's RFC, but do not
> address the fundamental concerns that led to it being NACKed.
> 
> Concerning Nava's latest RFC, scoping the ConfigFS entry point to
> /sys/kernel/config/fpga_region/ does not change the underlying code path
> in the kernel and leaves the same attack vector open. Userspace can
> still load any arbitrary hardware configuration at runtime and mess up
> with registers, clocks, DMA mappings, etc. to attack the kernel from
> "below" accessing potentially sensitive memory areas.

If the implementation does go outside fpga_region, fix it.

> 
> Conversely, this RFC addresses these concerns by constraining possible
> configurations to a limited and statically-defined set that can be
> authenticated as part of the DT at boot time to maintain the chain
> of trust. This is in accordance with the kernel's security model

I'm not sure why a DT at boot time could be verified as trusted while a
runtime overlay can't. Root of trust has anything to do with boot time
or runtime?

Or do you mean a DT boot time authentication could ensure the DT
description exactly match the content of a bin file (variant1-image.bin)
on disk, how?

> which holds that userspace cannot be trusted to define hardware.

I'm not sure, my understanding is FPGA programing is much like firmware
loading, whose correctness/trusty can't be ensured by kernel security
model. Only cryptography can help. Without crypto, kernel still loads
the selected binary, if it corrupts, let it corrupt.
