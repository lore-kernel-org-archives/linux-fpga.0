Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8414731AA9B;
	Wed,  4 Mar 2026 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634365; cv=none; b=HPMK2OaT7X3eWO5QY8dsgiuE2Vrs7426Eui+gwJl8eDTpGHrJBgVZ1ty+LRC75kUW1HQ0cqEHSQ1lF+83ia1RUAvtvuj14kSH4i2XxMSZqDCrndUU4/DuP9/pr/5oKCZALWVHsVZJJcHYUwVxViBdFR99iLOozxWcGc5989HhCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634365; c=relaxed/simple;
	bh=B0weNWDunmwVDkkQkN0kc7eG+tPkHSnvIyKW9SWUWPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUurjURWIww4u9oj/kGcb9ryyjEkGzLnwRK3PyyOT5MRoM+jtjN93+j5twVSqVlO2ZYPc1mGh5I+1M0m8Kcl5xhXcFPkmnosdIKvpNetlhN97C2MGpCMGWkTUd9w+GsVbAxgQhxaIEIhVvthW9V79Mna2fBwt4qnrAQyR49dLYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts/0Flsu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts/0Flsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833ACC2BC87;
	Wed,  4 Mar 2026 14:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772634365;
	bh=B0weNWDunmwVDkkQkN0kc7eG+tPkHSnvIyKW9SWUWPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ts/0Flsu+WenzEZfA5RIGH5FOlyHpWYzSgcefBgKg2f19RaSYz+irtf4VdJbC766a
	 NEaEpQ4umSV40OOs9ljryMEiSfaxm3WaBTUH3UGZdOvowqt/RrlEXVEAKUI6C31Gvf
	 sG/yB38kxV7mnWG2tWKaBWl+zjobjnciujPIucg+/jacQpHmpX7sP2g5nZzJTR2aZw
	 bKWY102ePDXk+dqRHGD/xD9P0Lzhe933nURcNLqi+A56D/2L2FMtcX/pA3iitdI5HO
	 WVnC3yjobyeiqlz2mpolNYTWQuQHio4sAY+ArQ4J4bALd5gkWoYuv152zQoKTasSQM
	 3hHcgssibybRg==
Date: Wed, 4 Mar 2026 16:26:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Colberg <pcolberg@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
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
Message-ID: <20260304142600.GB12611@unreal>
References: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
 <20260304084750.GW12611@unreal>
 <20260304141852.GF964116@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304141852.GF964116@ziepe.ca>

On Wed, Mar 04, 2026 at 10:18:52AM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 04, 2026 at 10:47:50AM +0200, Leon Romanovsky wrote:
> > On Tue, Mar 03, 2026 at 04:15:20PM -0500, Peter Colberg wrote:
> > > Add Rust abstractions for the Single Root I/O Virtualization (SR-IOV)
> > > capability of a PCI device. Provide a minimal set of wrappers for the
> > > SR-IOV C API to enable and disable SR-IOV for a device, and query if
> > > a PCI device is a Physical Function (PF) or Virtual Function (VF).
> > 
> > <...>
> > 
> > > For PF drivers written in C, disabling SR-IOV on remove() may be opted
> > > into by setting the flag managed_sriov in the pci_driver structure. For
> > > PF drivers written in Rust, disabling SR-IOV on unbind() is mandatory.
> > 
> > Why? Could you explain the rationale behind this difference between C and
> > Rust? Let me remind you that SR‑IOV devices which do not disable VFs do so
> > for a practical and well‑established reason: maximizing hardware
> > utilization.
> 
> Personally I think drivers doing this are wrong. That such a driver
> bug was allowed to become UAPI is pretty bad. The rust approach is
> better.

We already had this discussion. I see this as a perfectly valid
use-case.

Thanks

> 
> Jason
