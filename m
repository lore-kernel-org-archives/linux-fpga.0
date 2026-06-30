Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9068D38657D
	for <linux-fpga@vger.kernel.org>; Tue, 30 Jun 2026 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812408; cv=none; b=riaFwb2LZf/feD3zuUAJ7lnOL3mYcnHduygGXIDd9b03ZZMZfUfT5RjiQ5wNwWQpwYNP1yW+Jv8MMHH9suKZlXndzwGXTy1EHyoaGLtlQ6qkE+cnh0gXsJ/y3ykUzaskE4vS7U5Z2XMnIrXU3pHZO5vauCiDc3aQEDMpuaRaE5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812408; c=relaxed/simple;
	bh=LfoszQNARFH/T81K7pSsZArmiZ6G099I6CG/SkFpbaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eU1nnu2iWkkvWXDNwn3ZswzALD3W0ml53EmINzQ6zqc2xoXwWqh3fp2QlXMo9+Y0e154rgr4Zw3MIzmXfBWZmrasM6wX/qTNgkhAz02/IJLLLcsQ8ZN8qrrkfo6e94XdheIVLwqIy2C0Yv4TLhYlOBtI4YMXDq4AGpeCcAHA0tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=St49wi6T; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="St49wi6T"
Message-ID: <97739313-fc97-4b11-b2e2-d680621a7fe1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782812393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkKYj7hw/gGShlX8+BnzV254rC+Y7Ab6I7cW6Vx9xtk=;
	b=St49wi6TC/j0nyb4Bdn+6TnIBxps4GphnZiYmSxRsJvIBWi9oC0cYZpgYLAkA452xXwzSr
	cYRqKwuJAt1SRL4WL51xfybaKAskEJWk/+AslXFjPCW8GOscIje8fEMIsDNlVxnAjt2cBP
	nqXxHLKD67wXTcPE1pj6mn6sQzWFcDw=
Date: Tue, 30 Jun 2026 11:39:50 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260608164247.1998417-1-marco.pagani@linux.dev>
 <aj53joym0YpoYXWQ@yilunxu-OptiPlex-7050>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Marco Pagani <marco.pagani@linux.dev>
In-Reply-To: <aj53joym0YpoYXWQ@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 26/06/2026 14:58, Xu Yilun wrote:
> On Mon, Jun 08, 2026 at 06:42:45PM +0200, Marco Pagani wrote:
>> This RFC proposes a proof-of-concept implementation of FPGA region
>> variants, a mechanism that introduces a common way to handle
>> dynamic partial reconfiguration from userspace. The proposed approach
> 
> There are many threads talking about userspace reconfiguration, the
> latest one is this:
> 
> https://lore.kernel.org/linux-fpga/20250519033950.2669858-1-nava.kishore.manne@amd.com/
> 
> Before we dive into detail, could you help tell why the previous one
> won't work so we must switch to the new interface.

I think that Nava's latest RFC and older proposals for userspace FPGA
configuration are in effect functionally equivalent to Antoniou's RFC
for runtime DT changes via ConfigFS. In other words, they get around
the limitations of the current mainline kernel by using a different
implementation of the same core idea behind Antoniou's RFC, but do not
address the fundamental concerns that led to it being NACKed.

Concerning Nava's latest RFC, scoping the ConfigFS entry point to
/sys/kernel/config/fpga_region/ does not change the underlying code path
in the kernel and leaves the same attack vector open. Userspace can
still load any arbitrary hardware configuration at runtime and mess up
with registers, clocks, DMA mappings, etc. to attack the kernel from
"below" accessing potentially sensitive memory areas.

Conversely, this RFC addresses these concerns by constraining possible
configurations to a limited and statically-defined set that can be
authenticated as part of the DT at boot time to maintain the chain
of trust. This is in accordance with the kernel's security model
which holds that userspace cannot be trusted to define hardware.


