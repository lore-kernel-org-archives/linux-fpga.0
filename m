Return-Path: <SRS0=fldw=AU=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=fldw=AU=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Date: Thu, 9 Jul 2020 10:14:16 +0000
Message-ID: <DM6PR11MB3819D07348C347B5BB8F86C085640@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1594282705-32289-1-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819117029F124067F7EA8B985640@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200709093527.GA32541@yilunxu-OptiPlex-7050>
In-Reply-To: <20200709093527.GA32541@yilunxu-OptiPlex-7050>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Xu, Yilun" <yilun.xu@intel.com>
Cc: "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "trix@redhat.com" <trix@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, "Weight, Russell H" <russell.h.weight@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

> On Thu, Jul 09, 2020 at 05:10:49PM +0800, Wu, Hao wrote:
> > > Subject: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N30=
00
> > >
> > > Add PCIe Device ID for Intel FPGA PAC N3000.
> > >
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > ---
> > >  drivers/fpga/dfl-pci.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > > index 73b5153..824aecf 100644
> > > --- a/drivers/fpga/dfl-pci.c
> > > +++ b/drivers/fpga/dfl-pci.c
> > > @@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev=
)
> > >  #define PCIE_DEVICE_ID_PF_INT_5_X0xBCBD
> > >  #define PCIE_DEVICE_ID_PF_INT_6_X0xBCC0
> > >  #define PCIE_DEVICE_ID_PF_DSC_1_X0x09C4
> > > +#define PCIE_DEVICE_ID_PF_PAC_N3000 0x0B30
> >
> > Should we drop _PF_ here? and also do you want _INTEL_ here?
>=20
> I think we could keep _PF_, also there is no need to support VF of pac
> n3000 in product now, but it does exist (ID: 0x0b31).
>=20
> And add _INTEL_ is good to me.
>=20
> Then how about this one:
>   #define PCIE_DEVICE_ID_PF_INTEL_PAC_N3000	0x0B30

I am just considering the alignment with ids defined in include/linux/pci_i=
ds.h
So drop _PF_ before _INTEL_ would be better? : )

Thanks
Hao
