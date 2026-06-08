Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7406A23E320
	for <linux-fpga@vger.kernel.org>; Mon,  8 Jun 2026 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946900; cv=none; b=codXy7UDlPTrafY+9OIrHw7lCuQ29I5vgWOoFkt4xFMLyGi3mL1cPfC86ZkhqVSj2Wj3qK/lRUWIhvSfuiNnxcDMm1Xhx+mo9/hyxhWo49grELj9S7Ke5VaQNm14uSG1vb60jY0v6MInytKylwZiTLMD+bqTzgDYD6lhnfQfvC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946900; c=relaxed/simple;
	bh=uyxYDS/9e5+lC+/Dbjy7kpc4UXVw1qik+dd9NBWRqQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKRyUewpnGD+OfyMVTGwSCvkWkSZ6jjxWJYVY3yIVL8L6vLV5tjSMgt3lYVGpj4qK1wsXnBgjCqJJ2y+zW8uQyZJ/ifndRSLzVI8gcnjIeSOmbNamYUmBGbqxNNxcWTwkSKrxD3G0L/6unpqXc6lUEHb3ZpIaYD9qKcarS+pZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=piPrioBy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="piPrioBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A84B1F00893;
	Mon,  8 Jun 2026 19:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780946899;
	bh=r7Qts3e5r39x0n+KhozWW++DxlD0FA5A8FJ0L8+3qzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=piPrioBymqzGpNMQyaX4bRCPmJqWvSzhLY59Y5sAc4c4NdTGC1jASNvtKv9dzlVrZ
	 GOibii2hY0OhQf7iZHeRvxkZBsHZwmqSaiQeoDU4HshAWc0F8ckjmmAPv1TfXHFPhm
	 k0zTDP4/fCKcVlsB835JXTzlNJHKuppYfVGOpVFU=
Date: Mon, 8 Jun 2026 21:27:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 7.2-rc1
Message-ID: <2026060811-unpaid-confider-01a9@gregkh>
References: <aiD30tC74Rn2KjGM@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiD30tC74Rn2KjGM@yilunxu-OptiPlex-7050>

On Thu, Jun 04, 2026 at 11:58:10AM +0800, Xu Yilun wrote:
> The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:
> 
>   Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-7.2-rc1

Pulled and pushed out, thanks.

greg k-h
