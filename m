Date: Fri, 7 Apr 2017 17:52:59 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2] fpga fr br: update supported version numbers
Message-ID: <20170408005259.GA13822@tyrael.amer.corp.natinst.com>
References: <1491593196-25792-1-git-send-email-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <1491593196-25792-1-git-send-email-matthew.gerlach@linux.intel.com>
To: matthew.gerlach@linux.intel.com
Cc: atull@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 12:26:36PM -0700, matthew.gerlach@linux.intel.com w=
rote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> The value in the version register of the altera freeze bridge
> controller changed from the beta value of 2 to the
> value of 0xad000003 in the official release of the IP.
> This patch supports the old and new version numbers, and the
> driver's probe function will fail if neither of the supported
> versions is found.
>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: change warning to fail as per Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/altera-freeze-bridge.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-fr=
eeze-bridge.c
> index 8dcd9fb..114d3cb 100644
> --- a/drivers/fpga/altera-freeze-bridge.c
> +++ b/drivers/fpga/altera-freeze-bridge.c
> @@ -28,6 +28,7 @@
>  #define FREEZE_CSR_REG_VERSION			12
> =20
>  #define FREEZE_CSR_SUPPORTED_VERSION		2
> +#define FREEZE_CSR_OFFICIAL_VERSION		0xad000003
> =20
>  #define FREEZE_CSR_STATUS_FREEZE_REQ_DONE	BIT(0)
>  #define FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE	BIT(1)
> @@ -218,6 +219,7 @@ static int altera_freeze_br_probe(struct platform_dev=
ice *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	struct device_node *np =3D pdev->dev.of_node;
> +	void __iomem *base_addr;
>  	struct altera_freeze_br_data *priv;
>  	struct resource *res;
>  	u32 status, revision;
> @@ -225,26 +227,32 @@ static int altera_freeze_br_probe(struct platform_d=
evice *pdev)
>  	if (!np)
>  		return -ENODEV;
> =20
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base_addr =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base_addr))
> +		return PTR_ERR(base_addr);
> +
> +	revision =3D readl(base_addr + FREEZE_CSR_REG_VERSION);
> +	if ((revision !=3D FREEZE_CSR_SUPPORTED_VERSION) &&
> +	    (revision !=3D FREEZE_CSR_OFFICIAL_VERSION)) {
> +		dev_err(dev,
> +			"%s unexpected revision 0x%x !=3D 0x%x !=3D 0x%x\n",
> +			__func__, revision, FREEZE_CSR_SUPPORTED_VERSION,
> +			FREEZE_CSR_OFFICIAL_VERSION);
> +		return -EINVAL;
> +	}
> +
>  	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
> =20
>  	priv->dev =3D dev;
> =20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->base_addr =3D devm_ioremap_resource(dev, res);
> -	if (IS_ERR(priv->base_addr))
> -		return PTR_ERR(priv->base_addr);
> -
> -	status =3D readl(priv->base_addr + FREEZE_CSR_STATUS_OFFSET);
> +	status =3D readl(base_addr + FREEZE_CSR_STATUS_OFFSET);
>  	if (status & FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE)
>  		priv->enable =3D 1;
> =20
> -	revision =3D readl(priv->base_addr + FREEZE_CSR_REG_VERSION);
> -	if (revision !=3D FREEZE_CSR_SUPPORTED_VERSION)
> -		dev_warn(dev,
> -			 "%s Freeze Controller unexpected revision %d !=3D %d\n",
> -			 __func__, revision, FREEZE_CSR_SUPPORTED_VERSION);
> +	priv->base_addr =3D base_addr;
> =20
>  	return fpga_bridge_register(dev, FREEZE_BRIDGE_NAME,
>  				    &altera_freeze_br_br_ops, priv);
> --=20
> 2.7.4
>=20

Thanks,
Moritz

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY6DRpAAoJEL5CEHepFqovybUH/25rySFGnP1+7C3/4Zbqcn1w
hMy07hWi7iKAz6F/a+ZFyNgp67gly0r/hrk/CrmHz98/0IQoO5wOmBTlGUmP+Ib1
DT129uSdHgYhxNKJ2M7Q8aSRUJoGKf/kwZ5jRdAYmbtWn/k+yGwoeotGqEBXN/73
0I7+FfW0ikvKHW15bX80ub6cWldLSkbx6tTtlXahotbc6ODjXbm4rvMCX9MDkkGS
XvZUupDM7EgGs1HiS69CM+3ypDGzoD+qH0QV2r4A0DZi90oY70F5XOd+5whh04lr
aEv6nr6swljRYU+MuEXzxpQH5A4yq68l416m9UPemH3EqPpqq2gkMvPi3tdbvts=
=cRWa
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
