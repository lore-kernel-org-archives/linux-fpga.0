Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4733FE36;
	Wed,  4 Mar 2026 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643775; cv=none; b=UGJ6TQ4YJYH5nncw1+y+z91q1McbdxX6QpGhi9b3MlVvuLqIeceoWrLuH/Er5h3OXlde0ScC8RAI5s+6OG6BDGxUZotyPOkXb5QPGK1v38oO+nZRuu7AUz59lRmeEtIGCLresKnebdDsl0zO0SpNOOZ2aC2/I3D28ukPkTDjc7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643775; c=relaxed/simple;
	bh=aQJiY+2LCpzOcjrCyzcepEU8dJcqg8IvU44AMFz8v8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WI9twAkVh/HnycgHULkkSPpTfr/K+FTvCYE5vuYSIuKcJ5IJ4IemlK46kV7DXFenx2Z9M5ebmV3O9waG6sVhLvjMgjXohSSKtXrzp/BRC8FlWJ7tz9qXDyDYX7ed0HzUe1XaP+XJj7OlhpjrKA9CMixQK0yntLq2An0D6wT4SkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT9WUdDN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT9WUdDN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E299FC4CEF7;
	Wed,  4 Mar 2026 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772643774;
	bh=aQJiY+2LCpzOcjrCyzcepEU8dJcqg8IvU44AMFz8v8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hT9WUdDNSy78CtuA5kRf8mQTtoKTD2m4CXqf1thar1iHcKkmiNrxKPCHdoElX4ohB
	 GJDqQsLP/WI73C6u7MnKL/Gb7KlEuu21xLrOKbYRwd9hh4ETIowZMcVQnwJMF+AW59
	 EB+Tx62lWZlXgwqc23A2gC7Qy/YSjqMWXY5pw1ZrYR+nwYmCaXxLlqBaT4sWnEo64J
	 kFp6WTGP1rKSUpvrvYKc8sFz6to48D29AXlhF3+Sth6C5ewzSWg61wqJBIfw2mHGO6
	 CxQy0KUPVlSHwQUBw0X9FEkUIXbr6zoXZeMdEpLEiGVhiWv6rtRd9oAVIhrXmPhEaz
	 pYUq2rUyfTtOA==
Date: Wed, 4 Mar 2026 19:02:49 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Danilo Krummrich <dakr@kernel.org>, Peter Colberg <pcolberg@redhat.com>,
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
Message-ID: <20260304170249.GJ12611@unreal>
References: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
 <20260304084750.GW12611@unreal>
 <20260304141852.GF964116@ziepe.ca>
 <20260304142600.GB12611@unreal>
 <DGU347RJX5BV.1CZYELSZ9GS9D@kernel.org>
 <20260304162711.GI12611@unreal>
 <20260304164551.GG964116@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304164551.GG964116@ziepe.ca>

On Wed, Mar 04, 2026 at 12:45:51PM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 04, 2026 at 06:27:11PM +0200, Leon Romanovsky wrote:
> > On Wed, Mar 04, 2026 at 03:57:57PM +0100, Danilo Krummrich wrote:
> > > On Wed Mar 4, 2026 at 3:26 PM CET, Leon Romanovsky wrote:
> > > > On Wed, Mar 04, 2026 at 10:18:52AM -0400, Jason Gunthorpe wrote:
> > > >> On Wed, Mar 04, 2026 at 10:47:50AM +0200, Leon Romanovsky wrote:
> > > >> > On Tue, Mar 03, 2026 at 04:15:20PM -0500, Peter Colberg wrote:
> > > >> > > Add Rust abstractions for the Single Root I/O Virtualization (SR-IOV)
> > > >> > > capability of a PCI device. Provide a minimal set of wrappers for the
> > > >> > > SR-IOV C API to enable and disable SR-IOV for a device, and query if
> > > >> > > a PCI device is a Physical Function (PF) or Virtual Function (VF).
> > > >> > 
> > > >> > <...>
> > > >> > 
> > > >> > > For PF drivers written in C, disabling SR-IOV on remove() may be opted
> > > >> > > into by setting the flag managed_sriov in the pci_driver structure. For
> > > >> > > PF drivers written in Rust, disabling SR-IOV on unbind() is mandatory.
> > > >> > 
> > > >> > Why? Could you explain the rationale behind this difference between C and
> > > >> > Rust? Let me remind you that SR‑IOV devices which do not disable VFs do so
> > > >> > for a practical and well‑established reason: maximizing hardware
> > > >> > utilization.
> > > >> 
> > > >> Personally I think drivers doing this are wrong. That such a driver
> > > >> bug was allowed to become UAPI is pretty bad. The rust approach is
> > > >> better.
> > > >
> > > > We already had this discussion. I see this as a perfectly valid
> > > > use-case.
> > > 
> > > Can you remind about a specific use-case for this please? (Ideally, one that
> > > can't be solved otherwise.)
> > 
> > You create X VFs through sriov_configure, unbind PF, bind it to vfio
> > instead and forward (X + 1) functions to different VMs.
> 
> No, illegal, and it doesn't even work right. When VFIO FLRs the PF it
> will blow up the half baked SRIOV and break everything.

The FLR can be disabled. For example, PCI_DEV_FLAGS_NO_FLR_RESET flag
will do it.

> 
> VFIO already has its own sriov_config support, the right flow is to
> bind the PF to VFIO and then enable sriov and do your assignments.

VFIO started to support SR-IOV in 137e5531351d ("vfio/pci: Add
sriov_configure support"), which was added 8 years after VFIO core was
added cba3345cc494 ("vfio: VFIO core").

Thanks

> 
> Jason
> 
