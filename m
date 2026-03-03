Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2113BED7A
	for <linux-fpga@vger.kernel.org>; Tue,  3 Mar 2026 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572544; cv=none; b=MvdIFz5cxNUvvdJcoyGkbgI9Q2+0QPpzcvdzgDmNYuQOnUvEVUsXW/4gMx3YkB6z1Jhd7f33isbcdDUdXujpX2mYyjMeboVf53FWkIfoHzOs6MFrdHJtgNzOTrex4+DqDk5S2H1zxqzScc2I3wcmGq1Ih9bGbPW2LCjqC08K09A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572544; c=relaxed/simple;
	bh=degmGH7wPwx8NSuUy3FBbvJDakmae95tdtBgxpe2RUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AY1BD/kGn3gOnTPPrvmR4MPPUL8+4q1fKcmgKWpQRBWkQ4JV1i0S9RGJiQ69Kao7sX0fEfyt+TPIwFB4dUbIGk7lA0x2X7qWsbQJfgGjTNrM+ZSFAnlwpX4MN+LC1NhF1vZvFA+3UOlLR4nND0/xC4qBstKbfIwnGGZJOR2Ai/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEE53Au0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKA3pGY5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEE53Au0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKA3pGY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772572541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKSiyMf0ynPRuLtK//gTM+BGK6ixt+B/8DTHGEJv69g=;
	b=dEE53Au0HE/cSAZbZnk11r/yCRHPX2UwNv1Y2PDuERCXWDEFvPkHBjiCZcPLRFFfW/espn
	WhNwyLS1fzx+MWIB3g8mtbXkKQUAo+z7yCd9qjdZNL7JPzhLE9gIaF9P4SnurQgf6obexe
	QJiqx9KPCPViz9Z7IA/eHHwJMm5WcMk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-ocRJjoeLMH-kDbudENlSRg-1; Tue, 03 Mar 2026 16:15:39 -0500
X-MC-Unique: ocRJjoeLMH-kDbudENlSRg-1
X-Mimecast-MFC-AGG-ID: ocRJjoeLMH-kDbudENlSRg_1772572539
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-506a07740bdso945565151cf.2
        for <linux-fpga@vger.kernel.org>; Tue, 03 Mar 2026 13:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772572539; x=1773177339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKSiyMf0ynPRuLtK//gTM+BGK6ixt+B/8DTHGEJv69g=;
        b=fKA3pGY5MsDcul/N6psTEi/A9rBUoHj5oPEMPx8tGSJGL2Ulbzyitd2T+Y/hlgYs1S
         s5jlQft7U0tyeoz11d2MrekvYoohJ0eiXQOCNpeYa0vGucRwlJSyIp6NbU4a1RCABhMc
         zLVUfQXlH7Q/MpKBcXbMWYDmzm1mNOYJ2/kbzL2fpLBOIhBoAJi3JgtUq9KHCE5UpQEd
         GdJA2IYTwUp7Nr7XowlfbkX+EjEuDxeFM1dPgjzQQtpT29T/D/3/SjBX7Nc5a9T9iRV7
         Z4P+9jPuzxY0aJ5UcBq/e6bGcP+oPQbbkGj4BVtAYGWtKQ9ZZoyv4s0eDlfmJPI+lo03
         5Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572539; x=1773177339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dKSiyMf0ynPRuLtK//gTM+BGK6ixt+B/8DTHGEJv69g=;
        b=iMiP1XK8YwbD3dW/29cTx4HufNwizQn6C+2wkINmwB2d1h6nx3hPTUI5VclcddhNQ6
         4ciYoyDYvKX4mKI84wpKzmmsZ6Lw8NTCz4CKrYoDkKUFfewRhvANewjU+7k6syKkv91V
         sqBylKqGssLLKSlwgzwOS0g/ixBTaxnJLncPNAfdIR/Fqg47t/OQVxMDdVJzF9/k56OW
         D/VkSRmXKbDdH2jRyJCrcX/TPwfiRYMHnp+8rtYCOh4wgcD0KpCkJHc+LacEl9YTfAM9
         v63xDR2+nWLxSWoseuT3YvE/t71c40gpz3TDh4btHgBLNgptzF9HyzRJ9k/CAxYtlSGb
         puQA==
X-Forwarded-Encrypted: i=1; AJvYcCW34liu5HOuMpzaysrRn4T+ncbAGz3qsfIJA7Tr6syzuL/KPhdTWLJz3uBNWrV5+1Or0VCuEXtIf7hV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj2YALobKwTyIXRRmns3NHJnuCGLR1hvU5VVq2cwAlijDAfEW1
	zP7a/vEPdm+rrzF67aj60ox7V7lOfRiDP2BgF2fl5iP+sS6yzjL/iDxDUhaRxQx+TIHKf8MgS+Q
	1vMARz3eQwxZ4xRb9tv57sK6/DYbmRgdLEYQdcoeL9oJrw21VZRDHBitH1ImgXFU=
