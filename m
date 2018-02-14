Return-Path: <SRS0=ZLx5=FI=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=ZLx5=FI=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32818 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031938AbeBNXKS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 14 Feb 2018 18:10:18 -0500
Received: by mail-pg0-f65.google.com with SMTP id g12so2786237pgs.0
        for <linux-fpga@vger.kernel.org>; Wed, 14 Feb 2018 15:10:17 -0800 (PST)
Date: Wed, 14 Feb 2018 15:05:20 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga-manager: altera-ps-spi: preserve nCONFIG state
Message-ID: <20180214230520.GD25618@tyrael.ni.corp.natinst.com>
References: <20180201222004.15949-1-agust@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <20180201222004.15949-1-agust@denx.de>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Joshua Clayton <stillcompiling@gmail.com>


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anatolij,

On Thu, Feb 01, 2018 at 11:20:04PM +0100, Anatolij Gustschin wrote:
> If the driver module is loaded when FPGA is configured, the FPGA
> is reset because nconfig is pulled low (low-active gpio inited
> with GPIOD_OUT_HIGH activates the signal which means setting its
> value to low). Init nconfig with GPIOD_OUT_LOW to prevent this.
>=20
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/altera-ps-spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index c593f33d8db9..6891933d072d 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -258,7 +258,7 @@ static int altera_ps_probe(struct spi_device *spi)
>  	}
> =20
>  	conf->spi =3D spi;
> -	conf->config =3D devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_HIGH);
> +	conf->config =3D devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
>  	if (IS_ERR(conf->config)) {
>  		dev_err(&spi->dev, "Failed to get config gpio: %ld\n",
>  			PTR_ERR(conf->config));
> --=20
> 2.11.0
>=20

Thanks for your patch,

Moritz

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlqEwKkACgkQUVwKRFcJ
cNhf7Af/U6JM1jgnqeMj/s81+WLl4p9lB7RD321cvFY816gwf9KJQsrcIybzB8YM
ZipF+WIK/5yMTtX3mIjwTgWg8lSo6KmQiR7N+QcMkLsIht72T9kOce5g3CswPAut
g71asY4NNDoZcJcIcKMA0Po6lYO7VNN5+C0Oac0gDOBHDmTItg2LspZJdPV5BQ8f
yDNs3Gosi7On30OxXGXXIQrlXYx57aKt9IfcFIpTnt2USDQqtqYwXhSdC53LYkaW
Yl7iw1gRh/ix2ZW5AInPmggV9B2DQTbuM7aUz+wYUuap/18AfYDGUI7QTL1R5HWD
qr9TGHwBZEDfwSJJC6crAfeOeELurA==
=Bo8J
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
