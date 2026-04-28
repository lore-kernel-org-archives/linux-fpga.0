Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC380332ED0;
	Tue, 28 Apr 2026 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777348578; cv=none; b=GAeDFtNyQfFGhtOinlq1UzH4r2QUWm7lkrhn2XvRsm+b4+i/jvdyoZXmyfhC68JrgMhuNQSj/QgidoF1RXnyNN2K1XacTeyPvFp/6uIXfELfjCXLc6Imo8vyZ7RcTRvOLKeyZYsHOYwiYI04+B9Ry6OBrTtaBWyRWohp+7M4UOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777348578; c=relaxed/simple;
	bh=xqcaIUX8QLlEguWmxNfjx0KBxYjMkol7RCbc5o2EAsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVv7uMrAlMVnzpdOjDbPrR2nW4AZNfsWtT1DYTQyqFdpCii0JgfJOyvoYzuMZbIzdek9P4Atr0sk7cQHSUCJmoKBn4iCqgEdY1TEvovqV+QJPkyNugTGJJ/ZIM2jLXdrcRcgeBgPfC+OvEPB58hLCIj+AMb2O42DfxAiJXbA/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9H0odCs; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9H0odCs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777348576; x=1808884576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xqcaIUX8QLlEguWmxNfjx0KBxYjMkol7RCbc5o2EAsU=;
  b=S9H0odCsfA4FE+tBvNrYiU0NlGXy7H4Xh3KTApqjuVDqe70ORd98KNrl
   kWfzHSlVIMI7ha6AQOj+7kWJNCtiTMOB7QHh2Lp0p1e+CPSzCvvLJfg8G
   2cVM2neDxnKPyKszH13ru2coiVAbYy+I3bPKai0iEqtFNQSwxupy6Z/NU
   iLZ5e3Simo2kEo1j8xcaHBWwfsaEF4Y4zcSdl2V7ZmwqLwCM+8foXZYMH
   jFM7yLbxINnTzC+jWXl5zaa91koQqSnZuAo4LvPCBN8XnR0t6xPoGRgie
   aAO+/l3SUXjEfHcDUQ05hJ/ctPdEE7y37CsaokyBBfs8UaSohkiLYSyH7
   g==;
X-CSE-ConnectionGUID: +EtDKQvSRFq7UbuXMClj3Q==
X-CSE-MsgGUID: x//6JYyRT6GkOp0B9vuXGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88847361"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="88847361"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 20:56:14 -0700
X-CSE-ConnectionGUID: 3nKhigtTTJGCsyK/LoClIg==
X-CSE-MsgGUID: CQbrqSW3RcGMpUchpv+whg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="229469506"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 27 Apr 2026 20:56:08 -0700
Date: Tue, 28 Apr 2026 11:33:37 +0800
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
Message-ID: <afAqkfe8iOU1cUyQ@yilunxu-OptiPlex-7050>
References: <20260303200842.124996-1-ynorov@nvidia.com>
 <20260303200842.124996-6-ynorov@nvidia.com>
 <acJWNRb1t96yu/H6@yilunxu-OptiPlex-7050>
 <acLaDFuCzt0d33Q_@yury>
 <acON/EU/GFvxRO1e@yilunxu-OptiPlex-7050>
 <afAh1hq_mkRN3q2t@yury>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afAh1hq_mkRN3q2t@yury>

On Mon, Apr 27, 2026 at 10:56:22PM -0400, Yury Norov wrote:
> On Wed, Mar 25, 2026 at 03:25:48PM +0800, Xu Yilun wrote:
> > On Tue, Mar 24, 2026 at 02:38:04PM -0400, Yury Norov wrote:
> > > On Tue, Mar 24, 2026 at 05:15:33PM +0800, Xu Yilun wrote:
> > > > On Tue, Mar 03, 2026 at 03:08:41PM -0500, Yury Norov wrote:
> > > > > Switch show_canceled_csk() to use the proper sysfs_emit("%*pbl").
> > > > > 
> > > > > Reviewed-by: Russ Weight <russ.weight@linux.dev>
> > > > > Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > > > > ---
> > > > >  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > > index 10f678b9ed36..ae364c6636eb 100644
> > > > > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > > @@ -10,6 +10,7 @@
> > > > >  #include <linux/firmware.h>
> > > > >  #include <linux/mfd/intel-m10-bmc.h>
> > > > >  #include <linux/mod_devicetable.h>
> > > > > +#include <linux/mm.h>
> > > > 
> > > > Why add this header file?
> > > 
> > > When I was preparing the series, I had build issues without this. But
> > > now I checked it against -rc5, and it's clean. Would you like me to
> > > resend?
> > 
> > No need. Given that I'll pick this patch alone to fpga for-next with the
> > fix.
> > 
> > Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> 
> Hi Xu,
> 
> This patch is still not applied. This is the last non-lib user of

I see it is already in v7.1-rc1, what's your expectation?

> the bitmap_print_to_pagebuf(), and it blocks me from removing the
> function.
> 
> Are you still going to pick it yourself? I can move the patch with
> bitmap-for-next if you prefer.
> 
> Thanks,
> Yury
