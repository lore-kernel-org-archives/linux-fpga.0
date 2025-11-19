Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EDE2F6596;
	Wed, 19 Nov 2025 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577386; cv=none; b=A2Qx6BfmErfl4PuMkHz/nu8aQ5pfPmVMzqI+qiVm4yX3RoyxlxzXu3rADdIxgu29Aq5QqVp5awlRc4n2+j2jPIp/0eX4NPe+unDAM0xV88DVMBRXsmpK6+Ej+TGrcG7CRXGmC6UY0/ar4X07kRRnj8R3ORq66HAVveGic8t0ODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577386; c=relaxed/simple;
	bh=xwKZp/x+NWQ/Q/NfrVl33rtEFF4kXJDbcGr/uUULN5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upJj9ypw1HRHXrk1/nnjQOuIaphFVPnOnmgqpiplYR2zx5QC+yWaQw+7EGMOP8zGK40o87dgzS8PcgCAi0MPOV006PNvM0W49h0BXVCZaASxY9SQGTHLguvSCC9hgo43NXiwxWhRKk7QamYkJisJKuYuBkUZ24XJ49nBPz+Yt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVSWr3Vc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVSWr3Vc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C5DC4CEF5;
	Wed, 19 Nov 2025 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763577385;
	bh=xwKZp/x+NWQ/Q/NfrVl33rtEFF4kXJDbcGr/uUULN5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVSWr3VcWf04TXPc8OzdtC3WZc59SgUATizJV9nUaEyCWPRbKA7R0NytHLFQIcvt3
	 g9xiFGtEbUZ0zB/LIvVmMakhSe3mnp0WCU4DLmp2igBMzTSVW5KauU1MNWVtYvU6JY
	 9ptCOYP9I5nW536kDbEOXvfTI35UYMcJAiIL5rLz7+zw7mWCgYNhxpEqXmHTuuT0VL
	 V8SM29H6YcSeDlzU+YMUNqyBenm/u3Im6i8zh2A+L+TPcqH/3BXUZmwBxcLOypjhYA
	 q8dkorr3aMYObj+bnlzjBlcl/Rir1OYAR85MJZN6X3Ozt1ThOPwA9gWhdhhji7LdFt
	 VsJc3r7YpcQkw==
Date: Wed, 19 Nov 2025 18:36:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	Ho Yin <adrian.ho.yin.ng@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
Message-ID: <20251119-surfer-festival-da76a38dbec0@spud>
References: <cover.1763518321.git.khairul.anuar.romli@altera.com>
 <2092d4572e9772a30e8f50cb39d066c1c2b2cad9.1763518321.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QV4u/H7FWfggDSte"
Content-Disposition: inline
In-Reply-To: <2092d4572e9772a30e8f50cb39d066c1c2b2cad9.1763518321.git.khairul.anuar.romli@altera.com>


--QV4u/H7FWfggDSte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 10:26:05AM +0800, Khairul Anuar Romli wrote:
> Agilex5 introduces changes in how reserved memory is mapped and accessed
> compared to previous SoC generations. Agilex5 compatible allows stratix10-
> FPGA manager driver to handle these changes.
>=20
> Fallback is added for driver probe and init that rely on matching of table
> and DT node.
>=20
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

=02
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--QV4u/H7FWfggDSte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaR4OJAAKCRB4tDGHoIJi
0gfjAQCTiUNRgcq03G2tyNvU+67BLzzDA3yU8qZRAmO2jWvWwgEA/ksLDmhoBgcZ
tn4TRgJ2Aep4YZ3WM4YvKootVZLXQAw=
=x862
-----END PGP SIGNATURE-----

--QV4u/H7FWfggDSte--
