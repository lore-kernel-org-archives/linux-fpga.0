Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F543CD8CF
	for <linux-fpga@vger.kernel.org>; Tue,  3 Mar 2026 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572547; cv=none; b=oovLmNif0ZlZytowFJr2cY8frYnbEVaj29dkZvuAlwka7Uug2+ekQwsQIrhqVIO++ibSpaQ0QPX1RykwL7MSXU7uW2GjANOs3/A9W4naShXL68HiKiGaRCBwFU65Pcfr7AwhD/Dl538OIzCa5HSK0bLs8b5KTXxtZEr2XYAylX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572547; c=relaxed/simple;
	bh=OY7zfr6p9lvbctn7yr5wWYUOqciQoXU5irFoOySjssk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CmQnpag4W9Ar4cw3aMy/iRtEaQhraKdgzuZnf6Xj2WR+hL8Fgw0E06RQsK52WggRLUq+3vytoWT3A6ET2lxC60+LsgnpyVY+ypVaXB+7xz+hUHEd/d/THLtLii9mysF+rPZ7FQaGiRWTVDh3ZnYBWgaNO+x3u7FWuW8KFMofY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UatT3xYS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5wAGXwf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UatT3xYS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5wAGXwf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772572544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjMC0WxfV6FSNfe+9wyhxlyiyTMxjfq8oevr0CbOGEQ=;
	b=UatT3xYSruZfpjqVDf4AAd2t9EzKJjXY55MRpcvFzjVonc0uZncFQejFys8eSBcI1rWH3M
	LJgBE4oaR+/GpzYhH8O6n8m8t94J6OMCvSH0/UK7sQb+gU/IehSfGxBs3tq/4d18CJww70
	LxOFvkEbdZYQY9RX5syMnylNNlHDtuk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-RUvpQjmXPA-aTLKw80T0eA-1; Tue, 03 Mar 2026 16:15:43 -0500
X-MC-Unique: RUvpQjmXPA-aTLKw80T0eA-1
X-Mimecast-MFC-AGG-ID: RUvpQjmXPA-aTLKw80T0eA_1772572543
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-503342386c7so91934281cf.0
        for <linux-fpga@vger.kernel.org>; Tue, 03 Mar 2026 13:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772572543; x=1773177343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjMC0WxfV6FSNfe+9wyhxlyiyTMxjfq8oevr0CbOGEQ=;
        b=M5wAGXwf7ePyDDNSfoE73pBgvXeejs6u7EDFDXXCvNCouAskISV18rUxssNFTFqMah
         2szEdlSal0kuT7MppLbwkI0qMegNcp4HejF+qDWLRgi7PMi2HMyPxEYnHAKt5w1Z7GBQ
         t0mcCmWYzJ/J3jb0fMuXDlWde+Agc1BnEIvosFbrFFzLXyGuaCGdf/dmGnHmOkDJ4bQ4
         boFGh5z3OhsGYj7J2p7VFnMTXJUqvPxBlHBfHmmf/m0n9yxQAow5SbDl+TRLyM7W46NM
         266s/r9YMyR48G9K+Hb83MKuCsOmW7XnMeMD3y3qncPSSYiSwM4YzNawJN7mkJzXsuDQ
         Rc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572543; x=1773177343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XjMC0WxfV6FSNfe+9wyhxlyiyTMxjfq8oevr0CbOGEQ=;
        b=Waiw5De+gmbF+ffeFYXyLj/9JjcjnGoZ+U4yAVYUhR70KJK+hJqR/orJU2B6ozOBsR
         b2aie/5AhwXAUpfV1CLo7BzfCjyW6I9CqA66h7XdG6iGYWDsNKA04Gutn7RKODTg04dD
         e3FvldHfweri3hpHeCLDwybS3REeX9FS+amPN+T4gzu24yx9mNJnZiyIO6XeTh4hopo1
         0CHr+ae9ZTo0TH18SqDY/pZcsnhwwsPhr5n+Erv5+kNCkT9Vj8YDmBzZEFrx0QG7S+hg
         jqeeoYJ7AT/7DkhNKhdvn7Wxrg8elC7Y0T14l7qVr2koai1p4JsvKVF/ivLft2Xs452v
         mt2w==
X-Forwarded-Encrypted: i=1; AJvYcCW2ssgDpFWlu2M0VfVuEcZehQyqmDRmiBsVq7wSHyrv4JBBRhqZoHP2XFcQatKOU5bN+5dXtgGBSC8p@vger.kernel.org
X-Gm-Message-State: AOJu0YzIa6xgVNxgL/36IpVcmowb10byMy/imdyYsoKSc2N5Kz2ZzCoe
	As0PIy8FY3Enow9uV0SJ1rc4DSeGH7molXETMCVsldYz9xQQbrFcFq6prGYCRXdjH2JHnwBpnU7
	ZWQhyT7jr/pUkM54tuGzlN8xr17+BWCg964xcsjh6darHvqMf49JRfXkhTKeNcMU=
