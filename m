Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741983612E7;
	Tue, 18 Nov 2025 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492875; cv=none; b=V9GR4OiO2xd9zZUVzbHYA4NmT+eJu5Qhni5TVD95L4nNVaUSFvnPg1G44EPqss3hkfQ7r5oY4E1l39/q2F+YeXVBCiGBLwyrY86yQ8gorAkmLwqiXs2LPLNW0i8RvG1eAlfKpjtgAhE/NYepMbh46ZD5iyAFmWruh3CfwN4AEeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492875; c=relaxed/simple;
	bh=NBjFNlLcfeQTe5Bj0HCiTCUSf4jF7V5yae3gpojHyOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUZg7n9YTW3on5Z8zTt2ByOunN5Q8X6wTtrI99T2N2Gzx0/TqylmbN382n5eLSqGNu+b4AHEEQaopEjN5LL+5b6VkzXjoTDeHzAwYJl0Ad9cH+rjKuNkJiDdVQcWsRdDX+/WTxs8bCwTuCWl7C7dEVid6OkLT3vuCkAKLSdtaDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzKLY5L7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzKLY5L7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19570C2BCB1;
	Tue, 18 Nov 2025 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763492875;
	bh=NBjFNlLcfeQTe5Bj0HCiTCUSf4jF7V5yae3gpojHyOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CzKLY5L75nFtUMTrBkf9d2kV5zr55IUJsE36XDv2I9XOk4iDwBpO24NslvdITfxLN
	 +PtPzchb1pipSlG1SYpgeelGKuRVgZBGTzZC/MISYmNXvazWE9togQOIXslsNrgYM1
	 XuXerSZhZgBem+XDTgUJfF+cFf2UKd7Ax/wf6XT/ZYqvPoi1NJavt1qbKfeUhAOt7T
	 1v1jlG25LGZ1lDKh6XdwOUk3VTrOv4sTHD2wIWzA5qWg1dLW1rNK2oL7ljjGPpPTIp
	 w2O7cbHED9x65T/318XKiLMsggwaTTajDwNofN9E5frHPEvfvWs1TV/e2gtTEkIfiL
	 LVw7ii75ZxPOw==
Date: Tue, 18 Nov 2025 19:07:48 +0000
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
Subject: Re: [PATCH v4 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
Message-ID: <20251118-crescent-fritter-9411297ed6eb@spud>
References: <cover.1763427266.git.khairul.anuar.romli@altera.com>
 <79a58f075488733cced8eadd566b0b740a59094f.1763427266.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4zyPdB29WAkW2yzy"
Content-Disposition: inline
In-Reply-To: <79a58f075488733cced8eadd566b0b740a59094f.1763427266.git.khairul.anuar.romli@altera.com>


--4zyPdB29WAkW2yzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 09:11:42AM +0800, Khairul Anuar Romli wrote:
> Agilex5 introduces changes in how reserved memory is mapped and accessed
> compared to previous SoC generations. Agilex5 compatible allows stratix10-
> FPGA manager driver to handle these changes.
>=20
> Fallback is added for driver probe and init that rely on matching of table
> and DT node.
>=20
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v4:
> 	- Remove redundant "items - enum" as suggested in v3.
> 	- Simplify compatible property to use contains instead of oneOf.
> 	- Validate fallback and non-fallback DT. Also validate binding with
>           dt_binding_check.

What are you doing?? You've been told several times exactly what to do
and yet you keep conjuring up completely random different things.
Using contains instead of the oneOf construct that was being done before
is *not* a simplification, it is functionally different.

NAK. Go do what you were told to do.

pw-bot: changes-requested

> Changes in v3:
> 	- Add description for Agilex5 Device
> 	- Add and define fallback to "intel,agilex-soc-fpga-mgr"
> 	- Validate against Agilex and Stratix10 (non-fallback) and Agilex5
> 	  (fallback)
> Changes in v2:
> 	- No changes in this patch
> ---
>  .../bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml       | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-f=
pga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-f=
pga-mgr.yaml
> index 6e536d6b28a9..65c737a4734c 100644
> --- a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr=
=2Eyaml
> @@ -20,9 +20,11 @@ description:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - intel,stratix10-soc-fpga-mgr
> -      - intel,agilex-soc-fpga-mgr
> +    contains:
> +      enum:
> +        - intel,stratix10-soc-fpga-mgr
> +        - intel,agilex-soc-fpga-mgr
> +        - intel,agilex5-soc-fpga-mgr
> =20
>  required:
>    - compatible
> --=20
> 2.43.7
>=20

--4zyPdB29WAkW2yzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRzEAAAKCRB4tDGHoIJi
0hcxAQDE5Bp/63IJDGLDqNeBTsxoUY6Z3y8GzWSZlgIu07CSjwEA/CdYjIJBaC1A
Fk7imBsSmMoKST1noCPIAxJzkSHOJgw=
=m+AM
-----END PGP SIGNATURE-----

--4zyPdB29WAkW2yzy--
