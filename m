Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF6F253958;
	Fri, 26 Jun 2026 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478739; cv=none; b=Z2Ll8OQVuqaS23tCXoSNAzJ8TwS0Gfzgr7B5edEz63PqggB4+rNvwJTciLmEUzZyafZlnol7t5PHraGPK9LrhyNlp6I3yfzTCjgT7mLCkoV8b3jNcLruk5G4a1hMnUYh9NlkzhS8C0HX46CdYkzqTdNuy4q9pUV6SCBu1y6lXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478739; c=relaxed/simple;
	bh=WY4MI7IOzJG7C7UlIxYXlxYxmr62Rh07R779rRwbDWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJMc/Vsnc2pdk25ZkfTgEKhIbd3AdAPrhLF9mT2aTGVGDI2C0DoIkfbMOyVWgAlQ2bsw5kfzNC6ozCBZvvySEURK2N/fZPUqozGjMN1TtXUnF/sg7jySeHOgQZJm23tJ50r+sXVABd/RWrIXmyeIHMckGXDurOjOBl35wFG1o9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3gCGXKD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3gCGXKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782478738; x=1814014738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WY4MI7IOzJG7C7UlIxYXlxYxmr62Rh07R779rRwbDWU=;
  b=d3gCGXKDh+VQ9Q47F7w30IRwJ47PqKppFuauWpHmoX9E617gyAzXrAfO
   oe0NErI73Z0n1D1wyz5BSel4vjw0ojrGP5V2i/+DxS/sUGxYesnUGEs+b
   bmHNNcY2D17HenExzdc6hOZ2wBLrn4NEpaQdspW4R4B5/Hc24zC2KnYAl
   FpWEcZG1z9xBnD7vdog3+EdPGxMcAbYswlVKYFKXUvSOxBkonYDJ2iror
   vk2WvF9ITDz9XGo3MAiM2LvaDD9diFXLUgjzniboseBO7DJ7FlDetNUFl
   yNdK4cxk2iLQafw9qHspK72+sYkXLtcNVatvl8BQPezo76EI1Op6wxdv1
   w==;
X-CSE-ConnectionGUID: mfwfVDL2SbawcYR18WghxQ==
X-CSE-MsgGUID: 8aX/gL7ERx6v79NvwUgxzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="83405283"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="83405283"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 05:58:57 -0700
X-CSE-ConnectionGUID: BjycYbdYTFSvbeVZjQ0CNA==
X-CSE-MsgGUID: L8ok66lnSIua9VdnxAujPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="248685665"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 26 Jun 2026 05:58:55 -0700
Date: Fri, 26 Jun 2026 20:58:54 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marco.pagani@linux.dev>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
Message-ID: <aj53joym0YpoYXWQ@yilunxu-OptiPlex-7050>
References: <20260608164247.1998417-1-marco.pagani@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608164247.1998417-1-marco.pagani@linux.dev>

On Mon, Jun 08, 2026 at 06:42:45PM +0200, Marco Pagani wrote:
> This RFC proposes a proof-of-concept implementation of FPGA region
> variants, a mechanism that introduces a common way to handle
> dynamic partial reconfiguration from userspace. The proposed approach

There are many threads talking about userspace reconfiguration, the
latest one is this:

https://lore.kernel.org/linux-fpga/20250519033950.2669858-1-nava.kishore.manne@amd.com/

Before we dive into detail, could you help tell why the previous one
won't work so we must switch to the new interface.

> is safe and aligned with the mainline kernel's stance on hardware
> management by constraining the hardware to a mutually exclusive set
> of configurations (variants) defined upfront. This is a realistic
> assumption for FPGAs, as regions are typically statically defined and
> synthesized during the system design phase. To keep the architecture
> realistic, the following additional constraints are introduced:
> (i) variants cannot be nested, and (ii) variants cannot contain FPGA
> bridges.
> 
> The interface and core logic for the variant mechanism are defined
> in the fpga-region and implemented in a backwards-compatible way.
> The fpga-region now optionally exports sysfs attributes that allow
> the user to reconfigure a region that supports variants by selecting
> one variant a list of pre-defined variants. Concrete regions can enable
> variant support by implementing the new apply_variant and remove_variant
> methods and adding them to fpga_region_info before registration.
> 
> As part of this RFC, the of-fpga-region concrete region has been extended
> to implement the variant interface. Variants are statically specified in
> the device tree using an fpga-variants node. Additionally, it introduces
> a firmware-cached property to cache bitstreams in memory, enabling a fast
> reconfiguration path for real-time (latency-sensitive) applications.
> 
> Below is an example of how variants can be statically defined in the
> device tree under this architecture:
> 
> fake_mgr: fpga-mgr@0 {
>         compatible = "linux,fake-fpga-mgr";
> };
> 
> fpga_region: fpga-region@0 {
>         compatible = "fpga-region";
>         #address-cells = <2>;
>         #size-cells = <2>;
>         ranges;
> 
>         /* FPGA region properties */
>         fpga-mgr = <&fake_mgr>;
>         partial-fpga-config;
>         region-unfreeze-timeout-us = <10000>;
> 
>         /* Base variant */
>         base-variant = "variant-1";

Previously we use DT-overlay file, here we use a list of variants. I'm
actually not sure why it is safer or better managed. As far as I can
tell, the only difference is that DT-overlay puts the region descriptions
in different files/blobs, while your fpga-variant puts them together in
one file/node, and we switch from choosing a file/blob to choosing a
string, is it?

> 
>         /* Variants container node */
>         fpga-variants {
>                 #address-cells = <2>;
>                 #size-cells = <2>;
>                 ranges;
> 
>                 variant-1 {
>                         firmware-name = "variant1-image.bin";
> 
>                         #address-cells = <2>;
>                         #size-cells = <2>;
>                         ranges;
> 
>                         variant_1_ip: ip_1@10000 {
>                                 compatible = "fake,ip_1";
>                                 reg = <0x0 0x10000 0x0 0x1000>;
>                         };
>                 };
> 
>                 variant-2 {
>                         firmware-name = "variant2-image.bin";
>                         firmware-cached;
> 
>                         #address-cells = <2>;
>                         #size-cells = <2>;
>                         ranges;
> 
>                         variant_2_ip: ip_2@10000 {
>                                 compatible = "fake,ip_2";
>                                 reg = <0x0 0x20000 0x0 0x1000>;
>                         };
>                 };
>         };
> };
