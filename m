Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812B82E7390
	for <linux-fpga@vger.kernel.org>; Thu,  6 Aug 2026 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007285; cv=none; b=lW1AvtZ+ETVkTcJgmv7L7c3bF71pt9gGYtxZp3/LjIbKIx52AwN1g4bQo1L4ySVfS0WQJVBpIRr5O1qk4UXFTB9He/hnr4bPx0JqTeYrmb8XVbH+NpsxpURBYWzLF6mHRWg4zfCgv8Vpq1TasLnRRHQaY5LmhMN9AFJAIVPAyDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007285; c=relaxed/simple;
	bh=cgZdXbk6bSPkL/XF37B/udfrk1JPpVxrWvo4UCoNBoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVRQXK51Jyp2DarZI6UzFAW6EXtAhlZpcHVerVFRw+5ltXbZcT0IothedJGtgIlIvCl2bc+bf7FeEa1GvVlo2DywJCwXyXB7xVWXXuvPbRtLACJ63xIWNrPS3L3U8lK1Sk4JP6H8/VCHSYvlPiyaKNIm4lXyYT82YhP+SHx59V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tu9/wkUi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tu9/wkUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3471F000E9;
	Thu,  6 Aug 2026 09:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786007284;
	bh=vLjG7CY7VmbY8hwT1DvD0qJlnQs8tcv2S5bytpVqin8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tu9/wkUi2kxjWBh3HhcyXiWNQtlxK0Oa3krhGWDUk5MkxOhptlRi5vvHjxRlhXkh1
	 W3CXu+dXqlVdUzU2qyUHv/l6ukAsPrvm5kvYJLR8P4bsQUpFkEn8lYhZugz9ohJK+j
	 sRt5ELDmphftc6cC8+qS9D27lvcYj9xLy1EdktSs=
Date: Thu, 6 Aug 2026 11:07:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 7.3-rc1
Message-ID: <2026080620-outboard-porthole-4e53@gregkh>
References: <anG09zb/HD1+cD2s@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anG09zb/HD1+cD2s@yilunxu-OptiPlex-7050>

On Tue, Aug 04, 2026 at 05:46:31PM +0800, Xu Yilun wrote:
> The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:
> 
>   Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-v7.3-rc1

Pulled and pushed out, thanks.

greg k-h
