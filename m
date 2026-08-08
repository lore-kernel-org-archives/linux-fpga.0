Received: from out-189.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311BA4B0493
	for <linux-fpga@vger.kernel.org>; Sat,  8 Aug 2026 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786217739; cv=none; b=TsIAgHu3gm8KSc+7Yd0Ioy/P83yr3yJ9xhr14Wd6SGkYfdRzazRiEmdXhtIW4wKF4KBmFUTZtUiUOEeDA+rf5YJKNtwrWFc4Gp/fhd0M15Kf7/UXYJLPc55tWWLk67FbGGnbkwxDfs7xKFjoJyXTWt00fWUkjTgMnFMTxoX/BrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786217739; c=relaxed/simple;
	bh=eMBICWRYABGIWXk01SuKmYACZAHOm80uuFLLUB4qO1s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=u2ha6PbKsiNNyNHYJkwH1PdFCpFInOiOA5ysFbHBPdRBRf02J4ZM+9Mxn5vxmi1M8ZFGylF5o3JWwCNuoEfAgglZj6t20SE9lfk1XKVOjI6mk1AdKnNF8K9BNHlfns5euvyc01QJnHgTuJ+o2hbLsqT3Drmt5O0rlNyexBujvHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VEZD1814; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VEZD1814"
Message-ID: <db7cfe9e-b2ba-4323-bff9-44598e1f70bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786217725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRiZjkxTfWOCPrRZOlHo5Mc7kFgFs7LHkQ1VDc9hTR8=;
	b=VEZD18147mHxvnsyPHS4fUVVSCjT0a9t16TsB6G5xRVduhEeShWhKqOBaaiygffE/mSngC
	6QcNej2KUjdQG2ywrWKqpexxsT8+EDynRIeGJn+tlrLPPfxPx2sWnpA2WHTUe6p9vMi5m7
	T1FLzy0SSn0vvxM+yeiX3W3p0g8LPfA=
Date: Sat, 8 Aug 2026 21:35:08 +0200
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
 <5dbd4ac8-a532-4889-bae1-f0bab9a99267@linux.dev>
 <akyyp1GCecWj2Bk2@yilunxu-OptiPlex-7050>
 <417b510f-0f6d-4695-97f5-3fc19b9377b9@linux.dev>
 <amCn8UYdybT+RRnq@yilunxu-OptiPlex-7050>
 <9d4af487-69a7-4a0d-9335-35c3a057de54@linux.dev>
 <anBfAa4LpjbmYHIc@yilunxu-OptiPlex-7050>
Content-Language: en-US
In-Reply-To: <anBfAa4LpjbmYHIc@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 03/08/2026 11:27, Xu Yilun wrote:

>> (i) The base DT (including variant fragments) is built and global
>> resources are statically resolved at compile time. Then, the resulting
>> DTB is loaded by the kernel at boot time before userspace is loaded and
>> can be authenticated (as part of a FIT image) to maintain the chain of
>> trust.
> 
> That helps, thanks.
> 
>>
>> (ii) Once the boot is completed and userspace is running, the kernel
>> hardware configuration/topology remains safe and locked in place since
>> there are no interfaces that allow userspace to change it.
>>
>> So I think the main advantage of the variants compared to the open DTO
>> interface is limiting the "blast radius" in case things go wrong.
> 
> But I don't think limiting both the functionality and the blast radius can
> be the target of the uAPI.

I would see things the other way around: security is a requirement for a
uAPI rather than a feature.

I think there is a fundamental asymmetry between the marginal
convenience of not having to rebuild the base DTB and the massive and
potentially (semantically) unsolvable burden of securing an open DTO
interface and ensuring that it will not crash or corrupt the kernel,
given that most of the infrastructure there is not designed to handle
arbitrary node changes at runtime.


