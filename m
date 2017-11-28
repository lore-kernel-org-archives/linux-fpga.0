Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171128151538.2w6fjcib6my6wt5n@rob-hp-laptop>
References: <1511816284-12145-1-git-send-email-atull@kernel.org>
 <1511816284-12145-2-git-send-email-atull@kernel.org> <20171128151538.2w6fjcib6my6wt5n@rob-hp-laptop>
From: Alan Tull <atull@kernel.org>
Date: Tue, 28 Nov 2017 13:26:34 -0600
Message-ID: <CANk1AXQ756EeKDDWXT5W6T8CJqqoFR7pGNkL5BGPN8gYBneRfw@mail.gmail.com>
Subject: Re: [RFC 1/2] of: overlay: add whitelist
Content-Type: text/plain; charset="UTF-8"
To: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Moritz Fischer <mdf@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Nov 28, 2017 at 9:15 AM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Nov 27, 2017 at 02:58:03PM -0600, Alan Tull wrote:
>> Add simple whitelist.  When an overlay is submitted, if any target in
>> the overlay is not in the whitelist, the overlay is rejected.  Drivers
>> that support dynamic configuration can register their device node with:
>>
>>   int of_add_whitelist_node(struct device_node *np)
>>
>> and remove themselves with:
>>
>>   void of_remove_whitelist_node(struct device_node *np)
>
> I think these should be named for what they do, not how it is
> implemented.

Sure, such as of_node_overlay_enable and of_node_overlay_disable?

>
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> ---
>>  drivers/of/overlay.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/of.h   | 12 +++++++++
>>  2 files changed, 85 insertions(+)
>>
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index c150abb..5f952a1 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/err.h>
>>  #include <linux/idr.h>
>> +#include <linux/spinlock.h>
>>
>>  #include "of_private.h"
>>
>> @@ -646,6 +647,74 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>       kfree(ovcs);
>>  }
>>
>> +/* lock for adding/removing device nodes to the whitelist */
>> +static spinlock_t whitelist_lock;
>> +
>> +static struct list_head whitelist_list = LIST_HEAD_INIT(whitelist_list);
>> +
>> +struct dt_overlay_whitelist {
>> +     struct device_node *np;
>> +     struct list_head node;
>> +};
>
> Can't we just add a flags bit in device_node.flags? That would be much
> simpler.

Yes, much simpler.  Such as:

#define OF_OVERLAY_ENABLED     5 /* allow DT overlay targeting this node */

>
>> +
>> +int of_add_whitelist_node(struct device_node *np)
>> +{
>> +     unsigned long flags;
>> +     struct dt_overlay_whitelist *wln;
>> +
>> +     wln = kzalloc(sizeof(*wln), GFP_KERNEL);
>> +     if (!wln)
>> +             return -ENOMEM;
>> +
>> +     wln->np = np;
>> +
>> +     spin_lock_irqsave(&whitelist_lock, flags);
>> +     list_add(&wln->node, &whitelist_list);
>> +     spin_unlock_irqrestore(&whitelist_lock, flags);
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(of_add_whitelist_node);
>> +
>> +void of_remove_whitelist_node(struct device_node *np)
>> +{
>> +     struct dt_overlay_whitelist *wln;
>> +     unsigned long flags;
>> +
>> +     list_for_each_entry(wln, &whitelist_list, node) {
>> +             if (np == wln->np) {
>> +                     spin_lock_irqsave(&whitelist_lock, flags);
>> +                     list_del(&wln->node);
>> +                     spin_unlock_irqrestore(&whitelist_lock, flags);
>> +                     kfree(wln);
>> +                     return;
>> +             }
>> +     }
>> +}
>> +EXPORT_SYMBOL_GPL(of_remove_whitelist_node);
>> +
>> +static int of_check_whitelist(struct overlay_changeset *ovcs)
>> +{
>> +     struct dt_overlay_whitelist *wln;
>> +     struct device_node *target;
>> +     int i;
>> +
>> +     for (i = 0; i < ovcs->count; i++) {
>> +             target = ovcs->fragments[i].target;
>> +             if (!of_node_cmp(target->name, "__symbols__"))
>> +                     continue;
>> +
>> +             list_for_each_entry(wln, &whitelist_list, node)
>> +                     if (target == wln->np)
>> +                             break;
>> +
>> +             if (target != wln->np)
>> +                     return -ENODEV;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>>  /**
>>   * of_overlay_apply() - Create and apply an overlay changeset
>>   * @tree:    Expanded overlay device tree
>> @@ -717,6 +786,10 @@ int of_overlay_apply(struct device_node *tree, int *ovcs_id)
>>       if (ret)
>>               goto err_free_overlay_changeset;
>>
>> +     ret = of_check_whitelist(ovcs);
>> +     if (ret)
>> +             goto err_free_overlay_changeset;
>
> This will break you until the next patch and breaks any other users. I
> think this is now just the unittest as tilcdc overlay is getting
> removed.
>
> You have to make this chunk the last patch in the series.

I'd rather squash the two patches.  In either case, the contents of
second patch are dependent on stuff in char-misc-testing today, so it
won't be able to apply yet on linux-next or anywhere else.

Thanks
Alan

>
> Rob
