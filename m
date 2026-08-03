Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936C93DDDCB;
	Mon,  3 Aug 2026 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749254; cv=none; b=Y6WfmPHQYUYbNk8Nm6fwFSShp9jUpmk9NM4rzpWL7sCt+NOEarOVQrTm1ejmVXIZCGTS2LclyGXDVAYpv5t9Ajiz5UD7oFs6X/kMz0ao3QK49B5bbWSlGzhA1A02HXqUw0jxcxcqetGDevcMfivmgJaX7KIGaP7/RISCFtq7AmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749254; c=relaxed/simple;
	bh=XTrme2cEVaO2v+gZp+5K1DW31YfSPZPfUPdIfZqTmv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YisWizY++4PBQEIfsMMpSSR8NXPcELkFv599YtPVdV7TLBmKaCVHY/PtWu3pWZSrbqwkmZLMg7L8yqLuJ2s82u5IR4su9hG46SZi9TL/hjMN7Q0D8NOgR8opMcaWtZF2lehTXV6hlm+3NcmkFXBCEc0rbI3ztwKbd0rowCU8Svg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bpw4D5rl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bpw4D5rl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785749253; x=1817285253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XTrme2cEVaO2v+gZp+5K1DW31YfSPZPfUPdIfZqTmv0=;
  b=Bpw4D5rlvexEysHjC2k0roUneFCIVPVIgsm+I9LMu0q53KBjGnSB0RVo
   TJ4HGqum6becl5PeE/eytO7d4375kypZjmazAR8Hma9rd0JrS+PBtLv3L
   80xLOBv3zN5DOzXudHws7+1GgyWN/yKR5xq2Hw5mdWs3vnBUwMG3vP98L
   IPUA5YlqWEs+Nl+CH1giq2BCftlEv7rPCs7PsKZQabAkvXceecNxtyc9f
   2W6zwFZbrgLrdACBYplKoa3RuWBDAf6H9n7toOUekLPKqBkM/EFrc1bzL
   4LXUAnu8a51OEj4WQNZXw8rfxYB1bIITgogLeHX7/KLyfQetSu8+e6wHC
   g==;
X-CSE-ConnectionGUID: oDISmU3BRxCspKiuVIFNrg==
X-CSE-MsgGUID: j3/C4eGDTRKd8EGMP2xDvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="88809716"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="88809716"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 02:27:32 -0700
X-CSE-ConnectionGUID: TwVxLYlGSjOFKPFZiLJixQ==
X-CSE-MsgGUID: H8kF4UixQnmx7RMqSv23jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="285815035"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 03 Aug 2026 02:27:30 -0700
Date: Mon, 3 Aug 2026 17:27:29 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marco.pagani@linux.dev>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
Message-ID: <anBfAa4LpjbmYHIc@yilunxu-OptiPlex-7050>
References: <20260608164247.1998417-1-marco.pagani@linux.dev>
 <aj53joym0YpoYXWQ@yilunxu-OptiPlex-7050>
 <97739313-fc97-4b11-b2e2-d680621a7fe1@linux.dev>
 <akPZoGCyQW+6+hDX@yilunxu-OptiPlex-7050>
 <5dbd4ac8-a532-4889-bae1-f0bab9a99267@linux.dev>
 <akyyp1GCecWj2Bk2@yilunxu-OptiPlex-7050>
 <417b510f-0f6d-4695-97f5-3fc19b9377b9@linux.dev>
 <amCn8UYdybT+RRnq@yilunxu-OptiPlex-7050>
 <9d4af487-69a7-4a0d-9335-35c3a057de54@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d4af487-69a7-4a0d-9335-35c3a057de54@linux.dev>

> (i) The base DT (including variant fragments) is built and global
> resources are statically resolved at compile time. Then, the resulting
> DTB is loaded by the kernel at boot time before userspace is loaded and
> can be authenticated (as part of a FIT image) to maintain the chain of
> trust.

That helps, thanks.

> 
> (ii) Once the boot is completed and userspace is running, the kernel
> hardware configuration/topology remains safe and locked in place since
> there are no interfaces that allow userspace to change it.
> 
> So I think the main advantage of the variants compared to the open DTO
> interface is limiting the "blast radius" in case things go wrong.

But I don't think limiting both the functionality and the blast radius can
be the target of the uAPI.

> If the DT cannot be tampered with, the kernel can still enforce hardware
> boundaries (e.g., IOMMU config) that can contain the spill to the
> misbehaving region's resources. On the contrary, a single malicious DTO
> can compromise the entire kernel with its memory mappings.
> 
> Ultimately, I think the responsibility of authenticating image/bitstream
> is outside the scope of the kernel as they are configurations for the
> hardware and not the kernel itself. It's up to the device to
> authenticate its own firmware, like how reconfiguration engines of
> modern FPGA families can already authenticate signed image/bitstreams.

No I don't think so. It's the kernel drivers decision to load the image
to HW, authenticate or not authenticate the image, via an HW engine or by
software.

Basically you are treating the HW description blob and the HW image blob
differently, but I think they are basically one thing that can't be
torn apart. If you want security, you must build trust for both the image +
the HW description before re-program and re-enumerate.

I remember there was a discussion of accepting a FIT image for
re-programming several years ago.

> 
> 
> >> reconfigurable regions are floorplanned and synthesized, naturally
> >> resulting in a statically-defined set of partial images/bitstreams with
> >> their corresponding kernel configurations.
> 
> Thanks,
> Marco
> 
