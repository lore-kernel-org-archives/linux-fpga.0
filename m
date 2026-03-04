Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A424F36C0CB;
	Wed,  4 Mar 2026 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614074; cv=none; b=tDMAZVqDU4pttL2pvWqox9AT2Yt2wTdQdTaIF7/2WWZmjI6tUYOOavzc54fCVgyIkJ8RAUrCgUCfehcEYSmdJR048bn0GX8lCSitICsqQ6UnymUU9qgJP5JYGaKhaaR0FvKc69m9hu0FbSAamQgoYphy9tLfByJgkf85EWTSkT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614074; c=relaxed/simple;
	bh=q+uTTk+Tl69Kd6bd84m1ZhgW1BhIv3PD7PYeGemtd4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz4xX5H9IhLBZd4nv6h4EvOY5KW74zBUH65akkUlAnRJ3whGkYOPLhtz5DCdriD8GCSs9mu84HfF1JQaq5QAWgUJ00RqAGbjC35GaV3QvGaww99RQun6YLPOQSEzjph/jGwh+HIXFm4uafQwqOPmMj/ZzVhQ7TN91x8VNmuHeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGJ1QxVS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGJ1QxVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A627BC19423;
	Wed,  4 Mar 2026 08:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772614074;
	bh=q+uTTk+Tl69Kd6bd84m1ZhgW1BhIv3PD7PYeGemtd4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGJ1QxVSx+yDBHFSGoiEA2QyfySvBh3UP/gWJq3VOBTvYMvejMq8Rzpzqmukquutx
	 t2OTkdGkFfjSoNlRUuQHsgRR2xPyC48SdWHcHPMUqRWp8gTeKSSWi5DJpATFoDNtZ9
	 6eXTKs6/AXKf3TjhGc64AYu971aZ4AAO/zQACZtsTZBjYnwb7TRHrdWWzPAuac4+uI
	 uwf+ggXetFVdGtF6buvhLTW9e2UF/v1T5XqeceHaXg+bYpa0CX6BxkGll5sZcYS8Wk
	 QY08VrLwU/YutzRmF/PxK5OygjVR6y6ITvSo4XVbV1CW+cGGQcFSGVrXVfj/KOs/S7
	 pmv5gl2WFBVIQ==
Date: Wed, 4 Mar 2026 10:47:50 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Peter Colberg <pcolberg@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
	driver-core@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 00/10] rust: pci: add abstractions for SR-IOV
 capability
Message-ID: <20260304084750.GW12611@unreal>
References: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>

On Tue, Mar 03, 2026 at 04:15:20PM -0500, Peter Colberg wrote:
> Add Rust abstractions for the Single Root I/O Virtualization (SR-IOV)
> capability of a PCI device. Provide a minimal set of wrappers for the
> SR-IOV C API to enable and disable SR-IOV for a device, and query if
> a PCI device is a Physical Function (PF) or Virtual Function (VF).

<...>

> For PF drivers written in C, disabling SR-IOV on remove() may be opted
> into by setting the flag managed_sriov in the pci_driver structure. For
> PF drivers written in Rust, disabling SR-IOV on unbind() is mandatory.

Why? Could you explain the rationale behind this difference between C and
Rust? Let me remind you that SR‑IOV devices which do not disable VFs do so
for a practical and well‑established reason: maximizing hardware
utilization.

Thanks
