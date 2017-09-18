Return-Path: <SRS0=atEN=AT=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=atEN=AT=ettus.com=moritz.fischer@kernel.org>
Date: Mon, 18 Sep 2017 11:17:23 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v4 04/18] fpga: region: use dev_err instead of pr_err
Message-ID: <20170918181723.GB3429@tyrael.ni.corp.natinst.com>
References: <20170913204841.2730-1-atull@kernel.org>
 <20170913204841.2730-5-atull@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <20170913204841.2730-5-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2017 at 03:48:27PM -0500, Alan Tull wrote:
> Use dev_err messages instead of pr_err.
>=20
> Also s/&region->dev/dev/ in two places where we already
> have dev =3D &region->dev.
>=20
> Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: new in this version of the patchset
> v3: for bisectability some changes moved to earlier patches
> v4: no change to this patch in this version of patchset
> ---
>  drivers/fpga/fpga-region.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index 1e1640a..6b4f9ab 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -102,7 +102,7 @@ static struct fpga_region *fpga_region_get(struct fpg=
a_region *region)
>  		return ERR_PTR(-ENODEV);
>  	}
> =20
> -	dev_dbg(&region->dev, "get\n");
> +	dev_dbg(dev, "get\n");
> =20
>  	return region;
>  }
> @@ -116,7 +116,7 @@ static void fpga_region_put(struct fpga_region *regio=
n)
>  {
>  	struct device *dev =3D &region->dev;
> =20
> -	dev_dbg(&region->dev, "put\n");
> +	dev_dbg(dev, "put\n");
> =20
>  	module_put(dev->parent->driver->owner);
>  	of_node_put(dev->of_node);
> @@ -239,13 +239,13 @@ static int fpga_region_program_fpga(struct fpga_reg=
ion *region,
> =20
>  	region =3D fpga_region_get(region);
>  	if (IS_ERR(region)) {
> -		pr_err("failed to get fpga region\n");
> +		dev_err(dev, "failed to get FPGA region\n");
>  		return PTR_ERR(region);
>  	}
> =20
>  	mgr =3D fpga_region_get_manager(region);
>  	if (IS_ERR(mgr)) {
> -		pr_err("failed to get fpga region manager\n");
> +		dev_err(dev, "failed to get FPGA manager\n");
>  		ret =3D PTR_ERR(mgr);
>  		goto err_put_region;
>  	}
> @@ -258,25 +258,25 @@ static int fpga_region_program_fpga(struct fpga_reg=
ion *region,
> =20
>  	ret =3D fpga_region_get_bridges(region, overlay);
>  	if (ret) {
> -		pr_err("failed to get fpga region bridges\n");
> +		dev_err(dev, "failed to get FPGA bridges\n");
>  		goto err_unlock_mgr;
>  	}
> =20
>  	ret =3D fpga_bridges_disable(&region->bridge_list);
>  	if (ret) {
> -		pr_err("failed to disable region bridges\n");
> +		dev_err(dev, "failed to disable bridges\n");
>  		goto err_put_br;
>  	}
> =20
>  	ret =3D fpga_mgr_load(mgr, region->info);
>  	if (ret) {
> -		pr_err("failed to load fpga image\n");
> +		dev_err(dev, "failed to load FPGA image\n");
>  		goto err_put_br;
>  	}
> =20
>  	ret =3D fpga_bridges_enable(&region->bridge_list);
>  	if (ret) {
> -		pr_err("failed to enable region bridges\n");
> +		dev_err(dev, "failed to enable region bridges\n");
>  		goto err_put_br;
>  	}
> =20
> @@ -407,7 +407,7 @@ static int fpga_region_notify_pre_apply(struct fpga_r=
egion *region,
> =20
>  	/* If FPGA was externally programmed, don't specify firmware */
>  	if ((info->flags & FPGA_MGR_EXTERNAL_CONFIG) && info->firmware_name) {
> -		pr_err("error: specified firmware and external-fpga-config");
> +		dev_err(dev, "error: specified firmware and external-fpga-config");
>  		fpga_image_info_free(info);
>  		return -EINVAL;
>  	}
> @@ -420,7 +420,7 @@ static int fpga_region_notify_pre_apply(struct fpga_r=
egion *region,
> =20
>  	/* If we got this far, we should be programming the FPGA */
>  	if (!info->firmware_name) {
> -		pr_err("should specify firmware-name or external-fpga-config\n");
> +		dev_err(dev, "should specify firmware-name or external-fpga-config\n");
>  		fpga_image_info_free(info);
>  		return -EINVAL;
>  	}
> --=20
> 2.7.4
>=20

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEWcxjJBP2M15CncZ7vkIQd6kWqi8FAlnADa8ACgkQvkIQd6kW
qi93SAgApPSXA9s2qhBaRdfdlnCl7x0EVnSF7U8VcY+cNx048f61TLgqgxljuMrS
zkebz+U57YRV9E4T9i6FmHH7cBEI1vvjy3FtMDQiEtLMgbSkOmMneTWZxyREhhn5
FExzpCQEopuOOVgQjsbgtZ7cF5EydcTsOg/Yc10HJdv2VICvZtXSZAKNjrAXg1xH
9V0LqVJ2qEm3oeDin9QNS10bmNRUr9DI53GDf0EcI1WIjJrePAY1AGK8DJKPUtfs
Liq2m9Ablva2idq1kZWEUZe7daMWiFecjtvbrM9Sw3wuRDWuv73cmbual6Fgyk9Y
vZswxAIe+mXaTkX3pZxQKxyS3WkVmw==
=tW6R
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
