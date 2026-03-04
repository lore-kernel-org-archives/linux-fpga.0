Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90A45478D
	for <linux-fpga@vger.kernel.org>; Wed,  4 Mar 2026 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633936; cv=none; b=ckFDDTXDQssDjGAK16DOsY+7YxA4QjZzj1QELWHb7O8+LFaD8Q6VAP/T5ykHteWUAP/WVJWCFwTwnEVxSuLHLSBDNkxo1RE6SdGyPS2t9Muu3/H2mkuA+Hl4yt7YTs/v39sdPqAcMa9nyrkdzIPtHc7P4BP0xphbeBUKjAhQU2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633936; c=relaxed/simple;
	bh=ICcHAv5R0LkVRgx1sRn/PLrNOjP1Y8guvnLI6zDoVjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuKfga5zPiagzJhdfQvCqDQxzGY81y3+Q4RkzqnT34v5wy0lHAsFe5pyUDS1LXGxpr95bP9mKOG+adksR0Ye+Sxs13+YNUmCTNsLJmyMl8TzsL5irnMvrmwMo6afhPI6Hjx8kpiLOGqz0iDQD7ta2Jtbp7QHNepCNcGU3FZaP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iwL4lwEp; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iwL4lwEp"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50334dd44d2so78491591cf.1
        for <linux-fpga@vger.kernel.org>; Wed, 04 Mar 2026 06:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772633934; x=1773238734; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VJb/uIHrYqSTg+GB6V2BLb5y0MXgSCVKzM/ARVauTlU=;
        b=iwL4lwEpCvPFTLKVYRUJqmDywzHksr4krRU+dweyR/1V3/x4lCcclEwfELn5hpEMsh
         ul3itfgjvGFUK6uiNkdkKr6yrwZAvVqHWdjOqGmZxXBBZ9IDxc/OilKKpdCqOhuZbvy2
         eyOEWGbGmHt00JbZKH7t4jx3JF/HWOxbioYRrn22qamI3Mp54zZi/HnsquREdDyjJzlo
         22xcK2mmHgrlqiA9cNKTxCuflpF3l6iiP/T6YJ9lS2DdSERR+PYP8hrCLrrsxZnUuSr3
         dBNjpEHfPJlBdxyZc91Fwe7oYMyjNlXPiY8NB4qv74ax/ZtCwKTtoqcgwR4HoqFhiQV8
         l2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633934; x=1773238734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJb/uIHrYqSTg+GB6V2BLb5y0MXgSCVKzM/ARVauTlU=;
        b=aEBKUNM2VHqAw9uP4Xs0D9bTsT1FV/SH/CZFN5LFNhcz8hlWbSdt9mYsrgXbIlBUvH
         EucoWy5iJ+QkVrc40jsCF7VQKowu8nx1pXFF+bHQxo2+dNLszg4InT2WX1ciTldAP6lK
         fj9nMg+iiDFvF8zs/C/fQ8wuPgtHCfo7+BSbjLmNnDW4GqVRUZycru7sTYr4VLDli7Wt
         fyCZ2M84VPljpGNI59/9FOcxjUgLadvrjMkiaWUdveoRqpJuHWoF7h1PwW+7RAkOBxsq
         ciAk08JutZUMa3CMPmUheTks+ZymEfkSOIM1ibKDYILgGmtxa7yZw62KxisSBLhcIQpQ
         Tf/g==
X-Forwarded-Encrypted: i=1; AJvYcCXRGL37qfpXAGT0ciSBsM737Jyyjvg0xMYRYfdHNpTtIjwjOgJ/oDCn11Ee1mUzYoZnfwFhLMjOW3QG@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAIuTm3+/XH+DBRSpZjzvCyVhqNfGbmiGcd7yjR7tdYD0QfOr
	WmFhvRTR4nJgzUjp0otDKL12RmoFAQBFZ3beQWvSLnMUgsPNTIZBjF6XTWE7J7CDKVo=
X-Gm-Gg: ATEYQzyU+HXvnGJnF6cH3UjxswJpFdMMxM7hdyattAHwqNRYL52Op4pMXbX0RFDSCtG
	nSUnPaWSJ60UEWYYJn41ZH/LrK0GV1IGEJm11u62Qufw+5wyuqCoesOEXtzO1Gy2asPFH+HVxEC
	ohofUEE5fQObChLYcMzxL/2Gbvz5QYuekwG4ocrJLYFXjiqmwf4iKGoBrHq/05okV9R3BP+ooCr
	vN0T2UiPNQHR/HqqIE0UCxSc5yioO8mL3uIxLTYdeTnZpoACMz8br6GT5Oj5nw0+tN4NyReoOnp
	OOloGtQALWbm51pjP0iVj6cyXYAfTXKffVhvRDLKZc/9MdwFVlNu44nAKrsuWPyUyhr5xAvahRe
	/P+i3iII6aUPWg3NQUw/HUNpZCkxVk7AHL5sjGZAyS0WgDrn04JtFfNwPl9NGMTEIZX0OofaYsq
	FFRMLYzsVVyEfegrz0jcMjAu35GRFfSTP2vHBTLP1fMa7HBAeGUf5NFb2QrBjjsjlASL0qMcmZY
	MpXbN920bH5DK2m8Ho=
X-Received: by 2002:a05:622a:1899:b0:4f4:e15e:528f with SMTP id d75a77b69052e-508db3773fbmr27695511cf.62.1772633933669;
        Wed, 04 Mar 2026 06:18:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ad885bsm152669541cf.28.2026.03.04.06.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:18:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vxn3s-000000056cr-144y;
	Wed, 04 Mar 2026 10:18:52 -0400
Date: Wed, 4 Mar 2026 10:18:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Peter Colberg <pcolberg@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
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
Message-ID: <20260304141852.GF964116@ziepe.ca>
References: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
 <20260304084750.GW12611@unreal>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304084750.GW12611@unreal>

On Wed, Mar 04, 2026 at 10:47:50AM +0200, Leon Romanovsky wrote:
> On Tue, Mar 03, 2026 at 04:15:20PM -0500, Peter Colberg wrote:
> > Add Rust abstractions for the Single Root I/O Virtualization (SR-IOV)
> > capability of a PCI device. Provide a minimal set of wrappers for the
> > SR-IOV C API to enable and disable SR-IOV for a device, and query if
> > a PCI device is a Physical Function (PF) or Virtual Function (VF).
> 
> <...>
> 
> > For PF drivers written in C, disabling SR-IOV on remove() may be opted
> > into by setting the flag managed_sriov in the pci_driver structure. For
> > PF drivers written in Rust, disabling SR-IOV on unbind() is mandatory.
> 
> Why? Could you explain the rationale behind this difference between C and
> Rust? Let me remind you that SR‑IOV devices which do not disable VFs do so
> for a practical and well‑established reason: maximizing hardware
> utilization.

Personally I think drivers doing this are wrong. That such a driver
bug was allowed to become UAPI is pretty bad. The rust approach is
better.

Jason
