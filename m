Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C44131282F;
	Mon, 11 May 2026 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513740; cv=none; b=Hu1Aws60njmfKko6cudf6BDsPIFt4ANz3PqVtyCAYkEErE+I1Ck626MvbWcFvV0nj0HHZawEjJ+ppysONvP2Gxld0W722oYLI+3rVCz1YDFpx8b9uS15dDYsd+J+RB1Lkf0ZKcD702dGUL5gIw010ediaZOUKOvfV3FZ37k2V1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513740; c=relaxed/simple;
	bh=iUP8xMGCKKt29nj9vNR2drAUaCvet+bp+38xvr1WvmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDoy3fQgOAa7I82yCK0R+yENBgDFIBxr4RcOx8tA1H38hZQGk5JTN50vEtLTN61wyf6UGAT6s2YXgmthFKIMiPFnc8CFId4yyywhzmgj9JomAGvHaB57en6Lex5v0UMdT8egNcnDfeYTEA7UmXWDPMBMEDEbRbgxihPNCU6yGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRgEXh8b; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRgEXh8b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778513738; x=1810049738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iUP8xMGCKKt29nj9vNR2drAUaCvet+bp+38xvr1WvmQ=;
  b=gRgEXh8b2dRa7onRZoKTBAY90nYmzinxWmnxoDQSZOJSHxW0t7T3Y7CA
   WgoYjeDRVIPHWRm4JxTtL/bmieUTbINxXOQxKqKfJoAOUzZ4Lo2AUeIGo
   C/usRiFDKYZ0KgNYGC7damXCw9xa+LlGGRNeDAeIxTFfr/PJ2lOLOvbX6
   ZKvgAet8be8jiPLK/y9yyMsYyAcHaJL9Y362mGpsjHV5/KMBlI/k3HAyp
   2iuMhICRiDxIrxziNZ1ycqYVi/FmEEwyvHSzWJEIk12df58z0EnuddE3B
   RSfJYTKCVnnz6uuMvtBYwsIHB6C329kBE2jy4u1IxYUoeJgOvV00gO8Cn
   g==;
X-CSE-ConnectionGUID: j/kDMeUjSk+TqOwQQb+74w==
X-CSE-MsgGUID: asIZcX7dT16RXRRCyuxqsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90781477"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="90781477"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 08:35:37 -0700
X-CSE-ConnectionGUID: 0KLtvQrSSWixFeMQ85qIJQ==
X-CSE-MsgGUID: QnPkBA7eQ8Wm6XkSy4sETw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="239300854"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 11 May 2026 08:35:36 -0700
Date: Mon, 11 May 2026 23:12:26 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v1 0/3] fpga: lattice-sysconfig-spi: Ad-hoc cleanups
Message-ID: <agHx2tula7SFheYG@yilunxu-OptiPlex-7050>
References: <20260508082716.1156192-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508082716.1156192-1-andriy.shevchenko@linux.intel.com>

On Fri, May 08, 2026 at 10:25:34AM +0200, Andy Shevchenko wrote:
> While converting the driver to use modern SPI APIs, I have noticed
> more things to improve, hence this mini-series. Note, it's independent
> to the above mentioned conversion patch and may be applied before or
> after (separately).
> 
> Andy Shevchenko (3):
>   fpga: lattice-sysconfig-spi: Fix the terminator entries in ID tables
>   fpga: lattice-sysconfig-spi: Drop of_match_ptr() protection
>   fpga: lattice-sysconfig-spi: Don't use "proxy" headers
> 
>  drivers/fpga/lattice-sysconfig-spi.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

> 
> -- 
> 2.50.1
> 
> 
