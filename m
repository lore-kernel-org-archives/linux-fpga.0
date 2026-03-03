Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F6F3D5661
	for <linux-fpga@vger.kernel.org>; Tue,  3 Mar 2026 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572547; cv=none; b=aBP2oWrnBTkoRheBvlHh6Jcb+nZr+aDoQ3T4WU26BbBGKD4R/ver1N/bcg9MWNjRpHXx/dKwRSKU7v/1HipXlrd6Wp3QLVGcgUClczOAliyXi11875c5aBo/H1/mljha6/G0YTI+yg/+neAf+OeNxJFsPFWj6c2DmF6ydR9FjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572547; c=relaxed/simple;
	bh=Ovi7q4LBinaNMgbwhfXjFRVkgoBkC//IcdGA6/LR988=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R1Eh+PsXeM+CnC9avPMxh4dAeEqLOCOQKnmtoGzdFiJn1ZTttRERHRt2PXYWQWKAl/8mzIB1pybHVkjf0D7Urh48TcKJmZdruk/EfSggb1JUwWZOl26cF++03CfpGB1aMlN9b3ymDmnS/XAhWFFdPAYSc/dglOMu75NWn904B40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UETI5Ks1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0qN0E6i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UETI5Ks1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0qN0E6i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772572545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmGZI5WblWd631ssrKt08f4BijC6XK/3q+5rIjFI99c=;
	b=UETI5Ks1jvYbHv9ioR1C2CjIlAGtH8KukR4JoO4FwdpVtEsJ9hztyFg3yQfukHfeK4yVYC
	RgcT31clj24jrq4rLmXG8KhXmbc1/oFJwwUvwe3Wg9r0czHaO81z3ysVMiNrm5xOEM+lKo
	sLVEr6An0twxPRpyoNDx7xyhiOwvV6w=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-U6N5j6c7M6aUJQz3jy4vQg-1; Tue, 03 Mar 2026 16:15:42 -0500
X-MC-Unique: U6N5j6c7M6aUJQz3jy4vQg-1
X-Mimecast-MFC-AGG-ID: U6N5j6c7M6aUJQz3jy4vQg_1772572542
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50340e2b4dfso653353781cf.3
        for <linux-fpga@vger.kernel.org>; Tue, 03 Mar 2026 13:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772572542; x=1773177342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmGZI5WblWd631ssrKt08f4BijC6XK/3q+5rIjFI99c=;
        b=B0qN0E6iHUjtj5H5r8OZlT8CV/1awFd20j8XrWKPadjilWen9mvG5kLn3n1MxJr2q8
         uq8rBp8Q9LKycQJLayAaW+tB7SxzLHZoZ2zIyRpFdjtRJUrDI1End5DeZhbu7T3pOqHS
         hz0TG7fk9XLp1639q6soPgbBYYLFaBq/ls29gYEMsr3g48f33hUPcLbjVnx0MOcXM9Wt
         8tMBGR+rmxSc56PnxnwvQXP8IjisR7hO7/+KM7FbBl95pYMEPLxOb3ayMoBmHLnWReIS
         Dq9+B1WC5NmEgflA/mcRTZgSAQuZDYEDuBHCIhBB5sNKoVBiI+0Gb+8a8e/HnRUtyYro
         /CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572542; x=1773177342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nmGZI5WblWd631ssrKt08f4BijC6XK/3q+5rIjFI99c=;
        b=cf0z6OlzTxF5bbchpGSr15wuyfoa8ql12iI/56MwDeDoEbwHqlaNxUBUXQ5ThD5RJp
         VvkhNC64CZGZ0wdtJo5z5X6lj+vemjzun26cj7inDTpSzgpJHgeTo5SL4EXWai8wVFKv
         2dqb3P90dWkO8oFt3c2670grd6Cy93NZVkFFlxrx0lxRuRrUVWjiqstlR/Kq3wzT2s8q
         ihxUDw4gaITIAwmKiKVkQE/dTWKrMC3NfAUdh47vXIDslMAwlRKR06X3SDJT9b2apKp/
         /AvVN0QAZg1TNZpyb6F2lzM/8iraAwAC9X8NkojI2Nv14UGN8sPo3PV7ZpRvdbS4MPp2
         f9XA==
X-Forwarded-Encrypted: i=1; AJvYcCX5KL46+stWWtJAsCkhpKzKFfwOfYE1SzLOpVNidsqMOPuFGMPNwbt+XX2cUYfsq0NiI+xbr6/F/CY3@vger.kernel.org
X-Gm-Message-State: AOJu0YzT6bEwHH+xkrQRv6lrFJfj+3QpyCZDDBWNR3F0eZzqhtqDCQBK
	p7d6WlHimVhnlj4IrMQJI4P9c9frcJDjixIhavQxVqNUESx2RH7IRCzEKzJm7ViZJQWcupouGnW
	SIFw6+b6PrIr/i8HwHPW5vCYyuYu6gtysQG3Xo8rFy400+cJBv7TtTicbJnAeqtA=
