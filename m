Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB222EAD10;
	Fri,  6 Feb 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374834; cv=none; b=sTb/I85ZJ7QebdP4uH/deUiH2/mxsyhAH9u1b7G8np+Fn/35TNZymQGJ2tfwiuEGEGW5Utv5lHXnguPADJB/S43C27GM3upsTpqKzSTNnglk3+hSvwQgOnkdsG+L5FlDkKH2e7YxIaq1K5XAdiEIV0DdRK8dMncwO+BlzAieLgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374834; c=relaxed/simple;
	bh=hHVMdwW+wwkpn3m9YeQ+L1EfN1f7eOWIlEoTCcgPMEY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=pmOAx/Ti+ffNZHsk1B1E7YcEHyNvH3sjfcajed/pbSIQnc7Qp5RZ263VZXwwJmyVvVkW2dC49TmuCv/xE3UHkwlPUDw4aKCk3rRCmNs0V0ZhytqZnXJPKqydgwQqZmS0NWlTy9dkwchOtA26ux6lnajPanx0npX/L/2pkFetRNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+AaQumU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+AaQumU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAB7C116C6;
	Fri,  6 Feb 2026 10:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770374834;
	bh=hHVMdwW+wwkpn3m9YeQ+L1EfN1f7eOWIlEoTCcgPMEY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=k+AaQumUDRdLTa6+HJXM/M/ZH64/GRbY5Sqv5y58SCHivX8wv4BRcGRaowVuvFyi1
	 l28Re4f2IqBLyHlpTy4dN8W1IWVNDg2bE7GW8+GH9xWUgyaGCXCZo3dYHKB57jLjqf
	 zmXyX1z4VuYT388ufz63Rken35Iy8ckMJra7lWxw2g4eFKR+PB8yHBygXf8JlA5L0h
	 bI6q3oksHykbX/gZNI19GBo75SZjmanw9ZQ/Pg2qjHKSSzClGSADG1dTTbwx0h1pa4
	 gIf5BfRIxEW7v+EK+edD4iljRFXiQ1khCj5p93BXhkBGCwA0hjCaHCdU/P8Dt++g08
	 Vp6+VlLtcltpQ==
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Feb 2026 11:47:05 +0100
Message-Id: <DG7THZ3CYQYJ.LM9KKSFC48HI@kernel.org>
Subject: Re: [PATCH v2 00/10] rust: pci: add abstractions for SR-IOV
 capability
Cc: "Peter Colberg" <pcolberg@redhat.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Jonathan Corbet" <corbet@lwn.net>, "Xu Yilun"
 <yilun.xu@intel.com>, "Tom Rix" <trix@redhat.com>, "Moritz Fischer"
 <mdf@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Zijing Zhang" <zijing.zhang@ry.rs>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-doc@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
 <driver-core@lists.linux.dev>, "Jason Gunthorpe" <jgg@ziepe.ca>
To: "Dirk Behme" <dirk.behme@de.bosch.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260205-rust-pci-sriov-v2-0-ef9400c7767b@redhat.com>
 <4669209d-c53b-4cc5-ab2f-0f09aa5dfc50@de.bosch.com>
In-Reply-To: <4669209d-c53b-4cc5-ab2f-0f09aa5dfc50@de.bosch.com>

On Fri Feb 6, 2026 at 8:45 AM CET, Dirk Behme wrote:
> Or is this completely orthogonal?

Yes, this is orthogonal.
