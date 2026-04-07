Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2FE270ED7;
	Tue,  7 Apr 2026 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580197; cv=none; b=Cty7FAjtCw9sELJnzXu1v6Bo9VBBZ80KDfpOIjag62363Ltf0IzSAr9An47KeT5dok5tWrXq2SqZqCqiyxlqPkmZpfOYSSaIGHzf3CJSXsRqKkLEKRdu/vueVYPdgb3BohyKjgB6o6jPKVKQfWvHZSxdn1LV8W3XizSUrRhYT9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580197; c=relaxed/simple;
	bh=Ox69AsM+vDuSJSDnZDVjwXihczsBtHfSfaygPAMk3u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWesN+Xz9pXSX+gpx/66LUVF/w+143G+qqDvMmaTsUnJEa9qZ0ML475z5+qOpKUp5gMJoqtkBMlnKmHLX2DLsgrg+mjyLj+2MGZ5ep7XLQ1kIGNRBgsx+xgeV8jfirnCqWJ8D0DHjei/2cMd+PYIuGSrdPQBsvbciHY+TNLHMZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kj3UuIc+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj3UuIc+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB89DC116C6;
	Tue,  7 Apr 2026 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775580197;
	bh=Ox69AsM+vDuSJSDnZDVjwXihczsBtHfSfaygPAMk3u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kj3UuIc+qhDfQKdt5SB4XMhpciY5VmMMAEV5/2VCOJmk4pKG0+rjdxydVIgbMsZ0x
	 7xOmDP4Cfs96/d6qTghqlzJsV9q6uwdd+8vdRazU8xy33eNJt1pO48pSb/HLxk1NS1
	 XGz7BqoRWo57HjKekUG2CX1kX6O19NV7iKY6DMrny8Mh1LPMh7IU3rNfEWU3IUr6VO
	 6YoaOSFS8wta45Y/hLMAwDgiL2bmufAvEcf9NvkKqRC8iKRo9sHuwVhkb4aY8B0vJx
	 YR3bEcQhCg+RqTCb+9FGibGJtqqFvbA/Zyqh6p5coTNDeiGNEV7jA31z1URJtWgEpf
	 hzhhRT/in7jgw==
Date: Tue, 7 Apr 2026 17:43:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: yilun.xu@linux.intel.com, linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fpga: microchip-spi: add bounds checks in
 mpf_ops_parse_header()
Message-ID: <20260407-gap-contest-94de4e56592d@spud>
References: <20260402125446.3776153-1-sebasjosue84@gmail.com>
 <20260407140601.15006-1-sebasjosue84@gmail.com>
 <20260407140601.15006-3-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C0EgYrbvZPEfouiD"
Content-Disposition: inline
In-Reply-To: <20260407140601.15006-3-sebasjosue84@gmail.com>


--C0EgYrbvZPEfouiD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2026 at 08:06:01AM -0600, Sebastian Alba Vives wrote:
> From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
>=20
> mpf_ops_parse_header() reads several fields from the bitstream file
> and uses them as offsets and sizes without validating them against the
> buffer size, leading to multiple out-of-bounds read vulnerabilities:
>=20
> 1. When header_size (u8 from file) is 0, the expression
>    *(buf + header_size - 1) reads one byte before the buffer.
>=20
> 2. In the block lookup loop, block_id_offset and block_start_offset
>    advance by MPF_LOOKUP_TABLE_RECORD_SIZE (9) each iteration with
>    blocks_num (u8) controlling the count. With a small buffer, these
>    offsets exceed count, causing OOB reads via get_unaligned_le32().
>=20
> 3. components_size_start (from file) and component_size_byte_num
>    (derived from components_num, u16 from file) are used as offsets
>    into buf without validation, allowing arbitrary OOB reads.
>=20
> Add bounds checks for all three cases: reject header_size of 0,
> validate offsets in the block lookup loop, and validate the component
> size read offset.
>=20
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

If there's more revisions, please stop sending new versions in response
to old, this is what I see in my mailbox and it is very confusing:

|   1 N   Apr 02 Greg KH         (  43)   =E2=94=8C=E2=94=80>Re: [PATCH 2/3=
] fpga: dfl-afu: fix integer truncation of npages in afu_dma_pin_pages()
|   2 N   Apr 04 Greg KH         (  26)   =E2=94=82 =E2=94=8C=E2=94=80>
|   3 N   Apr 03 Sebastian Alba  (  55)   =E2=94=9C=E2=94=80>[PATCH v2] fpg=
a: dfl-afu: validate DMA mapping length in afu_dma_map_region()
|   4 N   Apr 07 Sebastian Alba  (  41)   =E2=94=9C=E2=94=80>[PATCH v3 2/3]=
 fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
|   5 N   Apr 02 Sebastian Alba  (  40) =E2=94=8C=E2=94=80>[PATCH 2/3] fpga=
: dfl-afu: fix integer truncation of npages in afu_dma_pin_pages()
|   6 NsF Apr 02 To Sebastian Al ( 116) =E2=94=82   =E2=94=8C=E2=94=80>
|   7 NsF Apr 02 To Sebastian Al ( 107) =E2=94=82 =E2=94=8C=E2=94=80>Re: [P=
ATCH 3/3] fpga: microchip-spi: add bounds checks in mpf_ops_parse_header()
|   8 N   Apr 02 Greg KH         ( 106) =E2=94=82 =E2=94=82 =E2=94=8C=E2=94=
=80>
|   9 N   Apr 02 Greg KH         (  45) =E2=94=82 =E2=94=82 =E2=94=9C=E2=94=
=80>
|  10 NsF Apr 02 To Sebastian Al ( 104) =E2=94=82 =E2=94=82 =E2=94=9C=E2=94=
=80>
|  11 N   Apr 02 Sebastian Alba  (  76) =E2=94=82 =E2=94=9C=E2=94=80>[PATCH=
 v2] fpga: microchip-spi: add bounds checks in mpf_ops_parse_header()
|  12 N   Apr 07 Xu Yilun        (  60) =E2=94=82 =E2=94=82 =E2=94=8C=E2=94=
=80>
|  13 N   Apr 02 Sebastian Alba  ( 105) =E2=94=82 =E2=94=9C=E2=94=80>[PATCH=
 v3] fpga: microchip-spi: add bounds checks in mpf_ops_parse_header()
|  14 N   Apr 02 Sebastian Alba  (  65) =E2=94=9C=E2=94=80>[PATCH 3/3] fpga=
: microchip-spi: add bounds checks in mpf_ops_parse_header()
|  15 N   Apr 07 Xu Yilun        (  61) =E2=94=9C=E2=94=80>Re: [PATCH 1/3] =
fpga: dfl: add bounds check in dfh_get_param_size()
|  16 N   Apr 07 Sebastian Alba  (  40) =E2=94=82 =E2=94=8C=E2=94=80>[PATCH=
 v2 2/3] fpga: dfl-afu: fix integer truncation of npages in afu_dma_pin_pag=
es()
|  17 N   Apr 07 Sebastian Alba  (  65) =E2=94=82 =E2=94=9C=E2=94=80>[PATCH=
 v2 3/3] fpga: microchip-spi: add bounds checks in mpf_ops_parse_header()
|  18 N   Apr 07 Sebastian Alba  (  41) =E2=94=9C=E2=94=80>[PATCH v2 1/3] f=
pga: dfl: add bounds check in dfh_get_param_size()
|  19 N   Apr 02 Sebastian Alba  (  37) [PATCH 1/3] fpga: dfl: add bounds c=
heck in dfh_get_param_size()

If one patch needs changing, you unfortunately need to resubmit the
whole series. If you look here there's multiple v2s of the
microchip-spi patch because of the partial resending.

--C0EgYrbvZPEfouiD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCadU0IQAKCRB4tDGHoIJi
0j5mAQCyuMz7otaxiedH2DOxRxXj4PDHt5off4e6DflGoISuvgD+Ol+r+gLlUxlE
P7tVYaqbsTDrZoVdD/1LgBCkvIm/gAA=
=WkrV
-----END PGP SIGNATURE-----

--C0EgYrbvZPEfouiD--