X-Gm-Gg: ATEYQzw7SrQbW8NWL+H2P5r/tif0k/SKh3Fk2NaoPfFg41r7YTB7OKsBIeBDy1HkFUf
	0eEgz0EifMT+l9JmXxlJi4wW1+DVu/TW/pAs1x33CYVJcIxQWZWhovYa2TjTZRYYnprM0CAL33Q
	EOmChG9YZk2Uz3RdaisqoC5wRlEdou7ecjMfnsVsY1rhl6+YIsq0XeHTXWJHNByHw4fEDTbrn1d
	kf62S9E09Gms9mgNGpK4/eF+927wT5STURmU5QK1SQQUao64zRNitfhbSHSUfjZtie+qkG3ObJX
	GeyXGf1QsuASsfUZ/1mVnB8QLfRS6v1PHl86czdvbQ2fpxVk9oSQMQiL2ZRfzXmqnj31RmOdu72
	pomZMuGyav+4M6+p8dvr4nW33OA==
X-Received: by 2002:a05:622a:14d2:b0:502:ad63:e15e with SMTP id d75a77b69052e-5075281833dmr229351201cf.55.1772572542976;
        Tue, 03 Mar 2026 13:15:42 -0800 (PST)
X-Received: by 2002:a05:622a:14d2:b0:502:ad63:e15e with SMTP id d75a77b69052e-5075281833dmr229350471cf.55.1772572542372;
        Tue, 03 Mar 2026 13:15:42 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b1e3:9a00:3c7:56c2:f819:96d2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074481c0e5sm156286991cf.0.2026.03.03.13.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:15:42 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Tue, 03 Mar 2026 16:15:25 -0500
Subject: [PATCH v3 05/10] rust: pci: add bus callback sriov_configure(), to
 control SR-IOV from sysfs
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-rust-pci-sriov-v3-5-4443c35f0c88@redhat.com>
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

Add an optional bus callback sriov_configure() to pci::Driver trait,
using the vtable attribute to query if the driver implements the
callback. The callback is invoked when a user-space application
writes the number of VFs to the sysfs file `sriov_numvfs` to
enable SR-IOV, or zero to disable SR-IOV for a PCI device.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
 rust/kernel/pci.rs | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index a4c27c674bd8bdf5e3316789d38d566e90b93fe2..88bd114970431bf8c3edef94c1d48567d895eaf6 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -83,6 +83,10 @@ unsafe fn register(
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
             (*pdrv.get()).managed_sriov = true;
+            #[cfg(CONFIG_PCI_IOV)]
+            if T::HAS_SRIOV_CONFIGURE {
+                (*pdrv.get()).sriov_configure = Some(Self::sriov_configure_callback);
+            }
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
@@ -135,6 +139,20 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
 
         T::unbind(pdev, data);
     }
+
+    #[cfg(CONFIG_PCI_IOV)]
+    extern "C" fn sriov_configure_callback(
+        pdev: *mut bindings::pci_dev,
+        nr_virtfn: c_int,
+    ) -> c_int {
+        // SAFETY: The PCI bus only ever calls the sriov_configure callback with a valid pointer to
+        // a `struct pci_dev`.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `sriov_configure_callback()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
+
+        from_result(|| T::sriov_configure(pdev, nr_virtfn))
+    }
 }
 
 /// Declares a kernel module that exposes a single PCI driver.
@@ -325,6 +343,44 @@ pub trait Driver: Send {
     fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
         let _ = (dev, this);
     }
+
+    /// Single Root I/O Virtualization (SR-IOV) configure.
+    ///
+    /// Called when a user-space application enables or disables the SR-IOV capability for a
+    /// [`Device`] by writing the number of Virtual Functions (VF), `nr_virtfn` or zero to the
+    /// sysfs file `sriov_numvfs` for this device. Implementing this callback is optional.
+    ///
+    /// Further, and unlike for a PCI driver written in C, when a PF device with enabled VFs is
+    /// unbound from its bound [`Driver`], the `sriov_configure()` callback is invoked to disable
+    /// SR-IOV before the `unbind()` callback. This guarantees that when a VF device is bound to a
+    /// driver, the underlying PF device is bound to a driver, too.
+    ///
+    /// Upon success, this callback must return the number of VFs that were enabled, or zero if
+    /// SR-IOV was disabled.
+    ///
+    /// See [PCI Express I/O Virtualization].
+    ///
+    /// [PCI Express I/O Virtualization]: https://docs.kernel.org/PCI/pci-iov-howto.html
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::{device::Core, pci, prelude::*};
+    /// #[cfg(CONFIG_PCI_IOV)]
+    /// fn sriov_configure(dev: &pci::Device<Core>, nr_virtfn: i32) -> Result<i32> {
+    ///     if nr_virtfn == 0 {
+    ///         dev.disable_sriov();
+    ///     } else {
+    ///         dev.enable_sriov(nr_virtfn)?;
+    ///     }
+    ///     Ok(nr_virtfn)
+    /// }
+    /// ```
+    #[cfg(CONFIG_PCI_IOV)]
+    fn sriov_configure(dev: &Device<device::Core>, nr_virtfn: i32) -> Result<i32> {
+        let _ = (dev, nr_virtfn);
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
 }
 
 /// The PCI device representation.

-- 
2.53.0

