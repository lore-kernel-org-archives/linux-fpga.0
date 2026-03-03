Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A4494A1D
	for <linux-fpga@vger.kernel.org>; Tue,  3 Mar 2026 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572556; cv=none; b=NK7bIHWFrqFCfApbwjPVdDhZ6AE07SIyz2IoQCYM6H+OQKChI/OwiNtceBVCbKI8x6+Wo9w4Zq2s6BSaC3kJUrXpzWDpSWCtTqkZUpu32WQBESHeoHm18+Ngc1Aowg9URdMAHvb5iHV+6wXOiZO3w7uph1I657In+PzPbB7pK4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572556; c=relaxed/simple;
	bh=aIeoCt7uogRc0fVC6+4FHa1SGMowdDhKrl+UTRXZUrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nl0/Lk0OOsElOpqJgcyr1ky/OCWmCLRA+4q73/amTr/rfiV440uK0KePlG8YyTYdXnO7tElu5irucXWLZ/4g0QJRPsAX38U2hvsLua8OxxEO52PuMMjw809NqgC52uwauCWUD93AdCsxlwHqgJHqEKGM5RT4k8IGqN8Gl+obEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClSPKbLW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rLPk8nqY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClSPKbLW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rLPk8nqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772572553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62xgaFtJ6odD5MPfFUAjLdRekJQ/qnRaVs4d4H+RycE=;
	b=ClSPKbLWZNGN7BuHje3qvLZ7qVruJgZQlQ6Dzt90mRjvMLJOgyuwOe+iLQmRQtehu3M1Eu
	aSQSrjDKm+qViaKWCQQupOBQPImtlkLD1m9E9esi1+5kppZbDOfiVFmiuqnQNeh/b92YUz
	pxiThj/9P3Lw7yb/ihg7WMAwOf58mYs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-jP1TF3VUMrSG-8R3kHNPzA-1; Tue, 03 Mar 2026 16:15:52 -0500
X-MC-Unique: jP1TF3VUMrSG-8R3kHNPzA-1
X-Mimecast-MFC-AGG-ID: jP1TF3VUMrSG-8R3kHNPzA_1772572551
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-506ab115571so476623431cf.0
        for <linux-fpga@vger.kernel.org>; Tue, 03 Mar 2026 13:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772572551; x=1773177351; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62xgaFtJ6odD5MPfFUAjLdRekJQ/qnRaVs4d4H+RycE=;
        b=rLPk8nqYiL48CuEcZ+suVKdUgx0kL6WmYj1FJl5K7S3j1utCxnP1YwEcerh3KXTz0h
         UY9gefGDHTfwL7rjIV1x62pGuCgfv7Xs8tBwO1bjiRQKwg1KTvNFfNi4NHrXU3JF4Tkc
         999JiCTBD26rJOY59/4RTX0LBodpTVmmCkQS7hTLe4YPDdto4rYo22f8/v1OsTjwbsJD
         5c94Dk2vmD6ljNvxT0CGZ5tabKiVB8DP6xQOFDz4pJHXxHPX9IUrt29T9ablpYkacUSR
         SlSiBDOgrK28z33A59konE34I9VvBZRJ/2evVSgzHnxNnEnTt/Krep/7TCwdgHqgvUHS
         PCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572551; x=1773177351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=62xgaFtJ6odD5MPfFUAjLdRekJQ/qnRaVs4d4H+RycE=;
        b=CGAfDvlb/9vGXN0GoAUoEe2QnZYWLg0EMj3ePuyWPG7R+GGvaUIResQgY/yhESy5rc
         ss3pc9SKDaGvG2jAOoaZltKF3F43lbltsl8QRAgLN1Ps3MmB13kfthHC0QF4EL8nKKmC
         p9B1yT3gManMWU/wmYJs3W6/aw3LO1pGjO6OG0qsmBwxx3nYYZm7bH7AvttZPbKTdMA6
         eg4i+XHQFbZfGiQKg5mNXAOAZD43WyHoEwD3n6juySZ3v0wzySQKiphqiL8puQn6Pb8n
         vlGS7nXEZHnvnTvbyKqiA5X6M7yIasGJfIIJUlf/Z2wdIUbOuqz4CmfaqGDQqw1saaBY
         d2jA==
X-Forwarded-Encrypted: i=1; AJvYcCV1HHJTk9dgaMaxK2En4odN7aFOcSjQXTwfSbtVFoAWay+ixhEjbH5fIT3tMKHL71Pb+8ReT2Zj0/jS@vger.kernel.org
X-Gm-Message-State: AOJu0YweEQk+trFf6MoN/141sCzUSPPMWslhnaYtdwjiA+kSGqzRxDAk
	M6J43UVTjzTZ7l9Xt4yllf5Jtrg2YvLoETy0KhXQspDbQvEHetdrABKRayYi+bYxJ21KIMphMus
	yYvQ0afUKmGPIqXA7eUom3+2Iq4Ibld/APU1RjANRA2wJP8dCJWqyhMI+3QcgWtE=
