Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANk1AXRzQmVUErPjtXY=idYWmov-ssMJr2DH9A3WbC_nWaTXWg@mail.gmail.com>
References: <1519188826-2047-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <1519188826-2047-2-git-send-email-shubhrajyoti.datta@gmail.com>
 <CANk1AXQ1R4dbgDJrUC4pgKtmoCaJhryTnD=bxwwWbEJn0BQcaA@mail.gmail.com>
 <20180227002832.GA24387@tyrael.ni.corp.natinst.com> <CAKfKVtGPhb6Mg4UcX58iknEHAvRhp7NzisEONz8Cj+k9OYcu7A@mail.gmail.com>
 <CANk1AXR6aSwyQTW=NeYrRUQo2Oe8BysyOzf6VHvBuXaxKwNp-g@mail.gmail.com>
 <CAKfKVtE5u7z_ASmw_f6t6MAybAnoPm+rKm5LQZ_MaYmUEYuOhg@mail.gmail.com>
 <20180302050033.v6dvlppskpzht7tf@derp-derp.lan> <CAKfKVtGc4rn0UWbs3TVzqS_2=UL24gRcQR4+5e4XOnrztOy06A@mail.gmail.com>
 <CANk1AXSOrfY6YyN+BfFneCPZEwTth8LrGNkKXgZ6kXuxkRT7QA@mail.gmail.com>
 <20180303032306.ay6hgctyjhy6wdxg@derp-derp.lan> <CANk1AXRzQmVUErPjtXY=idYWmov-ssMJr2DH9A3WbC_nWaTXWg@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 8 Mar 2018 16:32:20 -0600
