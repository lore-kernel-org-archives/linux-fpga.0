Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92392C0285;
	Mon, 18 May 2026 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116990; cv=none; b=HypVY+MqSPZRWOAyEC8NW1LT7ux+0spfAd0hNzYz4+WRcGUUZqt2ZkQMI/er3IuULLRrN2TVQU+JMTH/qpPZyHA1/ZZENnfFYAzRSDg32DTENEKwgz8nPqKkcNwAU3SElnxuAhq9hcQkd1TL66onZipmHB1eJFyFBgoDQ9tRwnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116990; c=relaxed/simple;
	bh=WKZYEhuY2FvrtXJIroTIhV4+i/xLJHJ0x+vs4MSa9yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE76FneSJonTY6fYRk6/DE3iinill7gUmEaDkvb1BDPT2pooAFV7qgbHJfwvjfU6ywUrLt4thqGJNQk+UQte0EvlYzohyR5xa1TAJx9MtHw4cIofaUXnhyG9jonNujz44VhHr2hahjWMgofLP2OBohWnI2JVE66BsWVS79Yy1fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNuvDoUq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNuvDoUq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779116989; x=1810652989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WKZYEhuY2FvrtXJIroTIhV4+i/xLJHJ0x+vs4MSa9yg=;
  b=kNuvDoUqTlSZdA0k5AN3AlCM0obPlRwpaFknrmHcRi9Ol34oFjFV24WY
   f2msYJBidswrbKxCEgVWeaJH62uRNXsYKpbzT4xL40vxnc4pvYV4g/BNr
   IxIpcyTTrhQPavU/KPlDeqYlfwduARDvYh+KGEXxDi8FAAsBLRrvVyOZG
   tgL8LeKNnsWgb8q9u/W9BuEjZ8/qThgUDzGR0xZHlhh1I8+CTRJRBBshx
   JT2ADb0CeFn9VLUabqW5Ygpn+FGA+JI5cDktFFLCHXL2/JqmEf3geklYU
   neuaeOpobhgZCx/0Oz8aEc3gtCJe92i3Wg9tyd1PpI9ffXPJlqntwOq2E
   g==;
X-CSE-ConnectionGUID: mI4cPWxfQF2uSiAPQt38fg==
X-CSE-MsgGUID: W/xM9S6MRxG7QkBdWFuw1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79936793"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="79936793"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 08:09:48 -0700
X-CSE-ConnectionGUID: 0y6fbu4jS0igkFBT3OggFw==
X-CSE-MsgGUID: 1047+jEsSTyh71ATGR+IYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="243436627"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 18 May 2026 08:09:46 -0700
Date: Mon, 18 May 2026 22:46:16 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Manish Baing <manishbaing2789@gmail.com>, s.trumtrar@pengutronix.de,
	devicetree@vger.kernel.org, yilun.xu@intel.com, trix@redhat.com,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org, krzk+dt@kernel.org, mdf@kernel.org
Subject: Re: [PATCH v2] dt-bindings: fpga: altr,socfpga-fpga-mgr: convert to
 DT schema
Message-ID: <agsmOHxOSLdqk+3F@yilunxu-OptiPlex-7050>
References: <20260512182033.66222-1-manishbaing2789@gmail.com>
 <177877399996.840047.5687994834400196062.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177877399996.840047.5687994834400196062.robh@kernel.org>

On Thu, May 14, 2026 at 10:53:58AM -0500, Rob Herring (Arm) wrote:
> 
> On Tue, 12 May 2026 18:20:33 +0000, Manish Baing wrote:
> > Convert the Altera SoCFPGA FPGA Manager bindings from text
> > format to YAML schema.
> > 
> > Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
> > ---
> > Changes in v2:
> > - Removed Rob Herring from the maintainers list as per Conor's feedback.
> > 
> >  .../bindings/fpga/altera-socfpga-fpga-mgr.txt | 17 ---------
> >  .../bindings/fpga/altr,socfpga-fpga-mgr.yaml  | 38 +++++++++++++++++++
> >  2 files changed, 38 insertions(+), 17 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/fpga/altera-socfpga-fpga-mgr.txt
> >  create mode 100644 Documentation/devicetree/bindings/fpga/altr,socfpga-fpga-mgr.yaml
> > 
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next

> 
> 
