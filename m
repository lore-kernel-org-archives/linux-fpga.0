Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050180;
	b=U6FMpwxN1Sk+Rt5g3s1G7QC4dtf3ry8CfFQpNTLcmZQKv9eByfpm6oHv0hS6JyrUAfn/
	 xAPeeOqIc51zhoglfroV6vFk+wEOiR9YEP553ACWk4RN3q7RWaRRLm1ZEnaAWYSnvs7RB
	 x0tvvqNHeb5vbxYSl+DqQB59D4wwPAbI/9Q2bgZ5nh9wkybNmn7SSsewAbuuTyH1yWTnE
	 ys25DBdN2ZYx/Il987dziOs+htxS0oneYxyEw+hAo5VO6eVppN2CKBTlygW80/C63WMgw
	 6gv6bOEoGaLaXAEh4JceYutnjeZkv3VdbIJB/5qoXqLCpjhdjy0LYE4LPw3iSF5h8iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050180;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=LMrhucrgVnpi30JNRYdhLtOMnaS1ZSP99n5Yy7pCXzY=;
	b=xHlpmX7EGtcoQI6SRHQdMDGWHOVwiqSz/RBjtNNqHCnVJpSq5yCfUtYjXqD20EzJnC6J
	 B9wtKuOnil7RaHpW5HjVwOwExLH1Khj42DTzztH6i6agRYlaV3UsV5Cyj6nmlpKLYWXsx
	 Ea/mw+ZjHYuTTZSoSGlk6y7rVUbgmqrnkS7Rn8AY+oh7LIePN2gpbq5586xLgy0elSe4M
	 pxVgMnp2TTZHiqjeMk/06fueDwKALNEx1o2zeqQ6s4ct6Jc7rAV/8W3W8Gsoi1vdnR8O2
	 erg/45pC3uBfo4ipW9CDzlxLZ8eww6jtKeGo6pXPfe01WoOIsjp8GfWhJce/sZL2N5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F0sF3ae0;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5597B606A326;
	Sat,  7 Nov 2026 11:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5597B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F0sF3ae0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794050179; x=1825586179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q26nfU7yQ+KUNyjkuLFzEx3HfNtlSM236u/gCkJt7r4=;
  b=F0sF3ae0xKLAPur4OGGoQTt/ZTu1KfAn2VfkcQL3o5zdOWFjXRe1HR4s
   96bLYmZcE2ha8H7wvHb4HQU3kMIS91eOsFMZsoAwixIgIdX9bWPo3IavC
   jJaC1p19LZqyBco0mRUTXppOuIM4lMlHbudDbUf2VEE3f5gY9Y7JPZYCQ
   os9QhTRenN138jEPZ77bpGgULgSyWmh3ZbS/VDApkh4H/0jtOMrbzzXOp
   OOC5ljYlzukKkmCoMdVVL/Olsu7MJS8wwVQz9Ukb56wBhk0fEM97AOT0W
   f8mmsFwEYMrNQNfi1rwQ5zn5qdoCYY/+EqkXmwoh11eihCoe5TYxII1k0
   w==;
X-CSE-ConnectionGUID: qDKmNkd+RSGECM/5kGPr2A==
X-CSE-MsgGUID: eXk8mG9yT6y/DcKNQ+8t8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2875256"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2875256"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 03:16:19 -0800
X-CSE-ConnectionGUID: 0P7ccIUJT7e7JAokhp0Bwg==
X-CSE-MsgGUID: grkfd/kQQriipPZi5ViG9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7810786"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa008.fm.intel.com with ESMTP; 07 Nov 2026 03:16:17 -0800
Date: Sat, 7 Nov 2026 19:08:52 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: linux-fpga@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: dfl: afu: prevent read-only port mappings from
 becoming writable
Message-ID: <au8GxITpviOO/H0O@yilunxu-OptiPlex-7050>
References: <6adb4881.dcf90272.1a940.5568@mx.google.com>
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
In-Reply-To: <6adb4881.dcf90272.1a940.5568@mx.google.com>

On Fri, Oct 23, 2026 at 04:44:01AM -0700, Abdifatah Suruur wrote:
> afu_mmap() rejects writable mappings of port regions without the WRITE
> flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
> read-only and then upgrade the mapping to writable with mprotect(),
> writing to FPGA port control/status registers the host owns.  A guest
> assigned an AFU can use this to reconfigure or reset the port and
> interfere with other tenants on the same FPGA.
> 
> Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
> its read-only objects and as fixed in drm/vc4 (CVE-2026-68445) and
> drm/panthor (CVE-2024-53071) and ptp: vmclock (commit
> a5edadbae57e2298a56cf7a4e774a027905a331f).
> 
> Fixes: 1a1527cf5dda ("fpga: dfl: add FPGA Accelerated Function Unit driver basic framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> 
> ---
> v2: use a 12-character commit id in the Fixes tag, as requested.
> 
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -836,7 +836,11 @@
>  	if ((vma->vm_flags & VM_WRITE) &&
>  	    !(region.flags & DFL_PORT_REGION_WRITE))
>  		return -EPERM;
> 
> +	/* Prevent read-only port mappings from being upgraded with mprotect() */
> +	if (!(region.flags & DFL_PORT_REGION_WRITE))
> +		vm_flags_clear(vma, VM_MAYWRITE);

The reason seems sound, but as a fix, is there a real problem to solve?
AFAICS, every region allows everything.

If a cleanup is really wanted, I'd rather delete all these flag
assigning and checking, until any real use case comes.

> +
>  	/* Support debug access to the mapping */
>  	vma->vm_ops = &afu_vma_ops;
> 
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> 
