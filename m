Return-Path: <SRS0=QjBe=4U=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=QjBe=4U=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:12082 "EHLO
        mx0b-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728356AbgCCSP7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Mar 2020 13:15:59 -0500
From: Luis Tanica <luis.f.tanica@seagate.com>
Subject: Re: LPC Bus Driver
Date: Tue, 3 Mar 2020 18:07:21 +0000
Message-ID: <3992844da4534804ade896dd5ba4dfcbMW2PR20MB2106669451CA09B579ECB973A0E40@MW2PR20MB2106.namprd20.prod.outlook.com>
References: <6daf1bb266a24c239aed34d8661fc5eaMW2PR20MB210660F6B17CB90ACD0B6E7CA0E70@MW2PR20MB2106.namprd20.prod.outlook.com>
 <797cec65-5504-ee85-3fe4-fe2b4c90991f@huawei.com>
 <20200303154522.GA24568@yilunxu-OptiPlex-7050>,<CAK8P3a01vYfqvj4eRQQsqC9FrUTr=q6ZRF-EuYV0iGC7AV7UBQ@mail.gmail.com>
In-Reply-To: <CAK8P3a01vYfqvj4eRQQsqC9FrUTr=q6ZRF-EuYV0iGC7AV7UBQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D3A9BEA3FB70F048B618023D91C9FACF@namprd20.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Xu Yilun <yilun.xu@intel.com>
Cc: John Garry <john.garry@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>

Thank you all for the help. This is the gist of what I got from your respon=
ses.=0A=
=0A=
=A0- if CPLD is the only thing on LPC bus, consider creating a single drive=
r for it=0A=
=A0- if not, then creating the LPC bus layer would be ideal=0A=
=A0- could also consider I2C framework and treat it like an I2C device=0A=
=0A=
I believe for us we'll only ever have that one CPLD on the LPC bus, so a si=
ngle driver could be a good idea.=0A=
The only reason I like regmap though, is that I could define a regmap bus t=
hat would implement all the LPC read/write operations (by implementing the =
.reg_read and .reg_write for regmap_bus) and then I could use those registe=
rs as I pleased from different places.=0A=
For instance, we could have a CPLD driver that exposes all the registers/fi=
elds via sysfs but then I could also have an arm-reset driver that only map=
s the register it needs for the arm reset.=0A=
=0A=
I actually started implementing the LPC bus, and then having 2 devices (res=
et and cpld) implemented as LPC devices.=0A=
Even though it seems a bit more logical overall, it's a lot of overhead for=
 what I need.=0A=
=0A=
I would like to take a look at the I2C option, since that's the only idea h=
ere I haven't explored. If you could point me in the right direction on how=
 to do it (or some examples in the kernel) I'd appreciate.=0A=
I should be able to make a decision after that, but I'm tempted to create a=
 single driver and keep it simple for now.=0A=
=0A=
P.S.: This is my first time using the mailing list and I'm guessing Outlook=
 is not the best client to use. Any tips on that end?=0A=
=0A=
=A0 =A0Luis=0A=
=0A=
=0A=
=0A=
=0A=
From: Arnd Bergmann <arnd@arndb.de>=0A=
=0A=
Sent: Tuesday, March 3, 2020 09:24=0A=
=0A=
To: Xu Yilun <yilun.xu@intel.com>=0A=
=0A=
Cc: John Garry <john.garry@huawei.com>; Luis Tanica <luis.f.tanica@seagate.=
com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-fp=
ga@vger.kernel.org <linux-fpga@vger.kernel.org>; gregkh <gregkh@linuxfounda=
tion.org>=0A=
=0A=
Subject: Re: LPC Bus Driver=0A=
=0A=
=A0=0A=
=0A=
=0A=
On Tue, Mar 3, 2020 at 4:47 PM Xu Yilun <yilun.xu@intel.com> wrote:=0A=
=0A=
> On Tue, Mar 03, 2020 at 10:13:36AM +0000, John Garry wrote:=0A=
=0A=
> > + add fpga list and Greg+Arnd for misc drivers=0A=
=0A=
> > >We have this board with our own SoC, which is connected to an external=
 CPLD (FPGA) via LPC (low pin count) bus.=0A=
