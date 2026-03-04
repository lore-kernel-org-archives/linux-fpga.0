Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19AF371CF5
	for <linux-fpga@vger.kernel.org>; Wed,  4 Mar 2026 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772642757; cv=none; b=SGlK5aiFFrpOGFiDvFFYj5CdeXccqqTx4zYAZQMuB1BtWy63qXATRWOe421Z5MmUXFT/TSTWF47Djswt+cPeZidhKyKc9bHC6LfLKUnO0gNkPw5cNrN6cBCk5BYqlHFincNF57Mng0cok1W9PJ4yaIaS+Dd1NASnao7yosS2mX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772642757; c=relaxed/simple;
	bh=6pAgg7PwRmYTS9sfT7RMwokWO0KOx6td5LNtCpZdbfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skiAfq+EsDZbuqKBcJ2eh7p9lXHUnrdWht2eolqxoXCy0w2q/476Ssy83Mc8OYlLuX9fDgN95m6SF5nuejw4rUwrUX1PRwzXvyM5pzo0kPt6IE1dF4f45i28tlo2QX8mG9oY6pzfkOuGCsGfNMlZ1oqAO2QoR95cgvQLPbwh8D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ud6A6r1+; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ud6A6r1+"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-89a05955720so39768036d6.2
        for <linux-fpga@vger.kernel.org>; Wed, 04 Mar 2026 08:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772642753; x=1773247553; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q6mBd5S5w+Qyk+kaNVLUq/NDaIG3PNFY6vyWjAmF/Cg=;
        b=Ud6A6r1+bHRxJNYf8G8kHphVUeyCOg+pUAFdANqR7rzdB4IgFobMnWmmC8/dkSlwZk
         W5pmK93pu85/JbL9itjDQyiMSCmefo26iYavmvrVgZs/ZuUb0mHputv1yvFDQ8qsi0Sl
         0kUTIMWBJ54P6wXjN6uhDE1xCj97YotZ7vpEonxJLN07kJIPGvgujQKJLb+Ce1iCydWW
         dc6zpiuTYh+K4HOa0NzUv+DYQDR+lGKq4TvxV/WW839TW7EgJz9GErqcrNw3T92Zb9G0
         wclkmpl6xlFd96apLB45jMxM6j38XlyOg3DAjTLV0ktP2fK+9pjYbQTdylIxNx8m8dzk
         1gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772642753; x=1773247553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6mBd5S5w+Qyk+kaNVLUq/NDaIG3PNFY6vyWjAmF/Cg=;
        b=lKkSJVbro/Bxdt5+4j2lmCvZWNvGrRKY8LKwDX/Rx/kB8kbZ8xCRbEWpw7bn2kxiyS
         UDfbSu9GB207Qb+M145TKii7OOq4WTXt1kmwCx1hqaaoEVhsYX3ySqvmI6Vi6d0tI7y3
         m6E5i4eNDSfg8wdWz7M83CScr7rwi0PJWqn33LZj+YXqQNzyvvId+4Q4xNzvmlPVUIdl
         0TKRkU7ApN+Lav2oyud94rMLYGK6WwqIpZPtD1u11MFtQ8FoVhTrOkhJNygzR/A3Qb2o
         wCYXQL+0U1TJwz19LAhCwTAvxKN/I8QbgVJZ0RCg/w51Rfqu4H0b+oGlUyG1upFcqXNo
         ymBA==
X-Forwarded-Encrypted: i=1; AJvYcCWrT3vjfSqqDRQI6OUqBalmOYVVEmJlOp4UMGdSk1FuXrtLm4JcLQI/JyXZFirCgmfzlNw9xAeZLkki@vger.kernel.org
X-Gm-Message-State: AOJu0YwEWbairOrwScnBMZzZ44tedPcOc5KRdPEjFhezXYAmbAx1ioJI
	kork2OuLvhrmOhQWh1pllZyjaoZA3EFzO+f3VEcnIA1VhVIolN2eslfu3Uu3d7vcKj0=
