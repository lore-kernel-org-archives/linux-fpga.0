Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F5E36308D;
	Thu,  2 Apr 2026 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146045; cv=none; b=tQ+Ln60/Bu+cX51UTLOqgE2/8+v3T/e9qX0A8XB79kqPh5VePvB2Ej6BJv2SY++Omv2ao04feXtVDIgRnhA/Ea/qWbYrQmBU3bXQjgf30YB5Pg3W8V2Vqc2U2fzsQZR0WRMQET4du23JpyAD7p5Htzzt0dDQv0XFEQsLA1TjJJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146045; c=relaxed/simple;
	bh=cV5NkpVrx05XLH+tTls30BH0nuqn6nmKKdeXhU05wVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrWLnH9SS6gcbJvMqvyEZdLsKBm48yR4R3aLy9sSzobnwu0bS7YvqVjNOTtmUh9xiVjuGENMP7e3lVAujZna7eT0B8B+3MYau9ULzC4F0TTca9ST2gYe8UYv7JkR1k9o0784potHwTSRskF767ligPmmersqzBxtIIPvcBShhAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cAx3VZ9D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cAx3VZ9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9882DC116C6;
	Thu,  2 Apr 2026 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775146045;
	bh=cV5NkpVrx05XLH+tTls30BH0nuqn6nmKKdeXhU05wVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAx3VZ9DILEgBh+xQ5joiBisKkrha2IorW+7dCEKajcQIpPr/VJIt0gmiZgmgtyrZ
	 +bThE3X/008uZTefPEwdQ8DdI0+aBwfav9AcSfdmqd6i91Q2Hp0XW0B4XF10NExtqp
	 8t7Yt0JME9/d7+ONnUaTaaLYNhtQHNTTn3KyCWi8=
Date: Thu, 2 Apr 2026 18:07:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: linux-fpga@vger.kernel.org, yilun.xu@linux.intel.com,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] fpga: dfl-afu: fix integer truncation of npages in
 afu_dma_pin_pages()
Message-ID: <2026040242-wrongly-hemlock-2c14@gregkh>
References: <20260402125446.3776153-1-sebasjosue84@gmail.com>
 <20260402125446.3776153-2-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402125446.3776153-2-sebasjosue84@gmail.com>

On Thu, Apr 02, 2026 at 06:54:45AM -0600, Sebastian Alba Vives wrote:
> From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
> 
> In afu_dma_pin_pages(), npages is declared as int but is assigned from
> region->length >> PAGE_SHIFT where region->length is u64. This causes
> implicit truncation on 64-bit systems when length is large.

How can length be that large?  You are shifting down, not up.

> 
> The truncated value is then passed to account_locked_vm() (which takes
> unsigned long) with implicit sign extension, and to pin_user_pages_fast()
> which takes int nr_pages, potentially causing incorrect VM accounting.
> 
> Change npages to unsigned long and add a cap to prevent values exceeding
> INT_MAX from reaching pin_user_pages_fast().
> 
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> ---
>  drivers/fpga/dfl-afu-dma-region.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> index 87652d5..0d1f973 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -34,10 +34,13 @@ void afu_dma_region_init(struct dfl_feature_dev_data *fdata)
>  static int afu_dma_pin_pages(struct dfl_feature_dev_data *fdata,
>  			     struct dfl_afu_dma_region *region)
>  {
> -	int npages = region->length >> PAGE_SHIFT;
> +	unsigned long npages = region->length >> PAGE_SHIFT;
>  	struct device *dev = &fdata->dev->dev;
>  	int ret, pinned;
>  
> +	if (npages > INT_MAX)
> +		return -EINVAL;

Why INT_MAX?  SHouldn't this be much smaller?

thanks,

greg k-h
