Date: Mon, 18 Sep 2017 09:43:49 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 2/2] driver core: remove DRIVER_ATTR
Message-ID: <20170918164349.GB31137@tyrael.ni.corp.natinst.com>
References: <20170918101736.GA30415@kroah.com>
 <20170918101757.GB30415@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <20170918101757.GB30415@kroah.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2017 at 12:17:57PM +0200, Greg Kroah-Hartman wrote:
>=20
> DRIVER_ATTR is no longer in use, and driver authors should be using
> DRIVER_ATTR_RW() or DRIVER_ATTR_RO() or DRIVER_ATTR_WO() instead in
> order to always get the permissions correct.  So remove it so that no
> one can use it anymore.
>=20
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  Documentation/driver-model/driver.txt | 7 ++++---
>  Documentation/filesystems/sysfs.txt   | 3 ++-
>  include/linux/device.h                | 2 --
>  3 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/driver-model/driver.txt b/Documentation/driver=
-model/driver.txt
> index 4421135826a2..d661e6f7e6a0 100644
> --- a/Documentation/driver-model/driver.txt
> +++ b/Documentation/driver-model/driver.txt
> @@ -196,12 +196,13 @@ struct driver_attribute {
>  };
> =20
>  Device drivers can export attributes via their sysfs directories.=20
> -Drivers can declare attributes using a DRIVER_ATTR macro that works
> -identically to the DEVICE_ATTR macro.=20
> +Drivers can declare attributes using a DRIVER_ATTR_RW and DRIVER_ATTR_RO
> +macro that works identically to the DEVICE_ATTR_RW and DEVICE_ATTR_RO
> +macros.
> =20
>  Example:
> =20
> -DRIVER_ATTR(debug,0644,show_debug,store_debug);
> +DRIVER_ATTR_RW(debug);
> =20
>  This is equivalent to declaring:
> =20
> diff --git a/Documentation/filesystems/sysfs.txt b/Documentation/filesyst=
ems/sysfs.txt
> index 24da7b32c489..9a3658cc399e 100644
> --- a/Documentation/filesystems/sysfs.txt
> +++ b/Documentation/filesystems/sysfs.txt
> @@ -366,7 +366,8 @@ struct driver_attribute {
> =20
>  Declaring:
> =20
> -DRIVER_ATTR(_name, _mode, _show, _store)
> +DRIVER_ATTR_RO(_name)
> +DRIVER_ATTR_RW(_name)
> =20
>  Creation/Removal:
> =20
> diff --git a/include/linux/device.h b/include/linux/device.h
> index c6f27207dbe8..2bc70ddda09b 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -307,8 +307,6 @@ struct driver_attribute {
>  			 size_t count);
>  };
> =20
> -#define DRIVER_ATTR(_name, _mode, _show, _store) \
> -	struct driver_attribute driver_attr_##_name =3D __ATTR(_name, _mode, _s=
how, _store)
>  #define DRIVER_ATTR_RW(_name) \
>  	struct driver_attribute driver_attr_##_name =3D __ATTR_RW(_name)
>  #define DRIVER_ATTR_RO(_name) \
> --=20
> 2.14.1
>=20

Thanks,

Moritz

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEWcxjJBP2M15CncZ7vkIQd6kWqi8FAlm/98EACgkQvkIQd6kW
qi89QAgArGcCQGz9jC+cTl8TqqC8+ER6Le3HIClH4/LaJR5iO9VqWekqbxjbmqvd
1MeHzPhbSeQ+6cXDWvCacXV47xrBnViWfws/KJwkGW0fLIFMHp6xlTq2+PGlycy/
ku0cW13hpZCzMSFDuNWmyONb/L5JsiWCjXemIbU1cbk67ZMFIcITq/gZYHGbpqbO
SkwvxuBCF5QnrmZcN/Hszht1vXGcJ/eue7+9t2KV2EUDS2LL+pRGpwBmtllL+va5
7GDzRKrP1uf+Tb6K8sb2mrUeWYQoK7oYpXIQIai5jJyAcJfVi25LpUg8TitQzxsO
+lA4gIpfim2RUYlOHgSAyk8u5nkTVg==
=LwVA
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
