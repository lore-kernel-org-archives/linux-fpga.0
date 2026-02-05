Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011432E72B
	for <linux-fpga@vger.kernel.org>; Thu,  5 Feb 2026 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770325236; cv=none; b=uKRciaKtmlb8+RfuSAdw0VhZHBq9bFgAm70TVk1woE4EvEYzLb+mj1c95RFnrzUoWJIA5BX9V3qrkn7SsyWMXsNZul+QkalPHDHqRe64ARztG6Vdj48zaNEnHeSqPTl1mxNACAEAL9iFUi4Cn0VyB/X3h9w2cli0q1eMHiHPIqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770325236; c=relaxed/simple;
	bh=goR6NT6+KiuW9XKjlJCHBNrcq9pPIxNj+WVW2jrpGs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CPih7aET46CHQITJPXXCREGGKsX9vg8cqSzGJiEE8NJdX54ZidI6i99lX8UvUFE2OMn0bkhgSGqfW2sJp+L3fFMLLMd6Ori+uqPjtRELeA0Xwk/ZxKuwq2V+mRdowhMC7cq/VVWPx84owtkQmN60PX3cBk4kiR9xUtcH2RWaeiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B838K7RV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QbJ6YRsm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B838K7RV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbJ6YRsm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770325235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEZ/NIGEd7tvljUjuiPoVXU22CsIWWTrf8BQDchgWf0=;
	b=B838K7RVZ3xvEyVUrLjkRi2Mv926uLlnBlH/Jc+7jGLN2q9RyTqfAOEt0Iijwy4e4UWe+/
	9A1FMzTVr3CXgWlv+YhyVsuT+/E/7MWpaLVaLcs3rIMKqYD3HWBhYz7BGsryJG8T4yAFcO
	TDiiEu0dxWIQfEmkXWXxiBMqaySVAWU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-pMwk4HziOg-A1dAK5wU4Eg-1; Thu, 05 Feb 2026 16:00:34 -0500
X-MC-Unique: pMwk4HziOg-A1dAK5wU4Eg-1
X-Mimecast-MFC-AGG-ID: pMwk4HziOg-A1dAK5wU4Eg_1770325233
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-894766748f9so85881956d6.1
        for <linux-fpga@vger.kernel.org>; Thu, 05 Feb 2026 13:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770325233; x=1770930033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEZ/NIGEd7tvljUjuiPoVXU22CsIWWTrf8BQDchgWf0=;
        b=QbJ6YRsm+Bp7e4TG7/79hxn8+evKLC73comgETOLNF75gBfZwyaiE4g0SzGd9tA0AV
         Kn02G4hDOALkgCDanHrG9Gy43LVj8eTuRJyGbM1jzJn/+ECbEmhNJ82hFDUGHQ3evob6
         07CuUDOxhefiwxG6+iVC0ykQJpIRbSDvy0HU/ohlxB+kAiBH4MPHfN8f5RKfklXKZau4
         Rqrd6apfjGELR/SVIxtKbz4q1SB2OjAa+jLDxJVhrY3HuvxLhWVG4KWNia9kY0X9IVp9
         I0R4IR4xHmYbGX4nHoblTYQjJ/UPOETOJcpg1i4p+taieciQ+fungMNd/LQlG7UnzpHo
         vkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770325233; x=1770930033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qEZ/NIGEd7tvljUjuiPoVXU22CsIWWTrf8BQDchgWf0=;
        b=lpN3Y82h9ICVzLvWs/XQ8TB5MPSXK0UCBa7nDkW52UD7+rxU+q3K37tiSC4xlAFZOM
         SSeTDufrPi8obCA+aQ+S0loQVJKTbUzdDjojpHs4SNgs/Gwb+3RsAt+AMN/lzW2mN4Vd
         t2qVGg8pzl1TdX5KRYctId2WX+yXMUEEFnoGogTEM+7EFh7I01GmuE68NJI2VYDpTHLd
         QpbH0ozZlcceHxpFBSrTQGW2d7vPzDI1fzK6qOAE6VyRrIhoTJckUTnCECztvY52yCnD
         BHrYNbCC4m3YzgKj3maXR1Q6Ai9vn+WoVEzDS3O/1TP9D4sBdTzliRogoouWA2eNmjMs
         neNA==
