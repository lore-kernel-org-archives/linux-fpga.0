Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170406042501.GB5981@tyrael.amer.corp.natinst.com>
References: <20170313215333.3008-1-atull@kernel.org> <20170313215333.3008-6-atull@kernel.org>
 <20170406042501.GB5981@tyrael.amer.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 6 Apr 2017 09:42:00 -0500
Message-ID: <CANk1AXQOSEwCMu4RAADjLi4fbQAgCcX_fTS=C-4rAL1KEf72RQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] fpga-region: separate out common code from dt
 specific code
Content-Type: text/plain; charset=UTF-8
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Apr 5, 2017 at 11:25 PM, Moritz Fischer <mdf@kernel.org> wrote:
Hi Moritz,

> Hi Alan,
>
> first pass ... need to get back to it.

Thanks for reviewing!

>
> On Mon, Mar 13, 2017 at 04:53:33PM -0500, Alan Tull wrote:
>> FPGA region is a layer above the FPGA manager and FPGA bridge
>> frameworks.  Currently, FPGA region is dependent on device tree.
>> This commit separates the device tree specific code from the
>> common code, separating fpga-region.c into fpga-region.c,
>> of-fpga-region.c, and fpga-region.h.
>>
>> Functons exported from fpga-region.c:
>> * fpga_region_register
>> * fpga_region_unregister
>>   Create/remove a FPGA region.  Caller will supply the region
>>   struct initialized with a pointer to a FPGA manager and
>>   a method to get the FPGA bridges.
>>
>> * of_fpga_region_find
>>   Find a fpga region, given the node pointer
>>
>> * fpga_region_alloc_image_info
>> * fpga_region_free_image_info
>>   Alloc/free fpga_image_info struct
>>
>> * fpga_region_program_fpga
>>   Program an FPGA region
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> ---
>>  drivers/fpga/Kconfig          |  12 +-
>>  drivers/fpga/Makefile         |   1 +
>>  drivers/fpga/fpga-region.c    | 475 +++++++-----------------------------------
>>  drivers/fpga/fpga-region.h    |  50 +++++
>>  drivers/fpga/of-fpga-region.c | 453 ++++++++++++++++++++++++++++++++++++++++
>>  include/linux/fpga/fpga-mgr.h |   6 +-
>>  6 files changed, 599 insertions(+), 398 deletions(-)
>>  create mode 100644 drivers/fpga/fpga-region.h
>>  create mode 100644 drivers/fpga/of-fpga-region.c
>>
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index ce861a2..be9c23d 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -15,10 +15,18 @@ if FPGA
>>
>>  config FPGA_REGION
>>       tristate "FPGA Region"
>> -     depends on OF && FPGA_BRIDGE
>> +     depends on FPGA_BRIDGE
>> +     help
>> +       FPGA Region common code.  A FPGA Region controls a FPGA Manager
>> +       and the FPGA Bridges associated with either a reconfigurable
>> +       region of an FPGA or a whole FPGA.
>> +
>> +config OF_FPGA_REGION
>> +     tristate "FPGA Region Device Tree Overlay Support"
>> +     depends on FPGA_REGION
>
> Doesn't this one now need depends on FPGA_REGION & OF ? Since
> FPGA_REGION no longer depends on OF, or does FPGA_BRIDGE pull it in?

Yes.  I will revisit this.

>> +
>> +/**
>> + * of_fpga_region_get_bridges - create a list of bridges
>> + * @region: FPGA region
>> + * @image_info: FPGA image info
>> + *
>> + * Create a list of bridges including the parent bridge and the bridges
>> + * specified by "fpga-bridges" property.  Note that the
>> + * fpga_bridges_enable/disable/put functions are all fine with an empty list
>> + * if that happens.
>> + *
>> + * Caller should call fpga_bridges_put(&region->bridge_list) when
>> + * done with the bridges.
>> + *
>> + * Return 0 for success (even if there are no bridges specified)
>> + * or -EBUSY if any of the bridges are in use.
>> + */
>> +static int of_fpga_region_get_bridges(struct fpga_region *region,
>> +                                   struct fpga_image_info *image_info)
>> +{
>> +     struct device *dev = &region->dev;
>> +     struct device_node *region_np = dev->of_node;
>> +     struct device_node *br, *np, *parent_br = NULL;
>> +     int i, ret;
>> +
>> +     /* If parent is a bridge, add to list */
>> +     ret = of_fpga_bridge_get_to_list(region_np->parent,
>> +                                      image_info,
>> +                                      &region->bridge_list);
>> +     if (ret == -EBUSY)
>> +             return ret;
>
> Would a if (ret) do here? Otherwise what happens on if (ret)?
> If you can replace the above if (ret == ...) the if (!ret) can go away.

I could have explained more clearly what this is doing.
of_fpga_bridge_get_to_list returns -ENODEV if the parent is not
a bridge or -EBUSY if it is a bridge that has already been gotten.
If the parent isn't a bridge, that's valid, this function should
continue and add bridges.

This function isn't new code and most of this patch isn't new.  It's
mostly moving code between files and doing some changes to
make that separation possible.  I've tried to make it easier by
breaking some of the functional changes to the previous smaller
patches.  Still thinking about how this could be made to be less
painful for reviewing.  I was thinking breaking this patch down further
by having one patch that does all the functional changes while
leaving the code in place in fpga-region.c.    That way the
functional changes will be clear (add a line/delete a line).  Then
another separate patch that actually creates the new
fpga-region.h and of-fpga-region.c files, moving stuff out of
fpga-region.c to them.

Alan

>> +
>> +     if (!ret)
>> +             parent_br = region_np->parent;
>> +
>> +     /* If overlay has a list of bridges, use it. */
>> +     if (of_parse_phandle(image_info->overlay, "fpga-bridges", 0))
>> +             np = image_info->overlay;
>> +     else
>> +             np = region_np;
>> +
>> +     for (i = 0; ; i++) {
>> +             br = of_parse_phandle(np, "fpga-bridges", i);
>> +             if (!br)
>> +                     break;
>> +
>> +             /* If parent bridge is in list, skip it. */
>> +             if (br == parent_br)
>> +                     continue;
>> +
>> +             /* If node is a bridge, get it and add to list */
>> +             ret = of_fpga_bridge_get_to_list(br, image_info,
>> +                                              &region->bridge_list);
>> +
>> +             /* If any of the bridges are in use, give up */
>> +             if (ret == -EBUSY) {
>> +                     fpga_bridges_put(&region->bridge_list);
>> +                     return -EBUSY;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
