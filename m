Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10EC366058;
	Wed,  4 Mar 2026 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772641635; cv=none; b=Xq8HoZBKB6rIidHwVoVFcS5uNMhuBhbfJYC7Gg2PTdDtt24cqm9jUifzNLaPllAWLWDfly/GT5rOHIWRNeVMy0EindR/n8VgFpwZt4aVBeLaRsUGaO5p6rB9vW2mzqjOnIvP75z4nknvFVaQDZPyZmuuOEQ7jZV0Ls9rm5yUw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772641635; c=relaxed/simple;
	bh=AfCEMFEFaW523pTkeEMztclMFG542ecaBMBKu13UGZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+Lw41hWcPcjfOIza0+0Dux01W9FREK645zDwtpKxdKSqbR4/GGlD8uLPyih0wuGThxXSQnNcGQ4zmJZkUTLrNjo8B/sVgmwn/lu4HVSvBAafajHiA3DUfGKJ9kq6Hp5McJJtwDoP2XffvpMC/Aie8BKlP+2xHgxqAgPC0ruuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KV8L5eiQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KV8L5eiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2EBC4CEF7;
	Wed,  4 Mar 2026 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772641635;
	bh=AfCEMFEFaW523pTkeEMztclMFG542ecaBMBKu13UGZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KV8L5eiQbBVOpo+OeokNyKPYBoKK5g7vSE/nknwa473tAFw/QjlmcNO0ix4gySsJR
	 P8HGEuYKgLhs2iM5qBup4aRAoDdpXBSoN6aXuQpuSZQdcyK32b9CU44GBf06JQKrxe
	 A0138itmdBGIzt7qc/FuKDjEYCSXJY2vYvZFDzZpkQ24AdU2CATXVuKtzKQ417beN1
	 1HdgzguxGjgcfat/rasyFw88NZA2mgp2RTQ+oZK6lzIyI5/4MvYgarsiLUsmNN3co+
	 4kUUCcvOouTRL65YcHGShRf++I/qi/7S9VXcwYBddr2f7ugd4CGFQAwpy46t5yyczu
	 ppjBkqA5Ki4Cg==
Date: Wed, 4 Mar 2026 18:27:11 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Peter Colberg <pcolberg@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
	driver-core@lists.linux.dev
Subject: Re: [PATCH v3 00/10] rust: pci: add abstractions for SR-IOV
 capability
Message-ID: <20260304162711.GI12611@unreal>
References: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
 <20260304084750.GW12611@unreal>
 <20260304141852.GF964116@ziepe.ca>
 <20260304142600.GB12611@unreal>
 <DGU347RJX5BV.1CZYELSZ9GS9D@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DGU347RJX5BV.1CZYELSZ9GS9D@kernel.org>

On Wed, Mar 04, 2026 at 03:57:57PM +0100, Danilo Krummrich wrote:
> On Wed Mar 4, 2026 at 3:26 PM CET, Leon Romanovsky wrote:
> > On Wed, Mar 04, 2026 at 10:18:52AM -0400, Jason Gunthorpe wrote:
> >> On Wed, Mar 04, 2026 at 10:47:50AM +0200, Leon Romanovsky wrote:
> >> > On Tue, Mar 03, 2026 at 04:15:20PM -0500, Peter Colberg wrote:
> >> > > Add Rust abstractions for the Single Root I/O Virtualization (SR-IOV)
> >> > > capability of a PCI device. Provide a minimal set of wrappers for the
> >> > > SR-IOV C API to enable and disable SR-IOV for a device, and query if
> >> > > a PCI device is a Physical Function (PF) or Virtual Function (VF).
> >> > 
> >> > <...>
> >> > 
> >> > > For PF drivers written in C, disabling SR-IOV on remove() may be opted
> >> > > into by setting the flag managed_sriov in the pci_driver structure. For
> >> > > PF drivers written in Rust, disabling SR-IOV on unbind() is mandatory.
> >> > 
> >> > Why? Could you explain the rationale behind this difference between C and
> >> > Rust? Let me remind you that SR‑IOV devices which do not disable VFs do so
> >> > for a practical and well‑established reason: maximizing hardware
> >> > utilization.
> >> 
> >> Personally I think drivers doing this are wrong. That such a driver
> >> bug was allowed to become UAPI is pretty bad. The rust approach is
> >> better.
> >
> > We already had this discussion. I see this as a perfectly valid
> > use-case.
> 
> Can you remind about a specific use-case for this please? (Ideally, one that
> can't be solved otherwise.)

You create X VFs through sriov_configure, unbind PF, bind it to vfio
instead and forward (X + 1) functions to different VMs.

If you destroy VFs on PF unbind, you will find yourself with one
function less per-device, as you will have not-utilized PF now,
which consumes HW resources anyway.

Thanks 