X-Forwarded-Encrypted: i=1; AJvYcCVR1AMUrFE7H1Oho2A/pGbbmvhJqxhVsu1kzP/NvCj06lZUcbyU59u8Z6Pq5bDB6hBObiZAqEOqqHbW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2m/UQhwoYgAm6aKqYtVRnf76b1Yp1XEB8DFqbM/g/jjUWLEYH
	FNRUOfXfOo+tg4w1v5y31+m4KPlYQ0DgRb2iQ6bw+cEEaI07YIAU7Ttl5JnGSd+iBIgQesaSumy
	FELs/n+L1P/m85YWdnIIAp03wkQhcBkHXtCkmEo9wU/OzGSPSJtgi1jmqFoBri4s=
X-Gm-Gg: AZuq6aJp/ZTIvVj5nXQYEdeeKOHCDpM7H/7TW6uoBAbx5hSILJMe4EmBBAbsH/knGZ2
	ApRdXcMNMIgbgneCX9VJE1ex2IFLcazAZvIBS2aow4PMp7VmklaFSeEXg9YLxuaHURqCEgUuwup
	5V7TlyUaPfQVcPG/DfUd1qyLPQPt2hGwEIBa+El2b8d4egOg0v0F+97Cv5YtJWGwK1QDzODf696
	bOnFdIUrDS/a1sPhyArtzWrHp0WuKRUWzpYwkpqPs6JpzADzaH+a1uvopz8OG4bDKggvAWDyX9Y
	jdRE7Q24iTDGoB0HOseWgpNXBZr8zSgT3IOrc5Bqg3lXa7B6eO0M+xxym4sOdTaZy/Ce1Ez/rqW
	BIVUjvR54Qn22rdg=
X-Received: by 2002:a05:6214:4017:b0:88a:3681:1d96 with SMTP id 6a1803df08f44-8953cd9c94fmr5941946d6.63.1770325233459;
        Thu, 05 Feb 2026 13:00:33 -0800 (PST)
X-Received: by 2002:a05:6214:4017:b0:88a:3681:1d96 with SMTP id 6a1803df08f44-8953cd9c94fmr5941106d6.63.1770325232827;
        Thu, 05 Feb 2026 13:00:32 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b010:9000:4c85:f148:4c91:943a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9fdf692sm17571285a.44.2026.02.05.13.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 13:00:32 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Thu, 05 Feb 2026 15:59:53 -0500
Subject: [PATCH v2 06/10] rust: pci: add is_virtfn(), to check for VFs
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rust-pci-sriov-v2-6-ef9400c7767b@redhat.com>
References: <20260205-rust-pci-sriov-v2-0-ef9400c7767b@redhat.com>
In-Reply-To: <20260205-rust-pci-sriov-v2-0-ef9400c7767b@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
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
 Moritz Fischer <mdf@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-fpga@vger.kernel.org, driver-core@lists.linux.dev, 
 Peter Colberg <pcolberg@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.2

From: John Hubbard <jhubbard@nvidia.com>

Add a method to check if a PCI device is a Virtual Function (VF) created
through Single Root I/O Virtualization (SR-IOV).

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
Changes in v2:
- Add #[inline] to is_virtfn().

This patch was originally part of the series "rust: pci: expose
is_virtfn() and reject VFs in nova-core" and modified as follows:
- Replace true -> `true` in doc comment.
- Shorten description and omit justification specific to nova-core.

Link: https://lore.kernel.org/rust-for-linux/20250930220759.288528-2-jhubbard@nvidia.com/
---
 rust/kernel/pci.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 88bd114970431bf8c3edef94c1d48567d895eaf6..db05641186c3a42922e2b6a463de9c1b099a4673 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -484,6 +484,13 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
         Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
     }
 
+    /// Returns `true` if this device is a Virtual Function (VF).
+    #[inline]
+    pub fn is_virtfn(&self) -> bool {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).is_virtfn() != 0 }
+    }
+
     /// Returns the size of the given PCI BAR resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {

-- 
2.52.0

