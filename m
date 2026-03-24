Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECBE3DB63E;
	Tue, 24 Mar 2026 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344990; cv=none; b=owqzAFPEvihjdIfMeLx0IfrEWOA0RjGH8O5mN1qvz6mfN2ooEFVsPk7FiPjXnI71GAQ5PIaCIa6qIfFNGWdZxt2rCVZGK9jgGcgV8AqEZ62ll97Rb9b1+AYxoGvde+L94PJi3iaGPM3E/YyDV8z5BPEioFIXL887Fxuf6mUhqrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344990; c=relaxed/simple;
	bh=Cl9Jn50dUXWt3BrXPsUSkT+go0J8MdRhtpKlgBhriss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emRdHRYui+keGw8n58gLW7qInlApfhwJpkP0hwezJupZ4bZ2DwGME26duU5XXMpGTQjeKlzjhzuHBisSkpUJa9KY89DMG5N4O185u/57zHBb5HRPmWs/uJN69aGQkXod7kCnc43SMNvA8l8aW9QWB1ylp8wqawg5vDxAn07bWaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ulqat822; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ulqat822"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774344990; x=1805880990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Cl9Jn50dUXWt3BrXPsUSkT+go0J8MdRhtpKlgBhriss=;
  b=Ulqat82263YGbGV5TgC/PjGiKQMpf7M84RAXMp3dboZ5zTQ/zdnw1Tn0
   rttuLtEgN1h8neaWX3Yue02gyujfA5O0FdXMHVpVRzF7R/81Kx9/7TyZn
   Bz25AG1+1FibsZoAUEPqkCDRisLcV2fCbFT/26t+6JiAUUr6eQpqpbKFF
   munH618JKmKwtWrDwFIEkLHyPs3zLIU41AJrLx1yX6mj6VPNNkxlvOvH7
   mur+pFsbAR6TWgBVQxPR/EuVgwq1V56vTFYksE2BDT4fOD6QXYDaUF46h
   kdpQrkI76MMEqkxWSRWhLCOxpv5r4qa3JkQwSWLFmGcUEl+fL9lcKRO08
   Q==;
X-CSE-ConnectionGUID: +gesGCLIRCe7C62d/M7xfQ==
X-CSE-MsgGUID: 5JVyMncGTgCaE7DaUdKnbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86725131"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86725131"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 02:36:29 -0700
X-CSE-ConnectionGUID: DmWR8uXHRDSrXII1rchdOA==
X-CSE-MsgGUID: CPrU1x//RC2oHAiWQSJ1zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="229228806"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 24 Mar 2026 02:36:21 -0700
Date: Tue, 24 Mar 2026 17:15:33 +0800
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
Message-ID: <acJWNRb1t96yu/H6@yilunxu-OptiPlex-7050>
References: <20260303200842.124996-1-ynorov@nvidia.com>
 <20260303200842.124996-6-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303200842.124996-6-ynorov@nvidia.com>

On Tue, Mar 03, 2026 at 03:08:41PM -0500, Yury Norov wrote:
> Switch show_canceled_csk() to use the proper sysfs_emit("%*pbl").
> 
> Reviewed-by: Russ Weight <russ.weight@linux.dev>
> Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 10f678b9ed36..ae364c6636eb 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -10,6 +10,7 @@
>  #include <linux/firmware.h>
>  #include <linux/mfd/intel-m10-bmc.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/mm.h>

Why add this header file?

Thanks,
Yilun

>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -183,7 +184,7 @@ show_canceled_csk(struct device *dev, u32 addr, char *buf)
>  
>  	bitmap_from_arr32(csk_map, csk32, CSK_BIT_LEN);
>  	bitmap_complement(csk_map, csk_map, CSK_BIT_LEN);
> -	return bitmap_print_to_pagebuf(1, buf, csk_map, CSK_BIT_LEN);
> +	return sysfs_emit(buf, "%*pbl\n", CSK_BIT_LEN, csk_map);
>  }
>  
>  #define DEVICE_ATTR_SEC_CSK_RO(_name)						\
> -- 
> 2.43.0
> 
> 
