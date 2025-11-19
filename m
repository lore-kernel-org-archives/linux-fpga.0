Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE11AC44D;
	Wed, 19 Nov 2025 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763515213; cv=none; b=uKX9NnPrXXUu+7ezDUa8eFJ2j8GwVbsEc2YvfRbtkFjZlUYc9l+wplksjQaN+QJ1+HkJEIFbZz4Oa6Iw+zt7iJcwNaJ1eoqJv//jlZttJz0SJYCwxVSzswAYb6uffkjgQQz2scjn+tq9oUCpIh432UyvvswfQ50gNoDeQCs6qCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763515213; c=relaxed/simple;
	bh=uuP28POgAh0XeGr8PvWzVoZscsQM1FFVlv8M3evfi3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtB6SAd9gZIBwwCEhO1LLH/1D/KDm3kMD9R+wRzaXR3p/cbWEeXxzodvGL4T62g72QIHn7yesCfycEhCZpTSPDukjfw7LWGicmiRfZEOWYJ86NCPg73k1vEFvV3gK4WTBK9wjGVu8laHUgWEnWk0ObHuLtJJF3QqVbTiE4hb06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If12Kc80; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If12Kc80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A96C4CEF5;
	Wed, 19 Nov 2025 01:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763515210;
	bh=uuP28POgAh0XeGr8PvWzVoZscsQM1FFVlv8M3evfi3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=If12Kc80mluai5frgnnoJPRFZSiN548cnAKpPAzx02Rm07/3dKrdrJ3wbJzvnXsKv
	 Ply7IeoC8ERociTPdrU9H6z12LuD50tRWtWb1lhr5V869USWQ0lqDHNoDgesy7E9xK
	 aIeG3S9LS9kcrPpv4DU+aiIY6mpCZCu8aP1hm3j5tro58HMDwXSMnDX3L/TyCd5eHc
	 KQLq2VN6AgD2Zzo1rillE31AYGAQOR7OhNEvh3Pbngk9EbWdPndOiUcj3B9vcORxxN
	 GwLdS5U+HiwBBWi++vxMALem1nC6gnjHZlo4nurOuwn/v1KE0/xaJw+8rpoVcs7heO
	 DbUSEesNlUT4g==
Date: Wed, 19 Nov 2025 01:20:03 +0000
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
Subject: Re: [PATCH v5 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
Message-ID: <20251119-switch-dubbed-84e2ae59d04c@spud>
References: <cover.1763508492.git.khairul.anuar.romli@altera.com>
 <e013899786a6a199627bc56c9766672d215a4e23.1763508492.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AyLkZHALeL9SuZed"
Content-Disposition: inline
In-Reply-To: <e013899786a6a199627bc56c9766672d215a4e23.1763508492.git.khairul.anuar.romli@altera.com>


--AyLkZHALeL9SuZed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 07:34:18AM +0800, Khairul Anuar Romli wrote:
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
> Changes in v5:
> 	- Revert to oneOf and use enum without items.
> Changes in v4:
> 	- Remove redundant "items - enum" as suggested in v3.
> 	- Simplify compatible property to use contains instead of oneOf.
> 	- Validate fallback and non-fallback DT. Also validate binding with
>           dt_binding_check.
> Changes in v3:
> 	- Add description for Agilex5 Device
> 	- Add and define fallback to "intel,agilex-soc-fpga-mgr"
> 	- Validate against Agilex and Stratix10 (non-fallback) and Agilex5
> 	  (fallback)
> Changes in v2:
> 	- No changes in this patch
> ---
>  .../bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml    | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-f=
pga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-f=
pga-mgr.yaml
> index 6e536d6b28a9..14437dfc47a4 100644
> --- a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr=
=2Eyaml
> @@ -20,9 +20,13 @@ description:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - intel,stratix10-soc-fpga-mgr
> -      - intel,agilex-soc-fpga-mgr
> +    oneOf:
> +      - enum:
> +          - intel,stratix10-soc-fpga-mgr
> +          - intel,agilex-soc-fpga-mgr

Great, you've fixed this part.

> +      - enum:
> +          - intel,agilex5-soc-fpga-mgr
> +        const: intel,agilex-soc-fpga-mgr

But unfortunately this is wrong, and you should have noticed it
because the dts patch you have will produce a warning.
This one actually does need the items, you had it right in v3.
You'll note that my v3 feedback specifically said "this construct" and
was inserted at the point of the redundant single item items list:
https://lore.kernel.org/all/20251114-countless-vantage-6e18528d2e31@spud/

pw-bot: changes-requested

Please take some time to both test and understand the change you are
making.

Thanks,
Conor.

> =20
>  required:
>    - compatible
> --=20
> 2.43.7
>=20

--AyLkZHALeL9SuZed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaR0bQwAKCRB4tDGHoIJi
0ppiAP4+vuCu8JGYYzUKyXtZKUsGBL/BN7HCrhfREqWfesez/gEA6wwlR3W8EJuu
1w9hknn8CAlm0HBmt0SqYyIBhgjMngI=
=rjPf
-----END PGP SIGNATURE-----

--AyLkZHALeL9SuZed--
