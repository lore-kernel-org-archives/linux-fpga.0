Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059263D34B7;
	Thu, 16 Apr 2026 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354198; cv=none; b=jBNeqMCfQ4/zws+jbVfrx7/mkkXyPH+k7JXADDhVjl6+KRRtVicsgaMkj72HghHFnjJTfAyHw62H3cicaoz03nR6ekJZO5KRvIdcNKLlUJryqkIDgvkZPAxiHjwigjH0QXzDvzTvmmSfihUwOoScwV4z1iTVv3HDd6STyBnhFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354198; c=relaxed/simple;
	bh=rMHEX9ORRD/sMRXlFXp6rrcrCcIxCNMh0IrWqoLikF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jh4bM5X9UKVaSn+9cAcbXNpANxwvj6fTCz/pSaTIV1ye3N4u2ZxSRshAlWtGUvPrPQ4wh9N+XOQHmrkGHh0EuEuBGjDQxVDRtmLKiMlUVFr31NybW2VMhkswH2eDUpCD3i6oBplFfBDQVKRh8qRSpVLh8ZZsgXWacVADuZofs+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kceb5G1y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kceb5G1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A992C2BCAF;
	Thu, 16 Apr 2026 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776354197;
	bh=rMHEX9ORRD/sMRXlFXp6rrcrCcIxCNMh0IrWqoLikF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kceb5G1ycS5HkKFhSkq1ulo72NE62CvhifaMHGIRmGx0l2Huo8OGTZVQ93647Mo1m
	 +H7UjMoIIxicXNcZfFQGU8pooECkgLiL+AfA0UpcSpgpW/kpvYmylk25nVjLAkOVM8
	 WzRu/mFwfuamwqWVuybadkgMh0Yvggd2IvQ46kLZvuEGgbqpAYonB1ZfVSQ+PalGFr
	 9CCvm6h97pmj+3hWORnEkh/58Kp7uhDoMZcoJTpyUwMKQqoJq5ZrDi0rLAYPISnehs
	 6X/OTbEX5DWFyGxrPGUcnROGOmCYHC4sHVRr54YwnpdvsT0bB4Bt6/PAMScw7WozVH
	 CDuUwcIyH5UkA==
Date: Thu, 16 Apr 2026 16:43:12 +0100
From: Conor Dooley <conor@kernel.org>
To: iansdannapel@gmail.com
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, mdf@kernel.org, yilun.xu@intel.com,
	trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, neil.armstrong@linaro.org, heiko@sntech.de,
	marex@nabladev.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	dev@kael-k.io
Subject: Re: [PATCH v7 2/3] dt-bindings: fpga: Add Efinix SPI programming
 bindings
Message-ID: <20260416-scanning-synopses-59f03e62c887@spud>
References: <20260416144237.373852-1-iansdannapel@gmail.com>
 <20260416144237.373852-3-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kRkONApBF3Gn6eQO"
Content-Disposition: inline
In-Reply-To: <20260416144237.373852-3-iansdannapel@gmail.com>


--kRkONApBF3Gn6eQO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 04:42:35PM +0200, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
>=20
> Add device tree bindings documentation for configuring Efinix FPGA
> using serial SPI passive programming mode.
>=20
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--kRkONApBF3Gn6eQO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeEDkAAKCRB4tDGHoIJi
0sHrAQDiF5LooF91fRMl4DyqGIZ7gSD+p4zlePOIonXDPbmHqQEAuFagpPQbCLnI
dQfSIzjlvJyln3fLqEHv7EZtcQSbQQQ=
=VlDa
-----END PGP SIGNATURE-----

--kRkONApBF3Gn6eQO--
