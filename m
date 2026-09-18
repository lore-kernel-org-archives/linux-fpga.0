Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834BE51AFF9;
	Fri, 18 Sep 2026 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753132; cv=none; b=frZO6ayfdhqpVhA6WqGbc7IbWJ5eIPfZL23+XLu/VrrnPzx4ukJHte3E2HcgzGD5FfV5NUTBTiXSwv1i82mDBL58pBQt/l3R/gjoHHg9EcZenA9iNHy4whT3hN4pvKnkojYUZMmBqARaqQ+Elq5/gEJMai7HtE0Mez+K9BCYC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753132; c=relaxed/simple;
	bh=CKO3icM4eR2lr37zpd+PK8SBz40gkwBtTjwx1xIU/M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGAAudM2MlzDHByNhVDM7zR+sElh1X9SJwrdhQRgg43r8Wo2U0mZTXfBBcMUxDKLsfkr9yjE91Q2RJZMDt9SVoilT4yCJfClnlqdYjnCyf0G3yNSmDQ+BOYu4dwnOoxeRFIOyjYjuuaVeQjxVtBIscj2OlXYrKk/wa7BHM2C234=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKVFwFPv; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKVFwFPv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789753130; x=1821289130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CKO3icM4eR2lr37zpd+PK8SBz40gkwBtTjwx1xIU/M8=;
  b=NKVFwFPvHsuwneZmdZuYXTSPAKaq2OE2zw8uoOg+ry6isDI4U1j5avcN
   IT0tDQiWRNdcV1NxdDPtqcO/rQAE5sV9cNIWKuMCXZMfRTvmSjYWXddJX
   aL5uuaM80ii0syNcldpMe166mcWO1hqynEATm9KdW3vEgXDzpcUySmkSH
   uffiWt+ILwYFfs4PFpXQiQHaN5gHxxKhol371op5rYTiLISjEGGqJTDuo
   um6rKT+4cyB0T9h7wxabt50C7AK10hzF+ZBcAa9Lrk0q2f6GfwuOzFkSp
   lmIxHMFM7N+uJPxFHlr6ZWUBWMFODCkZuh0e0K7h01C28Y4eh89quvFxS
   w==;
X-CSE-ConnectionGUID: zio5zlJaRXiKW1vU5prRIA==
X-CSE-MsgGUID: X1JsBYRnRxyUNaCnYMqyZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="788198"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="788198"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 10:38:46 -0700
X-CSE-ConnectionGUID: vVlmfQC7SD6r+8QbL8+gbA==
X-CSE-MsgGUID: i8nahSe4Q4aro2CA9+MNTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270796789"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 10:38:44 -0700
Date: Sat, 19 Sep 2026 01:38:19 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: mdf@kernel.org, yilun.xu@intel.com, trix@redhat.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fpga: fix typo in s10_ops_write() comment
Message-ID: <aq13CwhJWNOC5fDP@yilunxu-OptiPlex-7050>
References: <20260910044545.50261-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910044545.50261-1-hemanth.selam@gmail.com>

On Thu, Sep 10, 2026 at 10:15:45AM +0530, Hemanth Selam wrote:
> The comment reads "reuse it to send more data or free if if all data has
> been sent".  The first "if" is not a repetition, it should be "it", to
> match the "reuse it" earlier in the same sentence.
> 
> Only touches a comment, no code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next
