Return-Path: <SRS0=atEN=AT=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=atEN=AT=ettus.com=moritz.fischer@kernel.org>
Date: Mon, 18 Sep 2017 09:42:25 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 1/2] fpga: altera-cvp: remove DRIVER_ATTR() usage
Message-ID: <20170918164225.GA31137@tyrael.ni.corp.natinst.com>
References: <20170918101736.GA30415@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20170918101736.GA30415@kroah.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2017 at 12:17:36PM +0200, Greg Kroah-Hartman wrote:
> It's better to be explicit and use the DRIVER_ATTR_RW() macro when
> defining a driver's sysfs file.
>=20
> This is part of a series to drop DRIVER_ATTR() from the tree entirely.
>=20
> Cc: Alan Tull <atull@kernel.org>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: linux-fpga@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/altera-cvp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 08629ee69d11..00e73d28077c 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -361,12 +361,12 @@ static const struct fpga_manager_ops altera_cvp_ops=
 =3D {
>  	.write_complete	=3D altera_cvp_write_complete,
>  };
> =20
> -static ssize_t show_chkcfg(struct device_driver *dev, char *buf)
> +static ssize_t chkcfg_show(struct device_driver *dev, char *buf)
>  {
>  	return snprintf(buf, 3, "%d\n", altera_cvp_chkcfg);
>  }
> =20
> -static ssize_t store_chkcfg(struct device_driver *drv, const char *buf,
> +static ssize_t chkcfg_store(struct device_driver *drv, const char *buf,
>  			    size_t count)
>  {
>  	int ret;
> @@ -378,7 +378,7 @@ static ssize_t store_chkcfg(struct device_driver *drv=
, const char *buf,
>  	return count;
>  }
> =20
> -static DRIVER_ATTR(chkcfg, 0600, show_chkcfg, store_chkcfg);
> +static DRIVER_ATTR_RW(chkcfg);
> =20
>  static int altera_cvp_probe(struct pci_dev *pdev,
>  			    const struct pci_device_id *dev_id);
> --=20
> 2.14.1
>=20

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEWcxjJBP2M15CncZ7vkIQd6kWqi8FAlm/92kACgkQvkIQd6kW
qi+OtggAy0KgHzLef1Qk4utAgdxRNd/9Jv3s69zBQ6L0//0ViZbk6RrkZ3FUkdey
yq1Jg0FVI0GMFni/lQTjPYnpdNrugFmfL9AcqJY/8hv1AUL+5QGuCpKnhZbWIoaD
80WYSxbHkUKnhe44lgAW+p1yGOW61On8S+/hLfcw8P+HHA0zvMIJVgfBorv97CCK
LukECFp/eVdpSMmp+rRs0Zrv3MbpVfnPdSB9wFup3gE5M9k1PoaPL44WMhMMHqqv
ck5m7lzuN1Td2teqxqXyCQPmwc02FXU0vbEeHAqLj6Z2HLzk+KAZwZQFR6xQRfyD
MJWE4YsPKLYXSX8eFLmVGxdqokJFtg==
=yXQt
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
