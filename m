Return-Path: <SRS0=SxHV=DA=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=SxHV=DA=ettus.com=moritz.fischer@kernel.org>
Date: Mon, 4 Dec 2017 13:32:24 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2 1/5] fpga: region: don't use drvdata in common fpga
 code
Message-ID: <20171204213224.GA3345@tyrael.ni.corp.natinst.com>
References: <1510779112-5517-1-git-send-email-atull@kernel.org>
 <1510779112-5517-2-git-send-email-atull@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <1510779112-5517-2-git-send-email-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2017 at 02:51:48PM -0600, Alan Tull wrote:
> Part of patchset that changes the following fpga_*_register
> functions to not set drvdata:
> * fpga_region_register.
> * fpga_mgr_register
> * fpga_bridge_register
>=20
> The rationale is that setting drvdata is fine for DT based devices
> that will have one manager, bridge, or region per platform device.
> However PCIe based devices may have multiple FPGA mgr/bridge/regions
> under one PCIe device.  Without these changes, the PCIe solution has
> to create an extra device for each child mgr/bridge/region to hold
> drvdata.
>=20
> Signed-off-by: Alan Tull <atull@kernel.org>
> Reported-by: Jiuyue Ma <majiuyue@huawei.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: No change to this patch in v2 of patchset
> ---
>  drivers/fpga/fpga-region.c    | 1 -
>  drivers/fpga/of-fpga-region.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index edab2a2..ebe1f87 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -178,7 +178,6 @@ int fpga_region_register(struct device *dev, struct f=
pga_region *region)
>  	region->dev.parent =3D dev;
>  	region->dev.of_node =3D dev->of_node;
>  	region->dev.id =3D id;
> -	dev_set_drvdata(dev, region);
> =20
>  	ret =3D dev_set_name(&region->dev, "region%d", id);
>  	if (ret)
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index c6b2119..3079ed8 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -431,6 +431,7 @@ static int of_fpga_region_probe(struct platform_devic=
e *pdev)
>  		goto eprobe_mgr_put;
> =20
>  	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
> +	dev_set_drvdata(dev, region);
> =20
>  	dev_info(dev, "FPGA Region probed\n");
> =20
> --=20
> 2.7.4
>=20

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlolvuQACgkQUVwKRFcJ
cNgrdQf/Xdc9IOaNsN/2WANmkQsbXmJdkaU0vTqMv0fIGEfD7AJ4Pv8jmqPqYuJF
ubzkmMdHReTjfxCWUk3FPJqE32kx0G9Z7g2c7a+qmdCNDPqnqP7jEY1UPwHhOkV2
G9oZh1QpbVssfHJ2uQSPtcwygTxykSbOmTxw6gkSZ8BQ7XiD9GJ71nKGcEKajHNM
6BG50zDxBB1YLywXAVV8m6KKYrslAMfMAvk8I+mB744Ycm5ilRIUuVIaTJTkvkEM
2mRrh0yhintPeBRZJ25veW2kMvQDd/xnYmbI4hXALOzO86ojCul3b95NP2K7UnLa
cPhaYvun0VHOmXI1i2ElQ0EUiPoIUg==
=LIYe
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
