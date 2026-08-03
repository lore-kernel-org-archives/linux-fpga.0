Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D01317160;
	Mon,  3 Aug 2026 02:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785724884; cv=none; b=df5UO9Qkkp47sE5nizU9Qp4Vva2GHGLKZHUbbsCGKhyg4T/Rr5lBnImR97oPxhGnOCEIOb4sxns1oeffMKycMMmb+X81+sEDxc0a1UkDJFYAj6csQpLCJgpjZVUNI2oPaXoJyeH/+5GzwpDIUTNm55F4NyMLYo2EI0APAUiE3Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785724884; c=relaxed/simple;
	bh=nnBV8pcGhykxzgKZkuQgsbVei/LCOv2yV4ZSpmm0jq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVLIy/MXXFy8NMzbRCPPPyVkhEa7CWNWxcSLZFWU8eT5TMmw7zi2KXwGsfiDnh2x+KIxoffsTVgFr8XxrND5w04JEZULDhCrmkqbLbLVZXV9iUIXzMlBdC1MAkDVdWi0QV4n1dReuVkvOeF3tEgRM91goLnqZ6ELolmIKPTV3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXg9ZMph; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXg9ZMph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785724882; x=1817260882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nnBV8pcGhykxzgKZkuQgsbVei/LCOv2yV4ZSpmm0jq0=;
  b=mXg9ZMph3ubqm0cFvTZ85FoioAPdvU0w2ZDZ8pyZShIOz+ePeN73BpjO
   p6ik/TCWjWSgHu+40Yj8OX0ZdTsoXIs3mAMswJw+bdp/lvyt9VKj8+2dx
   iaSsqniBOQWJHiiGKPdHLuwb7ouB9NAbOpeaDBIuqlE9zJiycRqN4fOl2
   XthZfrTEpY9IKS66Df4y8K7EAU6SbZBDLmC3aS9dObJlWHQgT4Ddiq1M0
   TMWkZq8z9ONEVCIah8sDyF1+/rjr0BTfPG2PZJv9qgvcHkKpbDJH8/wfZ
   WzmIIOjLQSsPGpodoBWtjn91wrdOF5Ya1X1PEEhBdGBkiUkXHExc2lXRh
   A==;
X-CSE-ConnectionGUID: ZsG8yylbRxuK3XhQzNH2gg==
X-CSE-MsgGUID: GVD9lsCLTM2kRMJBup13YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="103796918"
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="103796918"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 19:41:21 -0700
X-CSE-ConnectionGUID: +RkGUIIBRQ+ge/gYQzYg1Q==
X-CSE-MsgGUID: k4rOMK/8RxiUjOdiM2WXSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="256769761"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 02 Aug 2026 19:41:19 -0700
Date: Mon, 3 Aug 2026 10:41:18 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Ionut Nechita <ionut.nechita@windriver.com>
Cc: Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-fpga@vger.kernel.org, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Russ Weight <russell.h.weight@intel.com>,
	Tianfei Zhang <tianfei.zhang@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2] fpga: m10bmc-sec: add image_load sysfs for N3000 and
 D5005
Message-ID: <am//znBXTh9eV5CC@yilunxu-OptiPlex-7050>
References: <20260724192117.60493-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724192117.60493-1-ionut.nechita@windriver.com>

> on N3000 that reboot also resets the FPGA and drops the PCIe link, so the card
> leaves the bus and re-enumeration is left to userspace. Nothing is quiesced on
> the kernel side first. That is documented in the ABI file rather than handled,
> because I do not think it can be handled meaningfully inside a single driver:
> the blast radius reaches the other functions of the card, and where it has to
> be dealt with is the bus layer, not here.

Yeah, so what I've got from your description is that the user API is located at
the wrong place. It should be located in a place that can properly
quiesce and unregister all affected devices before the reload.

[...]

> For the generic side I would propose, and can post as an RFC if you agree with
> the direction, an fpga_image_slot class: one device per reloadable slot, with

We had quite a lot of discussions about the uAPI for fpga region
reprogramming before and WIP. Although the reprograming from nvram doesn't
require a user input binary blob, the main concern is the same - how to
gracefully quiesce the affected devices, and how to re-enumerate the new
programmed devices.

> the slot name and a "disruption" attribute reading none, device_reset or
> bus_reprobe, so that userspace knows what it is about to trigger before it
> triggers it, while drivers keep only their load callback. One detail worth
> flagging early: a reload triggered from a sysfs store handler runs with the
> kernfs active reference held, so any slot whose reset removes the device needs
> sysfs_break_active_protection() or device_remove_file_self(), or the store
> deadlocks against its own removal.