X-Gm-Gg: ATEYQzxSndvoT1LTJWw1c7+O61R1q9bFwGmpD46dnYOYGDwWQeuW8Nem1pdfiL9lMDC
	5gHildPCKzU++zvIafqOBE5t+3ZYAyc/SRj7i/o88E7cKRtKtpucyI6q5xM5KtJVrl0eeIvBqom
	i224hp81rdK6UJrlhfpYmerwcwXTd+W3uk1dko16Z1vCnPEwBE02NyXrKZ6uOBU9KNi50mkYvYu
	Z8kcLamE5fgr93qkYNUDMtuUFfqHNkvOY4DmLbL3JsUen4UDElbVhlz8lnEiZeBIhyzjXg6bu0J
	mu4RRWhVMK9T9Am+Kck10lFWZlzh9/dyi0bjn/m57I7hgkOdkoEk04xJVH5kJbojAsIvxX/6oWT
	0jYOXfYoRkFt6QhmUFYQXVZhTQuD3VWyAr1JKBmR7xjpbefutnJ9zEWU90RWQRA+O+yIFRmujRW
	6hDGLwusmpHwR4quktsTn4sTiHDSTbzt23QZN6OfkNO0KqGo3edUQEpPfzB4iBfB1AjTt8VLhqI
	Cf3LTlqvMt2MbO15yg=
X-Received: by 2002:a05:6214:cc6:b0:899:f2af:bd85 with SMTP id 6a1803df08f44-89a19ce9729mr37872326d6.45.1772642752542;
        Wed, 04 Mar 2026 08:45:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899fdf30e99sm69421516d6.3.2026.03.04.08.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:45:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vxpM7-00000005CBf-1l90;
	Wed, 04 Mar 2026 12:45:51 -0400
Date: Wed, 4 Mar 2026 12:45:51 -0400
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
Message-ID: <20260304164551.GG964116@ziepe.ca>
References: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
 <20260304084750.GW12611@unreal>
 <20260304141852.GF964116@ziepe.ca>
 <20260304142600.GB12611@unreal>
 <DGU347RJX5BV.1CZYELSZ9GS9D@kernel.org>
 <20260304162711.GI12611@unreal>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304162711.GI12611@unreal>

On Wed, Mar 04, 2026 at 06:27:11PM +0200, Leon Romanovsky wrote:
> On Wed, Mar 04, 2026 at 03:57:57PM +0100, Danilo Krummrich wrote:
> > On Wed Mar 4, 2026 at 3:26 PM CET, Leon Romanovsky wrote:
> > > On Wed, Mar 04, 2026 at 10:18:52AM -0400, Jason Gunthorpe wrote:
> > >> On Wed, Mar 04, 2026 at 10:47:50AM +0200, Leon Romanovsky wrote:
> > >> > On Tue, Mar 03, 2026 at 04:15:20PM -0500, Peter Colberg wrote:
> > >> > > Add Rust abstractions for the Single Root I/O Virtualization (SR-IOV)
> > >> > > capability of a PCI device. Provide a minimal set of wrappers for the
> > >> > > SR-IOV C API to enable and disable SR-IOV for a device, and query if
> > >> > > a PCI device is a Physical Function (PF) or Virtual Function (VF).
> > >> > 
> > >> > <...>
> > >> > 
> > >> > > For PF drivers written in C, disabling SR-IOV on remove() may be opted
> > >> > > into by setting the flag managed_sriov in the pci_driver structure. For
> > >> > > PF drivers written in Rust, disabling SR-IOV on unbind() is mandatory.
> > >> > 
> > >> > Why? Could you explain the rationale behind this difference between C and
> > >> > Rust? Let me remind you that SR‑IOV devices which do not disable VFs do so
> > >> > for a practical and well‑established reason: maximizing hardware
> > >> > utilization.
> > >> 
> > >> Personally I think drivers doing this are wrong. That such a driver
> > >> bug was allowed to become UAPI is pretty bad. The rust approach is
> > >> better.
> > >
> > > We already had this discussion. I see this as a perfectly valid
> > > use-case.
> > 
> > Can you remind about a specific use-case for this please? (Ideally, one that
> > can't be solved otherwise.)
> 
> You create X VFs through sriov_configure, unbind PF, bind it to vfio
> instead and forward (X + 1) functions to different VMs.

No, illegal, and it doesn't even work right. When VFIO FLRs the PF it
will blow up the half baked SRIOV and break everything.

VFIO already has its own sriov_config support, the right flow is to
bind the PF to VFIO and then enable sriov and do your assignments.

Jason
