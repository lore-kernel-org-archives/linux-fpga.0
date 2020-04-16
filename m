Return-Path: <SRS0=veau=6A=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=veau=6A=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Date: Thu, 16 Apr 2020 08:04:30 +0000
Message-ID: <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
 <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Xu, Yilun" <yilun.xu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "trix@redhat.com" <trix@redhat.com>, "bhu@redhat.com" <bhu@redhat.com>
List-ID: <linux-fpga@vger.kernel.org>

> -----Original Message-----
> From: linux-fpga-owner@vger.kernel.org <linux-fpga-owner@vger.kernel.org>
> On Behalf Of Xu Yilun
> Sent: Thursday, April 16, 2020 11:12 AM
> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: trix@redhat.com; bhu@redhat.com; Xu, Yilun <yilun.xu@intel.com>
> Subject: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
>=20
> This is to fix lkp cppcheck warnings:
>=20
>  drivers/fpga/dfl-pci.c:230:6: warning: The scope of the variable 'ret' c=
an be
> reduced. [variableScope]
>     int ret =3D 0;
>         ^
>=20
>  drivers/fpga/dfl-pci.c:230:10: warning: Variable 'ret' is assigned a val=
ue that
> is never used. [unreadVariable]
>     int ret =3D 0;
>             ^
>=20
> Fixes: 3c2760b78f90 ("fpga: dfl: pci: fix return value of
> cci_pci_sriov_configure")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>

Looks good to me.

Acked-by: Wu Hao <hao.wu@intel.com>

> ---
>  drivers/fpga/dfl-pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 5387550..a78c409 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -227,7 +227,6 @@ static int cci_pci_sriov_configure(struct pci_dev
> *pcidev, int num_vfs)
>  {
>  	struct cci_drvdata *drvdata =3D pci_get_drvdata(pcidev);
>  	struct dfl_fpga_cdev *cdev =3D drvdata->cdev;
> -	int ret =3D 0;
>=20
>  	if (!num_vfs) {
>  		/*
> @@ -239,6 +238,8 @@ static int cci_pci_sriov_configure(struct pci_dev
> *pcidev, int num_vfs)
>  		dfl_fpga_cdev_config_ports_pf(cdev);
>=20
>  	} else {
> +		int ret;
> +
>  		/*
>  		 * before enable SRIOV, put released ports into VF access
> mode
>  		 * first of all.
> --
> 2.7.4
