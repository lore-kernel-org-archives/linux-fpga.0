Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047239;
	b=DBYj46576e9/vR1SKtJpfBDu2QC0qONPIU+BYWGynugEb65ltlt1s+Om/rGgVWiVmsxv
	 FjdAdJ1Tsp3W+cR3OzVRfan72JROogmAXSMJf2IymyZf+myndOPaYmWaLvdgK3I28uHAu
	 nW07nwENvW6Ww6QE7pJaTpdpJyAochOfGxq2VF9qxu+iTGqlFKdXmzlLPNk3wpB6X39Qi
	 gQGxW/YsZqxXoaSqsuLImS9KKhNz/9sFKFU3VndYORbu9IXZMHUoVKQboZiF2n4Z2lpAR
	 Z1Nr8ZVOD6kniaFoJIE+73GVJz5a9b2xU6gwYRCzp8hnj+0sj0cileSHFdHRTjvACIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047239;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7VGSMLdQgTrW+tnUtv9yvI4plQbPDLeABiASMlS9xag=;
	b=ZNXibog2KuZrYP8VKIr1WaILKiqEvmApZrfSaofK97buxh4Paef7IaNYqVn5vrujJsOg
	 Krx7hxAhnHOTSUYE0nY+lGJ4mQkOfwqwcGFLC1tbc//hOzk5zfFQJ9xex+GVGrkj16xda
	 4vLRGR8QhgzJ8+VYKcVhMqCLZmAytZWthrL1kZPlLo/h5SfUArxodTxIm68i27kY+SHpw
	 LwU4uYa16ymfGo5OTksJVDglUWLO0gdU5/QmB2savsB9CUg8DCzN3TviqTirjX7fTTOm/
	 dB+bynoqfoXxMZGo9qKFqK3K4UHAqNK71cXgWGpkDDvrd6Tpgy0Ymt/IysHH19scE1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oi1j+v2O;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231A606A32C;
	Sat,  7 Nov 2026 10:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9231A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oi1j+v2O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794047238; x=1825583238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eU3ThRrgV18yu75FgVMOclwssTznezQvXd3lRR3192I=;
  b=Oi1j+v2OI7f6u3a9vSzDiNPdxPo9yApOLt2PQ1rcbJdlivbZH9uj48Kk
   ANWhlgzyH+PMV8q+LLwOM2jQM2sODH2qUoI3bNnuiJTbFWO3bh/xkDJ5v
   pctQMElHGTYA23L+48bTNjI69I6699EbdZ6RrjFkoa82DWkXOs9bEP6m2
   5KCl3lDG9CzrYuiWVumc7MrL9yyXlYlQx1Jcx5sXj0Tf3rLNrlMO7lfCr
   /u+HGvQ/FIijvUUtIsYqe1H/YvCzgg/pY/7ILh11Nz3qF+nUHswg3GLFz
   9rrE2swfrnpcN0esUR5qjQt729x9Zze78tOp8FxrZfuWGz/5Hz+60/neB
   g==;
X-CSE-ConnectionGUID: 8tlAxWKzSjCWQiGVICRX0Q==
X-CSE-MsgGUID: +ZZqll+uQQGJ7y/wweJwSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2740622"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2740622"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 02:27:18 -0800
X-CSE-ConnectionGUID: 8nZamolPR/W+iDYnnyAt8g==
X-CSE-MsgGUID: +HAJSUcmQmqVqGXRLRNdaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7521411"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa006.jf.intel.com with ESMTP; 07 Nov 2026 02:27:14 -0800
Date: Sat, 7 Nov 2026 18:19:49 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: tze.yee.ng@altera.com
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Alan Tull <atull@opensource.altera.com>,
	Matthew Gerlach <mgerlach@opensource.altera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fpga: altera-freeze-bridge: clear all illegal request
 bits
Message-ID: <au77RfUe85UzN1ns@yilunxu-OptiPlex-7050>
References: <13856736bdb808b64826aab337d9919abeb3ea5c.1791253862.git.tze.yee.ng@altera.com>
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13856736bdb808b64826aab337d9919abeb3ea5c.1791253862.git.tze.yee.ng@altera.com>

On Tue, Oct 06, 2026 at 10:34:35AM +0800, tze.yee.ng@altera.com wrote:
> From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> 
> The freeze_illegal_request register is write-1-to-clear with one bit per
> Freeze Bridge connected to the Partial Reconfiguration Region Controller;

I still prefer the opening sentences in v2. Don't write like dense
Hardware spec.

> bit i is the bridge on freeze interface i. Unlike the status and control
> registers, which act on all bridges collectively, this register reports
> each bridge individually.

This clearly tells the hardware behavior, good.

But my real question is, why would the Partial Reconfiguration Region
Controller connect to multiple bridges? To control multiple PR regions,
or because a single PR region requires multiple bridges so we need to
gate them all on its PR?

> 
> Writing a literal 1 clears only bit 0 and leaves the illegal request
> latched for every other bridge. Write back the value just read instead, so
> the set-to-clear applies to whichever Freeze Bridge reported the request.
> 
> Fixes: ca24a648f535 ("fpga: add altera freeze bridge support")
> Cc: stable@vger.kernel.org # v4.10+
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
> Changes in v3:
> - Reword the commit message in imperative mood (Xu Yilun).
> - Describe the freeze_illegal_request register layout: one write-1-to-clear
>   bit per Freeze Bridge via the Conduit Merger, versus the collective
>   status/ctrl registers (Xu Yilun).
> 
> Changes in v2:
> - Add "Cc: stable@vger.kernel.org # v4.10+" into the signoff area so the
>   stable-kernel rule is satisfied (reported by kernel test robot).
> - Remove Chiau Ee's signoff as he is no longer working on this patch.
> 
> Link v2: 
> https://lore.kernel.org/all/2fe34c2dec61150a39d21e067521b0acc031247c.1789956938.git.tze.yee.ng@altera.com/
> ---
>  drivers/fpga/altera-freeze-bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
> index c24c976117c8..2591dcc53d83 100644
> --- a/drivers/fpga/altera-freeze-bridge.c
> +++ b/drivers/fpga/altera-freeze-bridge.c
> @@ -51,7 +51,7 @@ static int altera_freeze_br_req_ack(struct altera_freeze_br_data *priv,
>  		if (illegal) {
>  			dev_err(dev, "illegal request detected 0x%x", illegal);
>  
> -			writel(1, csr_illegal_req_addr);
> +			writel(illegal, csr_illegal_req_addr);
>  
>  			illegal = readl(csr_illegal_req_addr);
>  			if (illegal)
> -- 
> 2.43.7
> 
> 
