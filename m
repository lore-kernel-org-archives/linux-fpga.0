Return-Path: <SRS0=zVKI=7V=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=zVKI=7V=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:47061 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbgFHBxu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 7 Jun 2020 21:53:50 -0400
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH 1/1] fpga: dfl: Fix dead store
Date: Mon, 8 Jun 2020 01:53:46 +0000
Message-ID: <DM6PR11MB3819CCD054BC0A764AB4A57885850@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200606210241.7459-1-trix@redhat.com>
 <20200606210241.7459-2-trix@redhat.com>
In-Reply-To: <20200606210241.7459-2-trix@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: "trix@redhat.com" <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>
Cc: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> -----Original Message-----
> From: linux-fpga-owner@vger.kernel.org <linux-fpga-owner@vger.kernel.org>
> On Behalf Of trix@redhat.com
> Sent: Sunday, June 7, 2020 5:03 AM
> To: mdf@kernel.org
> Cc: linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org; Tom Rix
> <trix@redhat.com>
> Subject: [PATCH 1/1] fpga: dfl: Fix dead store
>=20

Thanks for this patch, looks good to me, but this patch is not related to
dfl, so please remove dfl from the title to avoid confusion. : )
or maybe it can be split into two patches:
fpga: mgr: xxx
fpga: bridge: xxx

Thanks
Hao

> From: Tom Rix <trix@redhat.com>
>=20
> Using clang's scan-build/view this issue was flagged in fpga-mgr.c
>=20
>   drivers/fpga/fpga-mgr.c:585:3: warning: Value stored to 'ret' is never =
read
> [deadcode.DeadStores]
>                   ret =3D id;
>=20
> A similar issue was flagged in fpga-bridge.
>=20
> So remove the unused stores.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/fpga-bridge.c | 6 ++----
>  drivers/fpga/fpga-mgr.c    | 4 +---
>  2 files changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 4bab9028940a..2deccacc3aa7 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -328,7 +328,7 @@ struct fpga_bridge *fpga_bridge_create(struct device
> *dev, const char *name,
>  				       void *priv)
>  {
>  	struct fpga_bridge *bridge;
> -	int id, ret =3D 0;
> +	int id, ret;
>=20
>  	if (!name || !strlen(name)) {
>  		dev_err(dev, "Attempt to register with no name!\n");
> @@ -340,10 +340,8 @@ struct fpga_bridge *fpga_bridge_create(struct
> device *dev, const char *name,
>  		return NULL;
>=20
>  	id =3D ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0) {
> -		ret =3D id;
> +	if (id < 0)
>  		goto error_kfree;
> -	}
>=20
>  	mutex_init(&bridge->mutex);
>  	INIT_LIST_HEAD(&bridge->node);
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index e05104f5e40c..f38bab01432e 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -581,10 +581,8 @@ struct fpga_manager *fpga_mgr_create(struct
> device *dev, const char *name,
>  		return NULL;
>=20
>  	id =3D ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0) {
> -		ret =3D id;
> +	if (id < 0)
>  		goto error_kfree;
> -	}
>=20
>  	mutex_init(&mgr->ref_mutex);
>=20
> --
> 2.26.0
