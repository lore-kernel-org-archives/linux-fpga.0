Return-Path: <SRS0=IzCg=3N=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=IzCg=3N=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH 03/16] fpga: intel: add FPGA PCIe device driver
Date: Wed, 5 Apr 2017 13:14:46 +0000
Message-ID: <BE8371DA886269458E0220A16DC1F8277D619E1C@SHSMSX101.ccr.corp.intel.com>
References: <1490875696-15145-1-git-send-email-hao.wu@intel.com>
 <1490875696-15145-4-git-send-email-hao.wu@intel.com>
 <20170404021028.GA8866@tyrael.amer.corp.natinst.com>
In-Reply-To: <20170404021028.GA8866@tyrael.amer.corp.natinst.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Moritz Fischer <mdf@kernel.org>
Cc: "atull@kernel.org" <atull@kernel.org>, "moritz.fischer@ettus.com" <moritz.fischer@ettus.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>, "Whisonant, Tim" <tim.whisonant@intel.com>, "Luebbers, Enno" <enno.luebbers@intel.com>, Rao,, Christopher  <christopher.rauer@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Wu, Hao" <hao.wu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

> > +#include <linux/pci.h>
> > +#include <linux/types.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/stddef.h>
> > +#include <linux/errno.h>
> > +#include <linux/aer.h>
> > +
> > +#define DRV_VERSION	"EXPERIMENTAL VERSION"
>=20
> Is that a leftover? :)

Sorry, will fix this.

> > +#define DRV_NAME	"intel-fpga-pci"
> > +
> > +/* PCI Device ID */
> > +#define PCIe_DEVICE_ID_PF_INT_5_X	0xBCBD
> > +#define PCIe_DEVICE_ID_PF_INT_6_X	0xBCC0
> > +#define PCIe_DEVICE_ID_PF_DSC_1_X	0x09C4
> > +/* VF Device */
> > +#define PCIe_DEVICE_ID_VF_INT_5_X	0xBCBF
> > +#define PCIe_DEVICE_ID_VF_INT_6_X	0xBCC1
> > +#define PCIe_DEVICE_ID_VF_DSC_1_X	0x09C5
> > +
> > +static struct pci_device_id cci_pcie_id_tbl[] =3D {
> > +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIe_DEVICE_ID_PF_INT_5_X),},
> > +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIe_DEVICE_ID_VF_INT_5_X),},
> > +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIe_DEVICE_ID_PF_INT_6_X),},
> > +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIe_DEVICE_ID_VF_INT_6_X),},
> > +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIe_DEVICE_ID_PF_DSC_1_X),},
> > +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIe_DEVICE_ID_VF_DSC_1_X),},
> > +	{0,}
> > +};
> > +MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
> > +
> > +static
> > +int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *=
pcidevid)
> > +{
> > +	int ret;
> > +
> > +	ret =3D pci_enable_device(pcidev);
> > +	if (ret < 0) {
> > +		dev_err(&pcidev->dev, "Failed to enable device %d.\n", ret);
> > +		goto exit;
> Why not 'return ret' here ?

Yes, you are right, will fix this.

> > +	}
> > +
> > +	ret =3D pci_enable_pcie_error_reporting(pcidev);
> > +	if (ret && ret !=3D -EINVAL)
> > +		dev_info(&pcidev->dev, "PCIE AER unavailable %d.\n", ret);
>=20
> What if it is EINVAL?

pci_enable_pcie_error_reporting is always return -EINVAL when CONFIG_PCIEAE=
R is not selected.
Then we don't need this boring message. : )

>=20
> > +
> > +	ret =3D pci_request_regions(pcidev, DRV_NAME);
> > +	if (ret) {
> > +		dev_err(&pcidev->dev, "Failed to request regions.\n");
> > +		goto disable_error_report_exit;
> > +	}
> > +
> > +	pci_set_master(pcidev);
> > +	pci_save_state(pcidev);
> > +
> > +	if (!dma_set_mask(&pcidev->dev, DMA_BIT_MASK(64))) {
> > +		dma_set_coherent_mask(&pcidev->dev, DMA_BIT_MASK(64));
> > +	} else if (!dma_set_mask(&pcidev->dev, DMA_BIT_MASK(32))) {
> > +		dma_set_coherent_mask(&pcidev->dev, DMA_BIT_MASK(32));
> > +	} else {
> > +		ret =3D -EIO;
> > +		dev_err(&pcidev->dev, "No suitable DMA support available.\n");
> > +		goto release_region_exit;
> > +	}
> > +
> > +	/* TODO: create and add the platform device per feature list */
> > +	return 0;
> > +
> > +release_region_exit:
> > +	pci_release_regions(pcidev);
> > +disable_error_report_exit:
> > +	pci_disable_pcie_error_reporting(pcidev);
> > +	pci_disable_device(pcidev);
> > +exit:
> > +	return ret;
> If you return as suggested above, this can go away.

Yes, you are right. Will fix this in next version.
Thanks a lot for your review and comments. : )

Hao
