Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C33D9686;
	Tue, 12 May 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605482; cv=none; b=PBqzVi2zTmBmo7wwHMdzxB19HY9hzQKxXpAdPQUm55qkYk3F0COQhaycej1tcapFtHUQ4iMvXz9KXMvt6Pyl9EsLCR/f00V5UEk8WmI0dT1kEceBm7T17nIsDTspobOx/4lltysmD5GobdlkYaSlEW0nwDfMa1Gbkg0QjwViE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605482; c=relaxed/simple;
	bh=T5Qgj7IZfQ5x/jfFjZT9Fe5ECh9w7mU15gRvxC/pB/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM8OnmWZ/wwY13yLa4tsYm9PRAd3pqHOwrlxxLSkp3xj92SrUuUmDDPp+8rdKURVUeh+YitDyPzuUXgLOWMuOROyjZtcuzxoKjuxSDTUxo9R8eSA9F+NLiq4wsyEZ5vbwSpAcAGt4WzmWStdxC4TBeAeDoUcoDoHL6L9yEzofK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIxbGykg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIxbGykg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A28C2BCC7;
	Tue, 12 May 2026 17:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778605481;
	bh=T5Qgj7IZfQ5x/jfFjZT9Fe5ECh9w7mU15gRvxC/pB/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EIxbGykgLmGDOoEMcW7ET660ZHjH6LBVRDMOCM4QW8pksj3iibH/mclLOwmxJFpEw
	 LVBRnpxwARTeN8jmLOXWR0EYPCANSEb+2zFOAEufJW/ttr6jIU2NMP6xzxvONBwB3o
	 oJXKtfGoKxrLJvRNc/u2Z4xEZr38ojb/xV4+tsn7GvK9L4HUEP+nU4Mk3XZgU4HpA4
	 f2lir8bhuxmEJ+7R+wV4RcgzXAXyYXs7ytWDY5d72HMoa9ZlPTrlvETuZ6L3KTE6XD
	 7bfOGrpfcBL6PwGrwYSiyxIK3QI/IrN9cAbF5otZpnKLi3B4AzKvyqTKk7dB5qet9k
	 tFUczi6+F1MFA==
Date: Tue, 12 May 2026 18:04:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Manish Baing <manishbaing2789@gmail.com>
Cc: mdf@kernel.org, yilun.xu@intel.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, trix@redhat.com, s.trumtrar@pengutronix.de,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fpga: altr,socfpga-fpga-mgr: convert to DT
 schema
Message-ID: <20260512-debit-shank-904d9c516e58@spud>
References: <20260512165058.64049-1-manishbaing2789@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Tt1ciJLHPxLr1+BN"
Content-Disposition: inline
In-Reply-To: <20260512165058.64049-1-manishbaing2789@gmail.com>


--Tt1ciJLHPxLr1+BN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 04:50:58PM +0000, Manish Baing wrote:
> Convert the Altera SoCFPGA FPGA Manager bindings from text
> format to YAML schema.
>=20
> Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
> ---
>  .../bindings/fpga/altera-socfpga-fpga-mgr.txt | 17 --------
>  .../bindings/fpga/altr,socfpga-fpga-mgr.yaml  | 39 +++++++++++++++++++
>  2 files changed, 39 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/fpga/altera-socfpga=
-fpga-mgr.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/altr,socfpga-f=
pga-mgr.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/fpga/altera-socfpga-fpga-m=
gr.txt b/Documentation/devicetree/bindings/fpga/altera-socfpga-fpga-mgr.txt
> deleted file mode 100644
> index d52f3340414d..000000000000
> --- a/Documentation/devicetree/bindings/fpga/altera-socfpga-fpga-mgr.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -Altera SOCFPGA FPGA Manager
> -
> -Required properties:
> -- compatible : should contain "altr,socfpga-fpga-mgr"
> -- reg        : base address and size for memory mapped io.
> -               - The first index is for FPGA manager register access.
> -               - The second index is for writing FPGA configuration data.
> -- interrupts : interrupt for the FPGA Manager device.
> -
> -Example:
> -
> -	hps_0_fpgamgr: fpgamgr@ff706000 {
> -		compatible =3D "altr,socfpga-fpga-mgr";
> -		reg =3D <0xFF706000 0x1000
> -		       0xFFB90000 0x1000>;
> -		interrupts =3D <0 175 4>;
> -	};
> diff --git a/Documentation/devicetree/bindings/fpga/altr,socfpga-fpga-mgr=
=2Eyaml b/Documentation/devicetree/bindings/fpga/altr,socfpga-fpga-mgr.yaml
> new file mode 100644
> index 000000000000..d09d552dde5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/altr,socfpga-fpga-mgr.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/altr,socfpga-fpga-mgr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera SOCFPGA FPGA Manager
> +
> +maintainers:
> +  - Steffen Trumtrar <s.trumtrar@pengutronix.de>
> +  - Rob Herring <robh@kernel.org>

Why's Rob a maintainer here? Doubt he cares about this device.

Otherwise this looks okay.


> +
> +properties:
> +  compatible:
> +    const: altr,socfpga-fpga-mgr
> +
> +  reg:
> +    items:
> +      - description: FPGA manager register access
> +      - description: Writing FPGA configuration data
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    fpgamgr@ff706000 {
> +        compatible =3D "altr,socfpga-fpga-mgr";
> +        reg =3D <0xff706000 0x1000>,
> +              <0xffb90000 0x1000>;
> +        interrupts =3D <0 175 4>;
> +    };
> --=20
> 2.43.0
>=20

--Tt1ciJLHPxLr1+BN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagNdpQAKCRB4tDGHoIJi
0tpvAQDAqWH9oEuS5MXcxaZSKkNdp6t0ikuSbzuIRQZdjvB0EAEAuGMcTIMXQ5J6
pGHAH4OkLJcmXeCqO9b+MTmapZ1LhQA=
=M5Ds
-----END PGP SIGNATURE-----

--Tt1ciJLHPxLr1+BN--
