Return-Path: <SRS0=pEcE=6B=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=pEcE=6B=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Date: Fri, 17 Apr 2020 05:55:39 +0000
Message-ID: <DM6PR11MB381922556FF1BB3FB550358985D90@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
 <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
 <9b1d85e0-4f44-179b-c847-af858fcc212a@redhat.com>
 <20200417015605.GA30618@yilunxu-OptiPlex-7050>
 <DM6PR11MB381919B83DB49F937E3EDEEA85D90@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200417032132.GA25293@yilunxu-OptiPlex-7050>
In-Reply-To: <20200417032132.GA25293@yilunxu-OptiPlex-7050>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Xu, Yilun" <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bhu@redhat.com" <bhu@redhat.com>
List-ID: <linux-fpga@vger.kernel.org>

> > > Subject: Re: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable=
 'ret'
> > >
> > > Hi Rix:
> > >
> > > This patch is based on linux-next. There is an preceding patch
> > > (3c2760b78f90 "fpga: dfl: pci: fix return value of cci_pci_sriov_conf=
igure",
> > > Also see Fixes:) in linux-next but not merged in 5.7-rc1 yet.
> > > This patch is to fix the lkp warning brought by the previous one.
> >
> > Yilun
> >
> > Is it possible that commit id may be different for master then?
>=20
> It is possible if the previous patch need a little change when merging
> to master.
>=20
> I'm not sure how to handle this then. But the previous patch is simple
> and is unlikely to change.

Maybe you can resend it once previous patch gets merged.

Hao
