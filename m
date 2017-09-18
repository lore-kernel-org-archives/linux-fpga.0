Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170918203404.17502-1-mdf@kernel.org>
References: <20170918203404.17502-1-mdf@kernel.org>
From: Alan Tull <atull@kernel.org>
Date: Mon, 18 Sep 2017 16:00:47 -0500
Message-ID: <CANk1AXSGXfJ6Jicfw6ho3SJC6kQSye3z1kE8HJZZz9wq+X0e7Q@mail.gmail.com>
Subject: Re: [RFC] fpga: region: Move spinlock for bridge_list into region
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Sep 18, 2017 at 3:34 PM, Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

> Instead of using a single (global) spinlock for all bridge lists use a
> spinlock per list inside the containing fpga region.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>
> Hi all,
>
> maybe I do misunderstand something fundamental here ;-) In that case,
> please explain. In my understanding the current version works, because
> it is more defensive, but is there a reason we need to make access to
> any of the bridge lists exclusive?

I think you are basically right here.  Moving the spinlock to the
region is correct.  When you do your final version of this, could you
just have it apply on top of this current patchset?  That will save me
a lot of rebasing.

Alan

>
> Cheers,
> Moritz
>
> PS: Not fully happy with this patch, but wanted to figure out first if
> this I'm wrong conceptually
>
> ---
>  drivers/fpga/fpga-bridge.c | 5 ++---
>  drivers/fpga/fpga-region.c | 6 ++++++
>  2 files changed, 8 insertions(+), 3 deletions(-)
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
> --
> 2.14.1
>