=0A=
> > >I've been doing some research to see what the best way of designing th=
e drivers for it would be, and came across the Hisilicon LPC driver stuff (=
which I believe you're the maintainer for).=0A=
=0A=
> > >=0A=
=0A=
> > >Just a little background. Let's say our host (ARM) has a custom LPC co=
ntroller. The LPC controller let's us perform reads/writes of CPLD register=
s via LPC bus. This CPLD is the only slave device attached to that bus and =
we only use it for reading/writing=0A=
 certain=0A=
=0A=
> > >=A0 registers (e.g., we use it to access some system information and f=
or resetting the ARM during reboot).=0A=
=0A=
> > >=0A=
=0A=
> > >I was looking at the regmap framework and that seemed a good way to go=
.=0A=
=0A=
> >=0A=
=0A=
> > I thought that regmap only allows mapping in MMIO regions for multiplex=
ing=0A=
=0A=
> > access from multiple drivers or accessing registers outside the device =
HW=0A=
=0A=
> > registers, but you seem to need to manually generate the LPC bus access=
es to=0A=
=0A=
> > access registers on the slave device.=0A=
=0A=
>=0A=
=0A=
> I'm not familar with LPC controller, but seems it could not perform=0A=
=0A=
> read/write by one memory access or io access instruction=0A=
=0A=
>=0A=
=0A=
> I didn't find an existing bus_type for LPC bus, so I think regmap is a=0A=
=0A=
> good way. When you have implemented the regmap for LPC bus, you need to=
=0A=
=0A=
> access the CPLD registers by regmap_read/write, and just pass CPLD local=
=0A=
=0A=
> register addr as parameter.=0A=
=0A=
=0A=
=0A=
LPC uses the same software abstraction as the old ISA bus, providing=0A=
=0A=
port (inb/outb) and mmio (readl/writel) style register access as well as=0A=
=0A=
interrupts and a crude form of DMA access.=0A=
=0A=
=0A=
=0A=
Whether regmap or something else works depends on which of these=0A=
=0A=
communication options the CPLD uses.=0A=
=0A=
=0A=
=0A=
> > If this FPGA is the only device which will ever be on this LPC bus, the=
n=0A=
=0A=
> > could you encode the LPC accesses directly in the FPGA driver?=0A=
=0A=
=0A=
=0A=
I think this is the most important question. If the same SoC is used=0A=
=0A=
in systems that connect something else on the same LPC bus, then=0A=
=0A=
making it look like a normal ISA/LPC bus to Linux is probably best,=0A=
=0A=
but if the CPLD and SoC are only ever used in this one combination,=0A=
=0A=
there is nothing wrong with pretending that the LPC MMIO interface=0A=
=0A=
on this chip part of the driver for the CPLD.=0A=
=0A=
=0A=
=0A=
> > As another alternative, it might be worth considering writing an I2C=0A=
=0A=
> > controller driver for your LPC host, i.e. model as an I2C bus, and have=
 an=0A=
=0A=
> > I2C client driver for the LPC slave (FPGA). I think that there are exam=
ples=0A=
=0A=
> > of this in the kernel.=0A=
=0A=
>=0A=
=0A=
> How the host cpu is connected to LPC host?=0A=
=0A=
> Why an I2C controller driver for LPC host? The LPC bus is compatible to i=
2c bus?=0A=
=0A=
=0A=
=0A=
i2c is a simple bus that allows multiple devices to share a bus=0A=
=0A=
and perform read/write operations on numbered registers. If the device=0A=
=0A=
attached to the LPC bus fits into that, it might be even easier than=0A=
=0A=
regmap.=0A=
=0A=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0 Arnd=0A=
=0A=
