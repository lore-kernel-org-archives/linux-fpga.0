Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553A1AA1D2
	for <linux-fpga@vger.kernel.org>; Fri, 21 Nov 2025 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735203; cv=none; b=tXOPrfJSZz7uyCR/JSvlN6huCD0VQvwT2fvIxcZ9ieVpH3uqmoeYlxZSra9Zle8tPD2xj0z2Hf5t46oTWt468cpTEQEXrotoKPe9xouEGUexF1mWCFUW6cM+NIUkEPBL1yqnJaZTUZHfq0wQT5HzM/6XXIHpUuk0Wegi7BianjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735203; c=relaxed/simple;
	bh=WIJ3Y5NwptAluMi8V9B24ngQUR8oU2s9jZuFhGlQXQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Joppanr4m+8VoflKR0pAb+Q+q3FEjr0yaF9vxUB6Vw0Qq/N3BEG7autFVr8wbs0vHVD/jHVOCs/0Honk0r7MJq31c7jvtJ2CD3F/q9CjJRmWa0eaFbAQhoB2BOGyD4i0FA/y1MkeRyKSpOjHyEHt4V5lvuE/6PubgTobqcx0f9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p905DWkw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p905DWkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B1EC4CEF1;
	Fri, 21 Nov 2025 14:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763735203;
	bh=WIJ3Y5NwptAluMi8V9B24ngQUR8oU2s9jZuFhGlQXQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p905DWkwM3imK74EVEjtwvKlwWko+fMow/PmKyhBuGAShurvVUnFFp7zPs1RivDM4
	 bGbQzezki4w0e2WC1aEfuJznH4hIU3BWMkAEvOsarnCBppS+q9zk7fkr3aUMu3Pgom
	 vxO9mYFn1/1e6V4jODkrPhF/TUAZ4Zv6YD9intQA=
Date: Fri, 21 Nov 2025 15:23:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: Re: Subject: [GIT PULL] FPGA Manager changes for 6.19-rc1
Message-ID: <2025112120-marigold-runt-6828@gregkh>
References: <aRcIb/DDDGTBTzDa@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRcIb/DDDGTBTzDa@yilunxu-OptiPlex-7050>

On Fri, Nov 14, 2025 at 06:46:07PM +0800, Xu Yilun wrote:
> The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:
> 
>   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.19-rc1
> 

Pulled and pushed out, thanks.

greg k-h
