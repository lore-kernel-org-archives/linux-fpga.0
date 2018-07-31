Return-Path: <SRS0=ipgG=KP=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=ipgG=KP=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbeGaRDB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 31 Jul 2018 13:03:01 -0400
MIME-Version: 1.0
In-Reply-To: <MWHPR0201MB34811402926886136673CE68C22E0@MWHPR0201MB3481.namprd02.prod.outlook.com>
References: <20180801100457.25614-1-nava.manne@xilinx.com> <20180801100457.25614-2-nava.manne@xilinx.com>
 <MWHPR0201MB34811402926886136673CE68C22E0@MWHPR0201MB3481.namprd02.prod.outlook.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 31 Jul 2018 10:21:30 -0500
Message-ID: <CANk1AXQ-qrEKAm9zEs8sVaFNGGFkjCr+npTKUNDXz_bnpL=DQw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Nava kishore Manne <navam@xilinx.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Michal Simek <michals@xilinx.com>, Soren Brinkmann <sorenb@xilinx.com>, "atull@opensource.altera.com" <atull@opensource.altera.com>, "moritz.fischer@ettus.com" <moritz.fischer@ettus.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Appana Durga Kedareswara Rao <appanad@xilinx.com>, "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>, linux-fpga@vger.kernel.org

On Tue, Jul 31, 2018 at 8:08 AM, Nava kishore Manne <navam@xilinx.com> wrote:
>
> +Alan Tull,

+ linux-fpga mailing list

Hi Nava,

Thanks for submitting.

This should be on the linux-fpga mailing list.  The
linux/scripts/get_maintainer.pl script would tell you that.

Also, did you run checkpatch.pl on these? :)  I encourage using the
--strict parameter.

>
>> -----Original Message-----
>> From: Nava kishore Manne [mailto:nava.manne@xilinx.com]
>> Sent: Wednesday, August 1, 2018 3:35 PM
>> To: robh+dt@kernel.org; mark.rutland@arm.com; Michal Simek
>> <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
>> atull@opensource.altera.com; moritz.fischer@ettus.com; Nava kishore Manne
>> <navam@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Appana Durga
>> Kedareswara Rao <appanad@xilinx.com>; chinnikishore369@gmail.com
>> Subject: [RFC PATCH 2/2] fpga manager: Adding FPGA Manager support for
>> Xilinx zynqmp
>>
>> This patch adds FPGA Manager support for the Xilinx ZynqMp chip.
>>
>> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
>> ---
>>  drivers/fpga/Kconfig       |   6 ++
>>  drivers/fpga/Makefile      |   1 +
>>  drivers/fpga/zynqmp-fpga.c | 164
>> +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 171 insertions(+)
>>  create mode 100644 drivers/fpga/zynqmp-fpga.c
>>
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
>> cd84934774cc..b84e3555b3e3 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -26,6 +26,12 @@ config FPGA_MGR_ZYNQ_FPGA
>>       help
>>         FPGA manager driver support for Xilinx Zynq FPGAs.
>>
>> +config FPGA_MGR_ZYNQMP_FPGA
>> +     tristate "Xilinx Zynqmp FPGA"
>> +     depends on ARCH_ZYNQMP || COMPILE_TEST
>> +     help
>> +       FPGA manager driver support for Xilinx ZynqMp FPGAs.
>> +
>>  endif # FPGA
>>
>>  endmenu
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
>> 8d83fc6b1613..ef444512cb01 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -8,3 +8,4 @@ obj-$(CONFIG_FPGA)                    += fpga-mgr.o
>>  # FPGA Manager Drivers
>>  obj-$(CONFIG_FPGA_MGR_SOCFPGA)               += socfpga.o
>>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)     += zynq-fpga.o
>> +obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)   += zynqmp-fpga.o
>> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c new file
>> mode 100644 index 000000000000..e4172c3a6868
>> --- /dev/null
>> +++ b/drivers/fpga/zynqmp-fpga.c
>> @@ -0,0 +1,164 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2018 Xilinx, Inc.
>> + *

Please delete the unnecessary blank '*' line here.

>> + */
>> +
>> +#include <linux/dma-mapping.h>
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/string.h>
>> +#include <linux/firmware/xilinx/zynqmp/firmware.h>

I don't see this firmware/xilinx folder.  Is this dependent on other
commits that were submitted?  If so, please note that in the header.

