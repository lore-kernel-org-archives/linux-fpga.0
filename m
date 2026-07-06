Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E73AF677
	for <linux-fpga@vger.kernel.org>; Mon,  6 Jul 2026 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332342; cv=none; b=gXbPFp1zzrve7te0RModvWTKBSX7IcyleqCZCbFNybtTT+Ch1upHT5q5w6JS2vhpHtaPNNzmXC9Y0awbDcT0wOxR9i8GF4iIMvfDc1Pemtgybv17uNG1U+FWYBvi/vyFO4Sadz57vYDWFjQufohzHw/p4WQvaQ+EvncFeXEomZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332342; c=relaxed/simple;
	bh=OXJsAxGVHGpcuoa4z98yjYVYUJBK2UGNTT1Sb0tHqRY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uCLPBTNXacXZ23slMfpt/tWYCUrWAoFB33MrNHMlIeTjKOlJRRNuOyI1CfzQcoN8FoEUcgBW4zD88H9ZGedo1aBukz9G6AL7aeHFjQexKMN1SMcWiK/e6YYjVa+pP2T4r4bCQ+K6e/Ee7FnYJVssYV/gbR8/mEHpUQQEH9SdzZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qwmGgnFD; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qwmGgnFD"
Message-ID: <5dbd4ac8-a532-4889-bae1-f0bab9a99267@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783332328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPGU2HHyXR/7TL5r/vVDzQnKTf4THbhKoj1Er2af7RQ=;
	b=qwmGgnFD6maHzuFdiu7L4ZjKu41iOjNQLUQxqISuUaBAOGYvCHykzp03oGFGeHizLNPwgB
	J5P3nbLmC+Tst+YUT3ucBTF6HpRRKnX1OZK1hOxmIcKBP0btHlLmIvMhWnNkQlqnJX/dg7
	QydBFiqUKsgFStOBvUSdhyx7OrpVoAs=
Date: Mon, 6 Jul 2026 12:05:24 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Marco Pagani <marco.pagani@linux.dev>
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260608164247.1998417-1-marco.pagani@linux.dev>
 <aj53joym0YpoYXWQ@yilunxu-OptiPlex-7050>
 <97739313-fc97-4b11-b2e2-d680621a7fe1@linux.dev>
 <akPZoGCyQW+6+hDX@yilunxu-OptiPlex-7050>
Content-Language: en-US
In-Reply-To: <akPZoGCyQW+6+hDX@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 30/06/2026 16:58, Xu Yilun wrote:
> On Tue, Jun 30, 2026 at 11:39:50AM +0200, Marco Pagani wrote:
>>
>>
>> On 26/06/2026 14:58, Xu Yilun wrote:
>>> On Mon, Jun 08, 2026 at 06:42:45PM +0200, Marco Pagani wrote:
>>>> This RFC proposes a proof-of-concept implementation of FPGA region
>>>> variants, a mechanism that introduces a common way to handle
>>>> dynamic partial reconfiguration from userspace. The proposed approach
>>>
>>> There are many threads talking about userspace reconfiguration, the
>>> latest one is this:
>>>
>>> https://lore.kernel.org/linux-fpga/20250519033950.2669858-1-nava.kishore.manne@amd.com/
>>>
>>> Before we dive into detail, could you help tell why the previous one
>>> won't work so we must switch to the new interface.
>>
>> I think that Nava's latest RFC and older proposals for userspace FPGA
>> configuration are in effect functionally equivalent to Antoniou's RFC
>> for runtime DT changes via ConfigFS. In other words, they get around
> 
> I think it is different. Arbitrarily changing any hardware is
> problematic, it doesn't align with how the hardware works. But changing
> the hardware inside an FPGA region is exactly the functionality of an
> FPGA. As long as we stay within the scope of fpga_region, I don't see
> the immediate problem.

I agree that changing the hardware is the normal use case for FPGA.
However, my point is that allowing userspace to arbitrarily change the
hardware configuration/topology of the kernel at runtime by loading a DT
overlay through ConfigFS opens a considerable attack vector, and this is
what led to Antoniou's RFC being rejected in the first place.

>> the limitations of the current mainline kernel by using a different
>> implementation of the same core idea behind Antoniou's RFC, but do not
>> address the fundamental concerns that led to it being NACKed.
>>
>> Concerning Nava's latest RFC, scoping the ConfigFS entry point to
>> /sys/kernel/config/fpga_region/ does not change the underlying code path
>> in the kernel and leaves the same attack vector open. Userspace can
>> still load any arbitrary hardware configuration at runtime and mess up
>> with registers, clocks, DMA mappings, etc. to attack the kernel from
>> "below" accessing potentially sensitive memory areas.
> 
> If the implementation does go outside fpga_region, fix it.

My understanding is that Nava's RFC already scopes the configuration to
/sys/kernel/config/fpga_region/. However, that would still leave the
attack vector open. A malevolent userspace component could still load a
malicious DT overlay with a rogue "ranges" property to access kernel
memory or a rouge "dma-ranges" property to hijack a legitimate IP for
the same purpose, or it can mess with the clock configuration. It also
worth considering that DT changes are applied to the global kernel
hardware configuration and cannot be sandboxed to the specific FPGA
region. The root of the problem is that we cannot check and guarantee
at runtime that an arbitrary DT overlay is sane and affects only its
specific FPGA region.

>>
>> Conversely, this RFC addresses these concerns by constraining possible
>> configurations to a limited and statically-defined set that can be
>> authenticated as part of the DT at boot time to maintain the chain
>> of trust. This is in accordance with the kernel's security model
> 
> I'm not sure why a DT at boot time could be verified as trusted while a
> runtime overlay can't. Root of trust has anything to do with boot time
> or runtime?
> 
> Or do you mean a DT boot time authentication could ensure the DT
> description exactly match the content of a bin file (variant1-image.bin)
> on disk, how?

I mean, the base DT of a system can be authenticated at boot-time
using a signed FIT image. Since FPGA variants are statically defined
within the base DT, their configurations are also authenticated
(together with the kernel) to maintain a chain of trust. However, I
think the main benefit of the variants approach is that it guarantees
better security and practicality by default, even without boot image
authentication, as it leaves no doors open for userspace to modify the
kernel hardware configuration/topology.

On the contrary, while runtime DT overlays could theoretically be
secured, enforcing mandatory signature verification for every DTBO
loaded through ConfigFS at runtime is highly impractical as it
introduces key-management complexities that would make the approach
cumbersome for many use cases. Conversely, leaving the interface as
it is now in Nava's RFC fundamentally trusts userspace to dynamically
change the kernel's hardware configuration/topology, and this again
leaves the attack vector open.

>> which holds that userspace cannot be trusted to define hardware.
> 
> I'm not sure, my understanding is FPGA programing is much like firmware
> loading, whose correctness/trusty can't be ensured by kernel security
> model. Only cryptography can help. Without crypto, kernel still loads
> the selected binary, if it corrupts, let it corrupt.

It is true that the kernel allows to load arbitrary firmware blobs at
runtime. However, those are for configuring/programming only the device
hardware and not for the kernel itself. What is particularly dangerous
with runtime DT overlays is that they can change not only the device's
firmware/image but also the kernel configuration/toplogy itself.
A single malicious DT overlay can compromise the entire kernel and
hence the system, not just the FPGA fabric.


Thanks,
Marco
