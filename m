Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2568830B535;
	Fri, 26 Jun 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782494579; cv=none; b=MvPGgSo1QnZDAchIw9J4LNDMzXBWlSkkNPI5AgGPntDWuFxNtQTD/V/GOho8M2W2fDZCmFY9/swH+UurmL3RDaH3GLkJZgqyF2gTD8Q4kkGptjY31teuBbrvwfIhFuVBShjtSLwL87C3gtngnyTSf7MFvWUmDZ7ttxCKzeodNXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782494579; c=relaxed/simple;
	bh=sxRw18zkQathnyRUCjykUrB0bBzcjMDPv4SrED00VSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELlE4bzH1N03Q8imeTOqtPi25ZEKZuqBmcJ5H5Kopo6Vk7goEu663CodpOOnQ+hdB2jG1BBipGbIJgoeHwvT8U9j/50MPgWN6fAOEGTNNQjVWP1KeNAKkHQwDG5Ni1PW6zVjz+sD/DShAwba/FSc1szFT0L6J1LoKWA568XcOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPFJZqgP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPFJZqgP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782494577; x=1814030577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sxRw18zkQathnyRUCjykUrB0bBzcjMDPv4SrED00VSc=;
  b=gPFJZqgPQUSDX+mqgR/X508bQK9ZD0P92FGZ4l3k1jJHNQ4cL463FH3E
   LUCpPrtv5oCP+6IfsSGpAKfHBj+Xpjt6hQaqUpwqoOwA14Ldi0QY4q6EN
   ZlIHXhDS3yNdt6XDV3R2Fd0BWia6b46lAf445XixemB1eeh7umfmqAHe7
   c2IcSfZqVGUzGlpQXa+yLiSsXRsEUfaXU/2WWVhz/K1yN1e0HmIu4s6Zg
   gpUDSYV2hx2gU48zqU85AYFVa4ZTxolLVsJ7ledrd4If1ICQhRDBVrbL7
   D7q20E1VrN/bHyORewjdi4mwW+6PD2oe452Xqdcc/g0U3ae9tBlESsaRK
   Q==;
X-CSE-ConnectionGUID: Tnj4Jz40SpKui6bofGXwcw==
X-CSE-MsgGUID: 4mgBUJbzTiGZFEJ9I73GWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="83300475"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="83300475"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 10:22:56 -0700
X-CSE-ConnectionGUID: MRPAZPY+SNOnmi7n9ZUeKg==
X-CSE-MsgGUID: +6Q51wUpQw2Gf1GiK2hyQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="246908176"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 26 Jun 2026 10:22:54 -0700
Date: Sat, 27 Jun 2026 01:22:53 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Pandey, Radhey Shyam" <radheys@amd.com>
Cc: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
	monstr@monstr.eu, git@amd.com, Moritz Fischer <mdf@kernel.org>,
	Tom Rix <trix@redhat.com>, Xu Yilun <yilun.xu@intel.com>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: Use devm_clk_get_prepared()
Message-ID: <aj61bRnqxDEDx9en@yilunxu-OptiPlex-7050>
References: <8ca8ee5ba720b608a41f842d2b743302e5500ad0.1782205286.git.michal.simek@amd.com>
 <5bd0f7db-7ec0-4390-b6ea-1edca46e1ca7@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd0f7db-7ec0-4390-b6ea-1edca46e1ca7@amd.com>

On Tue, Jun 23, 2026 at 04:31:28PM +0530, Pandey, Radhey Shyam wrote:
> > The driver keeps the "aclk" clock prepared but disabled in its idle
> > state, toggling only the atomic clk_enable()/clk_disable() around
> > register accesses in the bridge enable_set/enable_show callbacks.
> > 
> > At probe time this was open-coded as clk_prepare_enable() immediately
> > followed by clk_disable(), leaving the clock prepared, with a matching
> > clk_unprepare() in the error path and in remove().
> > 
> > devm_clk_get_prepared() expresses exactly this: it gets and prepares the
> > clock and unprepares it automatically on driver detach.
> > 
> > Use it to drop the manual prepare/disable dance, the error-path
> > unprepare, and the now-empty clock teardown in remove().
> > 
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Will apply to for-next when 7.2-rc1 comes.
