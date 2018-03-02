Return-Path: <SRS0=WCl+=FY=gmail.com=shubhrajyoti.datta@kernel.org>
Return-Path: <SRS0=WCl+=FY=gmail.com=shubhrajyoti.datta@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180302050033.v6dvlppskpzht7tf@derp-derp.lan>
References: <1519188826-2047-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <1519188826-2047-2-git-send-email-shubhrajyoti.datta@gmail.com>
 <CANk1AXQ1R4dbgDJrUC4pgKtmoCaJhryTnD=bxwwWbEJn0BQcaA@mail.gmail.com>
 <20180227002832.GA24387@tyrael.ni.corp.natinst.com> <CAKfKVtGPhb6Mg4UcX58iknEHAvRhp7NzisEONz8Cj+k9OYcu7A@mail.gmail.com>
 <CANk1AXR6aSwyQTW=NeYrRUQo2Oe8BysyOzf6VHvBuXaxKwNp-g@mail.gmail.com>
 <CAKfKVtE5u7z_ASmw_f6t6MAybAnoPm+rKm5LQZ_MaYmUEYuOhg@mail.gmail.com> <20180302050033.v6dvlppskpzht7tf@derp-derp.lan>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Fri, 2 Mar 2018 12:54:03 +0530
Message-ID: <CAKfKVtGc4rn0UWbs3TVzqS_2=UL24gRcQR4+5e4XOnrztOy06A@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpga: reset bridge: Add the reset bridge
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Michal Simek <michal.simek@xilinx.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, nofooter@xilinx.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-ID: <linux-fpga@vger.kernel.org>

Hi Moritz,

<snip>
>> >
>> > Normally, as Moritz is saying, the reset would be handled by the
>> > driver for the fabric-based hardware.
>> I didnt understand you mean the  platform-fpga.c ?
>
> I don't understand this sentence ;-) I'll try to re-explain:
>
> Say you have an AXI DMA engine in there that needs a reset to be toggled
> after programming the FPGA then you are in either one of these cases:
>
> a) You're doing a full reprogram of the entire fabric, at which point
> you can reset everything by asserting them in the driver like in
> drivers/fpga/zynq-fpga.c
That would work however I was thinking the reset technically should be in
the region and not the fpga manager as it is more related to the region than
the manager. Ofcourse manager could proxy for the region.

how about [1]

>
> b) You're doing a partial reconfiguration in which case the regions that
> are being reconfigured contain some peripherals you want to selectively
> reset. If you need a software reset, the driver for this peripheral can
> request a reset through the normal reset API.

So if the ip was  written in full bitstream case the fpga manager does
the request.
In PRR case the driver would do it ?

I would have preferred to keep that(full or PRR case) agnostic to the driver.
>
> Am I missing somehting here? Why do you need the bridge to do the reset?
>
> - Moritz
[1]
diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt
b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index 6db8aed..955a863 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -196,6 +196,7 @@ Optional properties:
 - config-complete-timeout-us : The maximum time in microseconds time for the
        FPGA to go to operating mode after the region has been programmed.
 - child nodes : devices in the FPGA after programming.
+- resets       : Phandle and reset specifier for this region

 In the example below, when an overlay is applied targeting fpga-region0,
 fpga_mgr is used to program the FPGA.  Two bridges are controlled during
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 58789b9..8c87a6b 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -25,6 +25,7 @@
 #include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/reset.h>

 /**
  * struct fpga_region - FPGA Region structure
@@ -235,6 +236,8 @@ static int fpga_region_program_fpga(struct
fpga_region *region,
 {
        struct fpga_manager *mgr;
        int ret;
+       struct device *dev = &region->dev;
+       struct reset_control *rstc;

        region = fpga_region_get(region);
        if (IS_ERR(region)) {
@@ -273,6 +276,15 @@ static int fpga_region_program_fpga(struct
fpga_region *region,
                goto err_put_br;
        }

+       rstc = of_reset_control_array_get(dev->of_node, false, true);
+       if (IS_ERR(rstc)) {
+               goto err_put_br;
+       }
+
+       reset_control_reset(rstc);
+       reset_control_put(rstc);
+
        fpga_bridges_put(&region->bridge_list);
        fpga_mgr_put(mgr);
        fpga_region_put(region);
