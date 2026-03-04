Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4843CCA1E
	for <linux-fpga@vger.kernel.org>; Wed,  4 Mar 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646334; cv=none; b=XDlbT+OnJQdVyjlIroSdQqEq0ZOLbAgunzbpszUFoznICcfBw+mnMS2Cy9/CBbv7kve3kYCbQUsesBDgKgH/IbSqzeKFMWpKg/nljoYhmwOP98gkiLsf7d2EnH5abM7PgYD1dkeFOtLQve5RwR1lQ4t/6ZQ307OJsvz1bjurN0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646334; c=relaxed/simple;
	bh=Z/NZQvcQCIgLMH/ylHiLwhG3hRbIZ3DJdjrycXHaYe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jq8NAHkqNPpsoGEKouP8Yt48gacToYLok+RBYQpos+KLAQhPhpCntE6qNElMSzuxWqcstwCAtEgOr01Oh12kTOPpY8XvsBkrKaxj5zw1G0X+feXT1zLNB2WVKKUkMTcbg9T99VBQaapwUXWKe5nSa+/wkzbbWbwZ0soxVHmp8R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ciuh2OlT; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ciuh2OlT"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb49f63238so395353285a.0
        for <linux-fpga@vger.kernel.org>; Wed, 04 Mar 2026 09:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772646332; x=1773251132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nSAtzjXqss+uxlpk1YxZqBQHrNvbCWRFoP2RW9VjGUc=;
        b=Ciuh2OlT5LbvGe2fLekjmWaFRmLjXcQ8+K3Q2RMQB08V72mMUT0d237S0cMP6/MXfw
         xOh94/jCUlZlk2z3AQAWmVtiXffk4ko/7txAqj5IN+gGXZlSvQHwcpHwxfY4sFJoIhAr
         k9CEkvEz/XaO/jKOZ3On01JDbOyBodBB/PafBIsJUHAXpcfODzDv15OBeNLanlFRmJlg
         DTA3dqlCpMRh1aDznm5plekJncXeDjPx5SzQi9XBjcy++ug5Qv9kMpuW2raKxItuExKP
         Sygl9M7ucBy54LbxYgn3kddbZhxLymSNrR89fDjKrpBekrPlT79wZ34Wf5QPYwzSK9m0
         IIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772646332; x=1773251132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSAtzjXqss+uxlpk1YxZqBQHrNvbCWRFoP2RW9VjGUc=;
        b=dJ3/9066lOYsTEoE6bDsyBD/ukx93leVUyloGXfj6pZAdXc90L6b0u6fkYlb6j1J8m
         deGqZCJ+C2RERd9mK2VRA4FFR4dw4sOZNILeZA9Aw/JD2wQwcvoxpydLCKc9KinwQeO3
         q9fCuKh4jTp4BC7fKNC4QZmj146Ea77Qx/Cutbve0iqHcUm48IzJJupSOsoVDzW0lMRf
         iKRpQTX46kqIIC4L3/ZEYc+VVPl14up72wfs6QGJ6IE2ZLdplw0Z7KzxViFaWbECGfQr
         iBDCyHzkfi72nhd2npHXSahQB0NOodUujBVlkXHbjr9zIKOEFLYCOsEUqXD3n2j9hHN9
         LYVw==
X-Forwarded-Encrypted: i=1; AJvYcCXUl0Cam+X4B0ZRBFzpHwCwwzcwRnZWjtJWbXrgHli9DfLwllIceG3H7X2ZB3+kEEDrk/+JumHdx+Wy@vger.kernel.org
X-Gm-Message-State: AOJu0YzgOyIyeyAfZ+YQrzcxzMcjXuHB/BjLIsYkMZe+3y/TJNbtw9cT
	oiAeKANgzs6KuCNL7hZE+EJ3G/ANqLTeUsXMXJMUbwRgf60zSFEdnboW7ztwu68pBEA=
X-Gm-Gg: ATEYQzwfApCbfH89GMR+pkahSuR2fN/emKbxmkcpfkxTKyj+Zme4LoMou+Ud0VzCiS1
	ZHQVVUqVVxdXXYxt3eFKfhHuTjU5iZKBnR4N7odnfftOOplXju34a13tU1EDACOEvSerEpy1Ygk
	hfrgUJVW43rHS5J60nceEMX9A/EgCvzV2bXli8kxIGYAz0yMKxx9RgovvEMGY/PdEzgeDj4B6/p
	2xwPBYcjfmkMoMLxpqblQE1G5OoSOEFals8jeYyNtpYINVsGlW9pwTvqXR90nqAgeac/KyDOnMN
	EfgH+zlIbxX3CnXx4j3/bapK0Gu6HHQFCccuxEp39Drg0F71RSvyj3Ln7qCyTAqBcJxGDhI4nVI
	fc8CyQ5W7juTrcieuhEPNWM2lIST85pLXSGqb/1NL6uDEpfmdiQjL0h75KmYh1L93BDY8e4ngW+
	LudU8iFDb+Vu0Lud0m5o1NRYNFMIh/1ANVqjOCykZP/dFooX5O8Lkoszv7vRBZfwwNy+jj4/vEO
	nd4nNf/
X-Received: by 2002:a05:620a:4481:b0:8c6:ee09:5eae with SMTP id af79cd13be357-8cd5adb8d1cmr343907185a.0.1772646331749;
        Wed, 04 Mar 2026 09:45:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a1fcb781fsm8074876d6.23.2026.03.04.09.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:45:31 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vxqHq-00000005ET5-2S2S;
	Wed, 04 Mar 2026 13:45:30 -0400
Date: Wed, 4 Mar 2026 13:45:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Peter Colberg <pcolberg@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Boqun Feng <boqun@kernel.org>, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v3 00/10] rust: pci: add abstractions for SR-IOV
 capability
Message-ID: <20260304174530.GH964116@ziepe.ca>
References: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
 <20260304084750.GW12611@unreal>
 <20260304141852.GF964116@ziepe.ca>
 <20260304142600.GB12611@unreal>
 <DGU347RJX5BV.1CZYELSZ9GS9D@kernel.org>
 <20260304162711.GI12611@unreal>
 <20260304164551.GG964116@ziepe.ca>
 <20260304170249.GJ12611@unreal>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304170249.GJ12611@unreal>

On Wed, Mar 04, 2026 at 07:02:49PM +0200, Leon Romanovsky wrote:
> > No, illegal, and it doesn't even work right. When VFIO FLRs the PF it
> > will blow up the half baked SRIOV and break everything.
> 
> The FLR can be disabled. For example, PCI_DEV_FLAGS_NO_FLR_RESET flag
> will do it.

Well that would break all the security properties of VFIO.

> > VFIO already has its own sriov_config support, the right flow is to
> > bind the PF to VFIO and then enable sriov and do your assignments.
> 
> VFIO started to support SR-IOV in 137e5531351d ("vfio/pci: Add
> sriov_configure support"), which was added 8 years after VFIO core was
> added cba3345cc494 ("vfio: VFIO core").

Well, time to upgrade, I see no reason to allow Rust drivers to
further propogate these mistakes.

Jason
