Received: from mta1.migadu.com (out-127.mta1.migadu.com [95.215.58.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E1D38B143
	for <linux-fpga@vger.kernel.org>; Wed, 23 Sep 2026 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181801; cv=none; b=fdTMWo/S+gCpN1F76+Hj1u9yCWEXGdsOLaO0XXk0tAJVOEymjKoBVwXcRpc41xG05Qmt1R4+MlTz3gag/TLPcFC11Lq06Qx3DX3YGno9FlobszziTwZdk2Uky7p+PbvlpGTQYm+tUgkmUuccOJf82OFCB+kfVPvwmpbL5XxP71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181801; c=relaxed/simple;
	bh=z5PVQJxayxGeNQifTwwvxx8fDx6857gHo9VSiCt+4cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8emw++3GtihAixp+OGIhTZ9ESoh0NoBXAbMn+6opXaKNWOHTqEOvOCdHaoskTNOez53N6FTQwvlyEBHmP7IyH8rqv4d8RgDMyiBo8WLK9X3sM6/vHZ+JdxAtRCns13QFZ6N0WIuC4MedCTsn2gClK21Sk747tc/tKeo0vI41pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OvHxP9xf; arc=none smtp.client-ip=95.215.58.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OvHxP9xf"
X-Envelope-To: linux-fpga@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=z5PVQJxayxGeNQifTwwvxx8fDx6857gHo9VSiCt+4cY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790181793; v=1; x=1790786593;
 b=OvHxP9xf1DVCchKRxQ/+HFpSC1KOAKXV+Qx3KmfU258EQ4IKCfjd+xF9Wt4DZsdiGhyeOMOy
 nQ10EGSXmBzWVgNUNZUVL4REk6tuU40hESCOvxDXiw8WhbfD8fpstdZJoqjp4BJ37kyWh4qABl5
 qH6rO8Rwk2s+1NEg5YHO5XGs=
X-Envelope-To: linux-fpga@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 64eb0ac43514703d;
	Wed, 23 Sep 2026 16:43:13 +0000
X-Mizu-Trace-ID: 64eb0ac43514703d
X-Migadu-Flow: FLOW_OUT
Message-ID: <12839ca0-cb1d-41da-9e48-bbec59ebf230@linux.dev>
Date: Wed, 23 Sep 2026 18:43:12 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
To: Krzysztof Kozlowski <krzk@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>
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
 <1857df9a-8952-426e-988b-cd05d45a04cc@kernel.org>
Content-Language: en-US
From: Marco Pagani <marco.pagani@linux.dev>
In-Reply-To: <1857df9a-8952-426e-988b-cd05d45a04cc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/09/2026 17:09, Krzysztof Kozlowski wrote:
> On 23/09/2026 16:30, Marco Pagani wrote:
>>
>>
>> On 18/09/2026 19:36, Xu Yilun wrote:
>>> On Fri, Sep 18, 2026 at 05:07:07PM +0200, Marco Pagani wrote:
>>>>
>>>> Hi Yilun,
>>>>
>>>> Is it okay with you if I CC the DT people to ask for an opinion?
>>>
>>> Of course. It's good to know in which case could a DTO be applied.
>>>
>>> But to be clear, I think that only affects how we accept and apply the
>>> image-DTO pair. For now, I basically don't want a varient selection
>>> interface.
>>
>>
>> Hello Rob, Saravana, Krzysztof, Conor,
>>
>> I'm CC-ing you on this thread as OF/DT maintainers to kindly ask
>> for your input on this debate we are having about how to implement
>> userspace FPGA reconfiguration, an important feature currently
>> lacking in mainline kernel.
>>
>> https://lore.kernel.org/all/20260608164247.1998417-1-marco.pagani@linux.dev
>>
>> To recap: modern FPGAs allow portions of the fabric to be reconfigured
>> at runtime to dynamically swap soft IPs. Usually, these IPs are
>> connected through a non-discoverable on-chip bus like AMBA AXI.
>> From a kernel perspective, this means the FPGA device configuration
>> image (bitstream) must be paired with a DT fragment that describes
>> the new topology.
>>
>> In this thread, we are essentially debating between two approaches for
>> implementing FPGA userspace reconfiguration at runtime:
>>
>> - Statically defined Variants (this RFC): Userspace can change FPGA
>>   configuration by selecting from a pre-validated set of variants
>>   (DT fragments) baked into the base DT.
> 
> I don't know what DT fragments are, maybe you meant overlays? But they
> are not baked into the base DT.
> 
> There are no bindings here and no DT maintainers were CCed on this RFC,
> so I really do not get how this patch can enable something like that.
> 
> Linked URL shows some undocumented ABI, so obviously this would be a no
> go. And RFC prefix does not justify undocumented ABI. At least one
> without clear explanation in the cover letter, why is this RFC and why
> it cannot be merged/reviewed.

Sorry, I couldn't have imagined that missing ABI documentation in a
"proof of concept" RFC would be so detrimental while asking for a
high-level opinion.


> 
>>
>> - Runtime DTOs (Nava's RFC): Userspace can change FPGA configuration
>>   by loading DTOs that are validated at runtime.
> 
> If runtime overlays were working, this looks suitable to the problem of
> runtime change of the hardware. This also fits hot-pluggable hardware
> problem, which Bootlin is working on.

Glad to know the problem is already being solved.


Thanks,
Marco
