Return-Path: <SRS0=pEcE=6B=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=pEcE=6B=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Date: Fri, 17 Apr 2020 03:05:16 +0000
Message-ID: <DM6PR11MB381919B83DB49F937E3EDEEA85D90@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
 <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
 <9b1d85e0-4f44-179b-c847-af858fcc212a@redhat.com>
 <20200417015605.GA30618@yilunxu-OptiPlex-7050>
In-Reply-To: <20200417015605.GA30618@yilunxu-OptiPlex-7050>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Xu, Yilun" <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc: "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bhu@redhat.com" <bhu@redhat.com>
List-ID: <linux-fpga@vger.kernel.org>

> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Friday, April 17, 2020 9:56 AM
> To: Tom Rix <trix@redhat.com>
> Cc: Wu, Hao <hao.wu@intel.com>; mdf@kernel.org; linux-
> fpga@vger.kernel.org; linux-kernel@vger.kernel.org; bhu@redhat.com
> Subject: Re: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 're=
t'
>=20
> Hi Rix:
>=20
> This patch is based on linux-next. There is an preceding patch
> (3c2760b78f90 "fpga: dfl: pci: fix return value of cci_pci_sriov_configur=
e",
> Also see Fixes:) in linux-next but not merged in 5.7-rc1 yet.
> This patch is to fix the lkp warning brought by the previous one.

Yilun

Is it possible that commit id may be different for master then?=20

Thanks
Hao

>=20
> Thanks.
>=20
> On Thu, Apr 16, 2020 at 09:56:47AM -0700, Tom Rix wrote:
> > Please check the scope.
> >
> > On linus/master, the result of this change looks like
> >
> > static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
> > {
> > =A0=A0=A0 struct cci_drvdata *drvdata =3D pci_get_drvdata(pcidev);
> > =A0=A0=A0 struct dfl_fpga_cdev *cdev =3D drvdata->cdev;
> >
> > =A0=A0=A0 if (!num_vfs) {
> > =A0=A0=A0 =A0=A0=A0 /*
> > =A0=A0=A0 =A0=A0=A0 =A0* disable SRIOV and then put released ports back=
 to default
> > =A0=A0=A0 =A0=A0=A0 =A0* PF access mode.
> > =A0=A0=A0 =A0=A0=A0 =A0*/
> > =A0=A0=A0 =A0=A0=A0 pci_disable_sriov(pcidev);
> >
> > =A0=A0=A0 =A0=A0=A0 dfl_fpga_cdev_config_ports_pf(cdev);
> >
> > =A0=A0=A0 } else {
> > =A0=A0=A0 =A0=A0=A0 int ret; <--- defined here
> >
> > =A0=A0=A0 =A0=A0=A0 /*
> > =A0=A0=A0 =A0=A0=A0 =A0* before enable SRIOV, put released ports into V=
F access mode
> > =A0=A0=A0 =A0=A0=A0 =A0* first of all.
> > =A0=A0=A0 =A0=A0=A0 =A0*/
> > =A0=A0=A0 =A0=A0=A0 ret =3D dfl_fpga_cdev_config_ports_vf(cdev, num_vfs=
);
> > =A0=A0=A0 =A0=A0=A0 if (ret)
> > =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return ret;
> >
> > =A0=A0=A0 =A0=A0=A0 ret =3D pci_enable_sriov(pcidev, num_vfs);
> > =A0=A0=A0 =A0=A0=A0 if (ret)
> > =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dfl_fpga_cdev_config_ports_pf(cdev);
> > =A0=A0=A0 }
> >
> > =A0=A0=A0 return ret;=A0 <---- not in scope, not defined here
> > }
> >
> > Tom
