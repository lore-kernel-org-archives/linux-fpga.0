Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF43EF644;
	Thu,  2 Apr 2026 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142202; cv=none; b=Qzp1oPtzmZxmLnQditwBmlD4UwRJbhzSyPTTGNx/slLkEsL04wH+VB9bTtER7DlIugMM7QBZDR3r0K/EEvGGy5wufP+wOUQW9lAkH7YXJ0yduxvsFA54/f2fDh5xbq1Pt41FBGTeu5WAoy3X42UKvPCinCP9XuS3v+KLf6+IxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142202; c=relaxed/simple;
	bh=e8ae+zvdXyQNfLJop42MAeLvPYPyarvjh7umS+VkM7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMiJcTSIAVBIPRmgmRzRDYnfXzOHknVpwGmYlZVR16Wi+qcOjLuUYF/ROOy1ijVLNLn5ns5Zyxo8+G4oQzmz0pJFnmjmjwlRB2ONhI72JlSY0fTVLBAQHKEHdVO/xurHKCvXp+TGs+QvckwEnN5k+Sh8It++wafHLR8cP/CQ8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td5SqQCY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td5SqQCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42143C116C6;
	Thu,  2 Apr 2026 15:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775142202;
	bh=e8ae+zvdXyQNfLJop42MAeLvPYPyarvjh7umS+VkM7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Td5SqQCYxTRHb4OBFKE1ScyOGSkigcaA9Jj57iNM7TfCbQBQI7pN0occMSjTTglEo
	 T9aMLoPjMd6uxBzTikvHsZXP5xIlzE33EhefpFutyHj1i9GeTg7vzH0OtxuDvZzOA1
	 zpBam6c6/QuEBhtYqtZenH/T/s/jYPFDfSqyKglp33xeQaCrNfmsUO7VwU8vKR99kF
	 NoBo6EALhn1uvfzJpuZaj08S/w3j7Pmlueky+EyggbkxfeQ2G5sWWW17pF/v8CG2e9
	 9jftG90IIHLtnznetONjZeGZr4ybcplo4NAYrXZB/4U5RPnWSKRUuclre2ftgkWqii
	 mw7qg2dgM1Wnw==
Date: Thu, 2 Apr 2026 16:03:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: linux-fpga@vger.kernel.org, yilun.xu@linux.intel.com,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] fpga: microchip-spi: add bounds checks in
 mpf_ops_parse_header()
Message-ID: <20260402-litigator-skeptic-ce7faf76ad2c@spud>
References: <20260402125446.3776153-1-sebasjosue84@gmail.com>
 <20260402125446.3776153-3-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hw9qLKsJg0PNQPdl"
Content-Disposition: inline
In-Reply-To: <20260402125446.3776153-3-sebasjosue84@gmail.com>


--hw9qLKsJg0PNQPdl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2026 at 06:54:46AM -0600, Sebastian Alba Vives wrote:
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

Fixes: 5f8d4a9008307 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
CC: stable@vger.kernel.org

> ---
>  drivers/fpga/microchip-spi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index 6134cea..7954dd0 100644
> --- a/drivers/fpga/microchip-spi.c
> +++ b/drivers/fpga/microchip-spi.c
> @@ -116,7 +116,7 @@ static int mpf_ops_parse_header(struct fpga_manager *=
mgr,
>  	}
> =20
>  	header_size =3D *(buf + MPF_HEADER_SIZE_OFFSET);
> -	if (header_size > count) {
> +	if (!header_size || header_size > count) {
>  		info->header_size =3D header_size;
>  		return -EAGAIN;

Hmm, looking at this while feeling less ill, is this actually right?
The function returns EAGAIN to retry with a bigger buffer, but if
header_size is zero, increasing the buffer size will not change that
fact, and it'll go around forever? See the user in
fpga_mgr_parse_header_sg()

>  	}
> @@ -139,6 +139,10 @@ static int mpf_ops_parse_header(struct fpga_manager =
*mgr,
>  	bitstream_start =3D 0;
> =20
>  	while (blocks_num--) {
> +		if (block_id_offset >=3D count ||
> +		    block_start_offset + sizeof(u32) > count)
> +			return -EINVAL;

And here, why doesn't it return EAGAIN? Isn't the provided section of
the image just too small, so we want to be provided more of it to
actually complete header parsing?

Cheers,
Conor.

> +
>  		block_id =3D *(buf + block_id_offset);
>  		block_start =3D get_unaligned_le32(buf + block_start_offset);
> =20
> @@ -183,6 +187,10 @@ static int mpf_ops_parse_header(struct fpga_manager =
*mgr,
>  		component_size_byte_off =3D
>  			(i * MPF_BITS_PER_COMPONENT_SIZE) % BITS_PER_BYTE;
> =20
> +		if (components_size_start + component_size_byte_num +
> +		    sizeof(u32) > count)
> +			return -EINVAL;
> +
>  		component_size =3D get_unaligned_le32(buf +
>  						    components_size_start +
>  						    component_size_byte_num);
> --=20
> 2.43.0
>=20

--hw9qLKsJg0PNQPdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCac6FMwAKCRB4tDGHoIJi
0hnfAQCIIbDH5jyvRBLdCy28xvuR1FIUVBfbpfbaKRl2IkoATgEA3dR+A89nVM/G
Kcv9kgdhRYrBQa4oapKt6J2OcE0QKwA=
=YbhR
-----END PGP SIGNATURE-----

--hw9qLKsJg0PNQPdl--
