Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C698F346761;
	Fri, 14 Nov 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143174; cv=none; b=ftcGyWUUsqSKkTbQgGxzCpDEgMoVRcXeQCu+YmH3yrLnecIn/lNXg0B0BFBYWk7i6PZ+QHhvgf+vjBaclieBuJkMP8zhyiQOSiWYpDbWqB0pVIRtKziTRVl5OP87zGjBg+WEC8udzmZcutJAP7ouKx4JBmnAQZ6/4upy9Q6F9b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143174; c=relaxed/simple;
	bh=Vdu1KBbH+cAEzJbQuhE/C2imI7qiEBaDqx63uJdCLmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSVvMqcb1ol08IzKZGBlX718Pmec9odTWZL/q39Jm7pLjni6Xov5ebF78IxJUx+Nd6mecwomvLILTf7JAdVEyAY1DR/lV8riL1EbPOoE7FdgyDFjbkuaWc3Z/oHfOv8xwrwljsoMvJKK4MX0ez1bMpD7a9RyVMHp8Tqxs7JRpw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mvc1Fkj2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mvc1Fkj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96616C4CEF5;
	Fri, 14 Nov 2025 17:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763143174;
	bh=Vdu1KBbH+cAEzJbQuhE/C2imI7qiEBaDqx63uJdCLmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mvc1Fkj2cL+08uF4ytZiv/jY/4atkGEpZUqpUkRxyoVXFfWKs8BjSkzIfT9/2om7Y
	 ZGJ1GiKN4d5ybmE6nczQtKo3rdAMpz8Mp2P7ym0AhVyNyJ5L+1VRfIggMMgxJFFDCc
	 sfuQTeRX8iYfhsb9V5ySanp7PCns95nteBgWREyek/e3OmxX4ztcCAVHYRQmaMPWdA
	 xf6QGwB3BKILg6r0ebf5ynxSUJ87LOM/zVRuM4KyAr7+AnmazcqzlIRpGc/LHUbjSZ
	 Oh8XywXUiPLn2RWNG/0DLlsWs6CoPXGqTP4F4G+HcSlMzWkizXU+Uj9+nopS35S0Sb
	 T2gnZqbUf2LKg==
Date: Fri, 14 Nov 2025 17:59:29 +0000
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
Subject: Re: [PATCH v3 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
Message-ID: <20251114-countless-vantage-6e18528d2e31@spud>
References: <cover.1763100984.git.khairul.anuar.romli@altera.com>
 <c614925ffdc98b1faace3ec9bd7124161b0b60ca.1763100984.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RZvDkIZ10B50HaV2"
Content-Disposition: inline
In-Reply-To: <c614925ffdc98b1faace3ec9bd7124161b0b60ca.1763100984.git.khairul.anuar.romli@altera.com>


--RZvDkIZ10B50HaV2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 02:27:41PM +0800, Khairul Anuar Romli wrote:
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
> Changes in v3:
> 	- Add description for Agilex5 Device
> 	- Add and define fallback to "intel,agilex-soc-fpga-mgr"
> 	- Validate against Agilex and Stratix10 (non-fallback) and Agilex5
> 	  (fallback)
> Changes in v2:
> 	- No changes in this patch
> ---
>  .../fpga/intel,stratix10-soc-fpga-mgr.yaml         | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-f=
pga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-f=
pga-mgr.yaml
> index 6e536d6b28a9..8eb414163d08 100644
> --- a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr=
=2Eyaml
> @@ -20,9 +20,17 @@ description:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - intel,stratix10-soc-fpga-mgr
> -      - intel,agilex-soc-fpga-mgr
> +    oneOf:
> +      - items:
> +          - enum:

This construct is redundant, "items: - enum" is the same as just having
"enum".
pw-bot: changes-requested

> +              - intel,stratix10-soc-fpga-mgr
> +              - intel,agilex-soc-fpga-mgr
> +
> +      - description: Agilex5 Device
> +        items:
> +          - enum:
> +              - intel,agilex5-soc-fpga-mgr
> +          - const: intel,agilex-soc-fpga-mgr
> =20
>  required:
>    - compatible
> --=20
> 2.43.7
>=20

--RZvDkIZ10B50HaV2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRduAQAKCRB4tDGHoIJi
0kbtAQClw4Jgyw2Trg8vY/5hjf1LL+ReGkAG7DyzBQrBKLTYZwD/SD8qS5+M3088
7bmN4aZf+Nue1Pf4Jd329B0ZkJNCKAU=
=5Rih
-----END PGP SIGNATURE-----

--RZvDkIZ10B50HaV2--
