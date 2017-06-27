Return-Path: <SRS0=mv5P=6A=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=mv5P=6A=ettus.com=moritz.fischer@kernel.org>
Date: Tue, 27 Jun 2017 09:36:00 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: altera-hps2fpga: fix multiple init of l3_remap_lock
Message-ID: <20170627163600.GA9914@tyrael.amer.corp.natinst.com>
References: <20170627151842.15955-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20170627151842.15955-1-abbotti@mev.co.uk>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>, Moritz Fischer <moritz.fischer@ettus.com>, "# 4 . 10+" <stable@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 04:18:42PM +0100, Ian Abbott wrote:
> The global spinlock `l3_remap_lock` is reinitialized every time the
> "probe" function `alt_fpga_bridge_probe()` is called.  It should only be
> initialized once.  Use `DEFINE_SPINLOCK()` to initialize it statically.
>=20
> Fixes: e5f8efa5c8bf ("ARM: socfpga: fpga bridge driver support")
> Cc: <stable@vger.kernel.org> # 4.10+
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Reviewed-By: Moritz Fischer <mdf@kernel.org>

Thanks for catching that,

Moritz
> ---
>  drivers/fpga/altera-hps2fpga.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpg=
a.c
> index 3066b805f2d0..08c0ecb7d109 100644
> --- a/drivers/fpga/altera-hps2fpga.c
> +++ b/drivers/fpga/altera-hps2fpga.c
> @@ -66,7 +66,7 @@ static int alt_hps2fpga_enable_show(struct fpga_bridge =
*bridge)
> =20
>  /* The L3 REMAP register is write only, so keep a cached value. */
>  static unsigned int l3_remap_shadow;
> -static spinlock_t l3_remap_lock;
> +static DEFINE_SPINLOCK(l3_remap_lock);
> =20
>  static int _alt_hps2fpga_enable_set(struct altera_hps2fpga_data *priv,
>  				    bool enable)
> @@ -171,8 +171,6 @@ static int alt_fpga_bridge_probe(struct platform_devi=
ce *pdev)
>  		return -EBUSY;
>  	}
> =20
> -	spin_lock_init(&l3_remap_lock);
> -
>  	if (!of_property_read_u32(dev->of_node, "bridge-enable", &enable)) {
>  		if (enable > 1) {
>  			dev_warn(dev, "invalid bridge-enable %u > 1\n", enable);
> --=20
> 2.11.0
>=20

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUoltAAoJEL5CEHepFqovJjwIAMh3y5wuHA+jGsY08zj5kBF9
O2mH7VO0vEf1vlf+66tyGeoKiAlZhMLAAPFBK32zABZ1ge8iUJzTSv9XjmMb0b3T
TMGZvyxDjUzU7KA5UcgXTx9nkJyWFNqHs17UzIz7SwFK/Jl7fcFLTAOyl4Klsgb8
SjIpTl16yvVzVoge0WZegL4TcLWbM89k+6PyGmEytBJ0szRyS4jqJm8b25/nDxAN
z7vi7POzQPOAMRT+8swI7CFFEVMXAbSLanEwdDNLGadWUS7jRKSpjRzEWHwTD6ca
eE+mdIAwQLUWSOUz0u8E0JbyZp2RX5wof738HO+pLT9DnEJ322AjZZfCex0HI5Y=
=paHL
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
