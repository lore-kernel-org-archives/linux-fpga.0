Return-Path: <SRS0=fldw=AU=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=fldw=AU=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Date: Thu, 9 Jul 2020 09:10:49 +0000
Message-ID: <DM6PR11MB3819117029F124067F7EA8B985640@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1594282705-32289-1-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1594282705-32289-1-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Xu, Yilun" <yilun.xu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "trix@redhat.com" <trix@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, "Weight, Russell H" <russell.h.weight@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

> Subject: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
>=20
> Add PCIe Device ID for Intel FPGA PAC N3000.
>=20
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/dfl-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 73b5153..824aecf 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>  #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
>  #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
>  #define PCIE_DEVICE_ID_PF_DSC_1_X	0x09C4
> +#define PCIE_DEVICE_ID_PF_PAC_N3000	0x0B30

Should we drop _PF_ here? and also do you want _INTEL_ here?

Thanks
Hao
