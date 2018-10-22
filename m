Return-Path: <moritz.fischer@ettus.com>
Return-Path: <moritz.fischer@ettus.com>
Date: Mon, 22 Oct 2018 03:22:55 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 3/3] fpga manager: Adding FPGA Manager support for Xilinx
 zynqmp
Message-ID: <20181022102255.GA1428@archbook>
References: <20181020084805.29103-1-nava.manne@xilinx.com>
 <20181020084805.29103-4-nava.manne@xilinx.com>
 <CAJYdmePxnkG=3iJC5Lewq3n3zFGTKASJX7ceUEufBvOJogCfdA@mail.gmail.com>
 <CAAtXAHdP6z5NG+EAvW_N_RfcPv59e15hkd83AR-L3RDBrLMvcQ@mail.gmail.com>
 <BYAPR02MB47106D61C0CDB8268BAF4E44C2F40@BYAPR02MB4710.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB47106D61C0CDB8268BAF4E44C2F40@BYAPR02MB4710.namprd02.prod.outlook.com>
To: Nava kishore Manne <navam@xilinx.com>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, Moritz Fischer <moritz.fischer.private@gmail.com>, Alan Tull <atull@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michal Simek <michals@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, Devicetree List <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Oct 22, 2018 at 10:03:55AM +0000, Nava kishore Manne wrote:
> Hi Mortiz,
> 
> Thanks for the quick response....
> Please find my response inline.
> 
> > -----Original Message-----
> > From: Moritz Fischer [mailto:moritz.fischer@ettus.com]
> > Sent: Saturday, October 20, 2018 7:02 AM
> > To: Moritz Fischer <moritz.fischer.private@gmail.com>
> > Cc: Nava kishore Manne <navam@xilinx.com>; Alan Tull <atull@kernel.org>;
> > Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > Michal Simek <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Jolly
> > Shah <JOLLYS@xilinx.com>; linux-fpga@vger.kernel.org; Devicetree List
> > <devicetree@vger.kernel.org>; linux-arm-kernel <linux-arm-
> > kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; chinnikishore369@gmail.com
> > Subject: Re: [PATCH 3/3] fpga manager: Adding FPGA Manager support for
> > Xilinx zynqmp
> > 
> > On Fri, Oct 19, 2018 at 2:33 PM Moritz Fischer
> > <moritz.fischer.private@gmail.com> wrote:
> > >
> > > Hi Nava,
> > >
> > > Looks good to me, a couple of nits inline below.
> > >
> > > On Fri, Oct 19, 2018 at 1:50 AM Nava kishore Manne
> > > <nava.manne@xilinx.com> wrote:
> > > >
> > > > This patch adds FPGA Manager support for the Xilinx ZynqMp chip.
> > >
> > > Isn't it ZynqMP ?
> > > >
> > > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > > ---
> > > > Changes for v1:
> > > >                 -None.
> > > >
> > > > Changes for RFC-V2:
> > > >                 -Updated the Fpga Mgr registrations call's
> > > >                  to 4.18
> > > >
> > > >  drivers/fpga/Kconfig       |   9 +++
> > > >  drivers/fpga/Makefile      |   1 +
> > > >  drivers/fpga/zynqmp-fpga.c | 159
> > > > +++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 169 insertions(+)
> > > >  create mode 100644 drivers/fpga/zynqmp-fpga.c
> > > >
> > > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> > > > 1ebcef4bab5b..26ebbcf3d3a3 100644
> > > > --- a/drivers/fpga/Kconfig
> > > > +++ b/drivers/fpga/Kconfig
> > > > @@ -56,6 +56,15 @@ config FPGA_MGR_ZYNQ_FPGA
> > > >         help
> > > >           FPGA manager driver support for Xilinx Zynq FPGAs.
> > > >
> > > > +config FPGA_MGR_ZYNQMP_FPGA
> > > > +       tristate "Xilinx Zynqmp FPGA"
> > > > +       depends on ARCH_ZYNQMP || COMPILE_TEST
> > > > +       help
> > > > +         FPGA manager driver support for Xilinx ZynqMP FPGAs.
> > > > +         This driver uses processor configuration port(PCAP)
> > > This driver uses *the* processor configuration port.
> > >
> > > > +         to configure the programmable logic(PL) through PS
> > > > +         on ZynqMP SoC.
> > > > +
> > > >  config FPGA_MGR_XILINX_SPI
> > > >         tristate "Xilinx Configuration over Slave Serial (SPI)"
> > > >         depends on SPI
> > > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> > > > 7a2d73ba7122..3488ebbaee46 100644
> > > > --- a/drivers/fpga/Makefile
> > > > +++ b/drivers/fpga/Makefile
> > > > @@ -16,6 +16,7 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)    +=
> > socfpga-a10.o
> > > >  obj-$(CONFIG_FPGA_MGR_TS73XX)          += ts73xx-fpga.o
> > > >  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)      += xilinx-spi.o
> > > >  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)       += zynq-fpga.o
> > > > +obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)     += zynqmp-fpga.o
> > > >  obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
> > > >  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
> > > >
> > > > diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> > > > new file mode 100644 index 000000000000..2760d7e3872a
> > > > --- /dev/null
> > > > +++ b/drivers/fpga/zynqmp-fpga.c
> > > > @@ -0,0 +1,159 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * Copyright (C) 2018 Xilinx, Inc.
> > > > + */
> > > > +
> > > > +#include <linux/dma-mapping.h>
> > > > +#include <linux/fpga/fpga-mgr.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of_address.h>
> > > > +#include <linux/string.h>
> > > > +#include <linux/firmware/xlnx-zynqmp.h>
> > > > +
> > > > +/* Constant Definitions */
> > > > +#define IXR_FPGA_DONE_MASK     0X00000008U
> > > > +
> > > > +/**
> > > > + * struct zynqmp_fpga_priv - Private data structure
> > > > + * @dev:       Device data structure
> > > > + * @flags:     flags which is used to identify the bitfile type
> > > > + */
> > > > +struct zynqmp_fpga_priv {
> > > > +       struct device *dev;
> > > > +       u32 flags;
> > > > +};
> > > > +
> > > > +static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
> > > > +                                     struct fpga_image_info *info,
> > > > +                                     const char *buf, size_t size)
> > > > +{
> > > > +       struct zynqmp_fpga_priv *priv;
> > > > +
> > > > +       priv = mgr->priv;
> > > > +       priv->flags = info->flags;
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
> > > > +                                const char *buf, size_t size) {
> > > > +       struct zynqmp_fpga_priv *priv;
> > > > +       char *kbuf;
> > > > +       dma_addr_t dma_addr;
> > > > +       int ret;
> > > > +       const struct zynqmp_eemi_ops *eemi_ops =
> > > > +zynqmp_pm_get_eemi_ops();
> > >
> > > Reverse xmas-tree please, i.e. long lines first.
> > >
> > > > +
> > > > +       if (!eemi_ops || !eemi_ops->fpga_load)
> > > > +               return -ENXIO;
> > > > +
> > > > +       priv = mgr->priv;
> > > > +
> > > > +       kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr,
> > GFP_KERNEL);
> > > > +       if (!kbuf)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       memcpy(kbuf, buf, size);
> > > > +
> > > > +       wmb(); /* ensure all writes are done before initiate FW call
> > > > + */
> > > > +
> > > > +       ret = eemi_ops->fpga_load(dma_addr, size, priv->flags);
> > 
> > Don't you have to do anything with the flags? Is it really just a pass-through of
> > FPGA manager flags to eemi calls?
> > 
> > Don't you want to make partial bitstreams e.g. use a flags value that you export
> > in your firmware header (xlnx-zynqmp.h) and set those based on what flags get
> > passed in, i.e. explicitely translate FPGA Manager flags to your firmware flags?
> 
> At this point of time the firmware use Flag 0 for full Bitstream and 1 for partial bitstream loading.
> So I have not doing any explicit translate FPGA Manager flags inside the driver.
> Will document the flags info in xlnx-zynqmp.h

I think you should explicitely translate them, the fact that they happen
to line up in the current implementation is somewhat of coincidence, and
in future might break (since it's not really easy to to spot the
dependency when refactoring).

Why don't you do something like:

#include <linux/firmware/xilinx-zynqmp.h>

[...]

eemi_flags = 0;

if (flags & FPGA_MGR_PARTIAL_RECONFIG)
	eemi_flags |= XILINX_ZYNQMP_PM_FPGA_PARTIAL;

eemi_ops->fpga_load(...., eemi_flags);

Thanks,

Moritz
