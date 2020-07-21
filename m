Return-Path: <SRS0=5LqL=BA=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=5LqL=BA=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH 2/2] fpga: dfl: create a dfl bus type to support DFL
  devices
Date: Tue, 21 Jul 2020 11:41:27 +0000
Message-ID: <DM6PR11MB381958D370FD3BF0173BBD5685780@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <1594791498-14495-3-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB38195AA712F8089090695CE5857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200721083030.GG17091@yilunxu-OptiPlex-7050>
In-Reply-To: <20200721083030.GG17091@yilunxu-OptiPlex-7050>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Xu, Yilun" <yilun.xu@intel.com>
Cc: "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "trix@redhat.com" <trix@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, "Weight, Russell H" <russell.h.weight@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

> > > +}
> > > +
> > > +dfl_dev->type =3D feature_dev_id_type(pdev);
> > > +dfl_dev->feature_id =3D (unsigned long long)feature->id;
> > > +
> > > +dfl_dev->dev.parent  =3D &pdev->dev;
> > > +dfl_dev->dev.bus     =3D &dfl_bus_type;
> > > +dfl_dev->dev.release =3D release_dfl_dev;
> > > +dev_set_name(&dfl_dev->dev, "%s.%d", dev_name(&pdev->dev),
> > > +     feature->index);
> >
> > Or it's better to have a generic name for the device on the bus.
>=20
> mm.. It is good suggestion, we should have a unified name for dfl
> devices.
>=20
> How about ("dfl.%d.%d", pdev->id, feature->index)

It's quite difficult for people to use related information from these magic=
=20
numbers. They are not ids defined in the spec, so just dfl_dev.x with one
unique id seems to be better. If you really need to expose some id
information, maybe you can consider adding some standard sysfs entry
to all dfl_dev, I think that will be easier for users. How do you think?

Thanks
Hao
