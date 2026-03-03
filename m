Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E474225782D
	for <linux-fpga@vger.kernel.org>; Tue,  3 Mar 2026 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572536; cv=none; b=hnPyCp+QwXpxYLsxgSz/v4FG0qJ7M7GvkHsI/vI5mezLwo95M1INOfKmkh2+lG+4bZ3ocYAHaE9s1WQYdKO/zwV+yELsfm3QDVAKMjxmKSRF1uywDSsUqaFiJadWchCm4miOAf9iScktdp1d+CsQebK91AZwNl6/nacBz8HFE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572536; c=relaxed/simple;
	bh=S/uQnRBX7EM2s7NdwB1h0Zvrd47E5NDlePG8Fysu8x8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xt+UIUIcDpBya94cewtx9bCGriGbjqBzV9E8YsPrfkIbWSa27+BWLob2lG1qy9c9hP/eGm6AsTtYXKn4eFLRV3aiDj1DIs+VXRFftZyvvCp4o9GVzfh+zcfVcQJtlDRVZj6FNe4Lj0uEhhRIt61Waw5oSp56eCQOIaWDNYSkA1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGkVIflW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gxZ5hJkB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGkVIflW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxZ5hJkB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772572534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wrmpWbz/D0LbSjhwAo9Mxe/RiGjDGWcxtMIqyIp8KYQ=;
	b=iGkVIflW/q203O//UxT3xpDOHkD/nUl7boXfrz/w+3PDbWQIAILlJU1Qa6DGysR6mfLOMW
	Gp3i6LZpxgi8RBwTazB95oC1Vw7FG+qTlRoDq1Iilron7wSZTQ96BBa8ZVbEm3yddp+9b2
	7mAMiBlqhxcDxBHHWbN26vMJAWZgRJE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-k0T5uiUTMMa94qLd4ya3Yw-1; Tue, 03 Mar 2026 16:15:33 -0500
X-MC-Unique: k0T5uiUTMMa94qLd4ya3Yw-1
X-Mimecast-MFC-AGG-ID: k0T5uiUTMMa94qLd4ya3Yw_1772572532
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-506c0da79c5so529575651cf.1
        for <linux-fpga@vger.kernel.org>; Tue, 03 Mar 2026 13:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772572532; x=1773177332; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wrmpWbz/D0LbSjhwAo9Mxe/RiGjDGWcxtMIqyIp8KYQ=;
        b=gxZ5hJkBx6lD9MZDFBiiaSYr721iedv1hdb6zvEGvWA5icT191USpfIEODXvUYl+jx
         YlOWGjzHtqextfJFJpemJTEwFfSrXQ+z5sXeBx9u+q2d/lgcUZTbEvQPwR/NmhguYNTH
         eMg1rCHk8ss/ZElGbCFEZMi+xq4et/12JTMTnCR9KKDbd2VM+rRoX9r0T6wv4CE04mVS
         5OTsO3CzHqUPAWIcgCpqISJCldt5S5K9EIJHT/4TxhZr4/l/RcbCUNsc+4xHBXt2QZpA
         nUkD9oaxbDglRQC444E/pe4mtnTQin8RFRjF5HO5YwkWU8+tx3kNj5KH9rYoMXmF1ydE
         Z7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572532; x=1773177332;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrmpWbz/D0LbSjhwAo9Mxe/RiGjDGWcxtMIqyIp8KYQ=;
        b=BrFWJEdF1nHekqoKOZ4ZT0xMkDClsfF28kQiS9153DXiqNs/nY04x+ZPWRKHNeCQnS
         vT84UTAXCKYlnXSruEWGxQRoumBSo8heI0UCdZjYBNu8kxfA03RZuY/swxX0+641X8K7
         lyJxr+frN3nxhJax0esfOGrqQoTxC667sVrPUvBlTiILungdGm+CL6JJCsf+/r+uwnGg
         4MqPM99cbc8IVLq+NFKnz0nG/rI7X4OAlkHE6Qb/DmkBVfOo5BuAYt6/Hh1oIh9tmfnM
         mAZ9xiQAlSwt11nJDc5hrbzgyI/VyAX8Tx/dBwEVrXUhDJS5PRQONwwLGb6AL5qfTeN7
         /6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEkV6q28Am2UWXkoU7t0fEqaw0es44pw7O0gRQTKBzVqhOLUwfohkSRJQP43uyKYWIDRbfVti8lyp4@vger.kernel.org
