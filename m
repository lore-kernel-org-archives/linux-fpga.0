Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDD42E889C;
	Tue, 18 Nov 2025 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494136; cv=none; b=IIB3aJXiXepRLpKpTrcQCCGr95DVoSSKLDOe3gGAMFPumAO6TMqFIOzEzajHkJJiQ1zXjt+rze3x8J6YtBvfbzg9p0FRzOpoqF3qjx5tWJLXF8QeCm/6A4c8aPcFHJjFrxai5gzVvIiWFiLqx5ivhT0xxNmTZycR0aUmieKSQmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494136; c=relaxed/simple;
	bh=eBuvi0lz7rk680A1jcXCHa4rLvZmN4o6j92IZiLwI/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0+6ZU+UlhGdNIvG2w/dsdMXziVWKfa9mr6VPcFCKRbtMzI9SblEwN3egP5f/nftB9tKjX+aE4xgXH6s8H+uugYiEGTp5e4rSGtcTwlRcTTFL9YV9WYKPvQq2J/9kQ6C/F13Tlv/ZsNnfozO+s4a/2FZNwx2pyKbUXMzIdvIAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2VRT1c4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2VRT1c4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64676C4AF62;
	Tue, 18 Nov 2025 19:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763494134;
	bh=eBuvi0lz7rk680A1jcXCHa4rLvZmN4o6j92IZiLwI/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q2VRT1c4n1rixpKNite83ExbyS8wQMj2nmTWXS5fWJHa/zmiAM4HOlpcVUS4VbMk+
	 gW/ac1lCGL+u6K9Q5vtTNE3a799FbYCqsz7vMRnjqOPYFfXsG3bvOtfgychC9o9Cwc
	 tOGDDWDqZdPVWHU6FbAgVjwAYpJ2Cy1dQFAuFPslGD3iEUnq8/FqL42M+YnTG1jDFd
	 tBv5iijAjyI0Va+mMwy3EZ0+ZXHEei176q93/w5LmwepHJHbuheIbzQHTdSpHlE6cP
	 ZxwQAYF/35E6/Y6JjFoJRmYLJ7dTHLgVMDNguNusI7U/y0XL47a8zbJP/zw/ptWGCA
	 5NXAM63Aw438Q==
Message-ID: <a4d58001-4914-4ce2-8116-c07451acd566@kernel.org>
Date: Tue, 18 Nov 2025 20:28:46 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
To: Conor Dooley <conor@kernel.org>,
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mahesh Rao <mahesh.rao@altera.com>,
 Ho Yin <adrian.ho.yin.ng@altera.com>,
 Niravkumar L Rabara <nirav.rabara@altera.com>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1763427266.git.khairul.anuar.romli@altera.com>
 <79a58f075488733cced8eadd566b0b740a59094f.1763427266.git.khairul.anuar.romli@altera.com>
 <20251118-crescent-fritter-9411297ed6eb@spud>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251118-crescent-fritter-9411297ed6eb@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/11/2025 20:07, Conor Dooley wrote:
> On Tue, Nov 18, 2025 at 09:11:42AM +0800, Khairul Anuar Romli wrote:
>> Agilex5 introduces changes in how reserved memory is mapped and accessed
>> compared to previous SoC generations. Agilex5 compatible allows stratix10-
>> FPGA manager driver to handle these changes.
>>
>> Fallback is added for driver probe and init that rely on matching of table
>> and DT node.
>>
>> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
>> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
>> ---
>> Changes in v4:
>> 	- Remove redundant "items - enum" as suggested in v3.
>> 	- Simplify compatible property to use contains instead of oneOf.
>> 	- Validate fallback and non-fallback DT. Also validate binding with
>>           dt_binding_check.
> 
> What are you doing?? You've been told several times exactly what to do
> and yet you keep conjuring up completely random different things.
> Using contains instead of the oneOf construct that was being done before
> is *not* a simplification, it is functionally different.
> 
> NAK. Go do what you were told to do.

There is no single file with that syntax, so I really do not understand
why completely different syntax is reasonable for the author :/

Best regards,
Krzysztof
