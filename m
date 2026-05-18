Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF40429D291;
	Mon, 18 May 2026 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130376; cv=none; b=AzyRySRt9alnhKp9BOJMN75B3sx+IEzck8t0JsxAtK6brqVG3AyuiDeUPs0uqh7WaZEu2UoURGGGz8ia4JvWTMAYyW0Hn5fyYnDB2Wgi1Oarl4tuZvSl78fcJBibqmVG2E0xSanl2wFh2JN+aSTZ5sMkj3opsoaHHtCak5AkzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130376; c=relaxed/simple;
	bh=1er2n1xt2Zey5TSeplw+EigYp1+3k6wisqwsQNaboVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iF42x0JFzcz39OqBHtZupPrAcx0LoyuiOvUwuTBXkOhSlGU60BRXyIP5OPyInhkQJCZAjBX5+o1kJzGbiCwE7Ka+xkMYverOAEgBuIrsWX6nCHF5DfkD+hUIOACDuN2ochzx8cbObMuQv62qgm8b7WoA7BXS13VFhmZ0GN0RjJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tdn5jsfD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tdn5jsfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F615C2BCB7;
	Mon, 18 May 2026 18:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779130375;
	bh=1er2n1xt2Zey5TSeplw+EigYp1+3k6wisqwsQNaboVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tdn5jsfD+uzMEWRtERrKX9EYs78z4s1Unvaij3eren4K/BjxM53IJCfH728U6mhIU
	 wYWDN0q1Ywi8KYb7pNxo2q3Y0WBRpr2yvMOfTz/tQZQHYDx8p2ZMxMQepKnQ4GDcrD
	 FQYCESJ2+57TK8fnF7qmIAhhmN/bzVn5eIA8Jq5w=
Date: Mon, 18 May 2026 20:52:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: yilun.xu@linux.intel.com, linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 2/3] fpga: dfl-afu: validate DMA mapping length in
 afu_dma_map_region()
Message-ID: <2026051800-humbly-pandemic-2f19@gregkh>
References: <20260518165218.35388-1-sebasjosue84@gmail.com>
 <20260518165218.35388-3-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518165218.35388-3-sebasjosue84@gmail.com>

On Mon, May 18, 2026 at 10:52:17AM -0600, Sebastian Alba Vives wrote:
> afu_ioctl_dma_map() accepts a 64-bit length from userspace via
> DFL_FPGA_PORT_DMA_MAP ioctl without an upper bound check. The value
> is passed to afu_dma_pin_pages() where npages is derived as
> length >> PAGE_SHIFT and passed to pin_user_pages_fast() which takes
> int nr_pages, causing implicit truncation if length is very large.
> 
> Validate map.length at the ioctl entry point before calling
> afu_dma_map_region(), rejecting values whose page count exceeds
> INT_MAX.
> 
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> ---
> Changes in v7:
>   - No changes.

Why no cc: stable?
