Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A8542F57C
	for <linux-fpga@vger.kernel.org>; Tue,  3 Mar 2026 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572551; cv=none; b=ZB0udENzXXiTL5LEvee/alfZ3vBeea75Cg3Mv8jFV0u8k5eqG1tZzrAr1W5BqYeg/v1+QjEDrlgoiZ7x/tOSf1eN5wEJ6PJ76YVXD4Rke/hD7SwUOn2W7UsYWosU5zfzwW6rJSDqlpVh85oVNWJQe+0r+bR2fMBPpgR9CiV9WVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572551; c=relaxed/simple;
	bh=s6mYU8Hu6u0tbKnwvAlOQsSAlR2qHgbV7fvzmNOhT1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BPnqY7Mm1vexlPSNGY+Cf++ppgb8BcEt92XCytDHcfmgv+ewUIiX7KUoA5tK+Tz9sApaUrz7d+yAMRjA2FFQjRNITrtm/hC0Fmuvnzco0wZDqQO4MqUrzQ4ZBTTkiWyU/HRCcVM0TyOoxpgiThPrwNG+hk73tbPoSUDZjUNlC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTkyQ1MI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kCAw1JBI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTkyQ1MI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kCAw1JBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772572548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLYDkNQ8A4x2T95jGRETa6NwStvleq7OKd2uXV0vocw=;
	b=BTkyQ1MIwdUr4SBnXaUoXkx2/qFXyrU5CIbfGcjArGrolbt/qJhAi2ziLVJz6vGm6IY23v
	UryGmw1nwaJVbxhzmYw/2pymwQ8XtHp17lugdIOZ9Q9g6Og820zug/p1Ip5J8SE0Mk91mb
	7FMRsKvQOEObo489Ivyt+Wyxi/oCehw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-6Thi64hDO6i1NRr5o_qqdA-1; Tue, 03 Mar 2026 16:15:47 -0500
X-MC-Unique: 6Thi64hDO6i1NRr5o_qqdA-1
X-Mimecast-MFC-AGG-ID: 6Thi64hDO6i1NRr5o_qqdA_1772572547
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-506ae021853so72635321cf.1
        for <linux-fpga@vger.kernel.org>; Tue, 03 Mar 2026 13:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772572547; x=1773177347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLYDkNQ8A4x2T95jGRETa6NwStvleq7OKd2uXV0vocw=;
        b=kCAw1JBIAXWRPZw4JUJv49YAWrljxCYbXksrBYpDoKBqfunUfLS7XVJD34AMw7f9pe
         lBP1ZOc6g2DZt9+ns25+uobgikZUqykOa6qiBIW+8Z6HDs3PQkeOn7oop4BuHgH2fU0+
         tyR6uRyuj41vz0FroNhHCjkmE5cabgSEgLWg7iZKShrJDXnc8UMmwJjxTMgiI1P3tsSv
         x2/6YqkSZgykeNdS9iOKTP25rRy32reg30RkLHB5d9B2be7QENmC9tAVVCikFcbaqii+
         3ExfTwxriP55kHvkyPhwceUhX+3o4RHe6gIsk8tNooyfKnefiYQoBGa7nU78ddbgToCW
         n2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572547; x=1773177347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qLYDkNQ8A4x2T95jGRETa6NwStvleq7OKd2uXV0vocw=;
        b=PbkzQnB7ExGseREpS0wsJpG4z9pgEr0x9a7Eeej65UqZN6CluYU664p+Vukz+foAI1
         kuxqCvKhKIqoejTDXYhn7AhkRUJ4lAevnhGWdtCfih4KfssR594plDnlgI7Ct7SSTPnl
         Q7KeeSsLlid0xlwDLrV32cc2jL4ILHyi459cJXvONP0FzJK1yxYNlyWHk5NUqj9FRCH3
         HAEmGGIW7NEMnnH6iNqPJGHJcmBkhaqtCPDiRz1KPwjeaRi6hVtW31GYbZ4PGXFfPjee
         SI+f9YXPCJRhGZkM63PwT1TGhKqyGuO0qfsnsdtMQ6j4TSEDvxz3SJjxEv9ywkpxnXON
         1yrg==
X-Forwarded-Encrypted: i=1; AJvYcCU18lcgXviBOiabE+ng+K75aHaHQ1OaSpAd3rI1uPS+xSAOnsToeNVL224faSwrrbrhMq+icaiJnK0l@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5dptjOaLPgUK0F86X2bSNsm6incmCpsLOs1Y/papk/hbTWc5r
	Vk9QLZiMVurI9pogxvTVlbaPbPPlW53WYYEt1sObMtVsSeE4E+8ehxFxpx5XqW4PNaiXQ0YgPtq
	9IoFo5RRHTSiIronML6yywggXsMT9JZOzBz3GiYC5bg6+hIzAHEYatDX+bL7jiYs=
X-Gm-Gg: ATEYQzygoawC5SalXwzV1LaQix1Ks8W5ryM3MEshQ4ac7g52T5X8DEgenxODnxtDxeg
	dudOHJpMuLOJEwUITJmscb+mDJcartdgQvn4FkBDOq3yhJcLPVp6V/edcnfH0AETqyJpf1U7MHS
	aAYU9aHQPeuDVdSBW2301WCzTEHq++D+U5Co0ZfYo9WEXckaQ6QAM3z5JJdjfSq5cGyLZKJX7oB
	a2J0zS8tT1clyxJ5z6/eio7674L/3l3CpeWV1F2xP4QtTBf+tFF6zbBjYGl9J9zGoRc7GlGgxJW
	g0xYiq0Z+0k5Z4Iu9mjT1WVVgXzWAKMaO0fFRJGKwggiIqxIgGOu4409DLGcHFOnCXA3Fl2kPv/
	tmmE5x4CD41k7RhK+yfGd44S3Kg==
X-Received: by 2002:a05:622a:64c:b0:4f3:5652:6743 with SMTP id d75a77b69052e-507527cc1c1mr213308891cf.39.1772572546786;
        Tue, 03 Mar 2026 13:15:46 -0800 (PST)
X-Received: by 2002:a05:622a:64c:b0:4f3:5652:6743 with SMTP id d75a77b69052e-507527cc1c1mr213308331cf.39.1772572546254;
        Tue, 03 Mar 2026 13:15:46 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b1e3:9a00:3c7:56c2:f819:96d2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074481c0e5sm156286991cf.0.2026.03.03.13.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:15:45 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Tue, 03 Mar 2026 16:15:27 -0500
Subject: [PATCH v3 07/10] rust: pci: add is_physfn(), to check for PFs
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-rust-pci-sriov-v3-7-4443c35f0c88@redhat.com>
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

Add a method to check if a PCI device is a Physical Function (PF).

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
Changes in v2:
- Replace VF -> PF in doc comment of is_physfn().
- Add #[inline] to is_physfn().
---
 rust/kernel/pci.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index db05641186c3a42922e2b6a463de9c1b099a4673..df39ad3f0d5fd898b034609efb03368f83c2a2e9 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -484,6 +484,13 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
         Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
     }
 
+    /// Returns `true` if this device is a Physical Function (PF).
+    #[inline]
+    pub fn is_physfn(&self) -> bool {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).is_physfn() != 0 }
+    }
+
     /// Returns `true` if this device is a Virtual Function (VF).
     #[inline]
     pub fn is_virtfn(&self) -> bool {

-- 
2.53.0

