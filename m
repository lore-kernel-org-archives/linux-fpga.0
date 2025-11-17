Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE330FF37;
	Mon, 17 Nov 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390051; cv=none; b=O8vn87FJKgcoh0ljSLdtJQkC+BZP6KTdz8Bp8MT+nJkTXSxmjBUlATdmg7y447aUuSaLKuIRtGcbSS16Ubm6lj3BU88JoXKTv1fmtpS7P00caeO8K62GR4IjovSeIrLspGNNt+qJX4J2bGmGKdYyHWzZBGAdUzTvZo1i1NK/53s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390051; c=relaxed/simple;
	bh=BXhc7ixW86ro/ZJjEn/CSD3jHeIMDbw9HLUl8qtuo4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgXtuXuRBYuFDyzxh+TL+H1GnbfiHT2KlHrPJ2GzZ73nXaSYyA9S6Ctl9kReDfXx++5fRwdfgsCmdPjayLh7GmO0uz4a7ZhLdeMMbXLjix9days65Gl+BRvgdnxhOe3VWor6EKsCcPJql1KEW9vSPGHOuZZKMbXZNzi9qHr2GgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/43iYsJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/43iYsJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A77DC4CEF1;
	Mon, 17 Nov 2025 14:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763390051;
	bh=BXhc7ixW86ro/ZJjEn/CSD3jHeIMDbw9HLUl8qtuo4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/43iYsJLHNxc+uAT00uCGEpMeKOXPb1/Tt34s0Ry1TPbFZIucKCznwnumI7fcQPh
	 e8U1QEewMilbDRMcmPquzKHtiTV/iwggHWo0vYyhx1jCYkt9iTuidXbbzZmUCk4YZg
	 T2DXlclxZp1lENhwjftprII/3TZTJcnJHHxYWDEbKMFWeZ+vigX0M84jkV0pRGfdMA
	 fsgIR1dGMaH1up1s4rr+2QpvcOwDG0k2NhdrBPRSyUaRpQZHqRzxGk0uZKjkU5NMHm
	 gbKXqct0FZ//wR7HgtkIOKEAuyr7wm+xynAa0UdBqgeuZ2y8EdCb3mWkVV3QHnAvWT
	 MwDHfnQc34gDg==
Date: Mon, 17 Nov 2025 14:34:06 +0000
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
Message-ID: <20251117-empty-skipping-a2c0c9aec1c7@spud>
References: <cover.1763100984.git.khairul.anuar.romli@altera.com>
 <c614925ffdc98b1faace3ec9bd7124161b0b60ca.1763100984.git.khairul.anuar.romli@altera.com>
 <20251114-countless-vantage-6e18528d2e31@spud>
 <56a3a993-9e54-4468-8774-5ed350948ab5@altera.com>
 <20251117-imprison-upstream-5c80b3a55169@spud>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WXFMmdlZ+8JG5dL+"
Content-Disposition: inline
In-Reply-To: <20251117-imprison-upstream-5c80b3a55169@spud>


--WXFMmdlZ+8JG5dL+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 02:32:16PM +0000, Conor Dooley wrote:
> On Mon, Nov 17, 2025 at 03:02:11AM +0000, Romli, Khairul Anuar wrote:
> > On 15/11/2025 1:59 am, Conor Dooley wrote:
> > > On Fri, Nov 14, 2025 at 02:27:41PM +0800, Khairul Anuar Romli wrote:
> > >> Agilex5 introduces changes in how reserved memory is mapped and acce=
ssed
> > >> compared to previous SoC generations. Agilex5 compatible allows stra=
tix10-
> > >> FPGA manager driver to handle these changes.
> > >>
> > >> Fallback is added for driver probe and init that rely on matching of=
 table
> > >> and DT node.
> > >>
> > >> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> > >> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> > >> ---
> > >> Changes in v3:
> > >> 	- Add description for Agilex5 Device
> > >> 	- Add and define fallback to "intel,agilex-soc-fpga-mgr"
> > >> 	- Validate against Agilex and Stratix10 (non-fallback) and Agilex5
> > >> 	  (fallback)
> > >> Changes in v2:
> > >> 	- No changes in this patch
> > >> ---
> > >>   .../fpga/intel,stratix10-soc-fpga-mgr.yaml         | 14 ++++++++++=
+---
> > >>   1 file changed, 11 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-=
soc-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-=
soc-fpga-mgr.yaml
> > >> index 6e536d6b28a9..8eb414163d08 100644
> > >> --- a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpg=
a-mgr.yaml
> > >> +++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpg=
a-mgr.yaml
> > >> @@ -20,9 +20,17 @@ description:
> > >>  =20
> > >>   properties:
> > >>     compatible:
> > >> -    enum:
> > >> -      - intel,stratix10-soc-fpga-mgr
> > >> -      - intel,agilex-soc-fpga-mgr
> > >> +    oneOf:
> > >> +      - items:
> > >> +          - enum:
> > >=20
> > > This construct is redundant, "items: - enum" is the same as just havi=
ng
> > > "enum".
> > > pw-bot: changes-requested
> > >=20
> > I've tried to look for some of the already merged bindings i.e=20
> > arm/qcom.yaml (although all the properties has enum - constant=20
> > combination), it is using items with enum. I tried to keep the enum wit=
hout
> > items but I keep getting error while validating the changes.
>=20
> I literally told you what to change, so I don't know why you didn't just
> do that. Replacing "items: - enum" with "enum" is what you need to do.
> You didn't even include the error you got, so I cannot help you with
> that at all, nor even if you did what I told you to do.

nor even know if you did*

>=20
> > Another option that I've validated is using the following changes.
> >=20
> > -    enum:
> > -      - intel,stratix10-soc-fpga-mgr
> > -      - intel,agilex-soc-fpga-mgr
> > +    oneOf:
> > +      - description: Intel Stratix10 Devices
> > +        items:
> > +          - const: intel,stratix10-soc-fpga-mgr
>=20
> These just have the same problem as your original patch.
> "items: - const" is just the same as "const".
> Since item "items" properties do not do anything other than bloat the
> schema.
>=20
> > +      - description: Intel Agilex Devices
> > +        items:
> > +          - const: intel,agilex-soc-fpga-mgr
> > +      - description: Intel Agilex5 Devices
> > +        items:
> > +          - const: intel,agilex5-soc-fpga-mgr
> > +          - const: intel,agilex-soc-fpga-mgr
> >=20
> > The drawback of this is we will need to implement enum instead of=20
> > constant for first element if we need to add new devices under "Intel=
=20
> > Agilex5 Devices" in the future.
> >=20
> > Thanks.
> >=20
> > Best Regards,
> > Khairul
> >=20
> > >> +              - intel,stratix10-soc-fpga-mgr
> > >> +              - intel,agilex-soc-fpga-mgr
> > >> +
> > >> +      - description: Agilex5 Device
> > >> +        items:
> > >> +          - enum:
> > >> +              - intel,agilex5-soc-fpga-mgr
> > >> +          - const: intel,agilex-soc-fpga-mgr
> > >>  =20
> > >>   required:
> > >>     - compatible
> > >> --=20
> > >> 2.43.7
> > >>
> >=20



--WXFMmdlZ+8JG5dL+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRsyXQAKCRB4tDGHoIJi
0rCyAP4utqQstWaCTP7+RBEHhitP90gFghDlw7UX7crpjV0zkQD9FeKC/peO/p8a
Av5AbloFAjSQqemalUIqPLkewQBwbAA=
=rrU3
-----END PGP SIGNATURE-----

--WXFMmdlZ+8JG5dL+--