X-Gm-Gg: ATEYQzyvOC7g1Qnh52nRf5zZ3FX7TAQ2FVi4tk8cqVa6S/tla7l9A/4GL7nJQ+fzImg
	oBuLJLjZY+x9//giR33VLBIzLAwG7Em+zkhEXYhiuOtVb/7tcxW98ptp9YscmGTqVpOBnIk5bc7
	G3gx3pYPb2uOVf+7tKxlJqhTNRoGE0FjcdUPguyJ2SgUJlo8mxHF2g5uqyifNZJ3B2ehNFcAzCg
	p9FmFYN9ftgSZcKJAg/mk5CTBQ5sVLI6aX8Ia1Z4Yim3fbxbIPLcohCfDf/hhBQxZk6GM+at/xv
	sJsqfuSSqPd3y758sE96RiT9yiFkTUv8cqtx+xJc/vWRI5LNRSXwJTthyo+kfTTo9/zmW4ruwk8
	rgXDOQsk+EBnh9DpJCo75ZuVMiQ==
X-Received: by 2002:ac8:7d53:0:b0:503:2ea0:ef2a with SMTP id d75a77b69052e-507528a83e7mr213703531cf.18.1772572551518;
        Tue, 03 Mar 2026 13:15:51 -0800 (PST)
X-Received: by 2002:ac8:7d53:0:b0:503:2ea0:ef2a with SMTP id d75a77b69052e-507528a83e7mr213703051cf.18.1772572551032;
        Tue, 03 Mar 2026 13:15:51 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b1e3:9a00:3c7:56c2:f819:96d2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074481c0e5sm156286991cf.0.2026.03.03.13.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:15:50 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Tue, 03 Mar 2026 16:15:29 -0500
Subject: [PATCH v3 09/10] rust: pci: add physfn(), to return PF device for
 VF device
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-rust-pci-sriov-v3-9-4443c35f0c88@redhat.com>
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

Add a method to return the Physical Function (PF) device for a Virtual
Function (VF) device in the bound device context.

Unlike for a PCI driver written in C, guarantee that when a VF device is
bound to a driver, the underlying PF device is bound to a driver, too,
by always setting the flag managed_sriov in the pci_driver structure.

In case SR-IOV has been enabled by a C driver that has not set the flag
managed_sriov in pci_driver, return an error from physfn().

This change depends on commit a995fe1a3aa7 ("rust: driver: drop device
private data post unbind") to also uphold the safety guarantee in case
a (broken) PF driver re-enables SR-IOV in its unbind() callback. That
commit extends the lifetime of the device private data beyond the
remove_callback() wrapper. In particular, that commit ensures that the
device private data for the PF device is still alive until after the
function pci_iov_remove() is called and forcibly re-disables SR-IOV,
which means the data can be safely accessed by VF drivers until then.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
Changes in v3:
- Replace SR_IOV -> SR-IOV in description.

Changes in v2:
- Uphold safety guarantee when PF driver is written in C.
- Let physfn() return error if driver flag managed_sriov is unset.
---
 rust/kernel/pci.rs | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 581930d0afe98ccc29d729e4d9aab75b4144e46c..3b11f73a9f2b69a02fe003b8feadd61864adc8c0 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -525,6 +525,59 @@ pub fn pci_class(&self) -> Class {
     }
 }
 
+impl Device<device::Bound> {
+    /// Returns the Physical Function (PF) device for a Virtual Function (VF) device.
+    ///
+    /// # Examples
+    ///
+    /// The following example illustrates how to obtain the private driver data of the PF device,
+    /// where `vf_pdev` is the VF device of reference type `&Device<Core>` or `&Device<Bound>`.
+    ///
+    /// ```
+    /// # use kernel::{device::Core, pci};
+    /// /// A PCI driver that binds to both the PF and its VF devices.
+    /// struct MyDriver;
+    ///
+    /// impl MyDriver {
+    ///     fn connect(vf_pdev: &pci::Device<Core>) -> Result {
+    ///         let pf_pdev = vf_pdev.physfn()?;
+    ///         let pf_drvdata = pf_pdev.as_ref().drvdata::<Self>()?;
+    ///         Ok(())
+    ///     }
+    /// }
+    /// ```
+    #[cfg(CONFIG_PCI_IOV)]
+    pub fn physfn(&self) -> Result<&Device<device::Bound>> {
+        if !self.is_virtfn() {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct pci_dev`.
+        // `physfn` is a valid pointer to a `struct pci_dev` since `is_virtfn()` is `true`.
+        let pf_dev = unsafe { (*self.as_raw()).__bindgen_anon_1.physfn };
+
+        // SAFETY: `pf_dev` is a valid pointer to a `struct pci_dev`.
+        // `driver` is either NULL or a valid pointer to a `struct pci_driver`.
+        let pf_drv = unsafe { (*pf_dev).driver };
+        if pf_drv.is_null() {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: `pf_drv` is a valid pointer to a `struct pci_driver`.
+        if !unsafe { (*pf_drv).managed_sriov } {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: `physfn` may be cast to a `Device<device::Bound>` since the
+        // driver flag `managed_sriov` forces SR-IOV to be disabled when the
+        // PF driver is unbound, i.e., all VF devices are destroyed. This
+        // guarantees that the underlying PF device is bound to a driver
+        // when the VF device is bound to a driver, which is the case since
+        // `Device::physfn()` requires a `&Device<Bound>` reference.
+        Ok(unsafe { &*pf_dev.cast() })
+    }
+}
+
 impl Device<device::Core> {
     /// Enable memory resources for this device.
     pub fn enable_device_mem(&self) -> Result {

-- 
2.53.0

