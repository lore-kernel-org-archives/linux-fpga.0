Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC768351C1F;
	Wed,  4 Mar 2026 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649031; cv=none; b=Y/UWwo1BNLEqWiicU2sg6RvDEv9uTnvqlj9Uie8QYs0Oy4mKP++hm6UOUgfhrscdJy4Y49iRGpACNHf2AONBigUOubkNCDY6FVuI/hwPr26DTyn4hEkTQDPS2xpc36C0ldVhmcWTKRcJE7v6HgSfYC7OsF38X63sYYnHL8mGGt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649031; c=relaxed/simple;
	bh=3A4++snizBAapyNv68E4VeyeJMe0EyUIxq7+6aoLznk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXRk/VdMZBzOC3D0aoM9OR+eucAZStdiIHNVxy+nHPu8R07lnV4S6A+5Xz9/wGqNZaRc5Nnbct10AibUQmmTvEC/db9pr2on8+2wllNt5Lzf9nyECbYTN3wDKWLrCZbOQPddxxBaKqEeCPUZbA9r7mvzgn4B+0vWbC3dSG4eMoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMsxj+87; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMsxj+87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAFFC4CEF7;
	Wed,  4 Mar 2026 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772649031;
	bh=3A4++snizBAapyNv68E4VeyeJMe0EyUIxq7+6aoLznk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMsxj+87FNW8R3BcSUdbOojVubkEI7VXqH9UxVPAUOcHueIEQb1GIz8KKHKTqAqVI
	 ZDRh6/Vy76t5TbW5ooVwhfM0Z1eW1sFBb4/qX60gdJcTJqEeOzxmT+Q5rZF2AOCy8G
	 SFhg73lSDr9D807CtE3lcQWrkydaLeVwlwOM7w2II9Caujs0XZ48t60V1T5Lqtx7I6
	 JB7gaZJmOIGcqdGDqBw7Hh5T6/RknLhXcAs+TTtXbXnqK4xKDfYm2dZFlVDn3jdGaf
	 VT13DGOk6qaZibn5zURj9ob4JTHGwSpmaCf6WHh8IG1eub1Y1luUumT3GWiFSaZcLq
	 ACufVT2HiwNJw==
Date: Wed, 4 Mar 2026 20:30:26 +0200
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
Message-ID: <20260304183026.GK12611@unreal>
References: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
 <20260304084750.GW12611@unreal>
 <20260304141852.GF964116@ziepe.ca>
 <20260304142600.GB12611@unreal>
 <DGU347RJX5BV.1CZYELSZ9GS9D@kernel.org>
 <20260304162711.GI12611@unreal>
 <20260304164551.GG964116@ziepe.ca>
 <20260304170249.GJ12611@unreal>
 <DGU6RZ7MWNAV.21PQC3NNK05D6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DGU6RZ7MWNAV.21PQC3NNK05D6@kernel.org>

On Wed, Mar 04, 2026 at 06:50:02PM +0100, Danilo Krummrich wrote:
> On Wed Mar 4, 2026 at 6:02 PM CET, Leon Romanovsky wrote:
> > On Wed, Mar 04, 2026 at 12:45:51PM -0400, Jason Gunthorpe wrote:
> >> On Wed, Mar 04, 2026 at 06:27:11PM +0200, Leon Romanovsky wrote:
> >> > On Wed, Mar 04, 2026 at 03:57:57PM +0100, Danilo Krummrich wrote:
> >> > > On Wed Mar 4, 2026 at 3:26 PM CET, Leon Romanovsky wrote:
> >> > > > On Wed, Mar 04, 2026 at 10:18:52AM -0400, Jason Gunthorpe wrote:
> >> > > >> On Wed, Mar 04, 2026 at 10:47:50AM +0200, Leon Romanovsky wrote:
> >> > > >> > On Tue, Mar 03, 2026 at 04:15:20PM -0500, Peter Colberg wrote:
> >> > > >> > > Add Rust abstractions for the Single Root I/O Virtualization (SR-IOV)
> >> > > >> > > capability of a PCI device. Provide a minimal set of wrappers for the
> >> > > >> > > SR-IOV C API to enable and disable SR-IOV for a device, and query if
> >> > > >> > > a PCI device is a Physical Function (PF) or Virtual Function (VF).
> >> > > >> > 
> >> > > >> > <...>
> >> > > >> > 
> >> > > >> > > For PF drivers written in C, disabling SR-IOV on remove() may be opted
> >> > > >> > > into by setting the flag managed_sriov in the pci_driver structure. For
> >> > > >> > > PF drivers written in Rust, disabling SR-IOV on unbind() is mandatory.
> >> > > >> > 
> >> > > >> > Why? Could you explain the rationale behind this difference between C and
> >> > > >> > Rust? Let me remind you that SR‑IOV devices which do not disable VFs do so
> >> > > >> > for a practical and well‑established reason: maximizing hardware
> >> > > >> > utilization.
> >> > > >> 
> >> > > >> Personally I think drivers doing this are wrong. That such a driver
> >> > > >> bug was allowed to become UAPI is pretty bad. The rust approach is
> >> > > >> better.
> >> > > >
> >> > > > We already had this discussion. I see this as a perfectly valid
> >> > > > use-case.
> >> > > 
> >> > > Can you remind about a specific use-case for this please? (Ideally, one that
> >> > > can't be solved otherwise.)
> >> > 
> >> > You create X VFs through sriov_configure, unbind PF, bind it to vfio
> >> > instead and forward (X + 1) functions to different VMs.
> >> 
> >> No, illegal, and it doesn't even work right. When VFIO FLRs the PF it
> >> will blow up the half baked SRIOV and break everything.
> >
> > The FLR can be disabled. For example, PCI_DEV_FLAGS_NO_FLR_RESET flag
> > will do it.
> 
> But this is a quirk and not a feature, no? So, we shouldn't use it as a baseline
> for actual features.

My point is slightly different. I was trying to explain the rationale for
preserving VFs after the PF is unbound, a design choice that predates the
introduction of the VFIO .srio_configure callback.

Thanks
