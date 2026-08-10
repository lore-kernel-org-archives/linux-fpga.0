Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0CB39F16B;
	Mon, 10 Aug 2026 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346752; cv=none; b=bTZUmkE+Y/vK3mveRX/Pqg9f7DR1yMyNoTF835VCNzOPwgyLM7Pb4y5fWKhsBz9GccywfL+1SiXJqYqzRUgj5hmdZ4RXIb4LJZ0wmrMV6c0ZrquY5sZqkAWtX5koNBc3RpJGn3DAWmRJnYHY4nFIG+4giNcMBcZBh+iJNFAbw+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346752; c=relaxed/simple;
	bh=/mbfP86eEDLuI23RB5qGbHtHMpSESOrHTH4eLTTU5fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbK1s/3Fyyn80ZfW+tC4Lr+c4pbfAANXgnT68qdEosALTRCrut7DZ/1Sdpwk5W0PtP9C22uh63ef0JwlopKexOsrOcK2IU6ZArRH65MCs37/Utpn0MhzWWffXCxp4HAsQYWVBO3aQZsgeTyW1rSsX2sQ8jmX4XwakyWcOlO0QJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxsevtJj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxsevtJj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786346749; x=1817882749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/mbfP86eEDLuI23RB5qGbHtHMpSESOrHTH4eLTTU5fI=;
  b=hxsevtJjZA1Qv5Y+vFiTFw2ACHEuq04sn64ZuviY2+n/TttqLca3aykL
   JOPSIoIU4EbK2bUWg/p6cKePIWDzSFOyNwAnAN1ADHxM8tAkIGQdt1OYP
   7HyQDWWp/5U7squSPTo5m1ObtHrha2uL9yxqe9vsWZaW4awZsIgPs5va4
   OfILZ0wjvXsQmfUPTYq+kG2XbdXlq+J6Kqzq4pyqwQ1jxICNkn1w7Fwsa
   +8nqklMa+W0zRyeR9G6ZmMCAXTeY9LcrQT6BYKTHta0Iv0NtXddG24YUT
   nx/+x/PO2B5aLorq6CS8gQZEBLC4xLyfPV/uQio++Am3CusQNrr4JL3lv
   w==;
X-CSE-ConnectionGUID: Ch95lvDJRM6wBkrMpfHWLw==
X-CSE-MsgGUID: N8Gaza7yRNm4oBlbkaHTiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97450560"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="97450560"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 00:25:44 -0700
X-CSE-ConnectionGUID: 3UwU5KesSKaoENAhwnSZ2Q==
X-CSE-MsgGUID: xklbLO2mTLORTvEyxFu9UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="266450781"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa003.jf.intel.com with ESMTP; 10 Aug 2026 00:25:41 -0700
Date: Mon, 10 Aug 2026 15:25:39 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marco.pagani@linux.dev>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
Message-ID: <anl8891cH+bUfsGY@yilunxu-OptiPlex-7050>
References: <aj53joym0YpoYXWQ@yilunxu-OptiPlex-7050>
 <97739313-fc97-4b11-b2e2-d680621a7fe1@linux.dev>
 <akPZoGCyQW+6+hDX@yilunxu-OptiPlex-7050>
 <5dbd4ac8-a532-4889-bae1-f0bab9a99267@linux.dev>
 <akyyp1GCecWj2Bk2@yilunxu-OptiPlex-7050>
 <417b510f-0f6d-4695-97f5-3fc19b9377b9@linux.dev>
 <amCn8UYdybT+RRnq@yilunxu-OptiPlex-7050>
 <9d4af487-69a7-4a0d-9335-35c3a057de54@linux.dev>
 <anBfAa4LpjbmYHIc@yilunxu-OptiPlex-7050>
 <db7cfe9e-b2ba-4323-bff9-44598e1f70bb@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db7cfe9e-b2ba-4323-bff9-44598e1f70bb@linux.dev>

On Sat, Aug 08, 2026 at 09:35:08PM +0200, Marco Pagani wrote:
> 
> On 03/08/2026 11:27, Xu Yilun wrote:
> 
> >> (i) The base DT (including variant fragments) is built and global
> >> resources are statically resolved at compile time. Then, the resulting
> >> DTB is loaded by the kernel at boot time before userspace is loaded and
> >> can be authenticated (as part of a FIT image) to maintain the chain of
> >> trust.
> > 
> > That helps, thanks.
> > 
> >>
> >> (ii) Once the boot is completed and userspace is running, the kernel
> >> hardware configuration/topology remains safe and locked in place since
> >> there are no interfaces that allow userspace to change it.
> >>
> >> So I think the main advantage of the variants compared to the open DTO
> >> interface is limiting the "blast radius" in case things go wrong.
> > 
> > But I don't think limiting both the functionality and the blast radius can
> > be the target of the uAPI.
> 
> I would see things the other way around: security is a requirement for a
> uAPI rather than a feature.
> 
> I think there is a fundamental asymmetry between the marginal
> convenience of not having to rebuild the base DTB and the massive and
> potentially (semantically) unsolvable burden of securing an open DTO
> interface and ensuring that it will not crash or corrupt the kernel,
> given that most of the infrastructure there is not designed to handle
> arbitrary node changes at runtime.

OK, then we put aside the idea of strict checking of a DTO. But do you
think in which case these kernel DTO interfaces can be used?

