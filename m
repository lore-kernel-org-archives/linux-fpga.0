Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E17271443;
	Wed, 23 Sep 2026 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176205; cv=none; b=R3VS73qUjdVOUZOEq/XPc6uQZKehQNnIaTiKAPWGVKyDvEE3hl8FoQqdBP+zF6DgbV35VUW6SRLpoPeCCF0+pTet/dBHrB9Dyb1WpP7V94c0fC5SvngQHjYyJXPn+n6Dgushn+8lUwLwCbunndM3LLrqtBTEU7pv1ndyH7VFavI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176205; c=relaxed/simple;
	bh=ZsCiCgubVfsHQuLEBzKfRq8LU4r2cNza4kmPyv0Ar34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWYQ1eJOqAm7JqjbaOwFU0G0XpEyfO9X5Q22TRtlERn0KwcizAGZY/zEJJxr/6HnLRWGfF6kVM/1esjRvA/Tu9yGIsWmG9weniV2Ec26yz+SsNQuUAw3L4Ugr1ql4BN/8yAmD0toQalX6iEODizHoxQQEklk42SjXjvey6bBuc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9k+J1Xv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9k+J1Xv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41101F00898;
	Wed, 23 Sep 2026 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790176203;
	bh=4tUYPNtyNh01xCJ2PLgysU7v0U9kxuU1XJhtJwMfEio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=A9k+J1Xv8H8FlYMbCo5VEee282+QP0qM1mxPpKCknxblZba3vik10szV2Grl23HTF
	 OdhkfcRQhNcFuksIR073l7cXQs4kpB7X1qLbpYCwRbNmIWM9sxWl7Z2M2i5sR5/xc6
	 VlxeK+yTWZ5D9aHtmwk2TvDkw72If4pGYi5TjFz/86tLcnf7cVcx9tK2Xml/jmlYUb
	 nXbGKtqEwSAT/JuuCAT7PpIRv0RrHdbNgOCBhQwgAn2wJkd7slhonzJLo7MLfL/L41
	 AHWGPU7pjxW/DUxdkyGj8W8oE07LvQ9J7aGlXtGzBkE4/L0M6uOwRmDqRbAgTWCvvg
	 Z8xvUoLdf0GXQ==
Message-ID: <1857df9a-8952-426e-988b-cd05d45a04cc@kernel.org>
Date: Wed, 23 Sep 2026 17:09:57 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
To: Marco Pagani <marco.pagani@linux.dev>, Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <417b510f-0f6d-4695-97f5-3fc19b9377b9@linux.dev>
 <amCn8UYdybT+RRnq@yilunxu-OptiPlex-7050>
 <9d4af487-69a7-4a0d-9335-35c3a057de54@linux.dev>
 <anBfAa4LpjbmYHIc@yilunxu-OptiPlex-7050>
 <db7cfe9e-b2ba-4323-bff9-44598e1f70bb@linux.dev>
 <anl8891cH+bUfsGY@yilunxu-OptiPlex-7050>
 <4dbdb52e-1b28-432e-a3a7-ad9c44f17d27@linux.dev>
 <aoJ6paA/8ndpJ17y@yilunxu-OptiPlex-7050>
 <8848432d-45b0-4efe-adf3-adfb64fe0899@linux.dev>
 <11b1a792-f8b1-4fce-8a7a-8352149febcf@linux.dev>
 <aq12s+hUVnnvCKmZ@yilunxu-OptiPlex-7050>
 <2adefc6f-328c-4683-8cba-091d9f3425ab@linux.dev>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <2adefc6f-328c-4683-8cba-091d9f3425ab@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/09/2026 16:30, Marco Pagani wrote:
> 
> 
> On 18/09/2026 19:36, Xu Yilun wrote:
>> On Fri, Sep 18, 2026 at 05:07:07PM +0200, Marco Pagani wrote:
>>>
>>> Hi Yilun,
>>>
>>> Is it okay with you if I CC the DT people to ask for an opinion?
>>
>> Of course. It's good to know in which case could a DTO be applied.
>>
>> But to be clear, I think that only affects how we accept and apply the
>> image-DTO pair. For now, I basically don't want a varient selection
>> interface.
> 
> 
> Hello Rob, Saravana, Krzysztof, Conor,
> 
> I'm CC-ing you on this thread as OF/DT maintainers to kindly ask
> for your input on this debate we are having about how to implement
> userspace FPGA reconfiguration, an important feature currently
> lacking in mainline kernel.
> 
> https://lore.kernel.org/all/20260608164247.1998417-1-marco.pagani@linux.dev
> 
> To recap: modern FPGAs allow portions of the fabric to be reconfigured
> at runtime to dynamically swap soft IPs. Usually, these IPs are
> connected through a non-discoverable on-chip bus like AMBA AXI.
> From a kernel perspective, this means the FPGA device configuration
> image (bitstream) must be paired with a DT fragment that describes
> the new topology.
> 
> In this thread, we are essentially debating between two approaches for
> implementing FPGA userspace reconfiguration at runtime:
> 
> - Statically defined Variants (this RFC): Userspace can change FPGA
>   configuration by selecting from a pre-validated set of variants
>   (DT fragments) baked into the base DT.

I don't know what DT fragments are, maybe you meant overlays? But they
are not baked into the base DT.

There are no bindings here and no DT maintainers were CCed on this RFC,
so I really do not get how this patch can enable something like that.

Linked URL shows some undocumented ABI, so obviously this would be a no
go. And RFC prefix does not justify undocumented ABI. At least one
without clear explanation in the cover letter, why is this RFC and why
it cannot be merged/reviewed.


> 
> - Runtime DTOs (Nava's RFC): Userspace can change FPGA configuration
>   by loading DTOs that are validated at runtime.

If runtime overlays were working, this looks suitable to the problem of
runtime change of the hardware. This also fits hot-pluggable hardware
problem, which Bootlin is working on.


Best regards,
Krzysztof
