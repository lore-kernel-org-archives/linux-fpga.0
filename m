Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D328370304;
	Tue, 18 Nov 2025 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763506901; cv=none; b=csrg/bThfmkJq+Z4P/Os+rcWMuNV15vXq2OISiWGL50196alGZrpKpuAvQ0fYDHcZfTF3JLUTwqaBiPUobRSKZtxQphen5QOG2c+AYTpY34rcK5JX/hQSbyhN1mh61mMMFpD4lcC/DE1Kua1JZlJNR2HqOixS3AxUciALelf+Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763506901; c=relaxed/simple;
	bh=S9XI8UppMlcHCp0zUVycM2ruN5zrzwfAKCsCCcTN/9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRoqEeGNosbOPfI3AXX7mxGDP6I6Cc/bzRa5dKb4+R3Wqr/20/Uop3n/GIMBYhbe5ikkQEz3onAA5/37J2fxYlE+Xw+SD6XjT73Scn3sThZ+uiFekTcCqmsUDEdeG/i+Qgdsz7N2AeM9WUgb6qByPt6hvbig6QYll5MAjVAr/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6YyfYQG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6YyfYQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92107C116D0;
	Tue, 18 Nov 2025 23:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763506900;
	bh=S9XI8UppMlcHCp0zUVycM2ruN5zrzwfAKCsCCcTN/9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6YyfYQGO/aXeRhM8Gjq98E47hNErrhHOd7HFhi71zqqTnwvi/0oxI03sKqPVKhG4
	 qdQhbqlWkbEQZHwCKpjyVJ6yVw11Qahgn+sEOKXkFhyHB89nvTTvaWebinccxQJwpp
	 fU9AyouOOaqUDTYg0cy49r403oY3QYQQI2p23jEb5UD0ahls8buTK+kDEeTEL1AcYn
	 Zfc08buc7y82JIM7irPvc5QSOgCdEqzAZY28SlyheBUx2EpH5mAwYpiYyWiR3RgVj5
	 buT0ROKUKWFck3KRA+mV/pLu0RsI4c3rum14ewd0je2zShSWPLm+iSPXcqU/0/P/C+
	 TiTJ/PZnGFMGA==
Date: Tue, 18 Nov 2025 23:01:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	Ho Yin <adrian.ho.yin.ng@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
Message-ID: <20251118-saint-flashbulb-995844e01ec1@spud>
References: <cover.1763427266.git.khairul.anuar.romli@altera.com>
 <79a58f075488733cced8eadd566b0b740a59094f.1763427266.git.khairul.anuar.romli@altera.com>
 <20251118-crescent-fritter-9411297ed6eb@spud>
 <a4d58001-4914-4ce2-8116-c07451acd566@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AocIK6Ay3niFbFPG"
Content-Disposition: inline
In-Reply-To: <a4d58001-4914-4ce2-8116-c07451acd566@kernel.org>


--AocIK6Ay3niFbFPG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 08:28:46PM +0100, Krzysztof Kozlowski wrote:
> On 18/11/2025 20:07, Conor Dooley wrote:
> > On Tue, Nov 18, 2025 at 09:11:42AM +0800, Khairul Anuar Romli wrote:
> >> Agilex5 introduces changes in how reserved memory is mapped and access=
ed
> >> compared to previous SoC generations. Agilex5 compatible allows strati=
x10-
> >> FPGA manager driver to handle these changes.
> >>
> >> Fallback is added for driver probe and init that rely on matching of t=
able
> >> and DT node.
> >>
> >> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> >> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> >> ---
> >> Changes in v4:
> >> 	- Remove redundant "items - enum" as suggested in v3.
> >> 	- Simplify compatible property to use contains instead of oneOf.
> >> 	- Validate fallback and non-fallback DT. Also validate binding with
> >>           dt_binding_check.
> >=20
> > What are you doing?? You've been told several times exactly what to do
> > and yet you keep conjuring up completely random different things.
> > Using contains instead of the oneOf construct that was being done before
> > is *not* a simplification, it is functionally different.
> >=20
> > NAK. Go do what you were told to do.
>=20
> There is no single file with that syntax, so I really do not understand
> why completely different syntax is reasonable for the author :/

There are actually a handful of bindings that do it (14). Some are
probably wrong, others are the generic portions of snps etc IP schemas.
Run this if you wanna quickly see what's what:

rg --multiline "^properties:\n.*compatible:\n.*contains" --context=3D5

I'd say that about half of them should be enums or const.

--AocIK6Ay3niFbFPG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRz6zQAKCRB4tDGHoIJi
0s8+AP9W0Vq1+uKIC/CAjJUvP7YxSjdE3DC7HhvMQHZ12TEDmwEA266l8vP8Giin
3eTWsXljj3iWpEK6NlZ+rOXZnE57qgc=
=ZUpm
-----END PGP SIGNATURE-----

--AocIK6Ay3niFbFPG--