>> is safe and aligned with the mainline kernel's stance on hardware
>> management by constraining the hardware to a mutually exclusive set
>> of configurations (variants) defined upfront. This is a realistic
>> assumption for FPGAs, as regions are typically statically defined and
>> synthesized during the system design phase. To keep the architecture
>> realistic, the following additional constraints are introduced:
>> (i) variants cannot be nested, and (ii) variants cannot contain FPGA
>> bridges.
>>
>> The interface and core logic for the variant mechanism are defined
>> in the fpga-region and implemented in a backwards-compatible way.
>> The fpga-region now optionally exports sysfs attributes that allow
>> the user to reconfigure a region that supports variants by selecting
>> one variant a list of pre-defined variants. Concrete regions can enable
>> variant support by implementing the new apply_variant and remove_variant
>> methods and adding them to fpga_region_info before registration.
>>
>> As part of this RFC, the of-fpga-region concrete region has been extended
>> to implement the variant interface. Variants are statically specified in
>> the device tree using an fpga-variants node. Additionally, it introduces
>> a firmware-cached property to cache bitstreams in memory, enabling a fast
>> reconfiguration path for real-time (latency-sensitive) applications.
>>
>> Below is an example of how variants can be statically defined in the
>> device tree under this architecture:
>>
>> fake_mgr: fpga-mgr@0 {
>>         compatible = "linux,fake-fpga-mgr";
>> };
>>
>> fpga_region: fpga-region@0 {
>>         compatible = "fpga-region";
>>         #address-cells = <2>;
>>         #size-cells = <2>;
>>         ranges;
>>
>>         /* FPGA region properties */
>>         fpga-mgr = <&fake_mgr>;
>>         partial-fpga-config;
>>         region-unfreeze-timeout-us = <10000>;
>>
>>         /* Base variant */
>>         base-variant = "variant-1";
> 
> Previously we use DT-overlay file, here we use a list of variants. I'm
> actually not sure why it is safer or better managed. As far as I can
> tell, the only difference is that DT-overlay puts the region descriptions
> in different files/blobs, while your fpga-variant puts them together in
> one file/node, and we switch from choosing a file/blob to choosing a
> string, is it?

For the reasons described above, I think switching from allowing
userspace to load an arbitrary hardware configuration file/blob to
having userspace merely selecting from a pre-authenticated, mutually
exclusive, set of hardware configurations via a string provides
considerable security advantages.

Regarding using the sysfs interface itself, I don't have a strong
opinion. I used sysfs for this RFC since it is a simple approach that is
similar to the one that has already been validated by other subsystems
such as pinctrl. However, I'm open to other alternatives.

Finally, please consider that FPGA variants are not specific or limited
to OF/DT systems. The core of the variants mechanism is generic and
implemented at the region level to remain backward compatible with
existing concrete regions. As part of this RFC, I provided an
implementation of variants for of-fpga-region because it is a relevant
use case for embedded systems.


>>
>>         /* Variants container node */
>>         fpga-variants {
>>                 #address-cells = <2>;
>>                 #size-cells = <2>;
>>                 ranges;
>>
>>                 variant-1 {
>>                         firmware-name = "variant1-image.bin";
>>
>>                         #address-cells = <2>;
>>                         #size-cells = <2>;
>>                         ranges;
>>
>>                         variant_1_ip: ip_1@10000 {
>>                                 compatible = "fake,ip_1";
>>                                 reg = <0x0 0x10000 0x0 0x1000>;
>>                         };
>>                 };
>>
>>                 variant-2 {
>>                         firmware-name = "variant2-image.bin";
>>                         firmware-cached;
>>
>>                         #address-cells = <2>;
>>                         #size-cells = <2>;
>>                         ranges;
>>
>>                         variant_2_ip: ip_2@10000 {
>>                                 compatible = "fake,ip_2";
>>                                 reg = <0x0 0x20000 0x0 0x1000>;
>>                         };
>>                 };
>>         };
>> };

Thanks,
Marco
