Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C912B2EFD95;
	Tue,  7 Apr 2026 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553211; cv=none; b=UeJConOHdN8/ophsrGFsk5Eivd4YtzU0OnbBHrKL4U0rnVptOOa0gwtBXhF20lT1oerbcPW3OX1qFb6LXU1yL7kL3N7TJP2hEQ6VW2vPPjCCHRWu6YMc1x6iuabA9PbF3D12b3I9te4K/7TphWlkZrHe/jzve6jxAHP/3wIHvPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553211; c=relaxed/simple;
	bh=PTCzasguh7fxAonrUeMp8OYjhZiL1RaGgeTHQLwyqf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VptMUWA9QKQYVPIvqd517VclZIcJ37NzWiOitf52w2cCWdusk2Lbf878x06xiOcAqM2esJ1F/nk9UIRCMk8AKJqUVcbSRDatIRNEEtDBSo98UlzgO5D/aNw1906zlfHk+n+0OC4mqtSqdamltxdfrbOcGCvx4UHpj0LwL2NP+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIu0KSvn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIu0KSvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775553209; x=1807089209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PTCzasguh7fxAonrUeMp8OYjhZiL1RaGgeTHQLwyqf4=;
  b=kIu0KSvnT6cja936CZbBBxh2c3VVY0AXEH9A6DwsdIK2IMkDbM3CXJqm
   a5lMhkPlW2qjLGdCz/qRy17WLV4DDGjVn11QLuCyPfJ1aQAiAoaXX9Fp5
   UuXIXlU+gjLj7C8usgHXqadlA8FQoT90/eLIdweY18uCSpNdYmUp6Nx/B
   DLegL5J6ch7fv4gaNjqQwkS5CKb8/BW2AX5/atCNS+EnxlrB6Z5BAPQnH
   d3Ff9efqbRfMn8QQFXTqISCvxZTtjvm1ewMN3/w2FMdQ/JaI34e8WsMio
   86nGKxRcYgWHcJbeAwA6WLrhLaYu1av4Fpg+J71HB/wKWh7dRpL6KEP0M
   w==;
X-CSE-ConnectionGUID: PwIN6EyGTeG2Ztz/WIeC4w==
X-CSE-MsgGUID: jYbBP+/zRr+KY3+U/hF5vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76633885"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76633885"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 02:13:29 -0700
X-CSE-ConnectionGUID: 2Kw98UXXQDmRQPgI6PdvWQ==
X-CSE-MsgGUID: a1DvL0SRTe+aYbvwjYTcVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="251408028"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 07 Apr 2026 02:13:28 -0700
Date: Tue, 7 Apr 2026 16:51:58 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: linux-fpga@vger.kernel.org, conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fpga: dfl: add bounds check in dfh_get_param_size()
Message-ID: <adTFrkzKcLBtay71@yilunxu-OptiPlex-7050>
References: <20260402125446.3776153-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402125446.3776153-1-sebasjosue84@gmail.com>

On Thu, Apr 02, 2026 at 06:54:44AM -0600, Sebastian Alba Vives wrote:
> From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
> 
> dfh_get_param_size() can return a parameter size larger than the feature
> region because the loop bounds check is evaluated before incrementing
> size. If the EOP (End of Parameters) bit is set in the same iteration,
> the inflated size is returned without re-validation against max.
> 
> This can cause create_feature_instance() to call memcpy_fromio() with
> a size exceeding the ioremap'd region when a malicious FPGA device
> provides crafted DFHv1 parameter headers.
> 
> Add a bounds re-check after the size increment to ensure the returned
> size never exceeds the feature boundary.
> 
> Fixes: a80a4b2b2e4f ("fpga: dfl: add support for DFHv1")
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> ---
>  drivers/fpga/dfl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 4087a36..0f0889a 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1133,6 +1133,9 @@ static int dfh_get_param_size(void __iomem *dfh_base, resource_size_t max)
>  
>  		size += next * sizeof(u64);
>  
> +		if (size + DFHv1_PARAM_HDR > max)
> +			return -EINVAL;

Seems (size + DFHv1_PARAM_HDR > max) is to ensure we don't handle the
next overflowed parameter header. But here we only need to ensure the
current parameter block within boundary. If we end up at this block,
should not care about next parameter header.

> +
>  		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
>  			return size;
>  	}

------8<------

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 4087a36a0571..ac958b80c8cd 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1132,6 +1132,8 @@ static int dfh_get_param_size(void __iomem *dfh_base, resource_size_t max)
                        return -EINVAL;

                size += next * sizeof(u64);
+               if (size > max)
+                       return -EINVAL;

                if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
                        return size;


Thanks,
Yilun
