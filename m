Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5B633506B
	for <linux-fpga@vger.kernel.org>; Thu,  5 Feb 2026 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770325241; cv=none; b=F+J7gHO+ZHOO6JJbEiJkHrZBZkoq4Vyim1xZ18rc8gWXAd//muNHe/8PQY/Gu92WcLNcwAbrF7f8v3AF7Ak0Hv0r05+bPPCEXQhR3GkVIsQi7XYBx5ul6kyakGQIczKNNfRPV23WCZF+KDt2DRGKcJUL2i6MjnVTMHtvkfjqF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770325241; c=relaxed/simple;
	bh=zYEg72eTegIm4aBsUkMl8q2KG4rMnFZIPR9seQA5Ej8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otqz3T90oopcJefJr1dtULYJ2tPyXXttIOFEjNbto//3X7oDCIbAIKPqwqiqPSBfpqNN4NOAILkv3n75lrAmz5TkRlrtHNuOW6FRzIrNgOSCL5wcAnlib3rG0fXdEOAIR3RuFfk3/pfELiGWiPxtYibFZR970W5lGRYdAIav8fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfvdjlNX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+PSR+nq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfvdjlNX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+PSR+nq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770325240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iChE2sHYyL+SE0NwtrGJ4SsAVC7actOKSXH6xK1kyOw=;
	b=gfvdjlNXLyYqwvQ1GxBILsJ26obKSZldv+dBuFw6geYhbv6zplUKvhNNEpliTsKM4RpOch
	1m0BiK0GIvbod7GMQ6VjW4ckC1joBtoI8ask6nH0ZCUm3VqPm00jkWKxNlxcCgsWomAnrB
	rgImUSTvSnEqPlIahgl6UzncAZ7G9Js=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-9EQ3DgGGMyOypV5A3LcWWg-1; Thu, 05 Feb 2026 16:00:38 -0500
X-MC-Unique: 9EQ3DgGGMyOypV5A3LcWWg-1
X-Mimecast-MFC-AGG-ID: 9EQ3DgGGMyOypV5A3LcWWg_1770325238
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c71500f274so180505085a.1
        for <linux-fpga@vger.kernel.org>; Thu, 05 Feb 2026 13:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770325238; x=1770930038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iChE2sHYyL+SE0NwtrGJ4SsAVC7actOKSXH6xK1kyOw=;
        b=f+PSR+nqSja3AkDKxPg5mAuHbp/eZpIVBhova0L9M2U3xQkV01sw+DZE3k7T/EayXn
         oy2PtbiJJU/enliZBjZS2CqaYlZ/ulfRYrWnUkkvmlU1/Qfs/O2vflq6nnocScESJVwZ
         3lS9OztANmWrJ34MlbqgaFbRtw9n2s4Quo88ytJzus5AxB0xeo8o381ZEm666s1DLBMU
         cv1vuiNICiSEmPUfHhsv19BjnQHbCScXSfucHI8Mx7pEzw8srBZlQsTUKWq6cNLjaEE/
         0svI7kdhQ7Vn40j/Od3UtyGe3Hb+NkRXGyFXGpZ9htwTeROMpWgVfKCxVf99typ8O3SW
         zT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770325238; x=1770930038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iChE2sHYyL+SE0NwtrGJ4SsAVC7actOKSXH6xK1kyOw=;
        b=loVsAne1Nb+wA/Rn1kEQhWovIGFsA93esKBbAmo7wnVj61ZW1k6pJ0sSTT7pIXrdZ3
         dLSVQsiG+DSpoAIRrerj0MJy4MJ57kUWyHFg5/hYz4w44JP58vff2zqZhGiAWAjAcxdd
         Aw/BsuyNSeVr2j5t0nhhSBhEy/bXXcP6yV9J/Jd2ux8DXg4ZUJEEtid06orBQDqwNB4Y
         ZGqBGR2mV7qExIkQKXy/15UVRaDolnF9Bb+AGkBv/WtgdkPn18bC97Y5xZTGDLrYRapP
         ppq26fIycjRulYRgvgbcRMy9R6/IPILv4GjE2rFCrdMec8JtJsDarn4FL0gX9oA/Sbdk
         xPXg==
X-Forwarded-Encrypted: i=1; AJvYcCUTbq3M/fJjlTEOpiK3hEVdAnYm+5I/BOGSPC73VyglHgJB/aIoxF88c4UGc8oEhIKNndXWFul66NZ9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ystQ4yo7UqOfraDqk0LXI5xmcQ5iGJ26V+rFpDMVpLNjoOUs
	AVsToqQlKm90JBY9dt9rBKUz4YIsjTSojlLkMFywwEU9KKCHv0mTT3KlJUxpSwkVJfjhbSkiDNn
	U7YvT1uE4BwJOTrCcN+5fQGMLLdKDT1sGSgZ0sj0GDnc8Vy+3CTSZi9XOP3xVAPU=
X-Gm-Gg: AZuq6aKTir788XIllZyCX4RVfF9Tu2yd7bPTZEol7IRWRNw8NuuWoMcTqFUeLLYoAnb
	bsogZ8MYI4f9NVVwxdb+S91YGz65YYVN6OapH5bG+CZ6TSoHCcw+Sk+k+yRqUh4qycPzUJ2/ni8
	6EuTZsQeTOHYJZud1hoFjL/syuJNez40IgduWp2FtBZKcRHhUosAvZut5NEL/AW+yK1OVR/iiNg
	YTUQvr9ZjzqR4gVocH7eQGmHQRcJS1hlI5JunRxoCQC7B7E8C+5hJKvcPjhSaoKOEETwRenAwz6
	/tRFQ5Fh44NDWeYosorB6Fb0yVdzCFRiOSgoR+g5n8Zf0SG9uK0kQcvI0OmPnF3Mmqm1fICjO1e
	HU2ZHpvsdY6LV7gI=
X-Received: by 2002:a05:620a:44cf:b0:8c5:3067:903c with SMTP id af79cd13be357-8caeeb50f3emr72336485a.11.1770325237517;
        Thu, 05 Feb 2026 13:00:37 -0800 (PST)
X-Received: by 2002:a05:620a:44cf:b0:8c5:3067:903c with SMTP id af79cd13be357-8caeeb50f3emr72328985a.11.1770325236916;
        Thu, 05 Feb 2026 13:00:36 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b010:9000:4c85:f148:4c91:943a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9fdf692sm17571285a.44.2026.02.05.13.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 13:00:36 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Thu, 05 Feb 2026 15:59:55 -0500
Subject: [PATCH v2 08/10] rust: pci: add num_vf(), to return number of VFs
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rust-pci-sriov-v2-8-ef9400c7767b@redhat.com>
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
2.52.0

