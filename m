Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62C59C977;
	Tue,  8 Sep 2026 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788893978; cv=none; b=lGo2NOxPW5dxXiMj20mgj3nhTGCbt5XqzwMQz3uA7OOPZNEccR/fsay5gCgIUgf7mOmz7UbGY5ujjoSlHYZwTZAk/1eANZimy3YWeLle3sYPfCpR9wUXCc0urD49RYxpi2t8oqskKfGYSbgKYaE4ggSBi/pZ+vl4cJcp6wM94i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788893978; c=relaxed/simple;
	bh=fWURKfC0YnKtnpIW+sCXZWGoSCh2jCIDL2blX3O/UH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDx8XExUNUUWb5Ytwphiz1oakgIhXen7uu0F17cDghvp4g6V8BSg3oA5m4Q7ql4ot6gVb2n2I0XbQeKFGNMADHfI+wp6YS0+bSgeNNGRGSuk+2ThLbXWixkCmoe+jx5KgSVwOl44udVAuhSBm25gFOrsq02Vpkrntq4lritf4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4oLHunT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4oLHunT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788893977; x=1820429977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fWURKfC0YnKtnpIW+sCXZWGoSCh2jCIDL2blX3O/UH0=;
  b=U4oLHunTydgLRgJHVBXZmgl5ZG6vkOuK/0EpvxOT8kIiSR69RvcamciC
   tuMmg+3l9rvoHqnfHMvCML74QzQ4aIy7zPr+zLHvXU5jhQqI+a8keDAh8
   W/D2S7GSUVm/uX59g4o+A2PDiIf+47aApL5yoPs/cAkKRe8Ha0HYROKlm
   macinbxQa4OVzWDaghI2ITkBWzj1R3ITc7Qk2tD+3AWInOD3uh1zP4X6Q
   EcoAjKBTkdB1x2ksiUFKBZCEg7Q5LOTl5zMzTamAa3KINzBVbyMZsT2KQ
   pMicR0/HTCo6dNGgMP3JVXbG70g+eHj1INXOV2z0ABNZwr8kCUFztPSAC
   Q==;
X-CSE-ConnectionGUID: uxSB/k+vRxenodLJzu9MTg==
X-CSE-MsgGUID: m+zERQXcRLmCbdoCYjB+sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100828040"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="100828040"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 11:59:36 -0700
X-CSE-ConnectionGUID: SAxxF9giQsaP/2WeIAZ85A==
X-CSE-MsgGUID: cktt8h4WT8SZl+P+UCCZbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="266773711"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa006.fm.intel.com with ESMTP; 08 Sep 2026 11:59:33 -0700
Date: Wed, 9 Sep 2026 02:59:32 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
	Xu Yilun <yilun.xu@intel.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4] driver: fpga: xilinx-selectmap: add csi and rdwr
 support
Message-ID: <aqBbFGExUpS0k0yE@yilunxu-OptiPlex-7050>
References: <20260810062105.299808-1-hs@nabladev.com>
 <ap2Yx8oACWfBKOep@yilunxu-OptiPlex-7050>
 <6a489d2b-b5d1-0455-793f-f4100fd3b3d1@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a489d2b-b5d1-0455-793f-f4100fd3b3d1@nabladev.com>

> I would change v5 commit message to:
> """
>     The driver requests the optional CSI_B and RDWR_B GPIOs with
>     GPIOD_OUT_HIGH and never touches them again. That flag carries a
>     logical value, so both signals end up asserted on every board,
>     whatever polarity the device tree states.

Yeah, that's clear now.

> 
>     Keeping them asserted works as long as a single FPGA owns the
>     SelectMAP port. That FPGA is the only device on the bus, so it may
>     stay selected, and the driver never reads from it, so the port may
>     stay in write mode.

I think keeping them asserted is a bad idea even for single FPGA, isn't
it?

> 
>     It stops working as soon as two FPGAs share one SelectMAP data bus,
>     which is the case CSI_B exists for. Both devices are selected all
>     the time, so every byte written for one of them is clocked into the
>     other as well, and neither can be configured on its own.
> 
>     CSI_B (Chip Select) selects the target FPGA. Assert it before the
>     configuration data is transferred and deassert it afterwards, so that
>     only the intended device sees the bus cycles.

What if we re-program the 2 FPGAs at the same time? Is there still
chance the 2 CS lines are all asserted? Can they be correctly
re-programmed in this case?

I mean I think this patch does fix the problem of "always assertion",
which is good to me. But the changelog seems stop me, it talks all about
2 FPGAs sharing the same bus, which seems more complex than just
manipulating the CS.

Thanks,
Yilun

> 
>     RDWR_B (Read/Write) selects the transfer direction on the SelectMAP
>     interface. Assert it for the write cycles that carry the bitstream and
>     deassert it afterwards. UG570 wants RDWR_B settled before CSI_B is
>     asserted, a change while the device is selected aborts the
>     configuration on the next CCLK.
> 
>     Both are requested with GPIOD_OUT_LOW now, the logical 0 that leaves
>     them deasserted, and their descriptors are kept in the driver private
>     data.
> 
>     A board with one FPGA keeps working. SelectMAP allows the bitstream to
>     be loaded non-continuously, with CSI_B deasserted between the data
>     transfers, and a deselected device ignores the bus.
> """
