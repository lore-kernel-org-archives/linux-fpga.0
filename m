Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170914225446.GA19426@tyrael.ni.corp.natinst.com>
References: <20170913204841.2730-1-atull@kernel.org> <20170913204841.2730-2-atull@kernel.org>
 <alpine.DEB.2.20.1709131636330.2622@mgerlach-VirtualBox> <CANk1AXRHdSu0=Kw3XrB6aS2zCf_iSqMacyY2aKnkTQckjTdFww@mail.gmail.com>
 <alpine.DEB.2.20.1709141521110.2240@mgerlach-VirtualBox> <20170914225446.GA19426@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 19 Sep 2017 11:06:50 -0500
Message-ID: <CANk1AXQAjmtoHa=2B2dk7TVnsfJOEcEFc9RXC8Ee_3teoFqjgw@mail.gmail.com>
Subject: Re: [PATCH v4 01/18] fpga: bridge: support getting bridge from device
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: matthew.gerlach@linux.intel.com, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Sep 14, 2017 at 5:54 PM, Moritz Fischer <mdf@kernel.org> wrote:
> On Thu, Sep 14, 2017 at 03:29:09PM -0700, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Thu, 14 Sep 2017, Alan Tull wrote:
>>
>> > On Wed, Sep 13, 2017 at 6:38 PM,  <matthew.gerlach@linux.intel.com> wrote:
>> >
>> > Hi Matthew,
>> >
>> > >
>> > > Hi Alan,
>> > >
>> > > Two minor nits below.
>> > >
>> > > Matthew Gerlach
>> > >
>> > > On Wed, 13 Sep 2017, Alan Tull wrote:
>> > >
>> > > > Add two functions for getting the FPGA bridge from the device
>> > > > rather than device tree node.  This is to enable writing code
>> > > > that will support using FPGA bridges without device tree.
>> > > > Rename one old function to make it clear that it is device
>> > > > tree-ish.  This leaves us with 3 functions for getting a bridge:
>> > > >
>> > > > * fpga_bridge_get
>> > > >  Get the bridge given the device.
>> > > >
>> > > > * fpga_bridges_get_to_list
>> > > >  Given the device, get the bridge and add it to a list.
>> > > >
>> > > > * of_fpga_bridges_get_to_list
>> > > >  Renamed from priviously existing fpga_bridges_get_to_list.
>> > > >  Given the device node, get the bridge and add it to a list.
>> > > >
>> > > > Signed-off-by: Alan Tull <atull@kernel.org>
>> > > > ---
>> > > > v2: use list_for_each_entry
>> > > >    static the bridge_list_lock
>> > > >    update copyright and author email
>> > > > v3: no change to this patch in this version of patchset
>> > > > v4: no change to this patch in this version of patchset
>> > > > ---
>> > > > drivers/fpga/fpga-bridge.c       | 110
>> > > > +++++++++++++++++++++++++++++++--------
>> > > > drivers/fpga/fpga-region.c       |  11 ++--
>> > > > include/linux/fpga/fpga-bridge.h |   7 ++-
>> > > > 3 files changed, 100 insertions(+), 28 deletions(-)
>> > > >
>> > > > diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
>> > > > index fcd2bd3..af6d97e 100644
>> > > > --- a/drivers/fpga/fpga-bridge.c
>> > > > +++ b/drivers/fpga/fpga-bridge.c
>> > > > @@ -2,6 +2,7 @@
>> > > >  * FPGA Bridge Framework Driver
>> > > >  *
>> > > >  *  Copyright (C) 2013-2016 Altera Corporation, All Rights Reserved.
>> > > > + *  Copyright (C) 2017 Intel Corporation
>> > > >  *
>> > > >  * This program is free software; you can redistribute it and/or modify it
>> > > >  * under the terms and conditions of the GNU General Public License,
>> > > > @@ -70,29 +71,12 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
>> > > > }
>> > > > EXPORT_SYMBOL_GPL(fpga_bridge_disable);
>> > > >
>> > > > -/**
>> > > > - * of_fpga_bridge_get - get an exclusive reference to a fpga bridge
>> > > > - *
>> > > > - * @np: node pointer of a FPGA bridge
>> > > > - * @info: fpga image specific information
>> > > > - *
>> > > > - * Return fpga_bridge struct if successful.
>> > > > - * Return -EBUSY if someone already has a reference to the bridge.
>> > > > - * Return -ENODEV if @np is not a FPGA Bridge.
>> > > > - */
>> > > > -struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
>> > > > -                                      struct fpga_image_info *info)
>> > > > -
>> > > > +struct fpga_bridge *__fpga_bridge_get(struct device *dev,
>> > > > +                                     struct fpga_image_info *info)
>> > >
>> > >
>> > > Should this be a static function?
>> >
>> > You are right.  Will fix in v5.
>> >
>> > >
>> > > I was recently told by mtd maintainers that function names prefixed with
>> > > __ should be avoided.
>> >
>> > I see functions named thusly around in the kernel.   Can you point me
>> > to that thread or let me know what their thinking was about this?  I
>> > am open for suggestions for a new function name.
>>
>> Marek Vasut just told me to "Avoid function names with __ prefix" in
>>
>> https://patchwork.kernel.org/patch/9883977/
>>
>> I tend to agree with you that the __ prefix seems to be around, but
>> this could be a case of "evolution" of coding style.  Historically,
>> __ seems to mean an internal version of an external function.  If __
>> is to be avoided, we might have to rename to fpga_bridge_get_internal().
>
> Bear in mind that coding style can be subsystem specific. What applies
> to MTD doesn't necessarily have to apply here.

Yes I agree.  I'll keep the __ name unless someone gives us good
explanation of the naming practice they are recommending.  But yes, it
should have been static.

Alan