X-Gm-Message-State: AOJu0YylDtfPI5V9WpA44macje3T/IwjpEX2RJjeOUAA17WPa33BI7SZ
	xfvrVfteJSetA5EgKzkkRWewRFWNRhTWz2fW47PIHAps/OVxecZZX5vKkal2IdDnFUu5TJtW8YE
	7NJ5IR+1rTvDUHiVXjlq1ouDX0boLybVeOg+LrxZ+gvEpA8TXSv7WZsNOnrdHiAU=
X-Gm-Gg: ATEYQzy5WBZyA4TVpz0pmTrfauTaRXJsR1YU8YeYntEu9OtJ4JXwiu73KBKurC14Lz3
	6eWkarHIbYwFo3xfOzXg7tBNuft9xukYOuVRPY6luQ8pLdH2ZBsNROqHjaLQ2rHgmuuY3basyXH
	UunNtmKigHN8t7dBH8XNjRztiljydTjhrQr488gySt7cvKNQoTUaDFp56DsC8heDc8nSPbaHq8U
	c9mywzPY39MIqtd4i6YrU+AeAlWmtqLjjKnTZgJloAaoAa+iRq4V/vnbnPaGNjURev98AC6tXWt
	p7NRh19m3WSOvQqENnqy9FGrVq1XgEcS/mCmqIDboQhmxRPw9cE6Ttrm2AYC45n3zYiWdgqZwM/
	5hnOg1zMMlzpKWeggQI4S+mN1mQ==
X-Received: by 2002:a05:622a:214:b0:4f1:83e4:6f55 with SMTP id d75a77b69052e-5075273cf0dmr220407571cf.16.1772572532244;
        Tue, 03 Mar 2026 13:15:32 -0800 (PST)
X-Received: by 2002:a05:622a:214:b0:4f1:83e4:6f55 with SMTP id d75a77b69052e-5075273cf0dmr220406951cf.16.1772572531594;
        Tue, 03 Mar 2026 13:15:31 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b1e3:9a00:3c7:56c2:f819:96d2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074481c0e5sm156286991cf.0.2026.03.03.13.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:15:31 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Subject: [PATCH v3 00/10] rust: pci: add abstractions for SR-IOV capability
Date: Tue, 03 Mar 2026 16:15:20 -0500
Message-Id: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XMQQ6CMBCF4auQrh0zLZRSV97DuChlkFlITYtND
 OHuNhoX6urlX3xvFYkiUxKHahWRMicOc4l6Vwk/uflCwENpoVBpiaqFeE8L3DxDihwyeNeNGmW
 vHNWioInTEuLj9ZdlmdObSml/aZaA0HW1s4221llzjDRMbtn7cBXn8pXVx7eoUP95VTyNtkH0x
 rSm//Lbtj0BNUVq1N0AAAA=
X-Change-ID: 20251026-rust-pci-sriov-ca8f501b2ae3
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

Add Rust abstractions for the Single Root I/O Virtualization (SR-IOV)
capability of a PCI device. Provide a minimal set of wrappers for the
SR-IOV C API to enable and disable SR-IOV for a device, and query if
a PCI device is a Physical Function (PF) or Virtual Function (VF).

Using the #[vtable] attribute, extend the pci::Driver trait with an
optional bus callback sriov_configure() that is invoked when a
user-space application writes the number of VFs to the sysfs file
`sriov_numvfs` to enable SR-IOV, or zero to disable SR-IOV [1].

Add a method physfn() to return the Physical Function (PF) device for a
Virtual Function (VF) device in the bound device context. Unlike for a
PCI driver written in C, guarantee that when a VF device is bound to a
driver, the underlying PF device is bound to a driver, too.

When a device with enabled VFs is unbound from a driver, invoke the
sriov_configure() callback to disable SR-IOV before the remove()
callback. To ensure the guarantee is upheld, call disable_sriov()
to remove all VF devices if the driver has not done so already.

