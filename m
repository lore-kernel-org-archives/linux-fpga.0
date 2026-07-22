Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CAB279DAF;
	Wed, 22 Jul 2026 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719354; cv=none; b=KGEfSJgv5P8F/TguKa4LvqCVk58i0bIZ+Ev4zllWrpYhndblMfNZIZYXi/js/3FR0Y3jmLGfawr58L/qyGMNt9xapOUIa63fXlQBkhgeel1Dm+omjOEBZUpQoQKahF3kcOUEC4l8ovvFIsJ1lWfmwjPJTLIRKVk3li4h1AppFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719354; c=relaxed/simple;
	bh=8Nr1T0OH6XHawJCEm6RnxtngfXhK7Z0IUN7xwyXuwlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vi+Wr0LF61hRS2bKAZyIhexfXIdLTY4Gph6WNxhpJxY8CRJjGNcL9RDp6uwU3bPF/SB7tC2TyoIsD2eMGcxdsDNoGF3Jh4KvlaqksFNiAvFS89k1nVMz/BjAJoAZZOcArOy5hnwNiNOUDLDfr8CnEB1ccZNmUO51QrcLUekGcog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Om2tUzMz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Om2tUzMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784719349; x=1816255349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Nr1T0OH6XHawJCEm6RnxtngfXhK7Z0IUN7xwyXuwlY=;
  b=Om2tUzMzu79aXt/MMrqRH2x8fbYPiSCw1hdmH5RPaQTKtIU1l4MhMfCZ
   7ENT2Zst16OUi2cDDMqdhbIfhdy7KPl9dBFmevKWtWqNPfpZz62zbrr8I
   BRDLKJHWi1IQZhnoXsqYuBFmou8HuaQgXXG+C72yYvO+QwRb//lJz30ux
   hZ4yDa+TIamgeg8UK1dwbLJoKexXfSrYLfW3VaoX9yWaDz7EaABcjuIyc
   gzBPAjwQdsfp0a1NHx3w8HDcyKwjNIjY9nmNAmLhvhzfF44R1W690oYI/
   XdbzXn1MyELsfy/oqffZo1g6YzLo6O5OKCXn7STJBnXQk5X/JYaIZZxql
   g==;
X-CSE-ConnectionGUID: +4yYDp6JRdO6OryScotbFA==
X-CSE-MsgGUID: dzxQMl2CTrmyHCG8BBXmgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96008586"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="96008586"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 04:22:28 -0700
X-CSE-ConnectionGUID: cgP6QkBMTiOAfRQsUTTNnw==
X-CSE-MsgGUID: VfvJZh47SPm90p+ZStzJiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="254668579"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 22 Jul 2026 04:22:26 -0700
Date: Wed, 22 Jul 2026 19:22:25 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marco.pagani@linux.dev>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
Message-ID: <amCn8UYdybT+RRnq@yilunxu-OptiPlex-7050>
References: <20260608164247.1998417-1-marco.pagani@linux.dev>
 <aj53joym0YpoYXWQ@yilunxu-OptiPlex-7050>
 <97739313-fc97-4b11-b2e2-d680621a7fe1@linux.dev>
 <akPZoGCyQW+6+hDX@yilunxu-OptiPlex-7050>
 <5dbd4ac8-a532-4889-bae1-f0bab9a99267@linux.dev>
 <akyyp1GCecWj2Bk2@yilunxu-OptiPlex-7050>
 <417b510f-0f6d-4695-97f5-3fc19b9377b9@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417b510f-0f6d-4695-97f5-3fc19b9377b9@linux.dev>

> If I understood correctly, your main concern is that having to specify
> all region variants at boot time is verbose and limiting. I see your

Yes, that's my concern. We are pursuing a userspace re-programming
interface for long time. I don't want to easily switch to a whitlist
based interface, which is as you said verbose and limiting. The DTO has
vulnerabilities but I'm not convinced yet it can't be secured.

> point. However, I still think that a statically-defined whitelist of
> variants is the most pragmatic approach, as it guarantees the best
> security while matching the actual FPGA design phase, where

I actually still don't understand how static DT can be more secure if it
references global resources. How could people verify a static DT is
correctly describing a blob on disk? And the blob can be changed by
userspace. If no, it still ends up with manipulating global resources
without reason.

> reconfigurable regions are floorplanned and synthesized, naturally
> resulting in a statically-defined set of partial images/bitstreams with
> their corresponding kernel configurations.
> 
> 
> Thanks,
> Marco
