Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC1C3AE70B
	for <linux-fpga@vger.kernel.org>; Thu, 22 Jan 2026 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075416; cv=none; b=SVdUvCj72Ng/gen7PxJVp3Ae3SlJcAniwGlVt8W0peSIifZsY7CtVRPzXS3yr0cqyUSu3Ab3lfGek9tusG8rY7PAkRelSEw/ukbpzT0bnHp5h8KIMuIpk6BiDukBE+4e8xkBElQPBAoDL8MRYt5faPNf2SZaLZFIKvTLoBcH1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075416; c=relaxed/simple;
	bh=QzDOgR4r5oL2YwT+3sMn807+K6tLKsEFR0i6+KTB4tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EC7ixM437tAtsWN31/pf8xpHPcaiSV/mhNiPlBWQXDJKQus9S1qk7XkvwQaL7cPFhTMP204YYuF4rvlp0NcrdQm1DZE5PE3/9s3sRNjXQxWHgvNFFPk1aDfSmfVKFzHro1DmCMTMYoznkO3cfIRTxcrEsVNjKAXJUa9N4rK+JxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kYaB1lqZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYaB1lqZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769075414; x=1800611414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QzDOgR4r5oL2YwT+3sMn807+K6tLKsEFR0i6+KTB4tI=;
  b=kYaB1lqZQXsOpwA1JFFLnoFLoWja0BceIlEe3Yh65ZtDvPrV5QYus34U
   2/4jvA1VXHhG7NqlMmUUY2tzzEzBEvFIuNojAd9Q4UgkZGYgBi3lnvnl0
   vXPGM04wHr6YGuBO0Syl7fafoGNszMgkBZXv4vOGn0mdKYtFwzeIPmVKl
   xoZDiVozxsJUaJZXDOkXJPslWt5t1ZPqhwby00u6QL/uwlMqwslhW0a3h
   6bGH1NQirdTPEDDicB16sgZYdyIhH6yGgl0dsNWAe1lQlPeWGXJdyzyDz
   CVe3b1smEeXvMDy7Dog6+M5fQBCM35UbqXZSj7D5xqRUVSwJiNR5LHJpg
   w==;
X-CSE-ConnectionGUID: NS43sUdcRiqbzagRqdcJjw==
X-CSE-MsgGUID: iPbE/AoGTEm1q3dy0eGVug==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="92978144"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="92978144"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 01:50:13 -0800
X-CSE-ConnectionGUID: W8Imlj1TREWtSTD4v/+v5Q==
X-CSE-MsgGUID: rMlDcudJS8GxVJ4K4AKf/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206953263"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 22 Jan 2026 01:50:11 -0800
Date: Thu, 22 Jan 2026 17:32:18 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Mukesh Kumar Sisodiya <mukeshkumarsisodiya1981@gmail.com>
Cc: yilun.xu@intel.com, trix@redhat.com, linux-fpga@vger.kernel.org,
	trivial@kernel.org
Subject: Re: [PATCH] fpga: dfl: fix typo in header file
Message-ID: <aXHuokWWEA9rEEzk@yilunxu-OptiPlex-7050>
References: <20251226150408.2802-1-mukeshkumarsisodiya1981@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226150408.2802-1-mukeshkumarsisodiya1981@gmail.com>

On Fri, Dec 26, 2025 at 03:04:08PM +0000, Mukesh Kumar Sisodiya wrote:
> fix typo "definitons" ==> "definitions" in DFHv1 Register Offset comment.
> 
> Signed-off-by: Mukesh Kumar Sisodiya <mukeshkumarsisodiya1981@gmail.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.