For PF drivers written in C, disabling SR-IOV on remove() may be opted
into by setting the flag managed_sriov in the pci_driver structure. For
PF drivers written in Rust, disabling SR-IOV on unbind() is mandatory.

This series is based on Danilo Krummrich's series "Device::drvdata() and
driver/driver interaction (auxiliary)" applied to driver-core-next,
which similarly guarantees that when an auxiliary bus device is bound to
a driver, the underlying parent device is bound to a driver, too [2, 3].

Add an SR-IOV driver sample that exercises the SR-IOV capability using
QEMU's 82576 (igb) emulation and was used to test the abstractions [4].

[1] https://docs.kernel.org/PCI/pci-iov-howto.html
[2] https://lore.kernel.org/rust-for-linux/20251020223516.241050-1-dakr@kernel.org/
[3] https://lore.kernel.org/rust-for-linux/20260107103511.570525-7-dakr@kernel.org/
[4] https://www.qemu.org/docs/master/system/devices/igb.html

Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
Changes in v3:
- Replace SR_IOV -> SR-IOV in description.
- Drop redundant `.as_ref()` for `dev_*` prints.
- Link to v2: https://lore.kernel.org/r/20260205-rust-pci-sriov-v2-0-ef9400c7767b@redhat.com

Changes in v2:
- Move logic to disable SR-IOV on remove() from Rust to C.
- Add driver flag managed_sriov to opt into disabling SR-IOV on remove().
- Demonstrate flag managed_sriov for dfl-pci driver.
- Uphold safety guarantee for physfn() when PF driver is written in C.
- Let physfn() return error if driver flag managed_sriov is unset.
- Use "kernel vertical" style on imports.
- Use to_result() to handle error in enable_sriov().
- Note Bound device context in SAFETY comments for {enable,disable}_sriov().
- Demonstrate how to reach driver data of PF device from VF device.
- Add missing #[vtable] attribute in PCI driver trait example.
- Add missing #[vtable] attribute in nova-core driver.
- Define struct MyDriver such that physfn() example compiles.
- Replace VF -> PF in doc comment of is_physfn().
- Add #[inline] to is_physfn() and is_virtfn().
- Link to v1: https://lore.kernel.org/r/20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com

---
John Hubbard (1):
      rust: pci: add is_virtfn(), to check for VFs

Peter Colberg (9):
      PCI: add driver flag to opt into disabling SR-IOV on remove()
      fpga: dfl-pci: set driver flag to disable SR-IOV on remove()
      rust: pci: add {enable,disable}_sriov(), to control SR-IOV capability
      rust: pci: add vtable attribute to pci::Driver trait
      rust: pci: add bus callback sriov_configure(), to control SR-IOV from sysfs
      rust: pci: add is_physfn(), to check for PFs
      rust: pci: add num_vf(), to return number of VFs
      rust: pci: add physfn(), to return PF device for VF device
      samples: rust: add SR-IOV driver sample

 MAINTAINERS                           |   1 +
 drivers/fpga/dfl-pci.c                |  17 ++--
 drivers/gpu/nova-core/driver.rs       |   1 +
 drivers/pci/iov.c                     |  41 ++++++++-
 drivers/pci/pci-driver.c              |   3 +-
 drivers/pci/pci.h                     |   2 +
 include/linux/pci.h                   |   8 ++
 rust/kernel/pci.rs                    | 165 ++++++++++++++++++++++++++++++++++
 samples/rust/Kconfig                  |  11 +++
 samples/rust/Makefile                 |   1 +
 samples/rust/rust_dma.rs              |   1 +
 samples/rust/rust_driver_auxiliary.rs |   1 +
 samples/rust/rust_driver_pci.rs       |   1 +
 samples/rust/rust_driver_sriov.rs     | 127 ++++++++++++++++++++++++++
 14 files changed, 366 insertions(+), 14 deletions(-)
---
base-commit: 1b9a5bc8513d081c1bfe2c096b6dc502a4660f47
change-id: 20251026-rust-pci-sriov-ca8f501b2ae3

Best regards,
-- 
Peter Colberg <pcolberg@redhat.com>