X-Gm-Gg: ATEYQzzehSLjuRCRg6RGbdNixMYZ44AVOhh/GoDjeFCdfPcOmcMZvEBLzS1WkcglnvQ
	Y5tZunPWo1fTmb28o1fmCeqCekQyYLBgzzZaIqn5tdaeykSDcij/bbX8bS+iTaaCoxhax66JW+X
	AsbcV4hDRGXiYDWDQmwbKpgcu+g6Cx1pm8CP7hLsDZyWaUBdOj1Wlfp4SeEkBkBYDYh8OLInEhH
	RDzqWaUtLZOx4/Y2c7V/LlxTAiV+/7jTAtQJ3BOrS+x4XXTDyawIFGHpSqGF9LSDj+lCzqVbkIl
	s0ljFSTY3IAXeNQuPXdEGzIT4p3T0iQ9kQRvhVifyJeOgFse84hBXu284nfkVYhPRlgwzU4D4qS
	vjgBmSCcKwK8ypgbr6uaHMIcqpQ==
X-Received: by 2002:a05:622a:50b:b0:4f1:b9ec:f6a4 with SMTP id d75a77b69052e-507527b8798mr223872261cf.33.1772572539201;
        Tue, 03 Mar 2026 13:15:39 -0800 (PST)
X-Received: by 2002:a05:622a:50b:b0:4f1:b9ec:f6a4 with SMTP id d75a77b69052e-507527b8798mr223871711cf.33.1772572538483;
        Tue, 03 Mar 2026 13:15:38 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b1e3:9a00:3c7:56c2:f819:96d2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074481c0e5sm156286991cf.0.2026.03.03.13.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:15:38 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Tue, 03 Mar 2026 16:15:23 -0500
Subject: [PATCH v3 03/10] rust: pci: add {enable,disable}_sriov(), to
 control SR-IOV capability
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-rust-pci-sriov-v3-3-4443c35f0c88@redhat.com>
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

Add methods to enable and disable the Single Root I/O Virtualization
(SR-IOV) capability for a PCI device. The wrapped C methods take care
of validating whether the device is a Physical Function (PF), whether
SR-IOV is currently disabled (or enabled), and whether the number of
requested VFs does not exceed the total number of supported VFs.

Set the flag managed_sriov to always disable SR-IOV when a Rust PCI
driver is unbound from a PF device. This ensures that when a Virtual
Function (VF) is bound to a driver, the corresponding Physical Function
(PF) is bound to a driver, too, which is a prerequisite for exposing a
safe Rust API that allows a VF driver to obtain the PF device for a VF
device and subsequently access the private data of the PF driver.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
Changes in v2:
- Set flag managed_sriov to disable SR-IOV on remove().
- Use to_result() to handle error in enable_sriov().
- Note Bound device context in SAFETY comments.
---
 rust/kernel/pci.rs | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index af74ddff6114db3c2ce8e228c5a953cd0769e8a5..e1cab1574a3d309d25bf5267c0b0d8da8fb66d44 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -82,6 +82,7 @@ unsafe fn register(
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*pdrv.get()).managed_sriov = true;
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
@@ -458,6 +459,38 @@ pub fn set_master(&self) {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
         unsafe { bindings::pci_set_master(self.as_raw()) };
     }
+
+    /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
+    /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
+    #[cfg(CONFIG_PCI_IOV)]
+    pub fn enable_sriov(&self, nr_virtfn: i32) -> Result {
+        // SAFETY:
+        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        //
+        // `pci_enable_sriov()` checks that the enable operation is valid:
+        // - the device is a Physical Function (PF),
+        // - SR-IOV is currently disabled, and
+        // - `nr_virtfn` does not exceed the total number of supported VFs.
+        //
+        // The Core device context inherits from the Bound device context,
+        // which guarantees that the PF device is bound to a driver.
+        to_result(unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_virtfn) })
+    }
+
+    /// Disable the Single Root I/O Virtualization (SR-IOV) capability for this device.
+    #[cfg(CONFIG_PCI_IOV)]
+    pub fn disable_sriov(&self) {
+        // SAFETY:
+        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        //
+        // `pci_disable_sriov()` checks that the disable operation is valid:
+        // - the device is a Physical Function (PF), and
+        // - SR-IOV is currently enabled.
+        //
+        // The Core device context inherits from the Bound device context,
+        // which guarantees that the PF device is bound to a driver.
+        unsafe { bindings::pci_disable_sriov(self.as_raw()) };
+    }
 }
 
 // SAFETY: `pci::Device` is a transparent wrapper of `struct pci_dev`.

-- 
2.53.0

