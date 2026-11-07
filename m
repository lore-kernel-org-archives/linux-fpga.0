Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051305;
	b=z6PV79fSKkAmmaqrU+p0YIG40EvgqL2AoU70ZXHd3r2B+/FBFucDG9/gjhHYyjsBR4qz
	 WNUKpgkeUfGBBXId4VwKzKaQ8+49/UoAdBRUoHyjjjqfTub40CnkxaKCmHW1S6GmnDkv+
	 IgCYzzJ/6uuaSuAKM9nx0CrGywipcMBi+ob+bPdlRT3I2mBMFXALR3Zg2GhLJ/CNzs1eb
	 8eTWPLtkPZ5L2mrI0opRAGf+8MMnFwXo7PFwWT6dB0xQb/Fuzbi2934kSIjxXh5u81PDr
	 wY3zrvCfsQ9UVkKiRIqIIPuHo9wpUPm95Tq9/1Hw63KB6hA2nOw2NHDL/WkugJF3ttw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051305;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=XLbaGDM2COjEF6QXUMnFci+Kn7F6xKRJ6DxPfKIJM/4=;
	b=WWCHcJdC+sAK524+XqK3JyiXIulY8QApAHAO7PEn6ABgAnstqh117HYkcb5GPZhVBqEM
	 4k2jtkBzItGo0EG9EN8YK783DPtMVaS2kJQnytCcSnEHjM0wQNuhiwO876A4kDoMYbqah
	 6NiQJwTiSUln7UJpAzJakyfiSv06c8RCK7K2Efhp7qV9yoU1z70MaMdAjFNVSuNEXxaOY
	 1sa765hdVhk1EahSrpmvBO6r7DCydaxZMd+jfRSDln6wnnfYqIWvPfM1nLO2dt3TnIf4I
	 ogx3jKLcKl4EogHmZQEyfsfjmTKlbvN3LcgDcbqIWSCGJMtwn4XWoH9sna9ilhILqjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VPaBFo97;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845B1606A326;
	Sat,  7 Nov 2026 11:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 845B1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VPaBFo97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794051305; x=1825587305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j8kUwPlcPLqU+l5i7Le/kW+vmc3UiikYsnY+VavUoQ0=;
  b=VPaBFo97Eu6A0NTrLT24zxjlScE3z48H93z9rLQg1ompVdYLYkiXCgy/
   BYVYGSQloKm1zN3URpLmHW7k9pyfTYX8/N1Q/ievfo39Wjs4wgVKA+GK7
   i4tDMehD0N6My73nexIPSS0siq4PF3PAI2bgLWRNmMAFM+O7bJ3ec+4eV
   jDYZfEUA9zumOUc0+2muU9mOcxMwfGA980V92c911O70LbNt6G9QLT8Xd
   inDmg0pcYDQrm5cVjNeK2YbrPC5BL1pLSzlUHLwX1i+L6jQQlEkda2tii
   L910pkXu4yVNEuCRnSLRjV316K4eXJhPf2NMeqMAjglSrYLrzauQTvT8e
   w==;
X-CSE-ConnectionGUID: Ku+iEE8sRS+gvrpAtZJNig==
X-CSE-MsgGUID: syVgZe9BSpi2iGfIceIBdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2894470"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2894470"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 03:35:04 -0800
X-CSE-ConnectionGUID: qfFdZ08vSxykMQX+zdr5Bw==
X-CSE-MsgGUID: mu0QJXHDTYGtt4wv0pL6rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7340876"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2026 03:35:03 -0800
Date: Sat, 7 Nov 2026 19:27:37 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: bo cao <treebacker@foxmail.com>
Cc: linux-fpga@vger.kernel.org, yilun.xu@intel.com, trix@redhat.com,
	mdf@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: afu: prevent read-only region mappings from
 becoming writable
Message-ID: <au8LKUyKQpGCy58F@yilunxu-OptiPlex-7050>
References: <tencent_C59525D78A2FBCC2425A3CA9EF4C53D56F08@qq.com>
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
In-Reply-To: <tencent_C59525D78A2FBCC2425A3CA9EF4C53D56F08@qq.com>

On Thu, Oct 29, 2026 at 11:53:17AM +0800, bo cao wrote:
> afu_mmap() rejects writable mappings of regions without the WRITE
> flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
> read-only and then upgrade the mapping to writable with mprotect().
> 
> Clear VM_MAYWRITE for regions without the WRITE flag, as fixed in
> vfio/platform (commit 420bed9131db), drm/vc4 (CVE-2026-68445),
> drm/panthor (CVE-2024-53071) and ptp/vmclock (commit a5edadbae57e).

Interesting, people write exact same changelog. I'm not sure if it is a
sign that AI generated it and just sent. I don't reject AI entirely, but
please write the changelog and comments by hand, to give me the
confidence that you really know the change.

Or maybe I'm wrong, you saw other's patch and copied it. Please don't.
If you really want to improve something, comment on that patch.

Even if you are sure the thread is dead and you revive it, reference the
original thread and the author.

> 
> Note this is defensive hardening: the in-tree callers of
> afu_mmio_region_add() (port_afu_init() and port_stp_init()) all
> register their regions with DFL_PORT_REGION_WRITE.  The guard costs
> nothing and keeps the mmap() interface honest if a read-only region
> ever appears.
> 
> Fixes: 857a26222ff7 ("fpga: dfl: afu: add afu sub feature support")
> Signed-off-by: bo cao <treebacker@foxmail.com>
> ---
>  drivers/fpga/dfl-afu-main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 097a97eeea66..a802309e0473 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -833,9 +833,13 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>  	if ((vma->vm_flags & VM_READ) && !(region.flags & DFL_PORT_REGION_READ))
>  		return -EPERM;
>  
> -	if ((vma->vm_flags & VM_WRITE) &&
> -	    !(region.flags & DFL_PORT_REGION_WRITE))
> -		return -EPERM;
> +	/* Prevent read-only region mappings from being upgraded with mprotect() */
> +	if (!(region.flags & DFL_PORT_REGION_WRITE)) {
> +		if (vma->vm_flags & VM_WRITE)
> +			return -EPERM;
> +
> +		vm_flags_clear(vma, VM_MAYWRITE);
> +	}
>  
>  	/* Support debug access to the mapping */
>  	vma->vm_ops = &afu_vma_ops;
> -- 
> 2.39.5 (Apple Git-154)
> 
> 
