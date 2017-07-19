Return-Path: <SRS0=0za6=6W=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=0za6=6W=ettus.com=moritz.fischer@kernel.org>
Date: Wed, 19 Jul 2017 09:12:37 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 002/102] ARM: socfpga: explicitly request exclusive reset
 control
Message-ID: <20170719161237.GA22403@tyrael.ni.corp.natinst.com>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
 <20170719152646.25903-3-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20170719152646.25903-3-p.zabel@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Alan Tull <atull@kernel.org>, Moritz Fischer <moritz.fischer@ettus.com>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 05:25:06PM +0200, Philipp Zabel wrote:
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
>=20
> No functional changes.
>=20
> Cc: Alan Tull <atull@kernel.org>
> Cc: Moritz Fischer <moritz.fischer@ettus.com>
> Cc: linux-fpga@vger.kernel.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-By: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/altera-hps2fpga.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpg=
a.c
> index 3066b805f2d07..a18ff430c9af1 100644
> --- a/drivers/fpga/altera-hps2fpga.c
> +++ b/drivers/fpga/altera-hps2fpga.c
> @@ -145,7 +145,8 @@ static int alt_fpga_bridge_probe(struct platform_devi=
ce *pdev)
>  	of_id =3D of_match_device(altera_fpga_of_match, dev);
>  	priv =3D (struct altera_hps2fpga_data *)of_id->data;
> =20
> -	priv->bridge_reset =3D of_reset_control_get_by_index(dev->of_node, 0);
> +	priv->bridge_reset =3D of_reset_control_get_exclusive_by_index(dev->of_=
node,
> +								     0);
>  	if (IS_ERR(priv->bridge_reset)) {
>  		dev_err(dev, "Could not get %s reset control\n", priv->name);
>  		return PTR_ERR(priv->bridge_reset);
> --=20
> 2.11.0
>=20

Thanks,

Moritz

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZb4TyAAoJEL5CEHepFqovR2UH/iSDe4WNOHC9N9vizADMlX0g
cX1jSaYlEE2HLTfntUrNMgAC0nbzC613p3cpHBiQseQGdVh5eAR8t8NvJQrsIA08
pWsf78GXSKbBgwqAXcedhd2b+3At+zE6hp9aurdwCRD4VKABYQH5dnr3urqUdSuH
6eRw5T6fZ3XYuIIz77uglgZUrvuGXaAby5K6m7yhNYWtbFp3Xhq6nJ10KeHounPB
CztYf3g5yjdhzKuPFtlM9uKCKvK8WjzPvp1VCdtVsiL4nUK9rLPkkGHyvfkIN9y/
5Q9o1toeHmjPx/2+HoEVLchfyIpLFW/iofgwV2vrWqJkMK9KtrVbekYMeET+5RI=
=vztB
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
