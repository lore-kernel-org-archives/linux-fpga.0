Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51643C5DB4;
	Mon, 23 Mar 2026 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286174; cv=none; b=bbHoEiAE1uvW0K16qJXqr5LsxKNjRs22Ld1yUIc8i6c847fNWfbLBhY8JHGCqtgBFaOTRy+fy6dbU2Zv3KdbD01O5gM/UdKVdUuQ8GK7FHd3FAutow/LobHzyWceWCYz/6EkBei5NRHOndM2Cr/6oRONdR/Upz0REfQtnEY6nJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286174; c=relaxed/simple;
	bh=GPZRjw9420otJR954wv9jlY5KaF4RQTzb5PccDoBlqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP5FyKE415K+/0PxH3Y3yBJiHA63ACGwPRRQ7Jb9mCht3mvAyJFhZ2M+CWc8yf5dJYq6FYc49VHnmbdoymufpTnZBM7JgQit1ymfjY1y8jTWazKG02enCUZbtrHhrpokJrsdiz1AyxpPF9tY90rK2CBnuS+4Y2xsxbiC4v36vFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEPcAVYx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEPcAVYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8213C4CEF7;
	Mon, 23 Mar 2026 17:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774286173;
	bh=GPZRjw9420otJR954wv9jlY5KaF4RQTzb5PccDoBlqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEPcAVYx8EfysVPLpGplRNI3M4k/Ct3YJWskSAod8cjNc1kdUYhIGoTf63okXWz2q
	 0hEGs2DfACbPoNyzgdtj87k/P+cEFXjqR4zVObWBaUkYJisObzaPTFF88rBaqW7kDE
	 u44XlLVOUONXIUPzTC9AC634kEAVIofUv5uLsWXnrnV6jadm4XyQlj4vWrFFiFKajE
	 To4Ze8LqNXjukWlYqjZq7F8XbbETwBxXQK5qIyqZx2UXnkN7Gp69ERU2MgblYsng5A
	 A/wZC66xfEiHhhCI5f/gGI3mYjB7rlZ7Sw+E+px2pkPKpvS8rJRJTMHzbqXvw/P49f
	 S+GsHsIhgxKOA==
Date: Mon, 23 Mar 2026 17:16:04 +0000
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
Message-ID: <098e1856-feee-4f4b-8059-85a53967f6b3@sirena.org.uk>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-3-b72eb22a1215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5CiJK9+3S3OZYzXr"
Content-Disposition: inline
In-Reply-To: <20260322-remove-device-find-by-of-node-v1-3-b72eb22a1215@gmail.com>
X-Cookie: Avoid gunfire in the bathroom tonight.


--5CiJK9+3S3OZYzXr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 06:54:21PM -0700, Dmitry Torokhov wrote:
> In preparation to class_find_device_by_of_node() going away switch to
> using class_find_device_by_fwnode().

>  struct spi_controller *of_find_spi_controller_by_node(struct device_node=
 *node)
>  {
> +	struct fwnode_handle *fwnode =3D of_fwnode_handle(node);
>  	struct device *dev;
> =20
> -	dev =3D class_find_device_by_of_node(&spi_controller_class, node);
> +	dev =3D class_find_device_by_fwnode(&spi_controller_class, fwnode);
>  	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
> -		dev =3D class_find_device_by_of_node(&spi_target_class, node);
> +		dev =3D class_find_device_by_fwnode(&spi_target_class, fwnode);
>  	if (!dev)
>  		return NULL;

Actually, no - this just looks weird.  We're in the middle of an OF
specific function but we're having to jump up to fwnode for no apparent
reason.  If we actually decide to get rid of the OF specific function
then I guess but I'm really not convinced this is an improvement in
isolation.

--5CiJK9+3S3OZYzXr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBdVMACgkQJNaLcl1U
h9AZpwf+IYUP90323AiTlXT8gw1Dypm0TDgs0IOfZCsY6eI2ifZgGPN9bmjL/nqn
qOCQnievL6WWoQiEOvgXsLRJl9rBwFIoqSVqZ5KSwziQt3eVC1C8h2BBG1RRNUTs
iAN2o35mqWmLWMjutA6YleGKMYmsZYLPhv47Bn89wSF5X2/KO2oAUR3pc4t1UZwV
iB4S4xXHm268iBSZduYC+IqDTV8Dd6HABhODhHHz96h17qZlzPM64vxVlOU30dlc
QEHhAL5tfwE+km7QmFrPh176jDVmndTGdXRJbtRICsUHDLuIPIjeuCFwom9RyzhN
v8Jk4nJOfxCXEkLHHAlP8AtJaBLsrw==
=ncpO
-----END PGP SIGNATURE-----

--5CiJK9+3S3OZYzXr--
