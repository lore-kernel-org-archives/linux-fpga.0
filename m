Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530552AD3D;
	Mon, 17 Nov 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763389941; cv=none; b=nyUcBxChc6j2W80AtLUK57fQn7bRl6D/S5Q7Kpz2iEAX9lH+hotooRlHe5sakPhLnsHmUjq2POPhGCJTuNAZclhO4xBdEQBlcap04ECDJZXzACJZGfFry7NVVVZZbgUBcAjfWKD+WBXGBul4Q/rWjuSUq0Eh3ezS3SDJM0W/iC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763389941; c=relaxed/simple;
	bh=LANXfRVYnfSHPCIqoyNMaF8FfXE0qCI6jJc8n7Rhjpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grYdzjaFYTSUD5eaIaxbO7dsl0amTAliWYP2uKmeHbYcD+fvW0qafh1MwwTouUU0SvyIJocqq+ZxthHS9FwnYTygPuQn3pkNSnYbAnalg3BWyP8OzoG96mP00KPTkBmz9lLDdAfRW4NXgtKzdao8m//TI0hbYy5aJ8i3Oxiu4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5JNskPz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5JNskPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369CCC4CEF1;
	Mon, 17 Nov 2025 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763389940;
	bh=LANXfRVYnfSHPCIqoyNMaF8FfXE0qCI6jJc8n7Rhjpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5JNskPza16XUIobhUjVCNqVUwedvBuQ4CtXaVdnkElJzCstUrXgkdICzz3hNvWlG
	 RGrpNZJreelsJ37VKEVP/k3ev0TuhEoDOAzTl6AvHODRsxkv1xM9rf0VOH4U5DNKwJ
	 y2p6VwCVaCcyqCRYMjgqU1UTLgZEsEymmNuRSvb4tVeccXZhy9juNJiQ46mzBXGiim
	 slfZPO3l8/88p68AjP9qudjB0oADLPX0dIE0RCzZ3y4a7V9oqJWgH/SNSVftVOLGFb
	 3mZueqawfRjJRRkNGwVQsMIw4EeJ2qsRQDQBpxSCp1ENMdcX4ibcPi5fGRQKeIg16f
	 dylemcPKpaIrQ==
Date: Mon, 17 Nov 2025 14:32:16 +0000
From: Conor Dooley <conor@kernel.org>
To: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rao, Mahesh" <mahesh.rao@altera.com>,
	"Ng, Adrian Ho Yin" <adrian.ho.yin.ng@altera.com>,
	"Rabara, Niravkumar Laxmidas" <nirav.rabara@altera.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
Message-ID: <20251117-imprison-upstream-5c80b3a55169@spud>
References: <cover.1763100984.git.khairul.anuar.romli@altera.com>
 <c614925ffdc98b1faace3ec9bd7124161b0b60ca.1763100984.git.khairul.anuar.romli@altera.com>
 <20251114-countless-vantage-6e18528d2e31@spud>
 <56a3a993-9e54-4468-8774-5ed350948ab5@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vWSTtIgt5V1L6ShY"
Content-Disposition: inline
In-Reply-To: <56a3a993-9e54-4468-8774-5ed350948ab5@altera.com>


--vWSTtIgt5V1L6ShY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 03:02:11AM +0000, Romli, Khairul Anuar wrote:
> On 15/11/2025 1:59 am, Conor Dooley wrote:
> > On Fri, Nov 14, 2025 at 02:27:41PM +0800, Khairul Anuar Romli wrote:
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
> >> Changes in v3:
> >> 	- Add description for Agilex5 Device
> >> 	- Add and define fallback to "intel,agilex-soc-fpga-mgr"
> >> 	- Validate against Agilex and Stratix10 (non-fallback) and Agilex5
> >> 	  (fallback)
> >> Changes in v2:
> >> 	- No changes in this patch
> >> ---
> >>   .../fpga/intel,stratix10-soc-fpga-mgr.yaml         | 14 +++++++++++-=
--
> >>   1 file changed, 11 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-so=
c-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-so=
c-fpga-mgr.yaml
> >> index 6e536d6b28a9..8eb414163d08 100644
> >> --- a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-=
mgr.yaml
> >> +++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-=
mgr.yaml
> >> @@ -20,9 +20,17 @@ description:
> >>  =20
> >>   properties:
> >>     compatible:
> >> -    enum:
> >> -      - intel,stratix10-soc-fpga-mgr
> >> -      - intel,agilex-soc-fpga-mgr
> >> +    oneOf:
> >> +      - items:
> >> +          - enum:
> >=20
> > This construct is redundant, "items: - enum" is the same as just having
> > "enum".
> > pw-bot: changes-requested
> >=20
> I've tried to look for some of the already merged bindings i.e=20
> arm/qcom.yaml (although all the properties has enum - constant=20
> combination), it is using items with enum. I tried to keep the enum witho=
ut
> items but I keep getting error while validating the changes.

I literally told you what to change, so I don't know why you didn't just
do that. Replacing "items: - enum" with "enum" is what you need to do.
You didn't even include the error you got, so I cannot help you with
that at all, nor even if you did what I told you to do.

> Another option that I've validated is using the following changes.
>=20
> -    enum:
> -      - intel,stratix10-soc-fpga-mgr
> -      - intel,agilex-soc-fpga-mgr
> +    oneOf:
> +      - description: Intel Stratix10 Devices
> +        items:
> +          - const: intel,stratix10-soc-fpga-mgr

These just have the same problem as your original patch.
"items: - const" is just the same as "const".
Since item "items" properties do not do anything other than bloat the
schema.

> +      - description: Intel Agilex Devices
> +        items:
> +          - const: intel,agilex-soc-fpga-mgr
> +      - description: Intel Agilex5 Devices
> +        items:
> +          - const: intel,agilex5-soc-fpga-mgr
> +          - const: intel,agilex-soc-fpga-mgr
>=20
> The drawback of this is we will need to implement enum instead of=20
> constant for first element if we need to add new devices under "Intel=20
> Agilex5 Devices" in the future.
>=20
> Thanks.
>=20
> Best Regards,
> Khairul
>=20
> >> +              - intel,stratix10-soc-fpga-mgr
> >> +              - intel,agilex-soc-fpga-mgr
> >> +
> >> +      - description: Agilex5 Device
> >> +        items:
> >> +          - enum:
> >> +              - intel,agilex5-soc-fpga-mgr
> >> +          - const: intel,agilex-soc-fpga-mgr
> >>  =20
> >>   required:
> >>     - compatible
> >> --=20
> >> 2.43.7
> >>
>=20

--vWSTtIgt5V1L6ShY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRsx8AAKCRB4tDGHoIJi
0o/fAQC96syge6k9COKhf2Lgn18Htaorsawx/aZAzKUlhSm1rAEAjKBPMYcMLogL
QQrz9erbEsoQzQZXvtZ6OuDlw5nP8Ac=
=fCSq
-----END PGP SIGNATURE-----

--vWSTtIgt5V1L6ShY--
