Received: from mta0.migadu.com (out-39.mta0.migadu.com [91.218.175.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B313E40F3
	for <linux-fpga@vger.kernel.org>; Thu, 24 Sep 2026 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270460; cv=none; b=Ttnm98uOss9wE2BuQHkBv0wI32Bo6OQTp2nAcoka5ts2HRhDeO+U6qcR94pFc3034KX1jzQdZEu31aDaEl/qIk3KWyRdvgacOj44DVbjahiYd82ptACNYqlLzokKvj1rpSYR5z51mruVX0+I3oT53yksFn14HTYxzf9mcaljiT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270460; c=relaxed/simple;
	bh=sTNDwUAQ6ymnymzDVj7cT8nViTfrekFPjMOFnnzmFck=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Iy2nXLcjz+asu8LDad7oXZMxFJQH5bVBiRBU4t/r2elThRhXr/0aGBTXpDtKl+DIm2mmOFgGpg4sda1HGXz4wmKvL1N2ojQThocPdp5ItpBGwksnVtjguJnQXT0kV3zFbQ7F7TjPQEduJrVNxBX82TFYc6pebCWdZqXgj/y6m7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QbMhbGML; arc=none smtp.client-ip=91.218.175.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QbMhbGML"
X-Envelope-To: linux-fpga@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sTNDwUAQ6ymnymzDVj7cT8nViTfrekFPjMOFnnzmFck=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790270456; v=1; x=1790875256;
 b=QbMhbGMLuBeny+/9cOD5tdicUnvOQlKBjIKK5e8rz9IYjYGH8/NYHb0NFvaL7zimtC5s5OVo
 taVJBM6+Wt1pD6iH2/xcwJl5ZVKuXJlySbAovUSTCscH/jJdxO4wyu0bRtCv5p0CuKdvGBU6/iI
 yhnokCbK5crZ5jG/tdd+jH5g=
X-Envelope-To: linux-fpga@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dac7283424669a5a;
	Thu, 24 Sep 2026 17:20:46 +0000
X-Mizu-Trace-ID: dac7283424669a5a
X-Migadu-Flow: FLOW_OUT
Message-ID: <67625511-d352-4196-8765-1557c200afbd@linux.dev>
Date: Thu, 24 Sep 2026 19:20:45 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marco Pagani <marco.pagani@linux.dev>
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Xu Yilun
 <yilun.xu@linux.intel.com>, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 <12839ca0-cb1d-41da-9e48-bbec59ebf230@linux.dev>
 <CAL_Jsq+XUzJaEY6euyZjqhnwhu1U1u7owU40BKnvadueArwmkA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAL_Jsq+XUzJaEY6euyZjqhnwhu1U1u7owU40BKnvadueArwmkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23/09/2026 18:57, Rob Herring wrote:
> On Wed, Sep 23, 2026 at 11:43 AM Marco Pagani <marco.pagani@linux.dev> wrote:
>>
>>
>>
>> On 23/09/2026 17:09, Krzysztof Kozlowski wrote:
>>> On 23/09/2026 16:30, Marco Pagani wrote:
>>>>
>>>>
>>>> On 18/09/2026 19:36, Xu Yilun wrote:
>>>>> On Fri, Sep 18, 2026 at 05:07:07PM +0200, Marco Pagani wrote:
>>>>>>
>>>>>> Hi Yilun,
>>>>>>
>>>>>> Is it okay with you if I CC the DT people to ask for an opinion?
>>>>>
>>>>> Of course. It's good to know in which case could a DTO be applied.
>>>>>
>>>>> But to be clear, I think that only affects how we accept and apply the
>>>>> image-DTO pair. For now, I basically don't want a varient selection
>>>>> interface.
>>>>
>>>>
>>>> Hello Rob, Saravana, Krzysztof, Conor,
>>>>
>>>> I'm CC-ing you on this thread as OF/DT maintainers to kindly ask
>>>> for your input on this debate we are having about how to implement
>>>> userspace FPGA reconfiguration, an important feature currently
>>>> lacking in mainline kernel.
>>>>
>>>> https://lore.kernel.org/all/20260608164247.1998417-1-marco.pagani@linux.dev
>>>>
>>>> To recap: modern FPGAs allow portions of the fabric to be reconfigured
>>>> at runtime to dynamically swap soft IPs. Usually, these IPs are
>>>> connected through a non-discoverable on-chip bus like AMBA AXI.
>>>> From a kernel perspective, this means the FPGA device configuration
>>>> image (bitstream) must be paired with a DT fragment that describes
>>>> the new topology.
>>>>
>>>> In this thread, we are essentially debating between two approaches for
>>>> implementing FPGA userspace reconfiguration at runtime:
>>>>
>>>> - Statically defined Variants (this RFC): Userspace can change FPGA
>>>>   configuration by selecting from a pre-validated set of variants
>>>>   (DT fragments) baked into the base DT.
>>>
>>> I don't know what DT fragments are, maybe you meant overlays? But they
>>> are not baked into the base DT.
>>>
>>> There are no bindings here and no DT maintainers were CCed on this RFC,
>>> so I really do not get how this patch can enable something like that.
>>>
>>> Linked URL shows some undocumented ABI, so obviously this would be a no
>>> go. And RFC prefix does not justify undocumented ABI. At least one
>>> without clear explanation in the cover letter, why is this RFC and why
>>> it cannot be merged/reviewed.
>>
>> Sorry, I couldn't have imagined that missing ABI documentation in a
>> "proof of concept" RFC would be so detrimental while asking for a
>> high-level opinion.
> 
> I think the point is the RFC needs to say why it can't be merged.
> Otherwise we have to guess no documentation is because you don't know
> that's a requirement or because it is an RFC.

Fair point. I mistakenly assumed that the content of the message and the
RFC being framed as a "proof of concept" would have made it clear that I
was just asking for a high-level opinion.

During the discussion with Yilun, we also touched on other important
topics, like how to safely pair the DT "descriptions" with the
images/bitstreams to avoid TOCTOU races.

My intent was to collect some constructive feedback on these topics and
extend the discussion to other developers and maintainers before investing
further effort into this.


>>>> - Runtime DTOs (Nava's RFC): Userspace can change FPGA configuration
>>>>   by loading DTOs that are validated at runtime.
>>>
>>> If runtime overlays were working, this looks suitable to the problem of
>>> runtime change of the hardware. This also fits hot-pluggable hardware
>>> problem, which Bootlin is working on.
> 
> Overlays were the plan when FPGA regions were added to the kernel. Not
> sure why that never happened. I would suggest you go read any
> discussions from that.

I spent a considerable amount of time reading related discussions
on the mailing list, before and after sending the RFC, as it can be
seen in the discussion.

https://lore.kernel.org/linux-fpga/97739313-fc97-4b11-b2e2-d680621a7fe1@linux.dev/
https://lore.kernel.org/linux-fpga/db7cfe9e-b2ba-4323-bff9-44598e1f70bb@linux.dev/

The historical pushback against userspace overlay interfaces motivated
by security, resource management, and kernel stability concerns
is exactly what led me to experiment with the statically pre-validated
region "variants" in the first place.

> From: Rob Herring @ 2017-10-18 15:44 UTC:
> [...]
> The issue remains that the kernel is not really setup to deal with any
> random property or node to be changed at any point in run-time. I
> think there needs to be some restrictions around what the overlays can
> touch. We can't have it be wide open and then lock things down later
> and break users. One example of what you could do is you can only add
> sub-trees to whitelisted nodes.

> From: Frank Rowand @ 2017-10-19 21:46 UTC
> [...]
> I would state that somewhat differently.  :-)  There is very little
> code that is aware of overlays, and most code assumes the device tree
> does not change after early boot.

https://lore.kernel.org/all/CAL_JsqKR3Jg+tgZr4xGPtcWnZW7ng741YjuyUFaS2SXKXbxGtg@mail.gmail.com/

The FPGA "variants" proposed in this RFC are essentially statically-defined
whitelisted nodes.

I see that "DT addon" mentioned by Krzysztof is the preferred solution,
but I still think a static approach is preferable for FPGA since the set
of bitstreams for an FPGA region is finite and statically defined at
design time. I think there is a fundamental asymmetry between the
marginal convenience of not having to rebuild the base DTB and the
burden of securing a DTO interface.


>> Glad to know the problem is already being solved.
> 
> Not sure I'd go that far. There are plenty of areas that need
> help/attention. And I don't like merging new things with only one user

I completely understand. However, the general idea behind variant regions
was to introduce a common way to handle partial reconfiguration from
userspace. In the proof-of-concept RFC, I extended of-fpga-region to
implement variants in a statically-defined way because it was a relevant
case, but the mechanism was designed to be eventually implemented also for
other FPGA regions.


> because every time I do that, someone comes along right after wanting
> something a bit different...
> 
> Rob


Thanks,
Marco
