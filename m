Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8729B3EBF32
	for <linux-fpga@vger.kernel.org>; Wed, 18 Feb 2026 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771380234; cv=none; b=V6ewO+15P3JvZSAf1I9OREZ1cF7B5T4RPQzHYLuk6weyGVG7fUmvarwugIfT4DwbuvOWAuvqHxy8+h1fy/4n0FqPFHe5Q2Um78t64ErjITk30uvtAN83ZnGmA1Qt1PxuiFNOLpThwwvhpEQj8csVV2y2kJJWBtguS7m367W48n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771380234; c=relaxed/simple;
	bh=PUEtUvlnxfRwbku097xynciK1P/oSr9Kiu2SbUO2/mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNkZ3bs+TGK3su3qBd5apQCrC8fN9gm2Oy5CUoljCd8whrmnCKd8b/yTw5Y2I/mM35ki5Srd1mpedolJROxHm1C1U5MpHyvp2x9g8wv7EQLCyr7wunSkKTxr2f0PDh7A7LCOETjuhVCCQu2QUJ+4NK4XFj3RsObs1gttf9Ap2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3Cq/OUm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWy+wtxm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3Cq/OUm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWy+wtxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771380231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4cHvKSBZESAOv4yzpaqvORLgvpDRThGyDvq3HOoF2s=;
	b=L3Cq/OUmE39lqbDMi4RD6vO0nKtNjMPE/ztjEMWsLNVlvhTOqH32r9XGzP0KVBn0aRAxFL
	ECWwUisKahCsLGqWNef6y4+tDeZl1lkLIBUtMqQnU21mpb2qa6F7gP0gTMVMYLcLDLChC5
	RNeehsEWsOmhFqPRegVtRrvWEoWC158=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-ptowoZhKN_qihykuREq7Vw-1; Tue, 17 Feb 2026 21:03:50 -0500
X-MC-Unique: ptowoZhKN_qihykuREq7Vw-1
X-Mimecast-MFC-AGG-ID: ptowoZhKN_qihykuREq7Vw_1771380230
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-896f84e69b6so726247326d6.0
        for <linux-fpga@vger.kernel.org>; Tue, 17 Feb 2026 18:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771380230; x=1771985030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4cHvKSBZESAOv4yzpaqvORLgvpDRThGyDvq3HOoF2s=;
        b=YWy+wtxmB0bLqsN7dnF5fxttInQrdOCeHQdYzNDBMe8JTFqaSi1PMTChdpWqeltjxH
         RPdTzO9Ub3DILfh+YFLW/PtTN8nXkcfqnr+b0dfKdxjQSs0W7d2pqn3V/2nRPG/Ie8vo
         jgyza9poN9/KNMeCLoTyGRTS8ZQaVl8SvYV3Pvgihyow+EB8FEP98Pk27PlHY00tff/V
         +8S8jZ16WTombYS9c3X9B82idlrc/ddh1DjOvjLx2AuiXibL8RjbdELtqetsrd9uGW+2
         gAk7S1XPPYVeWP3seHpoP4fnhU4J6kZ4awz7v0l15kcxK0MmkdVQGaHjtsV+ET2RlrVB
         j1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771380230; x=1771985030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4cHvKSBZESAOv4yzpaqvORLgvpDRThGyDvq3HOoF2s=;
        b=bBb/WczmaJInN9oKTQN+pEsxbgACyJeHOimaBRrlzBplvnVrnBUipIKnMRoLQZH4D+
         QstbYHcv/R1IMboKPMSRAgypxqHoQZZSOhIzA2i9Ol37r4eQGIa1pWJRQGmPRwqYDwd/
         +xTCmMkI/77sJhI9dW04/d4PtlzjPzFAHYEZNL5mJm3f67zmsyRnoHh6tWLhMNuA6/Ok
         vyaq1sO4BDs2sLkpRIiQ9Uo90aqOeDGD9UIbwirDo9yxF70b8Fj9FGMtmQFK2wubxjap
         vZL5MVq9ognv2A/LwnwVSw+iAV7FozYGqw7uJEKlTFGDY9NXXCe0bEGSLTxY8sTRjeFH
         4vJw==
X-Forwarded-Encrypted: i=1; AJvYcCVg6Kpwew45wAiuPw3onwPmFERjTRweakhWhl2WpuCZNQFQx4EvyQy64DOXrmM9VypyPbMIv3bVSm0I@vger.kernel.org
X-Gm-Message-State: AOJu0YwtazrWShZBySv3p1vWNpjdo/hhXOfjd6NXj8Sb7UVUDx9YvuCx
	Ypo1B6GXtChZqKhc2iIKltXNBHRuI1QSGNMUS8Ln4l/v3jnZBBVVmyfwaJDyikE48Y099DOz0h/
	hscnUpV7wi9AeWoPrH7NhMIyFkSKNKRy2vbKkuU8MFTV8wS0/13cegRieDMaHEzw=
X-Gm-Gg: AZuq6aLqsa9zdL/HfJE2/hokhGMX3mOYCBvZuK0Q6J7eJSIv8PkXQp0hm/0NA4rCLKo
	RpeYSW+IG61BHTX0AsRSbzdzxu7qXnAl+h/4HculW/bjtcCSya9rRHFNSjnd3eKYr6XLZOQXZnU
	B/5534uZfJNI1QhwtJ5tW1t7Y5Ls7kLCJ6+1tQPRO2r2ZdTDpH07W9qXxzccxYXEADaBInMUze3
	TJZh2s7qQTzz5ei4n60AB9t5JB7Pu+jEeZmFgT1Rlj7F8JBq0pWt55csMr+8IFrSX+zHaMH4GFt
	eNcqdYmmRenidKJ2364Uk0xeShYKB0JTmEgt4Zh/AuPFB5C2TSsAZyatG3tFAcuztJdWhJQ+sjM
	4WfF9BGP2Qd/b2nbuu3zKqw==
