Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EA342F55E
	for <linux-fpga@vger.kernel.org>; Tue,  3 Mar 2026 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572554; cv=none; b=hNoo1Sg0yaKIuVp44FQvzH1DKw0ojgF935kbDFnKIpp5cFdr/dKDaosJg3iK6mK0pmdl0WyZ0AB89pXX6NZZy8tei0EC03lvDs1AkdYebxiXjsx7P8gKMYekkKaPMMdtC2Bx3FVCbByty+WcMId0y3j+bdl05gzqsaeAhhZhE7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572554; c=relaxed/simple;
	bh=njU3I9YW/zDKjP+0RxMLdIuH1MmdjiC7YPBjwAwiJ4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uHCwTxpltzq0lpq2CMKsHXI7gBcE2z7DKTRHg5+x0x3SMyQBS/uAAF4IUtEfsWyx6VQijp1oDEJgMzW3E8A2bqN2g2J0OwPlT0uHhoWfcAr/wfW4rEdBoxG7Tr5wEmbkzCPJtMWOBYox/QQI9a6WW8GHCm+NFHQP7Iv/gBO1ymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwcPEOXW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwmBIwlY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwcPEOXW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwmBIwlY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772572551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nsl81xXoWOrG7fZ6D3nnOVMYFTWE73QzzhAJNIpS3Uk=;
	b=dwcPEOXWn4opOtp5G4RGm5qe6Qz8rm7pfGdh0iMeUmwtKZG1yxHkIjnz/6sJhozPAg+jGw
	BPhmntvzfQDpKMFQMutl5w4Jxup0LEhbRpr7gCvdTgViYsgeXzt/BoyBXL0C3zI7P4NxJL
	YVXY5CJRUTZn9VOUgJbM7LkXFNyw/XU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-sEqAVoyQPKyq-n9T65o8jA-1; Tue, 03 Mar 2026 16:15:50 -0500
X-MC-Unique: sEqAVoyQPKyq-n9T65o8jA-1
X-Mimecast-MFC-AGG-ID: sEqAVoyQPKyq-n9T65o8jA_1772572550
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50340e2b4dfso653365391cf.3
        for <linux-fpga@vger.kernel.org>; Tue, 03 Mar 2026 13:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772572550; x=1773177350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nsl81xXoWOrG7fZ6D3nnOVMYFTWE73QzzhAJNIpS3Uk=;
        b=BwmBIwlYkgPM4nkteh9HIu+jXvgEbaJgWAQeo4P4bfoSxoTsSw2yHO4p/KeeRtmaFr
         OIBl1288NNGOuT5B3vU45YNr1CgHAImY3BNMyNOY9UInFpWDcJnsGYGYsfvai85jUyxf
         LcfJsOKvlKYcRYUTSa3YbLyJbvOV1OcCYDZxoL/qspwKphq8UEDAGDPMWFXdreO69EEB
         OUnRu4allFNpQ+kRiLMMqCxS9MMAeGFk4VP2w5Tnko6gVPcR0GVcquRUCtpNtNZsyt6s
         pELoOZ17E7il4HBJul69sT3fXRR7OFjvCy0V1zDO8Q7R5jBazfMIJEJl37jU3TcxoIz1
         68Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572550; x=1773177350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nsl81xXoWOrG7fZ6D3nnOVMYFTWE73QzzhAJNIpS3Uk=;
        b=Zvn/Grez7g1GaoAoFs9m7WMBjsrwRCQbCjQi+UbKvcRB/yhscWWZSQ2tKnpyi3m8t8
         hP+LawxyT/e7P1y16M4c/OGH7Dm7mbvz3Y0mrhlR5/lUfwHEwDP6XevRnCt3AiGDGZQy
         EAgc4zRC3wZxUOKU7lhFs/AARqJ7ROq990qseLi/yXep+xWb5SX2+uV8glUlzZ6cWT8f
         +vBYgsxbGFwPHCkrgY4vcUJeCKKRPCu1W/rcuExcMW8e2A8oxm6lwX8KsRzI7nR91x1r
         7BhcmA1P4Y2xXaWhTeTs3RJnnlQNSOoiHvNAC7I1xabvC8nbYdULjHAyj6lbc85IPtq2
         AMUw==
X-Forwarded-Encrypted: i=1; AJvYcCUfBdi4BdqBrJqnC+Yv9opFtVO08E1m7NSj2Co1O/ZDFxPokjN1O+ymCVgWGBmsjo4//QJY51UIYr2k@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJdJ3QXMEdQ71hf1zpRDgqZ+sgEQ4IAFf/8wJZpb+ksZOzOWC
	PV2+NxNCYTzjeWvY7dhdX65hqlKF0G0LiAxN6jNl1eCEk5LCYkf+J/GQne9qcOTtPm6SuErURSV
	ukmVWUKfj4RHiZvZ9wSKHhMy4527a3mpoEojz0nCzAmMg13aY9f3g+GrX1/AKz6E=
X-Gm-Gg: ATEYQzwBZjCQIRWO2SsrSqDCoHD1Mf4ViFmbwA796oE8DvNf3Sj5AieCQuOp6/dfnGX
	WFKXHKrAshgJ3TBgta15oEk1gUfob5kt1gQ8BzIrTkLAZZJvCQ2Ar0RZCuWPkkxIvCoKErXud0Y
	Du4PAYMZFkMN2h5m7rI2LFj1+c2OEKACn8sAHF6bVkV1dRTrTl8RjWM2Ws06ozIozb0975fmFk6
	Ro0B5eJYZt8DsuSfmrG2Md7FbL0+zSTxMKbM6HV6stMtTB25U/+ZGKL6p3sfT5nGeuvUSFGjJ51
	1TTgOHdIumi3ZW5drXjDAkNz0d/4MrkJFOylTP6i0ItqFa041ogY2rguPfKUX0P5WuKg8LcwfFU
	InCKm6aj/sW1xSFPFPJ0E9oppXw==
X-Received: by 2002:a05:622a:1895:b0:4f1:ccea:6744 with SMTP id d75a77b69052e-507528db6e5mr222734551cf.58.1772572549583;
        Tue, 03 Mar 2026 13:15:49 -0800 (PST)
X-Received: by 2002:a05:622a:1895:b0:4f1:ccea:6744 with SMTP id d75a77b69052e-507528db6e5mr222733911cf.58.1772572549028;
        Tue, 03 Mar 2026 13:15:49 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b1e3:9a00:3c7:56c2:f819:96d2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074481c0e5sm156286991cf.0.2026.03.03.13.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:15:47 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Tue, 03 Mar 2026 16:15:28 -0500
Subject: [PATCH v3 08/10] rust: pci: add num_vf(), to return number of VFs
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-rust-pci-sriov-v3-8-4443c35f0c88@redhat.com>
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

Add a method to return the number of Virtual Functions (VF) enabled for
a Physical Function (PF).

Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
 rust/kernel/pci.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index df39ad3f0d5fd898b034609efb03368f83c2a2e9..581930d0afe98ccc29d729e4d9aab75b4144e46c 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -498,6 +498,13 @@ pub fn is_virtfn(&self) -> bool {
         unsafe { (*self.as_raw()).is_virtfn() != 0 }
     }
 
+    /// Returns the number of Virtual Functions (VF) enabled for a Physical Function (PF).
+    #[cfg(CONFIG_PCI_IOV)]
+    pub fn num_vf(&self) -> i32 {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { bindings::pci_num_vf(self.as_raw()) }
+    }
+
     /// Returns the size of the given PCI BAR resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {

-- 
2.53.0

