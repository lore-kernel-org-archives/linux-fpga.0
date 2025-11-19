Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1681304BD3;
	Wed, 19 Nov 2025 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763574559; cv=none; b=hYmrTE4iSj5jZz+0ajsGVGw7TyMmkLr8JxKH3cAChZKNA8ycDZbXTA+jcT003ULBBTvB8z9DqiQNMdl8kHGNFXyrfTucl3EnS60zE6Hm8aariT3px5icZHn9v3hylbL9fChbxAi+2QcAzvMhcluM98F0eA1D6WrtqUMSPT7gsQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763574559; c=relaxed/simple;
	bh=SBveXZKM7cTtEGT0408CwwwAeaNaVeR/uyCCnqgHVJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdAkeI8zFF97n5YbaSpCwTX+0yEzmE0gHxKpMTYeLgTYksr4w0gsa58i+dcmsyp4B+Y4YaJUnWcsKuUQzQoUDIOY0EfN6qHkATIHIn9wNfiBj7ynpfXk/+pjDPAVvZlsMYbHbxylQSP8qRh/yHJlICkmZ6cEF9FCDFs4XhMi7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q22w1wOn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q22w1wOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75BBC4CEF5;
	Wed, 19 Nov 2025 17:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763574557;
	bh=SBveXZKM7cTtEGT0408CwwwAeaNaVeR/uyCCnqgHVJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q22w1wOnTLYs4GSbYVWAmWAX7q59q5SxlJU8geY/qAmzu88upI0vhJZV//BH2Qg9A
	 BT5u6hvv9iSMQnNxO8SibZMeWVBOWzECbOlezWpqO/85dteA7He6zFaKUmycDF4Uam
	 F/ClG3sh9eSWN1UPap4IBeGJizKZboFMRHMgLBCowjMxLDKYQNRQHu6+G3h9QsVnvt
	 DnuNBXC80cIXcNctJyOR5tkIhadwoevX7Fa/e5NFI4hutKXdaVwMoWJQ6Id+Usk8Df
	 LCu5uc3alTNHLbuY9MEvrYQuIFDOyTMOIU70ubPfSuDMV656XwAuffkM19CwpbHxuN
	 cs3+KYQiVf9LQ==
Date: Wed, 19 Nov 2025 17:49:12 +0000
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
Subject: Re: [PATCH v5 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
Message-ID: <20251119-crushed-supreme-9d22b030f507@spud>
References: <cover.1763508492.git.khairul.anuar.romli@altera.com>
 <e013899786a6a199627bc56c9766672d215a4e23.1763508492.git.khairul.anuar.romli@altera.com>
 <20251119-switch-dubbed-84e2ae59d04c@spud>
 <07575ce3-eab7-46dd-baad-8a909124a962@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YoIZHTcLr5ZpKJR2"
Content-Disposition: inline
In-Reply-To: <07575ce3-eab7-46dd-baad-8a909124a962@altera.com>


--YoIZHTcLr5ZpKJR2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 01:45:03AM +0000, Romli, Khairul Anuar wrote:

> I will go through other bindings with rg --multiline that you shared and=
=20
> will send next version after all the test is done.

Unless you're planning on fixing the ones that should not have contains,
that comment was only for Krzysztof.

--YoIZHTcLr5ZpKJR2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaR4DFQAKCRB4tDGHoIJi
0lpUAPsGy6soVJo8aPIip7AXkgFYyXveot8BbSfbJ+Qa0XtHCQD/T1CqBLAr/zbr
nSFonUSak5SwdJYSV67LZDeSphQ9Qws=
=4CnJ
-----END PGP SIGNATURE-----

--YoIZHTcLr5ZpKJR2--
