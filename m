Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7A480353
	for <linux-fpga@vger.kernel.org>; Tue,  7 Jul 2026 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783460997; cv=none; b=PLDTF6d/bORvXVIpUrCzIsOcc7nApzxA3VAGVmzoyJRc6+EugSIkWQUyHSonCHDhk7BFMen+EXxNVVotMyt/1bLaFSsJAV9LDLAZXnlPtRWPbDT8SlM/FLYJQ9/N/qHJFEdjK3omdIyu/DCv35NsWxBYzcC7+81Pf04tkMli7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783460997; c=relaxed/simple;
	bh=zJLdO+dt45UTFcxqCrDYNMxtHpfAf3vAG6EIUSioknc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XLJ8Pqh5LHY66WmffKThZdI0X1FhViJxUaVCjrcru3Dbkk7WojXSlvxXKpgLjyUKfksr4GMyIHHJRRXEYy1N6Zm1dkf3SFkTp5pAE2mu5Mfm/Xj3lsZ5qv9FtfoDcZy5+B6fKxcfMKRWjcBcJR0xTBmX7mraoD/ELlzuu7Wt+WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DYOwHf/S; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DYOwHf/S"
Message-ID: <417b510f-0f6d-4695-97f5-3fc19b9377b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783460984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5mUFHMcwBWohKRFydgb/MLqEdQdGDZ8fPsOZhVhG3w=;
	b=DYOwHf/SbQKwXwx1cwXfFxH6za7y343YJvlsgLzh+KALZm6d+Miliv+XxX/Yw3FdniIYOz
	Ydi1b2n/zDM8wUSzCqk0jzEkoquUO0pg7Jj3UG/h8tp7QWcKWtG57m3dmhUOnKTysiDT9z
	2DSARHSeXFAg/gZk7IfyDK6b6vU4w1o=
Date: Tue, 7 Jul 2026 23:49:27 +0200
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
Content-Language: en-US
In-Reply-To: <akyyp1GCecWj2Bk2@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 07/07/2026 10:02, Xu Yilun wrote:
>> My understanding is that Nava's RFC already scopes the configuration to
>> /sys/kernel/config/fpga_region/. However, that would still leave the
>> attack vector open. A malevolent userspace component could still load a
>> malicious DT overlay with a rogue "ranges" property to access kernel
>> memory or a rouge "dma-ranges" property to hijack a legitimate IP for
>> the same purpose, or it can mess with the clock configuration. It also
>> worth considering that DT changes are applied to the global kernel
>> hardware configuration and cannot be sandboxed to the specific FPGA
>> region. The root of the problem is that we cannot check and guarantee
>> at runtime that an arbitrary DT overlay is sane and affects only its
>> specific FPGA region.
> 
> I see. So your concern is the DT overlay can impact the outside world by
> referencing global nodes. My idea is, if we could statically specify the
> fpga-region with these assigned resources, no updating of these static
> properties, and don't allow global referencing phandle, we are good?

I think I see what you mean: since the hardware interface of the region
is fixed and defined during the design phase, we could enforce the
resource boundaries (e.g., ranges, dma-ranges, interrupts, clocks, etc.)
defined in the base DT. This is certainly true. However, I think the
fundamental problem is that safely enforcing these boundaries in-kernel
at runtime remains very challenging.

As far as I know, there isn't a way to sandbox changes made by
of_overlay_fdt_apply(), as it simply digests what it is fed and applies
it globally against the live tree. Therefore, we would need to add a
runtime DT verifier that parses and validates DTO blobs, before calling
of_overlay_fdt_apply(), to ensure that they don't contain rogue global
phandles, and touch only nodes defined in the region. Adding such a
runtime DT verifier seems to me an over-complicated and inherently
fragile approach. Moreover, it can add a weak spot that attackers might
constantly attempt to exploit. Ultimately, I think that a static
whitelisting approach carries many benefits in security, simplicity, and
maintainability over building and maintaining a runtime verifier directly
exposed to userspace.

> I mean we don't have to verbose on every combination of hardware that a
> user might load. We harden the boundaries of the resources (ranges,
> dma-ranges, ...) that are initially designed for the fpga-region in base
> DT. To me, this seems to be more aligned to "DT describes the HW" and
> how the FPGA works.

If I understood correctly, your main concern is that having to specify
all region variants at boot time is verbose and limiting. I see your
point. However, I still think that a statically-defined whitelist of
variants is the most pragmatic approach, as it guarantees the best
security while matching the actual FPGA design phase, where
reconfigurable regions are floorplanned and synthesized, naturally
resulting in a statically-defined set of partial images/bitstreams with
their corresponding kernel configurations.


Thanks,
Marco
