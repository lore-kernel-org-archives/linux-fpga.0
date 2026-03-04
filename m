Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280F53B4E94;
	Wed,  4 Mar 2026 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636287; cv=none; b=ateR9XdZPzUmtkG7U+JwS4vNB2JhJodZvnXg0NtwPg0RBlxz12Ye3KxlnHr3u8imyBB6ppjxQ7bqKs9XVaA6OlNBX7pBdP6xSbZ/7MpdFJm42Cz9K4hV/9oX9B26oxF9BvOi/1JDlGl4/rX5VQTZuiRlNoUeMUjTyWVNyIPsO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636287; c=relaxed/simple;
	bh=dOS1j2epf5TPYMaiUEFBxK4GWJCF7AnlRNLv83KiR6E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Nc1GFWo3KdYYtI80GJqIBI7UEDMvYhnJpxm9GQLaWNKKzZvcZyIKM8y4ulpMlXR/i9tde7Hiv7M7q7lSP+j/xwgB2/8cnVSdzLfmVpcRR7Blhu94Ae4iKjEWd715lgvVjbMKj5fvCx7Z0BLxATCY1ommkrOw58j0o3iiidMApUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym9EQcZf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym9EQcZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46750C2BC9E;
	Wed,  4 Mar 2026 14:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772636286;
	bh=dOS1j2epf5TPYMaiUEFBxK4GWJCF7AnlRNLv83KiR6E=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Ym9EQcZfkOKBQHZvEQz/FhHVNSqmg+h+6mOr4awZN6lqVP89047H95oA7hDTD8Lxp
	 3/zrrsmHItaW0dHSdzHTPMNUEEPPrdDoAQGGe9wmG6r942WlV+NEL+DcbydsnltayO
	 SnkhnV7y40XDZUGJYiA6FsWGZM40iGremynvaU5Cw1rh8jc4wDHWy/miN2N3sbvfLc
	 Rn1TTCZbSsbm8xMotdnloy7atDTjiCMTCuYwLsPrm4P+VZShXKneJTrYQO7TL2CS2W
	 aGLtKXusmSvGJfMzJsY89VPeZZyDFz0aM8vrKSLF2R5CeTp1fFyviINf8C+4nr6mjK
	 wEsHpF7yuJvaA==
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Mar 2026 15:57:57 +0100
Message-Id: <DGU347RJX5BV.1CZYELSZ9GS9D@kernel.org>
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
 <20260304142600.GB12611@unreal>
In-Reply-To: <20260304142600.GB12611@unreal>

On Wed Mar 4, 2026 at 3:26 PM CET, Leon Romanovsky wrote:
> On Wed, Mar 04, 2026 at 10:18:52AM -0400, Jason Gunthorpe wrote:
>> On Wed, Mar 04, 2026 at 10:47:50AM +0200, Leon Romanovsky wrote:
>> > On Tue, Mar 03, 2026 at 04:15:20PM -0500, Peter Colberg wrote:
>> > > Add Rust abstractions for the Single Root I/O Virtualization (SR-IOV=
)
>> > > capability of a PCI device. Provide a minimal set of wrappers for th=
e
>> > > SR-IOV C API to enable and disable SR-IOV for a device, and query if
>> > > a PCI device is a Physical Function (PF) or Virtual Function (VF).
>> >=20
>> > <...>
>> >=20
>> > > For PF drivers written in C, disabling SR-IOV on remove() may be opt=
ed
>> > > into by setting the flag managed_sriov in the pci_driver structure. =
For
>> > > PF drivers written in Rust, disabling SR-IOV on unbind() is mandator=
y.
>> >=20
>> > Why? Could you explain the rationale behind this difference between C =
and
>> > Rust? Let me remind you that SR=E2=80=91IOV devices which do not disab=
le VFs do so
>> > for a practical and well=E2=80=91established reason: maximizing hardwa=
re
>> > utilization.
>>=20
>> Personally I think drivers doing this are wrong. That such a driver
>> bug was allowed to become UAPI is pretty bad. The rust approach is
>> better.
>
> We already had this discussion. I see this as a perfectly valid
> use-case.

Can you remind about a specific use-case for this please? (Ideally, one tha=
t
can't be solved otherwise.)
