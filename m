Return-Path: <SRS0=QjBe=4U=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=QjBe=4U=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:35831 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbgCCQZI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Mar 2020 11:25:08 -0500
MIME-Version: 1.0
References: <6daf1bb266a24c239aed34d8661fc5eaMW2PR20MB210660F6B17CB90ACD0B6E7CA0E70@MW2PR20MB2106.namprd20.prod.outlook.com>
 <797cec65-5504-ee85-3fe4-fe2b4c90991f@huawei.com> <20200303154522.GA24568@yilunxu-OptiPlex-7050>
In-Reply-To: <20200303154522.GA24568@yilunxu-OptiPlex-7050>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 3 Mar 2020 17:24:46 +0100
Message-ID: <CAK8P3a01vYfqvj4eRQQsqC9FrUTr=q6ZRF-EuYV0iGC7AV7UBQ@mail.gmail.com>
Subject: Re: LPC Bus Driver
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Xu Yilun <yilun.xu@intel.com>
Cc: John Garry <john.garry@huawei.com>, luis.f.tanica@seagate.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, gregkh <gregkh@linuxfoundation.org>

On Tue, Mar 3, 2020 at 4:47 PM Xu Yilun <yilun.xu@intel.com> wrote:
> On Tue, Mar 03, 2020 at 10:13:36AM +0000, John Garry wrote:
> > + add fpga list and Greg+Arnd for misc drivers
> > >We have this board with our own SoC, which is connected to an external CPLD (FPGA) via LPC (low pin count) bus.
> > >I've been doing some research to see what the best way of designing the drivers for it would be, and came across the Hisilicon LPC driver stuff (which I believe you're the maintainer for).
> > >
> > >Just a little background. Let's say our host (ARM) has a custom LPC controller. The LPC controller let's us perform reads/writes of CPLD registers via LPC bus. This CPLD is the only slave device attached to that bus and we only use it for reading/writing certain
> > >  registers (e.g., we use it to access some system information and for resetting the ARM during reboot).
> > >
> > >I was looking at the regmap framework and that seemed a good way to go.
> >
> > I thought that regmap only allows mapping in MMIO regions for multiplexing
> > access from multiple drivers or accessing registers outside the device HW
> > registers, but you seem to need to manually generate the LPC bus accesses to
> > access registers on the slave device.
>
> I'm not familar with LPC controller, but seems it could not perform
> read/write by one memory access or io access instruction
>
> I didn't find an existing bus_type for LPC bus, so I think regmap is a
> good way. When you have implemented the regmap for LPC bus, you need to
> access the CPLD registers by regmap_read/write, and just pass CPLD local
> register addr as parameter.

LPC uses the same software abstraction as the old ISA bus, providing
port (inb/outb) and mmio (readl/writel) style register access as well as
interrupts and a crude form of DMA access.

Whether regmap or something else works depends on which of these
communication options the CPLD uses.

> > If this FPGA is the only device which will ever be on this LPC bus, then
> > could you encode the LPC accesses directly in the FPGA driver?

I think this is the most important question. If the same SoC is used
in systems that connect something else on the same LPC bus, then
making it look like a normal ISA/LPC bus to Linux is probably best,
but if the CPLD and SoC are only ever used in this one combination,
there is nothing wrong with pretending that the LPC MMIO interface
on this chip part of the driver for the CPLD.

> > As another alternative, it might be worth considering writing an I2C
> > controller driver for your LPC host, i.e. model as an I2C bus, and have an
> > I2C client driver for the LPC slave (FPGA). I think that there are examples
> > of this in the kernel.
>
> How the host cpu is connected to LPC host?
> Why an I2C controller driver for LPC host? The LPC bus is compatible to i2c bus?

i2c is a simple bus that allows multiple devices to share a bus
and perform read/write operations on numbered registers. If the device
attached to the LPC bus fits into that, it might be even easier than
regmap.

       Arnd
