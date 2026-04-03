Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C70A30BF52;
	Fri,  3 Apr 2026 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775215015; cv=none; b=QAcO9lrgahf+HDnvGVpwGWxNqPixc0Xnzm7PzCXhSKCkLjKDuogpkKsr3GPMNk7UMz/OIcV4sXYmaRcKACUhxou5pChV/0nxzmiKxB0+s6v7fLKDTm+ataMhlJ/tdK1ZF7Fa7raFdydqFcYudCz6/0Yr1kzv3MLJALKFjCA4jv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775215015; c=relaxed/simple;
	bh=HtzARUidbVQF2DEEZkJELuNDbQvo0M1GX5/uO5G/vMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhCWVUDUOIPUExYYxNxlj5xd8/QhFCBMxYzMmqtdBLy3PfaHBkdRmRYJD34UJMZ9whsDVj5RPEFv0vO/O5mZwawsy/bl4c0QIWTNHJv4tEOw9p1eY9hl4ed1UWoLouX60dahO9dkOm0IFVukZz26UKDhU3Ph2zqRsmhO/u0aTbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BoOJA28N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BoOJA28N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2E8C4CEF7;
	Fri,  3 Apr 2026 11:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775215015;
	bh=HtzARUidbVQF2DEEZkJELuNDbQvo0M1GX5/uO5G/vMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BoOJA28Nr49yeK61tIdqlWBwQ4ZzLRsuXGx2HB5N4uHDrCjy0Wy/1szxZtnlGvarx
	 fsmYYVsRD3gQqoahtyHHsFS5zK4IIfMAbY1euCpLX5/pXXQFu0cAMU9AMKsGDg9qCM
	 A5iMGrMwjO53spCboQZ56hM9NHGhSLYtvdT9KLHA=
Date: Fri, 3 Apr 2026 13:16:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Sebasti=E1n?= Alba <sebasjosue84@gmail.com>
Cc: linux-fpga@vger.kernel.org, yilun.xu@linux.intel.com,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] fpga: dfl-afu: fix integer truncation of npages in
 afu_dma_pin_pages()
Message-ID: <2026040346-semicolon-catty-3f93@gregkh>
References: <20260402125446.3776153-1-sebasjosue84@gmail.com>
 <20260402125446.3776153-2-sebasjosue84@gmail.com>
 <2026040242-wrongly-hemlock-2c14@gregkh>
 <CAJD=UNc06upxLFo5eNrvy-UvP1Cu6CEBt-csCgECxAK94pa8mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD=UNc06upxLFo5eNrvy-UvP1Cu6CEBt-csCgECxAK94pa8mg@mail.gmail.com>

Please reply inline with the real message, not just at the top...

On Thu, Apr 02, 2026 at 10:25:14AM -0600, Sebastián Alba wrote:
> On Thu, Apr 02, 2026 at 10:07:00AM, Greg KH wrote:
> > How can length be that large?  You are shifting down, not up.
> 
> region->length comes from userspace via the DFL_FPGA_PORT_DMA_MAP
> ioctl (struct dfl_fpga_port_dma_map.length, __u64). The only
> validation in afu_dma_map_region() is PAGE_ALIGNED and an overflow
> check (user_addr + length < user_addr), but there is no upper bound.
> So length >> PAGE_SHIFT can still exceed INT_MAX.
> 
> > Why INT_MAX?  SHouldn't this be much smaller?
> 
> INT_MAX because pin_user_pages_fast() takes int nr_pages. But you
> are right, a practical limit should be much smaller. Happy to use a
> tighter cap if you have a preferred value, or I can base it on
> totalram_pages().

Ok, I think you should move back up the call chain, and for every ioctl,
properly validate ALL arguments before calling 3 levels deep into the
kernel afterwards, and just hope that the values you are passing around
then are actually valid.

Same for the firmware verification, that should all be done in one
place, before you start poking around in the image.  Try to treat all
data coming from userspace, or a firmware image, as "unverified" and it
must be verified before it can cross the boundry to being trusted to do
anything with it.

I'm guessing you have access to some "bad" firmware images to test this
out with?   This is a very odd driver, I doubt that anyone has thrown
any untrusted data at it before.

thanks,

greg k-h
