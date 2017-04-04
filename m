Return-Path: <moritz.fischer.private@gmail.com>
Date: Mon, 3 Apr 2017 19:10:28 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 03/16] fpga: intel: add FPGA PCIe device driver
Message-ID: <20170404021028.GA8866@tyrael.amer.corp.natinst.com>
References: <1490875696-15145-1-git-send-email-hao.wu@intel.com>
 <1490875696-15145-4-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <1490875696-15145-4-git-send-email-hao.wu@intel.com>
To: Wu Hao <hao.wu@intel.com>
Cc: atull@kernel.org, moritz.fischer@ettus.com, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, luwei.kang@intel.com, yi.z.zhang@intel.com, Tim Whisonant <tim.whisonant@intel.com>, Enno Luebbers <enno.luebbers@intel.com>, Shiva Rao <shiva.rao@intel.com>, Christopher Rauer <christopher.rauer@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2017 at 08:08:03PM +0800, Wu Hao wrote:
> From: Zhang Yi <yi.z.zhang@intel.com>
>=20
> The Intel FPGA device appears as a PCIe device on the system. This patch
> implements the basic framework of the driver for Intel PCIe device which
> locates between CPU and Accelerated Function Units (AFUs).
>=20
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/Kconfig           |   2 +
>  drivers/fpga/Makefile          |   3 +
>  drivers/fpga/intel/Kconfig     |  27 +++++++++
>  drivers/fpga/intel/LICENSE.BSD |  24 ++++++++
>  drivers/fpga/intel/Makefile    |   3 +
>  drivers/fpga/intel/pcie.c      | 129 +++++++++++++++++++++++++++++++++++=
++++++
>  6 files changed, 188 insertions(+)
>  create mode 100644 drivers/fpga/intel/Kconfig
>  create mode 100644 drivers/fpga/intel/LICENSE.BSD
>  create mode 100644 drivers/fpga/intel/Makefile
>  create mode 100644 drivers/fpga/intel/pcie.c
>=20
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index d99b640..4e49aee 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -69,6 +69,8 @@ config ALTERA_FREEZE_BRIDGE
>  	  isolate one region of the FPGA from the busses while that
>  	  region is being reprogrammed.
> =20
> +source "drivers/fpga/intel/Kconfig"
> +
>  endif # FPGA
> =20
>  endmenu
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 53a41d2..46f1a5d 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -20,3 +20,6 @@ obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+=3D altera-freeze-b=
ridge.o
> =20
>  # High Level Interfaces
>  obj-$(CONFIG_FPGA_REGION)		+=3D fpga-region.o
> +
> +# Intel FPGA Support
> +obj-$(CONFIG_INTEL_FPGA)		+=3D intel/
> diff --git a/drivers/fpga/intel/Kconfig b/drivers/fpga/intel/Kconfig
> new file mode 100644
> index 0000000..bf402f3
> --- /dev/null
> +++ b/drivers/fpga/intel/Kconfig
> @@ -0,0 +1,27 @@
> +menuconfig INTEL_FPGA
> +	tristate "Intel(R) FPGA support"
> +	depends on FPGA_DEVICE
> +	help
> +	  Select this option to enable driver support for Intel(R)
> +	  Field-Programmable Gate Array (FPGA) solutions. This driver
> +	  provides interfaces for userspace applications to configure,
> +	  enumerate, open, and access FPGA accelerators on platforms
> +	  equipped with Intel(R) FPGA solutions and enables system
> +	  level management functions such as FPGA reconfiguration,
> +	  power management, and virtualization.
> +
> +	  Say Y if your platform has this technology. Say N if unsure.
> +
> +if INTEL_FPGA
> +
> +config INTEL_FPGA_PCI
> +	tristate "Intel FPGA PCIe Driver"
> +	depends on PCI
> +	help
> +	  This is the driver for the PCIe device which locates between
> +	  CPU and Accelerated Function Units (AFUs) and allows them to
> +	  communicate with each other.
> +
> +	  To compile this as a module, choose M here.
> +
> +endif
> diff --git a/drivers/fpga/intel/LICENSE.BSD b/drivers/fpga/intel/LICENSE.=
BSD
> new file mode 100644
> index 0000000..309d2b7
> --- /dev/null
> +++ b/drivers/fpga/intel/LICENSE.BSD
> @@ -0,0 +1,24 @@
> +Redistribution and use in source and binary forms, with or without
> +modification, are permitted provided that the following conditions
> +are met:
> +  * Redistributions of source code must retain the above copyright
> +    notice, this list of conditions and the following disclaimer.
> +  * Redistributions in binary form must reproduce the above copyright
> +    notice, this list of conditions and the following disclaimer in
> +    the documentation and/or other materials provided with the
> +    distribution.
> +  * Neither the name of Intel Corporation nor the names of its
> +    contributors may be used to endorse or promote products derived
> +    from this software without specific prior written permission.
> +
> +THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> +"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> +LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> +A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> +OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> +SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> +LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> +DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> +THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> +(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> +OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> diff --git a/drivers/fpga/intel/Makefile b/drivers/fpga/intel/Makefile
> new file mode 100644
> index 0000000..61fd8ea
> --- /dev/null
> +++ b/drivers/fpga/intel/Makefile
> @@ -0,0 +1,3 @@
> +obj-$(CONFIG_INTEL_FPGA_PCI) +=3D intel-fpga-pci.o
> +
> +intel-fpga-pci-objs :=3D pcie.o
> diff --git a/drivers/fpga/intel/pcie.c b/drivers/fpga/intel/pcie.c
> new file mode 100644
> index 0000000..132d9da
> --- /dev/null
> +++ b/drivers/fpga/intel/pcie.c
> @@ -0,0 +1,129 @@
> +/*
> + * Driver for Intel FPGA PCIe device
> + *
> + * Copyright (C) 2017 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Zhang Yi <Yi.Z.Zhang@intel.com>
> + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> + *   Joseph Grecco <joe.grecco@intel.com>
> + *   Enno Luebbers <enno.luebbers@intel.com>
> + *   Tim Whisonant <tim.whisonant@intel.com>
> + *   Ananda Ravuri <ananda.ravuri@intel.com>
> + *   Henry Mitchel <henry.mitchel@intel.com>
> + *
> + * This work is licensed under a dual BSD/GPLv2 license. When using or
> + * redistributing this file, you may do so under either license. See the
> + * LICENSE.BSD file under this directory for the BSD license and see
> + * the COPYING file in the top-level directory for the GPLv2 license.
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/stddef.h>
> +#include <linux/errno.h>
> +#include <linux/aer.h>
> +
> +#define DRV_VERSION	"EXPERIMENTAL VERSION"

Is that a leftover? :)
> +#define DRV_NAME	"intel-fpga-pci"
> +
> +/* PCI Device ID */
> +#define PCIe_DEVICE_ID_PF_INT_5_X	0xBCBD
> +#define PCIe_DEVICE_ID_PF_INT_6_X	0xBCC0
> +#define PCIe_DEVICE_ID_PF_DSC_1_X	0x09C4
> +/* VF Device */
> +#define PCIe_DEVICE_ID_VF_INT_5_X	0xBCBF
> +#define PCIe_DEVICE_ID_VF_INT_6_X	0xBCC1
> +#define PCIe_DEVICE_ID_VF_DSC_1_X	0x09C5
> +
> +static struct pci_device_id cci_pcie_id_tbl[] =3D {
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIe_DEVICE_ID_PF_INT_5_X),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIe_DEVICE_ID_VF_INT_5_X),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIe_DEVICE_ID_PF_INT_6_X),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIe_DEVICE_ID_VF_INT_6_X),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIe_DEVICE_ID_PF_DSC_1_X),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIe_DEVICE_ID_VF_DSC_1_X),},
> +	{0,}
> +};
> +MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
> +
> +static
> +int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pc=
idevid)
> +{
> +	int ret;
> +
> +	ret =3D pci_enable_device(pcidev);
> +	if (ret < 0) {
> +		dev_err(&pcidev->dev, "Failed to enable device %d.\n", ret);
> +		goto exit;
Why not 'return ret' here ?
> +	}
> +
> +	ret =3D pci_enable_pcie_error_reporting(pcidev);
> +	if (ret && ret !=3D -EINVAL)
> +		dev_info(&pcidev->dev, "PCIE AER unavailable %d.\n", ret);

What if it is EINVAL?

> +
> +	ret =3D pci_request_regions(pcidev, DRV_NAME);
> +	if (ret) {
> +		dev_err(&pcidev->dev, "Failed to request regions.\n");
> +		goto disable_error_report_exit;
> +	}
> +
> +	pci_set_master(pcidev);
> +	pci_save_state(pcidev);
> +
> +	if (!dma_set_mask(&pcidev->dev, DMA_BIT_MASK(64))) {
> +		dma_set_coherent_mask(&pcidev->dev, DMA_BIT_MASK(64));
> +	} else if (!dma_set_mask(&pcidev->dev, DMA_BIT_MASK(32))) {
> +		dma_set_coherent_mask(&pcidev->dev, DMA_BIT_MASK(32));
> +	} else {
> +		ret =3D -EIO;
> +		dev_err(&pcidev->dev, "No suitable DMA support available.\n");
> +		goto release_region_exit;
> +	}
> +
> +	/* TODO: create and add the platform device per feature list */
> +	return 0;
> +
> +release_region_exit:
> +	pci_release_regions(pcidev);
> +disable_error_report_exit:
> +	pci_disable_pcie_error_reporting(pcidev);
> +	pci_disable_device(pcidev);
> +exit:
> +	return ret;
If you return as suggested above, this can go away.

> +}
> +
> +static void cci_pci_remove(struct pci_dev *pcidev)
> +{
> +	pci_release_regions(pcidev);
> +	pci_disable_pcie_error_reporting(pcidev);
> +	pci_disable_device(pcidev);
> +}
> +
> +static struct pci_driver cci_pci_driver =3D {
> +	.name =3D DRV_NAME,
> +	.id_table =3D cci_pcie_id_tbl,
> +	.probe =3D cci_pci_probe,
> +	.remove =3D cci_pci_remove,
> +};
> +
> +static int __init ccidrv_init(void)
> +{
> +	pr_info("Intel(R) FPGA PCIe Driver: Version %s\n", DRV_VERSION);
> +
> +	return pci_register_driver(&cci_pci_driver);
> +}
> +
> +static void __exit ccidrv_exit(void)
> +{
> +	pci_unregister_driver(&cci_pci_driver);
> +}
> +
> +module_init(ccidrv_init);
> +module_exit(ccidrv_exit);
> +
> +MODULE_DESCRIPTION("Intel FPGA PCIe Device Driver");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("Dual BSD/GPL");
> --=20
> 2.7.4
>=20

Cheers,

Moritz

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY4wCRAAoJEL5CEHepFqovV6IH/iCKInk7bRJgf8BPo2QPQZBN
guaOH+TxPoyd/a53tgcSPbX3HBwGpd4/g6cLsoT9dwPCrk6qkrdmxkP8qQbIXeiw
w7HzTfDUrgKU9SkdlkILD51UU5ejBkfCULOc3l9jYcg6IuVgliPOiK9LhL4cBBcn
+FPAzWnhl4MfB5N+OMUZiWQpfOjD0p8jS3vJCuaA5QcWcKxsTmnwkfGZQc4y+uUN
Zb0oZPZcybdEADo7tchvRsDO+N03o3T8DjitSgm3lEBtBDmciLLugZZCmQPwInWJ
ChvKMkaK+eb6ekwwOZ6RJEzYpSoVuGMtTURAgHtHdO5KUHkiOEXWb3t9vhRw/Ho=
=zFCD
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
