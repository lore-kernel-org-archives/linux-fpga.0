Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD54721420B;
	Thu, 20 Nov 2025 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656928; cv=none; b=ASj2+eaZwKrRR5FZ98cNqZDtrtiVomPRbfigv9EIO5nNdYJrOEq9u6rdknAjdiyqCgCORpal2mJ1rcpRHUnmUnC5splZiD/7U4uLIoyS8oYvQLM7Olq4P4pRb/Oi/83yqsc1G/Z1y0CIKzgcJaDvwx9hn3ULoytCRRDzYctsX1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656928; c=relaxed/simple;
	bh=BQP+9HU7UWNgB/djzj1McvUO3gPv8nbsXKf9BZ3fi7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npxblSu9V5kAm8KFg7KfInb9SUYT3MsJatWJRZnaAK+8IiEkkPJtPg3rYrx9DJBttQ7tcYqExqObPUd5aYTPwrOKyKJjCqhjhqkRc4ShVqYLEDmVOUugzNSK9w6VsIY9c2zkcci+xLIr6Q0BWDCR6CKNlD3Bkv4S58G5xX6H0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbQek0xr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbQek0xr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CE3C4CEF1;
	Thu, 20 Nov 2025 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763656928;
	bh=BQP+9HU7UWNgB/djzj1McvUO3gPv8nbsXKf9BZ3fi7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cbQek0xr4M7MQTwD1n+bMQcG7FMlRoGJ0l0Q/razRsVRM4h99Lt9QDFLMEnBsKBHv
	 vydTBMSItxQJ8o+wJQT62QTNCekIsoNbdOCjA+hDV98vKThwSjw1FMD6vol8qx1po1
	 iU4dIC8LrAtY9S4D1nrlXEkNcZes97k2VuW0LvasXUbgstwagdiDOR5Hzrtc5MeCUL
	 tgtKfQFP93wAJItSYPxJFGLqWFW65fEDJbhz/+/eoeimOhhsXNusA5sJHZnS4aOHYB
	 T//IqbyguQgGrWjaafxpwewWw81whTgVZ9dV0GAh7JPQm6mo41BYG3Cbk+2TsVLF7Y
	 Oa/asVBPKdiYQ==
Message-ID: <d05daf50-dee2-4fb9-a4b4-4ef68edfe384@kernel.org>
Date: Thu, 20 Nov 2025 17:42:03 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dt-bindings: fpga: Add Efinix SPI programming
 bindings
To: Ian Dannapel <iansdannapel@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org, mdf@kernel.org, yilun.xu@intel.com,
 trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, neil.armstrong@linaro.org, mani@kernel.org,
 kever.yang@rock-chips.com, dev@kael-k.io
References: <20251119184708.566461-1-iansdannapel@gmail.com>
 <20251119184708.566461-3-iansdannapel@gmail.com>
 <f65506e6-ac29-449e-86b3-540c23ca6119@kernel.org>
 <CAKrir7hCGEdwZihgV8-JaXq1EbzQCvpJXcG_FEmDYEoJqUpbcg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAKrir7hCGEdwZihgV8-JaXq1EbzQCvpJXcG_FEmDYEoJqUpbcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/11/2025 16:55, Ian Dannapel wrote:
> Hello Krzysztof,
> 
> On Thu, Nov 20, 2025 at 3:13 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - efinix,trion-spi
>>> +      - efinix,titanium-spi
>>> +      - efinix,topaz-spi
>>
>>
>> Nothing improved. You received comments about this - twice or more even
>> - so I feel like you just don't care about review.
> Sorry I am lost here, this is based on a similar driver, but it is
> probably very outdated.
> So the fallback pattern would be okay? Eg:
> items:
>       - enum:
>           - efinix,trion-config
>           - efinix,titanium-config
>           - efinix,topaz-config
>       - const: efinix,fpga-config
> Or would a single compatible be better since currently from the
> drivers perspective there is
> no difference in hardware?

Almost, because I think you asked about this and I instead asked to use
one specific device as the fallback. Choose the oldest device and use it
the fallback for two others. There is plenty of examples - including
example-schema - using it with oneOf syntax.

Best regards,
Krzysztof