>> +
>> +/* Constant Definitions */
>> +#define IXR_FPGA_DONE_MASK   0X00000008U
>> +#define IXR_FPGA_ENCRYPTION_EN       0x00000008U
>> +
>> +/**
>> + * struct zynqmp_fpga_priv - Private data structure
>> + * @dev:     Device data structure
>> + * @flags:   flags which is used to identify the bitfile type
>> + */
>> +struct zynqmp_fpga_priv {
>> +     struct device *dev;
>> +     u32 flags;
>> +};
>> +
>> +static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
>> +                                   struct fpga_image_info *info,
>> +                                   const char *buf, size_t size) {

checkpatch.pl would have complained about this:
ERROR: open brace '{' following function definitions go on the next line

>> +     struct zynqmp_fpga_priv *priv;
>> +
>> +     priv = mgr->priv;
>> +     priv->flags = info->flags;
>> +
>> +     return 0;
>> +}
>> +
>> +static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
>> +                              const char *buf, size_t size)
>> +{
>> +     struct zynqmp_fpga_priv *priv;
>> +     char *kbuf;
>> +     size_t dma_size;
>> +     dma_addr_t dma_addr;
>> +     int ret;
>> +     const struct zynqmp_eemi_ops *eemi_ops =
>> zynqmp_pm_get_eemi_ops();

Appears to have a dependency that I can't see here.  I'm looking at
the current linux-next/master branch and not seeing this
zynqmp_pm_get_eemi_ops function anywhere.

>> +
>> +     if (!eemi_ops || !eemi_ops->fpga_load)
>> +             return -ENXIO;
>> +
>> +     priv = mgr->priv;
>> +
>> +     if (mgr->flags & IXR_FPGA_ENCRYPTION_EN)
>> +             dma_size = size + ENCRYPTED_KEY_LEN;
>> +     else
>> +             dma_size = size;
>> +
>> +     kbuf = dma_alloc_coherent(priv->dev, dma_size, &dma_addr,
>> GFP_KERNEL);
>> +     if (!kbuf)
>> +             return -ENOMEM;
>> +
>> +     memcpy(kbuf, buf, size);
>> +
>> +     if (mgr->flags & IXR_FPGA_ENCRYPTION_EN)
>> +             memcpy(kbuf + size, mgr->key, ENCRYPTED_KEY_LEN);
>> +
>> +     wmb(); /* ensure all writes are done before initiate FW call */
>> +
>> +     if (mgr->flags & IXR_FPGA_ENCRYPTION_EN)
>> +             ret = eemi_ops->fpga_load(dma_addr, dma_addr + size,
>> +                                       mgr->flags);
>> +     else
>> +             ret = eemi_ops->fpga_load(dma_addr, size, mgr->flags);
>> +
>> +     dma_free_coherent(priv->dev, dma_size, kbuf, dma_addr);
>> +
>> +     return ret;
>> +}
>> +
>> +static int zynqmp_fpga_ops_write_complete(struct fpga_manager *mgr,
>> +                                       struct fpga_image_info *info)
>> +{
>> +     return 0;
>> +}
>> +
>> +static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager
>> +*mgr) {
>> +     u32 status;
>> +     const struct zynqmp_eemi_ops *eemi_ops =
>> zynqmp_pm_get_eemi_ops();
>> +
>> +     if (!eemi_ops || !eemi_ops->fpga_get_status)
>> +             return FPGA_MGR_STATE_UNKNOWN;
>> +
>> +     eemi_ops->fpga_get_status(&status);
>> +     if (status & IXR_FPGA_DONE_MASK)
>> +             return FPGA_MGR_STATE_OPERATING;
>> +
>> +     return FPGA_MGR_STATE_UNKNOWN;
>> +}
>> +
>> +static const struct fpga_manager_ops zynqmp_fpga_ops = {
>> +     .state = zynqmp_fpga_ops_state,
>> +     .write_init = zynqmp_fpga_ops_write_init,
>> +     .write = zynqmp_fpga_ops_write,
>> +     .write_complete = zynqmp_fpga_ops_write_complete, };
>> +
>> +static int zynqmp_fpga_probe(struct platform_device *pdev) {
>> +     struct device *dev = &pdev->dev;
>> +     struct zynqmp_fpga_priv *priv;
>> +     int err, ret;
>> +
>> +     priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +     if (!priv)
>> +             return -ENOMEM;
>> +
>> +     priv->dev = dev;
>> +     ret = dma_set_mask_and_coherent(&pdev->dev,
>> DMA_BIT_MASK(44));
>> +     if (ret < 0)
>> +             dev_err(dev, "no usable DMA configuration");
>> +
>> +     err = fpga_mgr_register(dev, "Xilinx ZynqMP FPGA Manager",
>> +                             &zynqmp_fpga_ops, priv);

The API has changed in 4.17 to be
fpga_mgr_create/free/register/unregister.  Please look at
linux-next/master for the latest.

>> +     if (err) {
>> +             dev_err(dev, "unable to register FPGA manager");
>> +             return err;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int zynqmp_fpga_remove(struct platform_device *pdev) {
>> +     fpga_mgr_unregister(&pdev->dev);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id zynqmp_fpga_of_match[] = {
>> +     { .compatible = "xlnx,zynqmp-pcap-fpga", },
>> +     {},
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, zynqmp_fpga_of_match);
>> +
>> +static struct platform_driver zynqmp_fpga_driver = {
>> +     .probe = zynqmp_fpga_probe,
>> +     .remove = zynqmp_fpga_remove,
>> +     .driver = {
>> +             .name = "zynqmp_fpga_manager",
>> +             .of_match_table = of_match_ptr(zynqmp_fpga_of_match),
>> +     },
>> +};
>> +
>> +module_platform_driver(zynqmp_fpga_driver);
>> +
>> +MODULE_AUTHOR("Nava kishore Manne <navam@xilinx.com>");
>> +MODULE_DESCRIPTION("Xilinx ZynqMp FPGA Manager");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.18.0
>
