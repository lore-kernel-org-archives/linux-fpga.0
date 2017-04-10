Date: Mon, 10 Apr 2017 10:56:20 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: region: release FPGA region reference in error path
Message-ID: <20170410175620.GA22815@tyrael.amer.corp.natinst.com>
References: <20170410135103.18612-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20170410135103.18612-1-tklauser@distanz.ch>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <moritz.fischer@ettus.com>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2017 at 03:51:03PM +0200, Tobias Klauser wrote:
> If fpga_region_get_manager() fails in fpga_region_program_fpga(), a
> reference to the fpga_manager instance previously acquired through
> fpga_region_get() is retained. Make sure to properly release it in the
> error case by using a separate jump label which will call
> fpga_region_put() in before returning.
>=20
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/fpga-region.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index ae4c61aada99..3b6b2f4182a1 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -245,7 +245,8 @@ static int fpga_region_program_fpga(struct fpga_regio=
n *region,
>  	mgr =3D fpga_region_get_manager(region);
>  	if (IS_ERR(mgr)) {
>  		pr_err("failed to get fpga region manager\n");
> -		return PTR_ERR(mgr);
> +		ret =3D PTR_ERR(mgr);
> +		goto err_put_region;
>  	}
> =20
>  	ret =3D fpga_region_get_bridges(region, overlay);
> @@ -281,6 +282,7 @@ static int fpga_region_program_fpga(struct fpga_regio=
n *region,
>  	fpga_bridges_put(&region->bridge_list);
>  err_put_mgr:
>  	fpga_mgr_put(mgr);
> +err_put_region:
>  	fpga_region_put(region);
> =20
>  	return ret;
> --=20
> 2.12.2
>=20
>=20

Thanks,
Moritz

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY68dCAAoJEL5CEHepFqovkewH/3S6Q88Aw/UjD+LBrynhVKgg
Hkv+GAXnmdDZO849tl1H3cB2sMkJj+kVpzWQAIA8dRw8nG5sTi+zrQg6udBZbTDh
olxsajDvtsHPtI2HgJUPWDhRwOZnv09WWey1bxkLW0lV6WglZjzwjV0d4cyfXn8A
L63o9T1OsGF8J4bWNDMcKxs50Z1zLR5Pxl0C8zx9NpYzU7JLPvmVqkTG1wtkbrqK
ht9RuXpwtd5h40q6C5KuufP1xaYYy3pFeNozIETcxgSRDQuzrpqbGlBSs3WZR0LO
aRpQEWKR1cbKf1YeNAUu9MXAkdYW8J8pAg2Amf9YrVy8V3DLRMnNVLc6NxuKcP8=
=NdiF
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
