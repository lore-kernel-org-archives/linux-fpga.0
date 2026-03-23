Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50463AC0E3;
	Mon, 23 Mar 2026 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274299; cv=none; b=C2VPtPvdsp3QUMLUlOF2Un+E0LfgSYMxRfP/GYMsBS1iKfoBTKgkGsuQJQ7NFa0aoid1FX4Jb7GQYANjXBLlZnwK4NUPDwXrnD+5fXEB8q368/d8IVmPpTR58grJv8w9YLAdYjeAOhiZYOjaZliyYw4Eci8UjWWqzIfKCCIWzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274299; c=relaxed/simple;
	bh=DqfWL4BSTBiaLqTmikifLZdJR1EIole67SS90j6+wPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoNQdafm4RgLplD0Z502TQFI5EMv1xY2c2wifOwE24UVmfFs3J9xYoxp8tA315qJUIIQ5i8XUtDRfqNMkygAlXxEZk4CfoiHuGfw7I/ikMq14gcJirhbTFFtnwZrK/9hcktdaA4v10L48vCUBne6/eV9lHy8V9FXce5Q43d7qqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug7FqFPO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug7FqFPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A146DC4CEF7;
	Mon, 23 Mar 2026 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774274299;
	bh=DqfWL4BSTBiaLqTmikifLZdJR1EIole67SS90j6+wPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ug7FqFPOxtjqtkSadBjpkd4bQYSehH4p2u3pHmJk9tmOoZu6fr0+vdVBUekcgA6/A
	 QnXwgH5xZaTtuisppuO7Isa5gwywmd5oZCkMmzQqAUk1xRyPfjBZkWYdt4jDFLtgce
	 jG6/HZKk7u6DP1SsWQWgCLGs3au+Dh/HpT8FZ5a9XULG7e+Ot4MU70ST2AC/mB472J
	 3WU43zruM06Q0aL1wgWvCiWoxpf7uin9XCKjJQhFzvY9Ij7zDpAAa1hWZGfhn/HuWA
	 TzEF+P8h5nrJG5gDl+i34duuOTOggqENQN21Fhq30HCbMyyNAklfwWsCb2t5CgQ7yX
	 cGR0rCKZ3nXrg==
Date: Mon, 23 Mar 2026 13:58:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH 03/10] spi: switch to using class_find_device_by_fwnode()
Message-ID: <03c80468-b097-47ac-b7b5-4170eb782772@sirena.org.uk>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-3-b72eb22a1215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Y4JH2eUDT/w1Qo1"
Content-Disposition: inline
In-Reply-To: <20260322-remove-device-find-by-of-node-v1-3-b72eb22a1215@gmail.com>
X-Cookie: Avoid gunfire in the bathroom tonight.


--/Y4JH2eUDT/w1Qo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 22, 2026 at 06:54:21PM -0700, Dmitry Torokhov wrote:
> In preparation to class_find_device_by_of_node() going away switch to
> using class_find_device_by_fwnode().

Acked-by: Mark Brown <broonie@kernel.org>

--/Y4JH2eUDT/w1Qo1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBRvMACgkQJNaLcl1U
h9CsIgf/RCKdllt9YwSLySimmbBJtkTLmhOS6EPJCqGv19zWp+V0LMQR7m+UNTGr
FnR+LwzGc6hEHm/6jhjD198BnnVCOW82zCI8Bs+E6y5/EdupkUDZ+b3g3SeURJAF
+QJq5bdoCW1CTTRSIGfA5rvSFcvntN7Zq8M1wxHw3tCGu9nFjd6zgDl89+AftFxf
y229F5tEErnywkxr7uTfooW7t6VMKlhRVBg4yrPvoa6Uya8sSLjcXMPA/rF9358P
K9Rq1TRyca20qXzUtriw7Az+/rk7ZBkCZoYVUBcihEdjyfxrORCd5RqlM6pxH80i
lcMvh6jcdGoRkTwa6/zxTPScelZsuw==
=oQMa
-----END PGP SIGNATURE-----

--/Y4JH2eUDT/w1Qo1--