X-Gm-Gg: ATEYQzyh8DdBMbqZ9ASrkn+p60NE7zqicRl71k037GbIMdv9/2Kl+ahPWbcJjjx87yk
	jXEJ3zKzLE6QOEunqbp4ih3x77DbMbNTPCIDqAc8puQWzOG0jHSvJcB5hOVfY284L/3bFk+rFC7
	vvaFpBC1ZOp8/0s560UluOdUXbQTgrsfealMWNeCksxQ+vWAkr71cptc39If7ax0Bn5gIdG6LnD
	KscMR6s88huwQGbvyx1vs4brpo5/dpfWji3/GB9GopDz78xfqDU5PP8IjD77uTXlia9qX8gFaYR
	gBKb4byXx1VNEeMMbsbfDL3nH6lgYsbDN8pzbN8u+xJRQ5aV1uBcmOxTb2p4GqATqulpmVSy5PY
	Tf1I4iWFbGUrnXwrCC0gl+W4K8g==
X-Received: by 2002:a05:622a:18a8:b0:502:a1bc:5691 with SMTP id d75a77b69052e-507525a5444mr232050571cf.0.1772572541849;
        Tue, 03 Mar 2026 13:15:41 -0800 (PST)
X-Received: by 2002:a05:622a:18a8:b0:502:a1bc:5691 with SMTP id d75a77b69052e-507525a5444mr232049271cf.0.1772572540438;
        Tue, 03 Mar 2026 13:15:40 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b1e3:9a00:3c7:56c2:f819:96d2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074481c0e5sm156286991cf.0.2026.03.03.13.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:15:40 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Tue, 03 Mar 2026 16:15:24 -0500
Subject: [PATCH v3 04/10] rust: pci: add vtable attribute to pci::Driver
 trait
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-rust-pci-sriov-v3-4-4443c35f0c88@redhat.com>
References: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
In-Reply-To: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
 Moritz Fischer <mdf@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-fpga@vger.kernel.org, driver-core@lists.linux.dev, 
 Peter Colberg <pcolberg@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.2

Add the #[vtable] attribute to pci::Driver trait and implementations,
to prepare a subsequent patch that adds an optional bus callback
sriov_configure() to enable or disable the SR-IOV capability.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
Changes in v2:
- Add missing #[vtable] attribute in PCI driver trait example.
- Add missing #[vtable] attribute in nova-core driver.
---
 drivers/gpu/nova-core/driver.rs       | 1 +
 rust/kernel/pci.rs                    | 2 ++
 samples/rust/rust_dma.rs              | 1 +
 samples/rust/rust_driver_auxiliary.rs | 1 +
 samples/rust/rust_driver_pci.rs       | 1 +
 5 files changed, 6 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 5a4cc047bcfc9fcef61373ace84ed43958a3bcbd..66a68048006fb33477bb00f61856c1aa92c0a8f1 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -64,6 +64,7 @@ pub(crate) struct NovaCore {
     ]
 );
 
+#[vtable]
 impl pci::Driver for NovaCore {
     type IdInfo = ();
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index e1cab1574a3d309d25bf5267c0b0d8da8fb66d44..a4c27c674bd8bdf5e3316789d38d566e90b93fe2 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -278,6 +278,7 @@ macro_rules! pci_device_table {
 ///     ]
 /// );
 ///
+/// #[vtable]
 /// impl pci::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
@@ -292,6 +293,7 @@ macro_rules! pci_device_table {
 ///```
 /// Drivers must implement this trait in order to get a PCI driver registered. Please refer to the
 /// `Adapter` documentation for an example.
+#[vtable]
 pub trait Driver: Send {
     /// The type holding information about each device id supported by the driver.
     // TODO: Use `associated_type_defaults` once stabilized:
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 9c45851c876ef33414eb0071c42a2fb4ac3f1e78..ae6f7328b830e32bcaf7f8b5f8b1f117135ebf8e 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -51,6 +51,7 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
     [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
+#[vtable]
 impl pci::Driver for DmaSampleDriver {
     type IdInfo = ();
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 5c5a5105a3fff90f5e396186776e1b3ffdf479b4..2f7ac8f7391f45827c086b704950fd01907c1825 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -65,6 +65,7 @@ struct ParentDriver {
     [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
+#[vtable]
 impl pci::Driver for ParentDriver {
     type IdInfo = ();
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index d3d4a7931deb0c1085cfd817990737717f466ea9..27e603a9509c19b6845c10ef06a0af897aa0e84b 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -92,6 +92,7 @@ fn config_space(pdev: &pci::Device<Bound>) {
     }
 }
 
+#[vtable]
 impl pci::Driver for SampleDriver {
     type IdInfo = TestIndex;
 

-- 
2.53.0

