Return-Path: <SRS0=atEN=AT=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=atEN=AT=ettus.com=moritz.fischer@kernel.org>
Date: Mon, 18 Sep 2017 15:53:09 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v4 01/18] fpga: bridge: support getting bridge from device
Message-ID: <20170918225309.GA23597@tyrael.ni.corp.natinst.com>
References: <20170913204841.2730-1-atull@kernel.org>
 <20170913204841.2730-2-atull@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20170913204841.2730-2-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2017 at 03:48:24PM -0500, Alan Tull wrote:
> Add two functions for getting the FPGA bridge from the device
> rather than device tree node.  This is to enable writing code
> that will support using FPGA bridges without device tree.
> Rename one old function to make it clear that it is device
> tree-ish.  This leaves us with 3 functions for getting a bridge:
>=20
> * fpga_bridge_get
>   Get the bridge given the device.
>=20
> * fpga_bridges_get_to_list
>   Given the device, get the bridge and add it to a list.
>=20
> * of_fpga_bridges_get_to_list
>   Renamed from priviously existing fpga_bridges_get_to_list.
>   Given the device node, get the bridge and add it to a list.
>=20
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
> v2: use list_for_each_entry
>     static the bridge_list_lock
>     update copyright and author email
> v3: no change to this patch in this version of patchset
> v4: no change to this patch in this version of patchset
> ---
>  drivers/fpga/fpga-bridge.c       | 110 +++++++++++++++++++++++++++++++--=
------
>  drivers/fpga/fpga-region.c       |  11 ++--
>  include/linux/fpga/fpga-bridge.h |   7 ++-
>  3 files changed, 100 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index fcd2bd3..af6d97e 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -2,6 +2,7 @@
>   * FPGA Bridge Framework Driver
>   *
>   *  Copyright (C) 2013-2016 Altera Corporation, All Rights Reserved.
> + *  Copyright (C) 2017 Intel Corporation
>   *
>   * This program is free software; you can redistribute it and/or modify =
it
>   * under the terms and conditions of the GNU General Public License,
> @@ -70,29 +71,12 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
>  }
>  EXPORT_SYMBOL_GPL(fpga_bridge_disable);
> =20
> -/**
> - * of_fpga_bridge_get - get an exclusive reference to a fpga bridge
> - *
> - * @np: node pointer of a FPGA bridge
> - * @info: fpga image specific information
> - *
> - * Return fpga_bridge struct if successful.
> - * Return -EBUSY if someone already has a reference to the bridge.
> - * Return -ENODEV if @np is not a FPGA Bridge.
> - */
> -struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
> -				       struct fpga_image_info *info)
> -
> +struct fpga_bridge *__fpga_bridge_get(struct device *dev,
> +				      struct fpga_image_info *info)
>  {
> -	struct device *dev;
>  	struct fpga_bridge *bridge;
>  	int ret =3D -ENODEV;
> =20
> -	dev =3D class_find_device(fpga_bridge_class, NULL, np,
> -				fpga_bridge_of_node_match);
> -	if (!dev)
> -		goto err_dev;
> -
>  	bridge =3D to_fpga_bridge(dev);
>  	if (!bridge)
>  		goto err_dev;
> @@ -117,8 +101,58 @@ struct fpga_bridge *of_fpga_bridge_get(struct device=
_node *np,
>  	put_device(dev);
>  	return ERR_PTR(ret);
>  }
> +
> +/**
> + * of_fpga_bridge_get - get an exclusive reference to a fpga bridge
> + *
> + * @np: node pointer of a FPGA bridge
> + * @info: fpga image specific information
> + *
> + * Return fpga_bridge struct if successful.
> + * Return -EBUSY if someone already has a reference to the bridge.
> + * Return -ENODEV if @np is not a FPGA Bridge.
> + */
> +struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
> +				       struct fpga_image_info *info)
> +{
> +	struct device *dev;
> +
> +	dev =3D class_find_device(fpga_bridge_class, NULL, np,
> +				fpga_bridge_of_node_match);
> +	if (!dev)
> +		return ERR_PTR(-ENODEV);
> +
> +	return __fpga_bridge_get(dev, info);
> +}
>  EXPORT_SYMBOL_GPL(of_fpga_bridge_get);
> =20
> +static int fpga_bridge_dev_match(struct device *dev, const void *data)
> +{
> +	return dev->parent =3D=3D data;
> +}
> +
> +/**
> + * fpga_bridge_get - get an exclusive reference to a fpga bridge
> + * @dev:	parent device that fpga bridge was registered with
> + *
> + * Given a device, get an exclusive reference to a fpga bridge.
> + *
> + * Return: fpga manager struct or IS_ERR() condition containing error co=
de.
> + */
> +struct fpga_bridge *fpga_bridge_get(struct device *dev,
> +				    struct fpga_image_info *info)
> +{
> +	struct device *bridge_dev;
> +
> +	bridge_dev =3D class_find_device(fpga_bridge_class, NULL, dev,
> +				       fpga_bridge_dev_match);
> +	if (!bridge_dev)
> +		return ERR_PTR(-ENODEV);
> +
> +	return __fpga_bridge_get(bridge_dev, info);
> +}
> +EXPORT_SYMBOL_GPL(fpga_bridge_get);

