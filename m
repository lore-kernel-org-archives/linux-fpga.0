Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F14649D5B9;
	Mon, 28 Sep 2026 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593794; cv=none; b=lbB4+ZOLPVJu/wi6gWihrdV6VhtS9UD/S/k6lFyEsyC2CjAzdojFvtaHtRZH/2gQSBtAR/P1MM5HLPSRl/+8Hc6J6A1s0d7WsgBXrHC7X2zEXSwlboCV9YbuvKV3JnETFv09bG61F9kWPCnYRGrN+Lsx+jowgBXJrJhPYFOpbSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593794; c=relaxed/simple;
	bh=40n0+hCTZ25lAbn7WkKBNh5mba7WJF+/ZXfidhdR1H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhLY80OAln/sZq0Wli2hI7nZrssdFZgmIMVTBUVyLI9z2zA50bH8ATCHl8UpEJ5gOj7xv2qLPvu6UFgOY4Lfyfymgn5CblamOOyAm04P3PDssm24FYCJJNDEsjCODb5O8TlHCp4iGA0xoLU2zRt3q8688GSGfXh5p6pF+DrbZug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBa5e1Ml; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBa5e1Ml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790593793; x=1822129793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=40n0+hCTZ25lAbn7WkKBNh5mba7WJF+/ZXfidhdR1H4=;
  b=oBa5e1MlFdUPeCUGlDqMTwx6xZdNMOO6P2otxyBJOvaEXfHfVpalnUhB
   LseMLrR4h1ymI/Hc6Z3Tdm2ZG0WZ6BBbMhGLaoaaA5O8LfOg8jSiYQCkt
   T+LWwHfXPGJiWtDt2oxhuITbHevRTRcPCTujsKpVQmOfCUCce1tEg7nuT
   y33Cy+8n7hJUBJW1mjEUTzHA8tT2N+6ITDTOJ6GDe+Vp/3FHADrQZeqXD
   xp70QNVGb21RFd7q6SVPXjFlShtvBv3DmQqhX8EvNhkZ7Sgk7pE1OX+rQ
   UCWsUMI6kFDmtcyPEwoCYU8nrZntX3+NOAXrzvXA9tKkJFSeJKua34L0h
   Q==;
X-CSE-ConnectionGUID: qJJ59UbcQTKhaZIa//Ottw==
X-CSE-MsgGUID: SFblhFniRUO5SaekmfzJbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90333044"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90333044"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 04:09:52 -0700
X-CSE-ConnectionGUID: 8WShdVDPSoOPCU2BF4Hb4Q==
X-CSE-MsgGUID: rZ97sl3eQ9mAl040n+E3ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="278225872"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa003.jf.intel.com with ESMTP; 28 Sep 2026 04:09:50 -0700
Date: Mon, 28 Sep 2026 19:08:02 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Guanxin Li <bruceli20040604@gmail.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: region: depopulate child devices on remove
Message-ID: <arpKkig+VAGXRSRo@yilunxu-OptiPlex-7050>
References: <20260928011551.15629-1-bruceli20040604@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928011551.15629-1-bruceli20040604@gmail.com>

On Mon, Sep 28, 2026 at 09:15:51AM +0800, Guanxin Li wrote:
> of_fpga_region_probe() populates child platform devices under the FPGA
> region using of_platform_populate(), but the remove path does not
> depopulate them before unregistering the region.
> 
> Call of_platform_depopulate() before unregistering the FPGA region so
> that the child devices are properly unregistered and their references
> are released.
> 
> Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")

Does it need to get backport into stable tree?

> Signed-off-by: Guanxin Li <bruceli20040604@gmail.com>
> ---
>  drivers/fpga/of-fpga-region.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index 9107a5b461d3..fd3f81db0385 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -429,6 +429,7 @@ static void of_fpga_region_remove(struct platform_device *pdev)
>  	struct fpga_region *region = platform_get_drvdata(pdev);
>  	struct fpga_manager *mgr = region->mgr;
>  
> +	of_platform_depopulate(&region->dev);
>  	fpga_region_unregister(region);
>  	fpga_mgr_put(mgr);
>  }
> -- 
> 2.43.0
> 
> 
