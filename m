Received: from mta1.migadu.com (out-158.mta1.migadu.com [95.215.58.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E416B379981
	for <linux-fpga@vger.kernel.org>; Wed, 23 Sep 2026 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173852; cv=none; b=ObTyVAnXr4aqB0U6PlSLU3Y1ReY9h9jBTB8WJM95mP2kdexf/t5rEnDKkZ0MDHTF3kmRnh09HJ8PTni4EpZlTH+RahGRpfsoD1gSeyI3YQ84JHUxZJUUF30gKEoGXx0XC1Bb1JofwLGsRoTFG43MrboEACV8gO596cQjBupj1+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173852; c=relaxed/simple;
	bh=b6ZBHffUU1kQW7t5E42xHCf7V8PqDJJijxTKcey/Qe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BG8T3BoGTsjW+8bRKJw/xsox/G1ucE1xeOC2ckqMsL6JdigNtn45sIVDvuLBMXS+A4RVWJ20vcLN/ZoH64AncrlaDCGHE14KnBjaH7fmFR95e79GCe86cV8nStzjrusvBAMSLhgF6rcrHd54b4IBgc6RKIPgozJJnSKchZi/RUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CEFw0t+s; arc=none smtp.client-ip=95.215.58.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CEFw0t+s"
X-Envelope-To: linux-fpga@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=b6ZBHffUU1kQW7t5E42xHCf7V8PqDJJijxTKcey/Qe0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790173847; v=1; x=1790778647;
 b=CEFw0t+sSSYZ18s8Ns83dY9xXsLJlRcST2FEeiCltERMntl4VCTroZnrsX82+KRsxhmGoCB3
 xzcUbgPcKVPEusIOuKaLjv/gbVZD4VP6nVXaydLO1DPq+AqWnxQx01/+GNgx/XaxW9hknHpmXvY
 RJv4/okjP4eCEnHI5++X/J1A=
X-Envelope-To: linux-fpga@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 08c87b445fde2718;
	Wed, 23 Sep 2026 14:30:47 +0000
X-Mizu-Trace-ID: 08c87b445fde2718
X-Migadu-Flow: FLOW_OUT
Message-ID: <2adefc6f-328c-4683-8cba-091d9f3425ab@linux.dev>
Date: Wed, 23 Sep 2026 16:30:42 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
To: Xu Yilun <yilun.xu@linux.intel.com>
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
Content-Language: en-US
From: Marco Pagani <marco.pagani@linux.dev>
In-Reply-To: <aq12s+hUVnnvCKmZ@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/09/2026 19:36, Xu Yilun wrote:
> On Fri, Sep 18, 2026 at 05:07:07PM +0200, Marco Pagani wrote:
>>
>> Hi Yilun,
>>
>> Is it okay with you if I CC the DT people to ask for an opinion?
> 
> Of course. It's good to know in which case could a DTO be applied.
> 
> But to be clear, I think that only affects how we accept and apply the
> image-DTO pair. For now, I basically don't want a varient selection
> interface.


Hello Rob, Saravana, Krzysztof, Conor,

I'm CC-ing you on this thread as OF/DT maintainers to kindly ask
for your input on this debate we are having about how to implement
userspace FPGA reconfiguration, an important feature currently
lacking in mainline kernel.

https://lore.kernel.org/all/20260608164247.1998417-1-marco.pagani@linux.dev

To recap: modern FPGAs allow portions of the fabric to be reconfigured
at runtime to dynamically swap soft IPs. Usually, these IPs are
connected through a non-discoverable on-chip bus like AMBA AXI.
From a kernel perspective, this means the FPGA device configuration
image (bitstream) must be paired with a DT fragment that describes
the new topology.

In this thread, we are essentially debating between two approaches for
implementing FPGA userspace reconfiguration at runtime:

- Statically defined Variants (this RFC): Userspace can change FPGA
  configuration by selecting from a pre-validated set of variants
  (DT fragments) baked into the base DT.

- Runtime DTOs (Nava's RFC): Userspace can change FPGA configuration
  by loading DTOs that are validated at runtime.

Could you share your thoughts on this? In your opinion, which one of
these two approaches aligns better with the DT infrastructure and
general kernel design philosophy?


Thanks,
Marco
