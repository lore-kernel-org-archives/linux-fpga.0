Return-Path: <SRS0=/QMV=QG=gmail.com=simon.k.r.goldschmidt@kernel.org>
Return-Path: <SRS0=/QMV=QG=gmail.com=simon.k.r.goldschmidt@kernel.org>
MIME-Version: 1.0
References: <20190129200858.19773-1-goldsimon@gmx.de> <CANk1AXTcbqgoCYkTY-ssMvpAbdoncrkOxyRfu-piLE2tQ15a2g@mail.gmail.com>
In-Reply-To: <CANk1AXTcbqgoCYkTY-ssMvpAbdoncrkOxyRfu-piLE2tQ15a2g@mail.gmail.com>
From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date: Wed, 30 Jan 2019 07:08:30 +0100
Message-ID: <CAAh8qsz9g-20ZOZpT2Fh5003ZkH=HQ9sUBVHWqooB2Pt-OXA4Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: socfpga: fix base address of SDR controller
Content-Type: text/plain; charset="UTF-8"
To: Alan Tull <atull@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Jan 29, 2019 at 11:31 PM Alan Tull <atull@kernel.org> wrote:
>
> On Tue, Jan 29, 2019 at 2:09 PM Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com> wrote:
>
> Hi Simon,
>
> Thanks for submitting.   A couple of things...
>
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > index f365003f0..8f6c1a5d6 100644
> > --- a/arch/arm/boot/dts/socfpga.dtsi
> > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > @@ -788,9 +788,9 @@
> >                         reg = <0xfffec000 0x100>;
> >                 };
> >
> > -               sdr: sdr@ffc25000 {
> > +               sdr: sdr@ffc20000 {
> >                         compatible = "altr,sdr-ctl", "syscon";
> > -                       reg = <0xffc25000 0x1000>;
> > +                       reg = <0xffc20000 0x6000>;
>
> The binding doc will also need this change (in a separate patch)
> Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt

Right. I didn't realise there is an actual address in that file as it says
"Example"...

But I'll make sure to change that if this patch is accepted.

>
> > diff --git a/arch/arm/mach-socfpga/self-refresh.S b/arch/arm/mach-socfpga/self-refresh.S
> > index f2d7f883e..bd7759357 100644
> > --- a/arch/arm/mach-socfpga/self-refresh.S
> > +++ b/arch/arm/mach-socfpga/self-refresh.S
> > @@ -19,8 +19,8 @@
> >  #define MAX_LOOP_COUNT         1000
> >
> >  /* Register offset */
> > -#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x54
> > -#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x58
> > +#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x5054
> > +#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x5058
>
> These offsets are used for ldr/sdr and are limited to 12 bits.  This
> won't build if CONFIG_SOCFPGA_SUSPEND is enabled.
>
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:
> Assembler messages:
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:65:
> Error: bad immediate value for offset (20564)
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:67:
> Error: bad immediate value for offset (20564)
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:72:
> Error: bad immediate value for offset (20568)
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:101:
> Error: bad immediate value for offset (20564)
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:103:
> Error: bad immediate value for offset (20564)
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:108:
> Error: bad immediate value for offset (20568)
> /home/atull/repos/linux-socfpga/scripts/Makefile.build:367: recipe for
> target 'arch/arm/mach-socfpga/self-refresh.o' failed

Oops, you're right. Sorry for that. I just saw now that socfpga_defconfig
leaves CONFIG_SOCFPGA_SUSPEND inactive. I'll make sure to test that if it
comes to v2 (depending on the discussion).

Thanks,
Simon