Do we really need two functions here? Can't we just do a:

	if (dev->of_node)
		dev =3D class_find_device(fpga_bridge_class, NULL, np,
			fpga_bridge_of_node_match);
	else
		dev =3D class_find_device(fpga_bridge_class, NULL, dev,
			fpga_bridge_dev_match);

instead? Maybe you could even move the check into the match function,
so you can reuse all the code here?

> +
>  /**
>   * fpga_bridge_put - release a reference to a bridge
>   *
> @@ -206,7 +240,7 @@ void fpga_bridges_put(struct list_head *bridge_list)
>  EXPORT_SYMBOL_GPL(fpga_bridges_put);
> =20
>  /**
> - * fpga_bridges_get_to_list - get a bridge, add it to a list
> + * of_fpga_bridge_get_to_list - get a bridge, add it to a list
>   *
>   * @np: node pointer of a FPGA bridge
>   * @info: fpga image specific information
> @@ -216,14 +250,44 @@ EXPORT_SYMBOL_GPL(fpga_bridges_put);
>   *
>   * Return 0 for success, error code from of_fpga_bridge_get() othewise.
>   */
> -int fpga_bridge_get_to_list(struct device_node *np,
> +int of_fpga_bridge_get_to_list(struct device_node *np,
> +			       struct fpga_image_info *info,
> +			       struct list_head *bridge_list)
> +{
> +	struct fpga_bridge *bridge;
> +	unsigned long flags;
> +
> +	bridge =3D of_fpga_bridge_get(np, info);
> +	if (IS_ERR(bridge))
> +		return PTR_ERR(bridge);
> +
> +	spin_lock_irqsave(&bridge_list_lock, flags);
> +	list_add(&bridge->node, bridge_list);
> +	spin_unlock_irqrestore(&bridge_list_lock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_fpga_bridge_get_to_list);
> +
> +/**
> + * fpga_bridge_get_to_list - given device, get a bridge, add it to a list
> + *
> + * @dev: FPGA bridge device
> + * @info: fpga image specific information
> + * @bridge_list: list of FPGA bridges
> + *
> + * Get an exclusive reference to the bridge and and it to the list.
> + *
> + * Return 0 for success, error code from fpga_bridge_get() othewise.
> + */
> +int fpga_bridge_get_to_list(struct device *dev,
>  			    struct fpga_image_info *info,
>  			    struct list_head *bridge_list)
>  {
>  	struct fpga_bridge *bridge;
>  	unsigned long flags;
> =20
> -	bridge =3D of_fpga_bridge_get(np, info);
> +	bridge =3D fpga_bridge_get(dev, info);
>  	if (IS_ERR(bridge))
>  		return PTR_ERR(bridge);
> =20
> @@ -381,7 +445,7 @@ static void __exit fpga_bridge_dev_exit(void)
>  }
> =20
>  MODULE_DESCRIPTION("FPGA Bridge Driver");
> -MODULE_AUTHOR("Alan Tull <atull@opensource.altera.com>");
> +MODULE_AUTHOR("Alan Tull <atull@kernel.org>");
>  MODULE_LICENSE("GPL v2");
> =20
>  subsys_initcall(fpga_bridge_dev_init);
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index d9ab7c7..91755562 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -183,11 +183,14 @@ static int fpga_region_get_bridges(struct fpga_regi=
on *region,
>  	int i, ret;
> =20
>  	/* If parent is a bridge, add to list */
> -	ret =3D fpga_bridge_get_to_list(region_np->parent, region->info,
> -				      &region->bridge_list);
> +	ret =3D of_fpga_bridge_get_to_list(region_np->parent, region->info,
> +					 &region->bridge_list);
> +
> +	/* -EBUSY means parent is a bridge that is under use. Give up. */
>  	if (ret =3D=3D -EBUSY)
>  		return ret;
> =20
> +	/* Zero return code means parent was a bridge and was added to list. */
>  	if (!ret)
>  		parent_br =3D region_np->parent;
> =20
> @@ -207,8 +210,8 @@ static int fpga_region_get_bridges(struct fpga_region=
 *region,
>  			continue;
> =20
>  		/* If node is a bridge, get it and add to list */
> -		ret =3D fpga_bridge_get_to_list(br, region->info,
> -					      &region->bridge_list);
> +		ret =3D of_fpga_bridge_get_to_list(br, region->info,
> +						 &region->bridge_list);
> =20
>  		/* If any of the bridges are in use, give up */
>  		if (ret =3D=3D -EBUSY) {
> diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-b=
ridge.h
> index dba6e3c..9f6696b 100644
> --- a/include/linux/fpga/fpga-bridge.h
> +++ b/include/linux/fpga/fpga-bridge.h
> @@ -42,6 +42,8 @@ struct fpga_bridge {
> =20
>  struct fpga_bridge *of_fpga_bridge_get(struct device_node *node,
>  				       struct fpga_image_info *info);
> +struct fpga_bridge *fpga_bridge_get(struct device *dev,
> +				    struct fpga_image_info *info);
>  void fpga_bridge_put(struct fpga_bridge *bridge);
>  int fpga_bridge_enable(struct fpga_bridge *bridge);
>  int fpga_bridge_disable(struct fpga_bridge *bridge);
> @@ -49,9 +51,12 @@ int fpga_bridge_disable(struct fpga_bridge *bridge);
>  int fpga_bridges_enable(struct list_head *bridge_list);
>  int fpga_bridges_disable(struct list_head *bridge_list);
>  void fpga_bridges_put(struct list_head *bridge_list);
> -int fpga_bridge_get_to_list(struct device_node *np,
> +int fpga_bridge_get_to_list(struct device *dev,
>  			    struct fpga_image_info *info,
>  			    struct list_head *bridge_list);
> +int of_fpga_bridge_get_to_list(struct device_node *np,
> +			       struct fpga_image_info *info,
> +			       struct list_head *bridge_list);
> =20
>  int fpga_bridge_register(struct device *dev, const char *name,
>  			 const struct fpga_bridge_ops *br_ops, void *priv);
> --=20
> 2.7.4
>=20

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEWcxjJBP2M15CncZ7vkIQd6kWqi8FAlnATlEACgkQvkIQd6kW
qi8m8gf+Klc0QOaDSkuw+byfWh2Vp1QF9uD8fOaZ4dC/RdBh/I5IGBXwSEjwTkSs
XN5bsapYbVXQTNwtfYr0HCVqJ9JUUuipR0vRdirPTQ7OhSgpZ33hctgz1vHGGUjs
aPELLzBzXY2isWYkxPpmrTdC8YIR+oZ7koqPgC8adh4YrRRdvQ/d9yHK0iLtEqWJ
u3Xc5n4Q/CCZIOlJ5EyDV10RgCSuGFlvBYzgyDVEpV5s3P8UZckQBGOaUFQqQBpo
3duY4wSYzi0o5YYJStTF5HUm26FolBjevWipwx0ifs+dhDzh1j+TqGRVxBhfjNlu
M6IWoIxcDzPaRsazsIcSNIg1lx/YYg==
=mRvm
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
