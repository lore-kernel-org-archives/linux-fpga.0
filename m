Return-Path: <SRS0=87Bd=DD=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=87Bd=DD=ettus.com=moritz.fischer@kernel.org>
Date: Thu, 7 Dec 2017 15:27:28 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2 5/5] fpga: region: return NOTIFY_STOP if overlay shoud
 be accepted
Message-ID: <20171207232728.GC17574@tyrael.ni.corp.natinst.com>
References: <1510779112-5517-1-git-send-email-atull@kernel.org>
 <1510779112-5517-6-git-send-email-atull@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <1510779112-5517-6-git-send-email-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2017 at 02:51:52PM -0600, Alan Tull wrote:
> Recent changes to the Device Tree overlay notifier code have changed
> how notifier return codes are interpreted, requiring a NOTIFY_STOP to
> signal that the overlay should be accepted.  This commit makes the
> appropriate change to the FPGA region's Device Tree overlay notifier.
>=20
> Fixes: 24789c5ce5a3 ("of: overlay: detect cases where device tree may bec=
ome corrupt")
> Signed-off-by: Alan Tull <atull@kernel.org>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: Added in v2 of this patchset.  Tested on linux-next/master.
> ---
>  drivers/fpga/of-fpga-region.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index 276ffe2..a0c13cb 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -349,7 +349,8 @@ static void of_fpga_region_notify_post_remove(struct =
fpga_region *region,
>   * This notifier handles programming a FPGA when a "firmware-name" prope=
rty is
>   * added to a fpga-region.
>   *
> - * Returns NOTIFY_OK or error if FPGA programming fails.
> + * Returns NOTIFY_OK if this notification isn't about this region or
> + * NOTIFY_STOP if the overaly is to be accepted or error if FPGA program=
ming fails.
>   */
>  static int of_fpga_region_notify(struct notifier_block *nb,
>  				 unsigned long action, void *arg)
> @@ -395,7 +396,7 @@ static int of_fpga_region_notify(struct notifier_bloc=
k *nb,
>  	if (ret)
>  		return notifier_from_errno(ret);
> =20
> -	return NOTIFY_OK;
> +	return NOTIFY_STOP;
>  }
> =20
>  static struct notifier_block fpga_region_of_nb =3D {
> --=20
> 2.7.4
>=20

Thanks,

Moritz

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlopzlwACgkQUVwKRFcJ
cNgwOAgAghuCAi5MRCdVDedklTmSPCaMVYDhyKZUJ9Q/bUlT/B5fJmFuyu+3c/XA
7o4IPulxcVqjPs4qoJpf9BQlpoS27BWvCMj4mqwrzJ3jKepjcp9InKAiBjnD5pza
xvruFcV7DrJlA04HEQBrxVOiRHP8rEJHAV0QK3l3fEvojuotlLg5RZETeKul86lV
YaaZboXUovyriI7URMFqXYn+5fxSuxQHbqvXihGqe0TXqyw+licaj+0laojVnHHe
zfsr/Ej+ZfRrkS14uwpOQhO3YTYCm28Xft6Rn9W8FMtNDlhJ8QKndISs7y2azDzE
w1TagFY5uArrrcOsJ/3XfG5/8LYOLw==
=IyaZ
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
