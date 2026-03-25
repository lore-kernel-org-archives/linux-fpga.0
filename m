Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4093F38D018;
	Wed, 25 Mar 2026 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424811; cv=none; b=mU4Fkpm+V+lbC7w6iM1Qt2j0GBrrfRvikyc6eafYZ3+Yd6RWJMzkOJ5Fe/C/2P1ivPYImtI+ax8zaOwTYe/FCaGGaY6IV/qHR4FoiP7l360VyCpdMvr0FiiOFNBa9UdG7VBCVSawO0lrhZf+wVJAlpNxfWQm0n9LO56sxWnAQzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424811; c=relaxed/simple;
	bh=4QhcKUHKk5f8eHU20gHK+CrNvm5trqyhWVTA3ToVauo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOByufT2qh6xUs65raHgaSG2V7mBRiUpuBtJftZFwFZOv28a0jz1dZaauzDxB7S3nR05x4W0Vlnbc8qsqnzQ6CbEXAXL6noiVEP/ys5ubfiPCbnTbRi8/zDIPpiZDykTI7VG7pnJCTYl5wtvGN3tl77xGr9qWR2oOJjPHAZmz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V//wg2Ub; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V//wg2Ub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774424808; x=1805960808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4QhcKUHKk5f8eHU20gHK+CrNvm5trqyhWVTA3ToVauo=;
  b=V//wg2UbcwmSevZ2733zsMrV++Y7wOj2+uz7DuyCSubrOn8JIYSMZJRB
   lHC3mGsYAawce5b3EcSlh/FrbDFepG83EEtwj2xaq3npnXXxMPQ2RXqhZ
   nlJFb0a+ptPi5RJqB3SpIp6TeV/vizMOW0x384gNOvg7RFJ8XlXnayKef
   hKmKAUBA62R2G7BWRV/rWpJRR5k8PDtHeHDgMB2Bk0DEMiS3toT10J4y2
   RVuh66agr6nolXyrHz0ceIcyr8qHEoJqa49CRivk9Ygf+ATWJb10UYRjY
   +v6+WM3paS+2XBBa0Vqd+TPVtf4d/obcVCo2kxSBVpISMMeWXpUjwWMsB
   Q==;
X-CSE-ConnectionGUID: 9d8b2glCTMO6jl8vIqSzRQ==
X-CSE-MsgGUID: KHb4sKdPQT6zZHtJQxQ80Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75172561"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="75172561"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 00:46:46 -0700
X-CSE-ConnectionGUID: G5PNN/E4QiyOvAoi05CTsA==
X-CSE-MsgGUID: sOq0GGDtRp+QhOXKg1GRfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="229378652"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2026 00:46:40 -0700
Date: Wed, 25 Mar 2026 15:25:48 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@linaro.org>, Moritz Fischer <mdf@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Russ Weight <russ.weight@linux.dev>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Suki K Poulose <suzuki.poulose@arm.com>, Tom Rix <trix@redhat.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Xu Yilun <yilun.xu@intel.com>, Yury Norov <yury.norov@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5/5] fpga: m10bmc-sec: switch show_canceled_csk() to
 using sysfs_emit()
Message-ID: <acON/EU/GFvxRO1e@yilunxu-OptiPlex-7050>
References: <20260303200842.124996-1-ynorov@nvidia.com>
 <20260303200842.124996-6-ynorov@nvidia.com>
 <acJWNRb1t96yu/H6@yilunxu-OptiPlex-7050>
 <acLaDFuCzt0d33Q_@yury>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acLaDFuCzt0d33Q_@yury>

On Tue, Mar 24, 2026 at 02:38:04PM -0400, Yury Norov wrote:
> On Tue, Mar 24, 2026 at 05:15:33PM +0800, Xu Yilun wrote:
> > On Tue, Mar 03, 2026 at 03:08:41PM -0500, Yury Norov wrote:
> > > Switch show_canceled_csk() to use the proper sysfs_emit("%*pbl").
> > > 
> > > Reviewed-by: Russ Weight <russ.weight@linux.dev>
> > > Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> > > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > > ---
> > >  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > index 10f678b9ed36..ae364c6636eb 100644
> > > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/firmware.h>
> > >  #include <linux/mfd/intel-m10-bmc.h>
> > >  #include <linux/mod_devicetable.h>
> > > +#include <linux/mm.h>
> > 
> > Why add this header file?
> 
> When I was preparing the series, I had build issues without this. But
> now I checked it against -rc5, and it's clean. Would you like me to
> resend?

No need. Given that I'll pick this patch alone to fpga for-next with the
fix.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

> 
> > >  #include <linux/module.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/slab.h>
> > > @@ -183,7 +184,7 @@ show_canceled_csk(struct device *dev, u32 addr, char *buf)
> > >  
> > >  	bitmap_from_arr32(csk_map, csk32, CSK_BIT_LEN);
> > >  	bitmap_complement(csk_map, csk_map, CSK_BIT_LEN);
> > > -	return bitmap_print_to_pagebuf(1, buf, csk_map, CSK_BIT_LEN);
> > > +	return sysfs_emit(buf, "%*pbl\n", CSK_BIT_LEN, csk_map);
> > >  }
> > >  
> > >  #define DEVICE_ATTR_SEC_CSK_RO(_name)						\
> > > -- 
> > > 2.43.0
> > > 
> > > 
