Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170918175927.GA3429@tyrael.ni.corp.natinst.com>
References: <20170913204841.2730-1-atull@kernel.org> <20170913204841.2730-2-atull@kernel.org>
 <20170918175927.GA3429@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 18 Sep 2017 15:53:21 -0500
Message-ID: <CANk1AXSGWkSYnFK3sbJTah1-B=Q8+RZe-7DM7JbbVMkJb=B3aQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/18] fpga: bridge: support getting bridge from device
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Sep 18, 2017 at 12:59 PM, Moritz Fischer <mdf@kernel.org> wrote:
> On Wed, Sep 13, 2017 at 03:48:24PM -0500, Alan Tull wrote:
>> Add two functions for getting the FPGA bridge from the device
>> rather than device tree node.  This is to enable writing code
>> that will support using FPGA bridges without device tree.
>> Rename one old function to make it clear that it is device
>> tree-ish.  This leaves us with 3 functions for getting a bridge:
>>
>> * fpga_bridge_get
>>   Get the bridge given the device.
>>
>> * fpga_bridges_get_to_list
>>   Given the device, get the bridge and add it to a list.
>>
>> * of_fpga_bridges_get_to_list
>>   Renamed from priviously existing fpga_bridges_get_to_list.
>>   Given the device node, get the bridge and add it to a list.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> ---
>> v2: use list_for_each_entry
>>     static the bridge_list_lock
>>     update copyright and author email
>> v3: no change to this patch in this version of patchset
>> v4: no change to this patch in this version of patchset
>> ---
>>  drivers/fpga/fpga-bridge.c       | 110 +++++++++++++++++++++++++++++++--------
>>  drivers/fpga/fpga-region.c       |  11 ++--
>>  include/linux/fpga/fpga-bridge.h |   7 ++-
>>  3 files changed, 100 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
>> index fcd2bd3..af6d97e 100644
>> --- a/drivers/fpga/fpga-bridge.c
>> +++ b/drivers/fpga/fpga-bridge.c
>> @@ -2,6 +2,7 @@
>>   * FPGA Bridge Framework Driver
>>   *
>>   *  Copyright (C) 2013-2016 Altera Corporation, All Rights Reserved.
>> + *  Copyright (C) 2017 Intel Corporation
>>   *
>>   * This program is free software; you can redistribute it and/or modify it
>>   * under the terms and conditions of the GNU General Public License,
>> @@ -70,29 +71,12 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_bridge_disable);
>>
>> -/**
>> - * of_fpga_bridge_get - get an exclusive reference to a fpga bridge
>> - *
>> - * @np: node pointer of a FPGA bridge
>> - * @info: fpga image specific information
>> - *
>> - * Return fpga_bridge struct if successful.
>> - * Return -EBUSY if someone already has a reference to the bridge.
>> - * Return -ENODEV if @np is not a FPGA Bridge.
>> - */
>> -struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
>> -                                    struct fpga_image_info *info)
>> -
>> +struct fpga_bridge *__fpga_bridge_get(struct device *dev,
>> +                                   struct fpga_image_info *info)
>>  {
>> -     struct device *dev;
>>       struct fpga_bridge *bridge;
>>       int ret = -ENODEV;
>>
>> -     dev = class_find_device(fpga_bridge_class, NULL, np,
>> -                             fpga_bridge_of_node_match);
>> -     if (!dev)
>> -             goto err_dev;
>> -
>>       bridge = to_fpga_bridge(dev);
>>       if (!bridge)
>>               goto err_dev;
>> @@ -117,8 +101,58 @@ struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
>>       put_device(dev);
>>       return ERR_PTR(ret);
>>  }
>> +
>> +/**
>> + * of_fpga_bridge_get - get an exclusive reference to a fpga bridge
>> + *
>> + * @np: node pointer of a FPGA bridge
>> + * @info: fpga image specific information
>> + *
>> + * Return fpga_bridge struct if successful.
>> + * Return -EBUSY if someone already has a reference to the bridge.
>> + * Return -ENODEV if @np is not a FPGA Bridge.
>> + */
>> +struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
>> +                                    struct fpga_image_info *info)
>> +{
>> +     struct device *dev;
>> +
>> +     dev = class_find_device(fpga_bridge_class, NULL, np,
>> +                             fpga_bridge_of_node_match);
>> +     if (!dev)
>> +             return ERR_PTR(-ENODEV);
>> +
>> +     return __fpga_bridge_get(dev, info);
>> +}
>>  EXPORT_SYMBOL_GPL(of_fpga_bridge_get);
>>
>> +static int fpga_bridge_dev_match(struct device *dev, const void *data)
>> +{
>> +     return dev->parent == data;
>> +}
>> +
>> +/**
>> + * fpga_bridge_get - get an exclusive reference to a fpga bridge
>> + * @dev:     parent device that fpga bridge was registered with
>> + *
>> + * Given a device, get an exclusive reference to a fpga bridge.
>> + *
>> + * Return: fpga manager struct or IS_ERR() condition containing error code.
>> + */
>> +struct fpga_bridge *fpga_bridge_get(struct device *dev,
>> +                                 struct fpga_image_info *info)
>> +{
>> +     struct device *bridge_dev;
>> +
>> +     bridge_dev = class_find_device(fpga_bridge_class, NULL, dev,
>> +                                    fpga_bridge_dev_match);
>> +     if (!bridge_dev)
>> +             return ERR_PTR(-ENODEV);
>> +
>> +     return __fpga_bridge_get(bridge_dev, info);
>> +}
>> +EXPORT_SYMBOL_GPL(fpga_bridge_get);
>> +
>>  /**
>>   * fpga_bridge_put - release a reference to a bridge
>>   *
>> @@ -206,7 +240,7 @@ void fpga_bridges_put(struct list_head *bridge_list)
>>  EXPORT_SYMBOL_GPL(fpga_bridges_put);
>>
>>  /**
>> - * fpga_bridges_get_to_list - get a bridge, add it to a list
>> + * of_fpga_bridge_get_to_list - get a bridge, add it to a list
>>   *
>>   * @np: node pointer of a FPGA bridge
>>   * @info: fpga image specific information
>> @@ -216,14 +250,44 @@ EXPORT_SYMBOL_GPL(fpga_bridges_put);
>>   *
>>   * Return 0 for success, error code from of_fpga_bridge_get() othewise.
>>   */
>> -int fpga_bridge_get_to_list(struct device_node *np,
>> +int of_fpga_bridge_get_to_list(struct device_node *np,
>> +                            struct fpga_image_info *info,
>> +                            struct list_head *bridge_list)
>> +{
>> +     struct fpga_bridge *bridge;
>> +     unsigned long flags;
>> +
>> +     bridge = of_fpga_bridge_get(np, info);
>> +     if (IS_ERR(bridge))
>> +             return PTR_ERR(bridge);
>> +
>> +     spin_lock_irqsave(&bridge_list_lock, flags);
>> +     list_add(&bridge->node, bridge_list);
>> +     spin_unlock_irqrestore(&bridge_list_lock, flags);
>
> I know this is not new code, but I was wondering the other day:
>
> Why are we using a single spinlock to protect all lists that are being
> passed in as parameters here?
>
> I have a patch that moves the spinlock into the region containing the
> list that uses the bridges which (unless I misunderstand something
> here), makes more sense:
>
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 9651aa56244a..b03ec59448e2 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -214,6 +214,8 @@ EXPORT_SYMBOL_GPL(fpga_bridges_put);
>   *
>   * Get an exclusive reference to the bridge and and it to the list.
>   *
> + * Must be called with list lock held.
> + *
>   * Return 0 for success, error code from of_fpga_bridge_get() othewise.
>   */
>  int fpga_bridge_get_to_list(struct device_node *np,
> @@ -221,15 +223,12 @@ int fpga_bridge_get_to_list(struct device_node *np,
>                             struct list_head *bridge_list)
>  {
>         struct fpga_bridge *bridge;
> -       unsigned long flags;
>
>         bridge = of_fpga_bridge_get(np, info);
>         if (IS_ERR(bridge))
>                 return PTR_ERR(bridge);
>
> -       spin_lock_irqsave(&bridge_list_lock, flags);
>         list_add(&bridge->node, bridge_list);
> -       spin_unlock_irqrestore(&bridge_list_lock, flags);
>
>         return 0;
>  }
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index 3b6b2f4182a1..c5c958e0e601 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -37,6 +37,7 @@ struct fpga_region {
>         struct device dev;
>         struct mutex mutex; /* for exclusive reference to region */
>         struct list_head bridge_list;
> +       spinlock_t bridge_list_lock; /* protects access to bridge list */
>         struct fpga_image_info *info;
>  };
>
> @@ -180,11 +181,15 @@ static int fpga_region_get_bridges(struct fpga_region *region,
>         struct device *dev = &region->dev;
>         struct device_node *region_np = dev->of_node;
>         struct device_node *br, *np, *parent_br = NULL;
> +       unsigned long flags;
>         int i, ret;
>
>         /* If parent is a bridge, add to list */
> +       spin_lock_irqsave(&region->bridge_list_lock, flags);
>         ret = fpga_bridge_get_to_list(region_np->parent, region->info,
>                                       &region->bridge_list);
> +       spin_unlock_irqrestore(&region->bridge_list_lock, flags);
> +
>         if (ret == -EBUSY)
>                 return ret;
>
> @@ -508,6 +513,7 @@ static int fpga_region_probe(struct platform_device *pdev)
>
>         mutex_init(&region->mutex);
>         INIT_LIST_HEAD(&region->bridge_list);
> +       spin_lock_init(&region->bridge_list_lock);
>
>         device_initialize(&region->dev);
>         region->dev.class = fpga_region_class;
>
> Am I missing something here? If not I"ll send out my patch separately.

Hi Moritz,

You are right!  I'll look at your patch.

Alan

>
>
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(of_fpga_bridge_get_to_list);
>> +
>> +/**
>> + * fpga_bridge_get_to_list - given device, get a bridge, add it to a list
>> + *
>> + * @dev: FPGA bridge device
>> + * @info: fpga image specific information
>> + * @bridge_list: list of FPGA bridges
>> + *
>> + * Get an exclusive reference to the bridge and and it to the list.
>> + *
>> + * Return 0 for success, error code from fpga_bridge_get() othewise.
>> + */
>> +int fpga_bridge_get_to_list(struct device *dev,
>>                           struct fpga_image_info *info,
>>                           struct list_head *bridge_list)
>>  {
>>       struct fpga_bridge *bridge;
>>       unsigned long flags;
>>
>> -     bridge = of_fpga_bridge_get(np, info);
>> +     bridge = fpga_bridge_get(dev, info);
>>       if (IS_ERR(bridge))
>>               return PTR_ERR(bridge);
>>
>> @@ -381,7 +445,7 @@ static void __exit fpga_bridge_dev_exit(void)
>>  }
>>
>>  MODULE_DESCRIPTION("FPGA Bridge Driver");
>> -MODULE_AUTHOR("Alan Tull <atull@opensource.altera.com>");
>> +MODULE_AUTHOR("Alan Tull <atull@kernel.org>");
>>  MODULE_LICENSE("GPL v2");
>>
>>  subsys_initcall(fpga_bridge_dev_init);
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index d9ab7c7..91755562 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -183,11 +183,14 @@ static int fpga_region_get_bridges(struct fpga_region *region,
>>       int i, ret;
>>
>>       /* If parent is a bridge, add to list */
>> -     ret = fpga_bridge_get_to_list(region_np->parent, region->info,
>> -                                   &region->bridge_list);
>> +     ret = of_fpga_bridge_get_to_list(region_np->parent, region->info,
>> +                                      &region->bridge_list);
>> +
>> +     /* -EBUSY means parent is a bridge that is under use. Give up. */
>>       if (ret == -EBUSY)
>>               return ret;
>>
>> +     /* Zero return code means parent was a bridge and was added to list. */
>>       if (!ret)
>>               parent_br = region_np->parent;
>>
>> @@ -207,8 +210,8 @@ static int fpga_region_get_bridges(struct fpga_region *region,
>>                       continue;
>>
>>               /* If node is a bridge, get it and add to list */
>> -             ret = fpga_bridge_get_to_list(br, region->info,
>> -                                           &region->bridge_list);
>> +             ret = of_fpga_bridge_get_to_list(br, region->info,
>> +                                              &region->bridge_list);
>>
>>               /* If any of the bridges are in use, give up */
>>               if (ret == -EBUSY) {
>> diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
>> index dba6e3c..9f6696b 100644
>> --- a/include/linux/fpga/fpga-bridge.h
>> +++ b/include/linux/fpga/fpga-bridge.h
>> @@ -42,6 +42,8 @@ struct fpga_bridge {
>>
>>  struct fpga_bridge *of_fpga_bridge_get(struct device_node *node,
>>                                      struct fpga_image_info *info);
>> +struct fpga_bridge *fpga_bridge_get(struct device *dev,
>> +                                 struct fpga_image_info *info);
>>  void fpga_bridge_put(struct fpga_bridge *bridge);
>>  int fpga_bridge_enable(struct fpga_bridge *bridge);
>>  int fpga_bridge_disable(struct fpga_bridge *bridge);
>> @@ -49,9 +51,12 @@ int fpga_bridge_disable(struct fpga_bridge *bridge);
>>  int fpga_bridges_enable(struct list_head *bridge_list);
>>  int fpga_bridges_disable(struct list_head *bridge_list);
>>  void fpga_bridges_put(struct list_head *bridge_list);
>> -int fpga_bridge_get_to_list(struct device_node *np,
>> +int fpga_bridge_get_to_list(struct device *dev,
>>                           struct fpga_image_info *info,
>>                           struct list_head *bridge_list);
>> +int of_fpga_bridge_get_to_list(struct device_node *np,
>> +                            struct fpga_image_info *info,
>> +                            struct list_head *bridge_list);
>>
>>  int fpga_bridge_register(struct device *dev, const char *name,
>>                        const struct fpga_bridge_ops *br_ops, void *priv);
>> --
>> 2.7.4
>>
> Thanks,
>
> Moritz