X-Received: by 2002:ad4:5dee:0:b0:894:6cb7:da94 with SMTP id 6a1803df08f44-897402c95aamr190213086d6.8.1771380229545;
        Tue, 17 Feb 2026 18:03:49 -0800 (PST)
X-Received: by 2002:ad4:5dee:0:b0:894:6cb7:da94 with SMTP id 6a1803df08f44-897402c95aamr190212556d6.8.1771380228953;
        Tue, 17 Feb 2026 18:03:48 -0800 (PST)
Received: from localhost ([2607:f2c0:b1e3:9a00:3d5c:8422:4052:e7a6])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8971cc7dc1csm176656526d6.10.2026.02.17.18.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 18:03:48 -0800 (PST)
Date: Tue, 17 Feb 2026 21:03:47 -0500
From: Peter Colberg <pcolberg@redhat.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org,
	driver-core@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 10/10] samples: rust: add SR-IOV driver sample
Message-ID: <aZUeA1hmYlZIILQg@earendel>
References: <20260205-rust-pci-sriov-v2-0-ef9400c7767b@redhat.com>
 <20260205-rust-pci-sriov-v2-10-ef9400c7767b@redhat.com>
 <0e762787-7270-426f-81ee-b24761617c18@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e762787-7270-426f-81ee-b24761617c18@de.bosch.com>

Hi Dirk,

On Mon, Feb 16, 2026 at 09:27:44AM +0100, Dirk Behme wrote:
> Hi Peter,
> 
> On 05.02.2026 21:59, Peter Colberg wrote:
> > Add a new SR-IOV driver sample that demonstrates how to enable and
> > disable the Single Root I/O Virtualization capability for a PCI device.
> > 
> > The sample may be exercised using QEMU's 82576 (igb) emulation.
> > 
> > Link: https://www.qemu.org/docs/master/system/devices/igb.html
> > Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> > ---
> > Changes in v2:
> > - Use "kernel vertical" style on imports.
> > - Demonstrate how to reach driver data of PF device from VF device.
> > ---
> >   MAINTAINERS                       |   1 +
> >   samples/rust/Kconfig              |  11 ++++
> >   samples/rust/Makefile             |   1 +
> >   samples/rust/rust_driver_sriov.rs | 127 ++++++++++++++++++++++++++++++++++++++
> >   4 files changed, 140 insertions(+)
> > 
> ...
> > diff --git a/samples/rust/rust_driver_sriov.rs b/samples/rust/rust_driver_sriov.rs
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..84d057629c7b03d743179a4e05ccc092f814bf6b
> > --- /dev/null
> > +++ b/samples/rust/rust_driver_sriov.rs
> > @@ -0,0 +1,127 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Rust SR-IOV driver sample based on QEMU's 82576 ([igb]) emulation.
> > +//!
> > +//! To make this driver probe, QEMU must be run with `-device igb`.
> > +//!
> > +//! Further, enable [vIOMMU] with interrupt remapping using, e.g.,
> > +//!
> > +//! `-M q35,accel=kvm,kernel-irqchip=split -device intel-iommu,intremap=on,caching-mode=on`
> > +//!
> > +//! and append `intel_iommu=on` to the guest kernel arguments.
> > +//!
> > +//! [igb]: https://www.qemu.org/docs/master/system/devices/igb.html
> > +//! [vIOMMU]: https://wiki.qemu.org/Features/VT-d
> > +
> > +use kernel::{
> > +    device::Core,
> > +    pci,
> > +    prelude::*,
> > +    sync::aref::ARef, //
> > +};
> > +
> > +use core::any::TypeId;
> > +
> > +#[pin_data(PinnedDrop)]
> > +struct SampleDriver {
> > +    pdev: ARef<pci::Device>,
> > +    private: TypeId,
> > +}
> > +
> > +kernel::pci_device_table!(
> > +    PCI_TABLE,
> > +    MODULE_PCI_TABLE,
> > +    <SampleDriver as pci::Driver>::IdInfo,
> > +    [
> > +        // E1000_DEV_ID_82576
> > +        (pci::DeviceId::from_id(pci::Vendor::INTEL, 0x10c9), ()),
> > +        // E1000_DEV_ID_82576_VF
> > +        (pci::DeviceId::from_id(pci::Vendor::INTEL, 0x10ca), ())
> > +    ]
> > +);
> > +
> > +#[vtable]
> > +impl pci::Driver for SampleDriver {
> > +    type IdInfo = ();
> > +
> > +    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
> > +
> > +    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
> > +        pin_init::pin_init_scope(move || {
> > +            dev_info!(
> > +                pdev.as_ref(),
> 
> The `as_ref()` in the `dev_*()` prints can be dropped. Example:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/samples/rust/rust_driver_pci.rs?id=600de1c008b2302b56d69ff27d12a9d8d14892ac

Thank you for the pointer, dropped in v3.

Peter

> 
> Best regards
> 
> Dirk
> 