> 
> 
> >> If the DT cannot be tampered with, the kernel can still enforce hardware
> >> boundaries (e.g., IOMMU config) that can contain the spill to the
> >> misbehaving region's resources. On the contrary, a single malicious DTO
> >> can compromise the entire kernel with its memory mappings.
> >>
> >> Ultimately, I think the responsibility of authenticating image/bitstream
> >> is outside the scope of the kernel as they are configurations for the
> >> hardware and not the kernel itself. It's up to the device to
> >> authenticate its own firmware, like how reconfiguration engines of
> >> modern FPGA families can already authenticate signed image/bitstreams.
> > 
> > No I don't think so. It's the kernel drivers decision to load the image
> > to HW, authenticate or not authenticate the image, via an HW engine or by
> > software.
> > 
> > Basically you are treating the HW description blob and the HW image blob
> > differently, but I think they are basically one thing that can't be
> > torn apart. If you want security, you must build trust for both the image +
> > the HW description before re-program and re-enumerate.
> 
> I see your point. I think the main challenge here comes from the fact
> that images/bitstreams are not stored in immutable kernel memory buffers
> but rather usually kept in the rootfs like regular firmware files.
> This intrinsically leaves the door open for TOCTOU races and attacks.
> 
> 
> > I remember there was a discussion of accepting a FIT image for
> > re-programming several years ago.
> 
> From a conceptual point of view, I do agree with you. Getting the pair
> {config, image} for each partial image directly from the FIT image at
> boot time (from the buffer passed by the bootloader) and then keeping it
> in kernel memory seems like the most straightforward approach to me as
> well. However, I think the size of practical FPGA images/bitstreams
> forces us to support the /lib/firmware path anyway.
> 
> So I did some digging to see if there have been past attempts to secure
> firmware loading. Indeed, I found some attempts (e.g., [1-3]), but they
> have been all rejected for various reasons, including the fact that a
> malevolent root user can always mess up a device by mapping and
> accessing its register space, and potentially bypass the secure firmware
> loader by directly programming the device to load a malicious firmware.
> 
> As I understand it, the current upstream consensus is that hardware
> devices must be responsible for verifying their own firmware, just as

I totally agree the hardware must be responsible for the firmware image.

> the kernel is responsible for maintaining the safety of its own data
> structures from potential userspace attacks.

That's not just about DT attack, to be consistent to the firmware image
consensus, the vendor FPGA driver should be responsible for the
authentication of the extra DT description, "do whatever it wants with
it if it is signed or not", is it?

To me, I support "it's OK for driver to just apply the DTO if the device
can't do verification". Basically I don't believe the HW image won't
impact the whole system but only DTO do.

But if the no-verification-in-driver is denied, I think the thing we
need to do is to verify the binding between the DT description & image.
After we've verified the DTO & the image is a valid pair, they are not
arbitrary, whatever the DTO does is necessary to the updated hardware.

> 
> If, despite this, there is a requirement to secure /lib/firmware, it
> should be done at the filesystem level using the IMA subsystem [4] that
> would in turn use the TPM (or a firmware running in a TEE) as the root
> of trust.
> 
> For these reasons, while I fully understand your point of view, I am
> hesitant to implement custom FPGA-specific signature checking for the
> RFC. My concern is that even if it is accepted here, it will ultimately
> be rejected as it moves up in the pull requests.

It is possible. To be more efficient, I think we should invite boarder
discussions.

> 
> However, if you still want me to go down the road of securing the
> partial images directly from the FIT image, I'm open to that. For
> instance, we could add an optional sha-512 hash alongside the partial
> image fw name property in each variant node of the base DT, so that the
> FPGA framework can verify the image before programming.

No I mentioned FIT image just thinking if we could verify the signed
binding at runtime. Basically I don't think switching variants is a
meaningful uAPI definition, it is like a workaround to avoid the
real question "when could we use these kernel DTO kAPIs".

> 
> Another alternative could be computing the hash of each of the partial
> images received at boot time from the authenticated initramfs during the
> of-fpga-region probe, and then storing it in its variant struct.
> However, this would require having all images in the initramfs and might
> be impractical on systems with little RAM.
> 
> I think we have a couple of arguments we could use to back it up,
> framing it as a fallback mechanism due to the specificity of FPGA
> devices:
> 
> - Not all FPGA reconfiguration engines support crypto image
>   verification;
> - Not all SoCs/platforms have a TPM IP or support for a TEE;
> - We must guarantee the pair {config, image}.
> 
> Also, with the FPGA variants, the verification phase will only occur
> once during the initial loading and then be skipped if images are cached
> using the "firmware-cached" property, enabling a lean zero-overhead
> reconfiguration flow.
> 
> However, I fear having a custom FPGA-specific verification mechanism
> accepted would be a tough battle. For this reason, I would really prefer
> to keep it as a future extension rather than as part of the initial
> infrastructure for userspace FPGA reconfiguration.
> 
> 
> [1] https://lwn.net/Articles/645823/
> [2] https://lore.kernel.org/all/1431996325-8840-3-git-send-email-mcgrof@do-not-panic.com/
> [3] https://lore.kernel.org/all/20170526030609.1414-2-takahiro.akashi@linaro.org/
> [4] https://lore.kernel.org/all/1455301771-7703-11-git-send-email-zohar@linux.vnet.ibm.com
> 
> 
> Thanks,
> Marco
> 
