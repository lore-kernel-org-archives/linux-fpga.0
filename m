Return-Path: <SRS0=OAol=A7=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=OAol=A7=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48464 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTJJj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 20 Jul 2020 05:09:39 -0400
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH 1/2] fpga: dfl: map feature mmio resources in their own
 feature drivers
Date: Mon, 20 Jul 2020 09:09:35 +0000
Message-ID: <DM6PR11MB381928806B8E65BEEF66D07F857B0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <1594791498-14495-2-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1594791498-14495-2-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: "Xu, Yilun" <yilun.xu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "trix@redhat.com" <trix@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, "Weight, Russell H" <russell.h.weight@intel.com>

> Subject: [PATCH 1/2] fpga: dfl: map feature mmio resources in their own
> feature drivers
>=20
> This patch makes preparation for modularization of DFL sub feature
> drivers.
>=20
> Currently, if we need to support a new DFL sub feature, an entry should
> be added to fme/port_feature_drvs[] in dfl-fme/port-main.c. And we need
> to re-compile the whole DFL modules. That make the DFL drivers hard to be
> extended.
>=20
> Another consideration is that DFL may contain some IP blocks which are
> already supported by kernel, most of them are supported by platform
> device drivers. We could create platform devices for these IP blocks and
> get them supported by these drivers.
>=20
> An important issue is that platform device drivers usually requests mmio
> resources on probe. But now dfl mmio is mapped in dfl bus driver (e.g.
> dfl-pci) as a whole region. Then platform device drivers for sub features
> can't request their own mmio resources again. This is what the patch
> trying to resolve.
>=20
> This patch changes the DFL enumeration. DFL bus driver will unmap mmio
> resources after first step enumeration and pass enumeration info to DFL
> framework. Then DFL framework will map the mmio resources again, do 2nd
> step enumeration, and also unmap the mmio resources. In this way, sub
> feature drivers could then request their own mmio resources as needed.
>=20
> An exception is that mmio resource of FIU headers are still mapped in dfl
> bus driver. The FIU headers have some fundamental functions (sriov set,
> port enable/disable) needed for dfl bus devices and other sub features.
> They should not be unmapped as long as dfl bus device is alive.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/dfl-pci.c |  21 ++++--
>  drivers/fpga/dfl.c     | 187 +++++++++++++++++++++++++++++++++++--------=
---
> ---
>  drivers/fpga/dfl.h     |   6 +-
>  3 files changed, 152 insertions(+), 62 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index e220bec..22dc025 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -39,6 +39,11 @@ static void __iomem *cci_pci_ioremap_bar(struct
> pci_dev *pcidev, int bar)
>  	return pcim_iomap_table(pcidev)[bar];
>  }
>=20
> +static void cci_pci_iounmap_bars(struct pci_dev *pcidev, int mapped_bars=
)
> +{
> +	pcim_iounmap_regions(pcidev, mapped_bars);
> +}
> +
>  static int cci_pci_alloc_irq(struct pci_dev *pcidev)
>  {
>  	int ret, nvec =3D pci_msix_vec_count(pcidev);
> @@ -123,7 +128,7 @@ static int *cci_pci_create_irq_table(struct pci_dev
> *pcidev, unsigned int nvec)
>  static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>  {
>  	struct cci_drvdata *drvdata =3D pci_get_drvdata(pcidev);
> -	int port_num, bar, i, nvec, ret =3D 0;
> +	int port_num, bar, i, nvec, mapped_bars, ret =3D 0;
>  	struct dfl_fpga_enum_info *info;
>  	struct dfl_fpga_cdev *cdev;
>  	resource_size_t start, len;
> @@ -163,6 +168,8 @@ static int cci_enumerate_feature_devs(struct pci_dev
> *pcidev)
>  		goto irq_free_exit;
>  	}
>=20
> +	mapped_bars =3D BIT(0);
> +
>  	/*
>  	 * PF device has FME and Ports/AFUs, and VF device only has one
>  	 * Port/AFU. Check them and add related "Device Feature List" info
> @@ -172,7 +179,7 @@ static int cci_enumerate_feature_devs(struct pci_dev
> *pcidev)
>  		start =3D pci_resource_start(pcidev, 0);
>  		len =3D pci_resource_len(pcidev, 0);
>=20
> -		dfl_fpga_enum_info_add_dfl(info, start, len, base);
> +		dfl_fpga_enum_info_add_dfl(info, start, len);
>=20
>  		/*
>  		 * find more Device Feature Lists (e.g. Ports) per information
> @@ -200,22 +207,26 @@ static int cci_enumerate_feature_devs(struct
> pci_dev *pcidev)
>  			if (!base)
>  				continue;
>=20
> +			mapped_bars |=3D BIT(bar);
> +

One more place,

As you removed base addr usage below, so ideally we don't need to map
more bars for port here? is my understanding correct?

>  			start =3D pci_resource_start(pcidev, bar) + offset;
>  			len =3D pci_resource_len(pcidev, bar) - offset;
>=20
> -			dfl_fpga_enum_info_add_dfl(info, start, len,
> -						   base + offset);
> +			dfl_fpga_enum_info_add_dfl(info, start, len);

Thanks
Hao