Message-ID: <CANk1AXQyLM4H_uSdVFMHs6LSM7v-+_ZUm3Denrr4OXAzVA63ew@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpga: reset bridge: Add the reset bridge
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>, linux-fpga@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Michal Simek <michal.simek@xilinx.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, nofooter@xilinx.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Wu Hao <hao.wu@intel.com>, Enno Luebbers <enno.luebbers@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Mar 2, 2018 at 9:54 PM, Alan Tull <atull@kernel.org> wrote:
> On Fri, Mar 2, 2018 at 9:23 PM, Moritz Fischer <mdf@kernel.org> wrote:
>> Hi Shubhrajyoti, Alan,
>>
>> On Fri, Mar 02, 2018 at 08:43:19PM -0600, Alan Tull wrote:
>>> On Fri, Mar 2, 2018 at 1:24 AM, Shubhrajyoti Datta
>>> <shubhrajyoti.datta@gmail.com> wrote:
>>> > Hi Moritz,
>>> >
>>> > <snip>
>>> >>> >
>>> >>> > Normally, as Moritz is saying, the reset would be handled by the
>>> >>> > driver for the fabric-based hardware.
>>> >>> I didnt understand you mean the  platform-fpga.c ?
>>> >>
>>> >> I don't understand this sentence ;-) I'll try to re-explain:
>>> >>
>>> >> Say you have an AXI DMA engine in there that needs a reset to be toggled
>>> >> after programming the FPGA then you are in either one of these cases:
>>> >>
>>> >> a) You're doing a full reprogram of the entire fabric, at which point
>>> >> you can reset everything by asserting them in the driver like in
>>> >> drivers/fpga/zynq-fpga.c
>>> > That would work however I was thinking the reset technically should be in
>>> > the region and not the fpga manager as it is more related to the region than
>>> > the manager.
>>>
>>> OK now I understand that this is supporting a reset that is resetting
>>> all the hardware in a region of fabric.  The region could contain
>>> multiple devices.  This change isn't meant to support toggling a
>>> single fpga-based device's reset (that would be handled in the
>>> device's driver).
>>
>> I could see how that could happen in a design, yes.
>>
>>>
>>> > Ofcourse manager could proxy for the region.
>>>
>>> Mapping the reset to the region is the more general case.  It will
>>> support resets that either apply to a single PR region or resetting a
>>> whole fabric of a FPGA that is doing full reconfig,  i
>>>
>>> >
>>> > how about [1]
>>>
>>> [1] makes sense to me now.  That is a better solution than making this
>>> be a bridge.
>>
>> Yeah I think this is the direction to go for what he's trying to achieve.
>>>
>>> >
>>> >>
>>> >> b) You're doing a partial reconfiguration in which case the regions that
>>> >> are being reconfigured contain some peripherals you want to selectively
>>> >> reset. If you need a software reset, the driver for this peripheral can
>>> >> request a reset through the normal reset API.
>>> >
>>> > So if the ip was  written in full bitstream case the fpga manager does
>>> > the request.
>>>
>>> > In PRR case the driver would do it ?
>>> >
>>> > I would have preferred to keep that(full or PRR case) agnostic to the driver.
>>
>> Yeah, the device driver should not have to worry about whether it's in partial
>> reconfiguration or full reconfiguration. What I do feel strongly about
>> is the region reset shouldn't remove the reset handling from the drivers
>> if they do need it.
>
> Yes, I agree totally.
>
>>
>>> >>
>>> >> Am I missing somehting here? Why do you need the bridge to do the reset?
>>> >>
>>> >> - Moritz
>>> > [1]
>>> > diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt
>>> > b/Documentation/devicetree/bindings/fpga/fpga-region.txt
>>> > index 6db8aed..955a863 100644
>>> > --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
>>> > +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
>>> > @@ -196,6 +196,7 @@ Optional properties:
>>> >  - config-complete-timeout-us : The maximum time in microseconds time for the
>>> >         FPGA to go to operating mode after the region has been programmed.
>>> >  - child nodes : devices in the FPGA after programming.
>>> > +- resets       : Phandle and reset specifier for this region
>>> >
>>> >  In the example below, when an overlay is applied targeting fpga-region0,
>>> >  fpga_mgr is used to program the FPGA.  Two bridges are controlled during
>>> > diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>>> > index 58789b9..8c87a6b 100644
>>> > --- a/drivers/fpga/fpga-region.c
>>> > +++ b/drivers/fpga/fpga-region.c
>>> > @@ -25,6 +25,7 @@
>>> >  #include <linux/of_platform.h>
>>> >  #include <linux/slab.h>
>>> >  #include <linux/spinlock.h>
>>> > +#include <linux/reset.h>
>>> >
>>> >  /**
>>> >   * struct fpga_region - FPGA Region structure
>>> > @@ -235,6 +236,8 @@ static int fpga_region_program_fpga(struct
>>> > fpga_region *region,
>>> >  {
>>> >         struct fpga_manager *mgr;
>>> >         int ret;
>>> > +       struct device *dev = &region->dev;
>>> > +       struct reset_control *rstc;
>>> >
>>> >         region = fpga_region_get(region);
>>> >         if (IS_ERR(region)) {
>>> > @@ -273,6 +276,15 @@ static int fpga_region_program_fpga(struct
>>> > fpga_region *region,
>>> >                 goto err_put_br;
>>> >         }
>>> >
>>> > +       rstc = of_reset_control_array_get(dev->of_node, false, true);
>>> > +       if (IS_ERR(rstc)) {
>>> > +               goto err_put_br;
>>> > +       }
>>> > +
>>> > +       reset_control_reset(rstc);
>>> > +       reset_control_put(rstc);
>>> > +
>>>
>>> This looks good to me.  This allows there to be a reset that's not
>>> dedicated to a specific device, but really is resetting a whole PR
>>> region.  Or resetting the whole FPGA, it handles both cases.  And we
>>> get that pretty pain-free, just add the reset to the fpga region in
>>> the device tree, if this device tree is being used, for example.
>>
>> One thing to watch out for is to make sure to not re-introduce an DT
>> dependency into the fpga-region code.
>
> Good catch Moritz!  It looks like this example is based on v4.15?
> Shubhrajyoti, please look at the linux-next repo [2] as I've separated
> the DT parts of fpga region to a separate file of-fpga-region.c.

The rstc can be added to struct fpga_region in fpga-region.h.
of_reset_control_array_get can be in of-fpga-region.c.  Toggling the
reset can still happen in fpga_region_program_fpga.

Resetting the contents of a FPGA region is something that will be
useful in general (currently there are now two users with patches on
this mailing list wanting to do region reset).  The cool thing is that
reset support for non-DT platforms has recently been added [3].

Alan

>
> Alan
>
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/fpga

[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/reset/core.c?id=940821732839622c22db89b57d3969e76c863e44
