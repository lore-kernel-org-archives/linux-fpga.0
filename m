Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1923A0EAB;
	Wed,  4 Mar 2026 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646612; cv=none; b=Wc82MASWhsix8ozrmPl1SV9Ev8pzdFKGs8r7Hz1D8kGfBHr9cobRnqpVDXeEKERbocsD4GG1f7vFp8ucao6fm7e8WSaRjj4HISWg0kKYlVo4lP/FK2bxEYnmfvmI0AtszYCPpTSvgwWFjt8OzsQbGxADFDkR2y+i1tQe2Ig4SWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646612; c=relaxed/simple;
	bh=E4znfVinBg671eglK8T1taFw+aFY5/rXYKUjl3WI3wk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=or+2Xg9iOIA2/rh/o17WpP22ilBBN1RCqZ/FSlDHfdgirmTTlxLw8IdsdjfNMxnRcJ6vo4o+tFHR/6egod1ftgde27puVZe5d3byo1ZSot4kUCxI9CYq+GYaswZzI7jobc96cOIC7pyvY84GCLeMX65704X8GV+xbeBbHwLojS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnxaPJez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnxaPJez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F283C4CEF7;
	Wed,  4 Mar 2026 17:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772646611;
	bh=E4znfVinBg671eglK8T1taFw+aFY5/rXYKUjl3WI3wk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=BnxaPJez/SGvWsdn9rFcxp1SWi2seMtpjZi8xUe0Em3idKqLKyZUYNWYn5P8zZSAL
	 J1sdpkcRmZ5TJ03pG7ShVlWlXqP2po1Dqta5bAqqQBQeiFn8l1In6EXafPYi9hNSWj
	 7LkWlTwuYY6dQNI6zjtrp0cVxXMR+r53gJCFfTVOKZWm3HmOa2KWXuE0c4v3e6XegB
	 DO3RcT+4GZS9MPpiApeygGxi09mPDKR3qNT/v4y3tgtK3WQdKd1km1ffLByhFC4zf+
	 q4DWNAG1ulOiDVZOpKolL38Gdck7at60opVYY6NlMIViFWDgQvDP7APYg2Nf+MhV78
	 S6Jpfw8wqH5YQ==
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Mar 2026 18:50:02 +0100
Message-Id: <DGU6RZ7MWNAV.21PQC3NNK05D6@kernel.org>
Subject: Re: [PATCH v3 00/10] rust: pci: add abstractions for SR-IOV
 capability
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Peter Colberg" <pcolberg@redhat.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jonathan
 Corbet" <corbet@lwn.net>, "Xu Yilun" <yilun.xu@intel.com>, "Tom Rix"
 <trix@redhat.com>, "Moritz Fischer" <mdf@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>,
 <linux-fpga@vger.kernel.org>, <driver-core@lists.linux.dev>
To: "Leon Romanovsky" <leon@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
 <20260304084750.GW12611@unreal> <20260304141852.GF964116@ziepe.ca>
 <20260304142600.GB12611@unreal> <DGU347RJX5BV.1CZYELSZ9GS9D@kernel.org>
 <20260304162711.GI12611@unreal> <20260304164551.GG964116@ziepe.ca>
 <20260304170249.GJ12611@unreal>
In-Reply-To: <20260304170249.GJ12611@unreal>

On Wed Mar 4, 2026 at 6:02 PM CET, Leon Romanovsky wrote:
> On Wed, Mar 04, 2026 at 12:45:51PM -0400, Jason Gunthorpe wrote:
>> On Wed, Mar 04, 2026 at 06:27:11PM +0200, Leon Romanovsky wrote:
>> > On Wed, Mar 04, 2026 at 03:57:57PM +0100, Danilo Krummrich wrote:
>> > > On Wed Mar 4, 2026 at 3:26 PM CET, Leon Romanovsky wrote:
>> > > > On Wed, Mar 04, 2026 at 10:18:52AM -0400, Jason Gunthorpe wrote:
>> > > >> On Wed, Mar 04, 2026 at 10:47:50AM +0200, Leon Romanovsky wrote:
>> > > >> > On Tue, Mar 03, 2026 at 04:15:20PM -0500, Peter Colberg wrote:
>> > > >> > > Add Rust abstractions for the Single Root I/O Virtualization =
(SR-IOV)
>> > > >> > > capability of a PCI device. Provide a minimal set of wrappers=
 for the
>> > > >> > > SR-IOV C API to enable and disable SR-IOV for a device, and q=
uery if
>> > > >> > > a PCI device is a Physical Function (PF) or Virtual Function =
(VF).
>> > > >> >=20
>> > > >> > <...>
>> > > >> >=20
>> > > >> > > For PF drivers written in C, disabling SR-IOV on remove() may=
 be opted
>> > > >> > > into by setting the flag managed_sriov in the pci_driver stru=
cture. For
>> > > >> > > PF drivers written in Rust, disabling SR-IOV on unbind() is m=
andatory.
>> > > >> >=20
>> > > >> > Why? Could you explain the rationale behind this difference bet=
ween C and
>> > > >> > Rust? Let me remind you that SR=E2=80=91IOV devices which do no=
t disable VFs do so
>> > > >> > for a practical and well=E2=80=91established reason: maximizing=
 hardware
>> > > >> > utilization.
>> > > >>=20
>> > > >> Personally I think drivers doing this are wrong. That such a driv=
er
>> > > >> bug was allowed to become UAPI is pretty bad. The rust approach i=
s
>> > > >> better.
>> > > >
>> > > > We already had this discussion. I see this as a perfectly valid
>> > > > use-case.
>> > >=20
>> > > Can you remind about a specific use-case for this please? (Ideally, =
one that
>> > > can't be solved otherwise.)
>> >=20
>> > You create X VFs through sriov_configure, unbind PF, bind it to vfio
>> > instead and forward (X + 1) functions to different VMs.
>>=20
>> No, illegal, and it doesn't even work right. When VFIO FLRs the PF it
>> will blow up the half baked SRIOV and break everything.
>
> The FLR can be disabled. For example, PCI_DEV_FLAGS_NO_FLR_RESET flag
> will do it.

But this is a quirk and not a feature, no? So, we shouldn't use it as a bas=
eline
for actual features.
