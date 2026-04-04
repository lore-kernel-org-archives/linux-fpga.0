Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E71FC7;
	Sat,  4 Apr 2026 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775286112; cv=none; b=FR6ye/06pMwRkbgEOEjfNAVPdHCP7rom9twAMxN+q+4Ha3zKsak7u/4Z+b26nat5OjSiQsYpqL6Q+WHTF3ACrraTUUTn9cWplGHRhcKwxBE3CXdTAo8mSHmmPrHUKknk4jjQRNimj9nRPMlwj3FGy4d2YvMhM95GieIPDtd8b0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775286112; c=relaxed/simple;
	bh=go+ONJynqiEeu2+jIilg1Rn7fyAXu5pzs7GJv8pNKps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEEmOd7Qrg6DGq23O1oQJ9Eh2gl07V28bON75I+g9MN1XqvcYrWUeljdNi15f77xNNu2XJpZSLN50dJwVcdRQPk/IA1p8wTE84sJ7I3GRDx7uQh3xsUa++aEc6tOoy0FO22an0tL6IAL1DMrQbPxPcWCU1YR45IqMLYhv9ot8vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YP+9PZBK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YP+9PZBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4F2C19425;
	Sat,  4 Apr 2026 07:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775286112;
	bh=go+ONJynqiEeu2+jIilg1Rn7fyAXu5pzs7GJv8pNKps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YP+9PZBK7HQb1NIUUqDD3Y6561m8gRHsMCSJ2m4VYP8TqgUk3MNysUpLbxFXrMLW9
	 GopLks59VscHOlRDmdRD+61S81yPVI5yZBtReVbHOZdY5rGWbqJ3s7eJZtGvgjnwrH
	 HPBYicK6GVq2Jy1eRiiKG83awzZHGSdhMsvCZhag=
Date: Sat, 4 Apr 2026 09:01:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: linux-fpga@vger.kernel.org, yilun.xu@linux.intel.com,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: dfl-afu: validate DMA mapping length in
 afu_dma_map_region()
Message-ID: <2026040417-criteria-cut-b24b@gregkh>
References: <20260402125446.3776153-2-sebasjosue84@gmail.com>
 <20260403175719.75904-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403175719.75904-1-sebasjosue84@gmail.com>

On Fri, Apr 03, 2026 at 11:57:18AM -0600, Sebastian Alba Vives wrote:
> From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
> 
> region->length comes from userspace via the DFL_FPGA_PORT_DMA_MAP ioctl
> as a __u64 value. While the function checks for page alignment and
> address overflow, there is no upper bound on the length value. When
> length >> PAGE_SHIFT exceeds INT_MAX, the downstream call to
> pin_user_pages_fast() (which takes int nr_pages) receives a truncated
> value.
> 
> Add the length validation alongside the existing input checks in
> afu_dma_map_region(), where all userspace arguments are validated
> before being passed deeper into the call chain.
> 
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> ---
> Changes in v2:
>   - Move validation from afu_dma_pin_pages() to afu_dma_map_region()
>     to validate at the ioctl entry point as suggested by Greg KH

This isn't the ioctl entry point, why not put it in afu_ioctl_dma_map()
with the other checks?

thanks,

greg k-h
