Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E148A22576E
	for <linux-fpga@vger.kernel.org>; Sun,  2 Aug 2026 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785706380; cv=none; b=ecZJ3VhrXHnCXi1n5/r//n3ixIn44asEDASaOm6A0AwUVjmGBUM+1cjXTWp8rLzRXM45llBsZ3B0cIpP/mEMaDDesT72gLwZgXSY1HnWT6yDaMq1QVGM8ETER4WpX1rRbUbRubKJ2plqTDC0RN/FYsblxwMxEoKcLh3UGWR39+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785706380; c=relaxed/simple;
	bh=29+zDkd1169JiNN9mVW7h2cO55zMy/ylyYA6N9/WANA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HWrxQOrQSOkzmXJq+Qt9npn+zkVLZYLN3TRft0XjSyanN7rwDE+IDf4TfSBF1LxaDBu5CX2T2H86glM+C+nI3m79ivX77uRpPDCP0l/Y7eho6IkMPyjHG1JuJyeM3apTcQDyGueZSALSw2CA9W7k+91HolpKZ+9X4CAgAZQvhDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QZJmrvwr; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QZJmrvwr"
Message-ID: <9d4af487-69a7-4a0d-9335-35c3a057de54@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785706366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SU38SlPadxakJy7CsYvatzn0/eKmbBCRXn+nTilpwg=;
	b=QZJmrvwrfB16KZ60hFA69T3VyJYgKw7WOI01dVNLJCDF81ZZYSXW1iWhlun37vQczpRXdU
	c7xFKNYlueCiyX3dbKhsVI1/ZU+LV1AnYAORNUHk5yw/IjzNK1oyCCTVWRLKWef96tU+vG
	ltDrYb/gBRQAfWr0nyxarTm3y+wIbRY=
Date: Sun, 2 Aug 2026 23:32:38 +0200
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
Content-Language: en-US
In-Reply-To: <amCn8UYdybT+RRnq@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 22/07/2026 13:22, Xu Yilun wrote:
>> If I understood correctly, your main concern is that having to specify
>> all region variants at boot time is verbose and limiting. I see your
> 
> Yes, that's my concern. We are pursuing a userspace re-programming
> interface for long time. I don't want to easily switch to a whitlist
> based interface, which is as you said verbose and limiting. The DTO has
> vulnerabilities but I'm not convinced yet it can't be secured.

I think the main problem with having an "open" userspace DTO interface
is that it would force the kernel to act as a runtime DT validator,
and this goes beyond the responsibilities of a kernel.

DT validation should be done statically at compilation time (make
CHECK_DTBS=y...) and not burden the kernel at runtime in terms of
compute time and, even more importantly, security. My fundamental
concern is that such a runtime DT validator exposed to userspace
will create a weak spot that every potential attacker will aim for.

On a more subtle level, even if we had a perfect runtime DT validator,
we could still not guarantee security. A malevolent userspace component
could forge a syntactically correct but semantically malicious DTO to
mount an attack. For instance, consider a malicious DTO defining a
smaller dma-ranges (that would pass the DT validator limits check) for
the new node just to force DMA buffer allocation to fail and then mount
a side channel attack. This is really an open-ended can of worms.

In a certain sense, variants can be thought of as a statically defined
and pre-validated list of DTOs. I think this fits better the current
device tree infrastructure that has been designed to handle a static
hardware description that does not change at runtime.

Concerning the verbosity, I think in practice region variants can be
defined as DT fragments (dtsi) without burdening the main dts. These
fragments could be auto-generated by the tooling starting from a
hardware description, like what PetaLinux is already doing to a
certain extent.


>> point. However, I still think that a statically-defined whitelist of
>> variants is the most pragmatic approach, as it guarantees the best
>> security while matching the actual FPGA design phase, where
> 
> I actually still don't understand how static DT can be more secure if it
> references global resources. How could people verify a static DT is
> correctly describing a blob on disk? And the blob can be changed by
> userspace. If no, it still ends up with manipulating global resources
> without reason.

I see your point and agree that neither the variants nor the DTO
interface can prevent a malicious userspace component from swapping
a valid image/bitstream with a rogue one. However, only the variants
approach guarantees the immutability (from userspace) of the kernel's
configuration/topology:

(i) The base DT (including variant fragments) is built and global
resources are statically resolved at compile time. Then, the resulting
DTB is loaded by the kernel at boot time before userspace is loaded and
can be authenticated (as part of a FIT image) to maintain the chain of
trust.

(ii) Once the boot is completed and userspace is running, the kernel
hardware configuration/topology remains safe and locked in place since
there are no interfaces that allow userspace to change it.

So I think the main advantage of the variants compared to the open DTO
interface is limiting the "blast radius" in case things go wrong.
If the DT cannot be tampered with, the kernel can still enforce hardware
boundaries (e.g., IOMMU config) that can contain the spill to the
misbehaving region's resources. On the contrary, a single malicious DTO
can compromise the entire kernel with its memory mappings.

Ultimately, I think the responsibility of authenticating image/bitstream
is outside the scope of the kernel as they are configurations for the
hardware and not the kernel itself. It's up to the device to
authenticate its own firmware, like how reconfiguration engines of
modern FPGA families can already authenticate signed image/bitstreams.


>> reconfigurable regions are floorplanned and synthesized, naturally
>> resulting in a statically-defined set of partial images/bitstreams with
>> their corresponding kernel configurations.

Thanks,
Marco