>> If the DT cannot be tampered with, the kernel can still enforce hardware
>> boundaries (e.g., IOMMU config) that can contain the spill to the
>> misbehaving region's resources. On the contrary, a single malicious DTO
>> can compromise the entire kernel with its memory mappings.
>>
>> Ultimately, I think the responsibility of authenticating image/bitstream
>> is outside the scope of the kernel as they are configurations for the
>> hardware and not the kernel itself. It's up to the device to
>> authenticate its own firmware, like how reconfiguration engines of
>> modern FPGA families can already authenticate signed image/bitstreams.
> 
> No I don't think so. It's the kernel drivers decision to load the image
> to HW, authenticate or not authenticate the image, via an HW engine or by
> software.
> 
> Basically you are treating the HW description blob and the HW image blob
> differently, but I think they are basically one thing that can't be
> torn apart. If you want security, you must build trust for both the image +
> the HW description before re-program and re-enumerate.

I see your point. I think the main challenge here comes from the fact
that images/bitstreams are not stored in immutable kernel memory buffers
but rather usually kept in the rootfs like regular firmware files.
This intrinsically leaves the door open for TOCTOU races and attacks.


> I remember there was a discussion of accepting a FIT image for
> re-programming several years ago.

From a conceptual point of view, I do agree with you. Getting the pair
{config, image} for each partial image directly from the FIT image at
boot time (from the buffer passed by the bootloader) and then keeping it
in kernel memory seems like the most straightforward approach to me as
well. However, I think the size of practical FPGA images/bitstreams
forces us to support the /lib/firmware path anyway.

So I did some digging to see if there have been past attempts to secure
firmware loading. Indeed, I found some attempts (e.g., [1-3]), but they
have been all rejected for various reasons, including the fact that a
malevolent root user can always mess up a device by mapping and
accessing its register space, and potentially bypass the secure firmware
loader by directly programming the device to load a malicious firmware.

As I understand it, the current upstream consensus is that hardware
devices must be responsible for verifying their own firmware, just as
the kernel is responsible for maintaining the safety of its own data
structures from potential userspace attacks.

If, despite this, there is a requirement to secure /lib/firmware, it
should be done at the filesystem level using the IMA subsystem [4] that
would in turn use the TPM (or a firmware running in a TEE) as the root
of trust.

For these reasons, while I fully understand your point of view, I am
hesitant to implement custom FPGA-specific signature checking for the
RFC. My concern is that even if it is accepted here, it will ultimately
be rejected as it moves up in the pull requests.

However, if you still want me to go down the road of securing the
partial images directly from the FIT image, I'm open to that. For
instance, we could add an optional sha-512 hash alongside the partial
image fw name property in each variant node of the base DT, so that the
FPGA framework can verify the image before programming.

Another alternative could be computing the hash of each of the partial
images received at boot time from the authenticated initramfs during the
of-fpga-region probe, and then storing it in its variant struct.
However, this would require having all images in the initramfs and might
be impractical on systems with little RAM.

I think we have a couple of arguments we could use to back it up,
framing it as a fallback mechanism due to the specificity of FPGA
devices:

- Not all FPGA reconfiguration engines support crypto image
  verification;
- Not all SoCs/platforms have a TPM IP or support for a TEE;
- We must guarantee the pair {config, image}.

Also, with the FPGA variants, the verification phase will only occur
once during the initial loading and then be skipped if images are cached
using the "firmware-cached" property, enabling a lean zero-overhead
reconfiguration flow.

However, I fear having a custom FPGA-specific verification mechanism
accepted would be a tough battle. For this reason, I would really prefer
to keep it as a future extension rather than as part of the initial
infrastructure for userspace FPGA reconfiguration.


[1] https://lwn.net/Articles/645823/
[2] https://lore.kernel.org/all/1431996325-8840-3-git-send-email-mcgrof@do-not-panic.com/
[3] https://lore.kernel.org/all/20170526030609.1414-2-takahiro.akashi@linaro.org/
[4] https://lore.kernel.org/all/1455301771-7703-11-git-send-email-zohar@linux.vnet.ibm.com


Thanks,
Marco

