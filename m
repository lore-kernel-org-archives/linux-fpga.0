Return-Path: <SRS0=kXu+=GR=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=kXu+=GR=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33339 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeC0UKV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Mar 2018 16:10:21 -0400
Received: by mail-io0-f195.google.com with SMTP id l3so785672iog.0
        for <linux-fpga@vger.kernel.org>; Tue, 27 Mar 2018 13:10:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180327195957.3878-4-atull@kernel.org>
References: <20180327195957.3878-1-atull@kernel.org> <20180327195957.3878-4-atull@kernel.org>
From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Tue, 27 Mar 2018 13:10:20 -0700
Message-ID: <CAAtXAHeW50R2Mu+4+qUv0fZh5=CxJ5oiS71H_o6nGu6mpxVqwA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 3/4] fpga: bridge: don't use drvdata in common
 fpga code
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Anatolij Gustschin <agust@denx.de>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, Joel Holdsworth <joel@airwebreathe.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Joshua Clayton <stillcompiling@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org

On Tue, Mar 27, 2018 at 12:59 PM, Alan Tull <atull@kernel.org> wrote:
> Change fpga_bridge_register to not set drvdata.
>
> Change the register/unregister functions parameters to take the
> bridge struct:
> * int fpga_bridge_register(struct fpga_bridge *bridge);
> * void fpga_bridge_unregister(struct fpga_bridge *bridge);
>
> Change the drivers that call fpga_bridge_register to alloc the struct
> fpga_bridge (using devm_kzalloc) and partly fill it, adding name,
> ops, parent device, and priv.
>
> The rationale is that setting drvdata is fine for DT based devices
> that will have one manager, bridge, or region per platform device.
> However PCIe based devices may have multiple FPGA mgr/bridge/regions
> under one pcie device.  Without these changes, the PCIe solution has
> to create an extra device for each child mgr/bridge/region to hold
> drvdata.
>
> Signed-off-by: Alan Tull <atull@kernel.org>
> Reported-by: Jiuyue Ma <majiuyue@huawei.com>
Acked-by: Moritz Fischer <mdf@kernel.org>

> ---
> v2: change fpga_bridge_register to not need parent device param
>     fix undeclared - s/dev/&pdev->dev/
> v3: minor changes to make diffs smaller and more obviously correct
> ---
>  drivers/fpga/altera-fpga2sdram.c    | 20 +++++++++++++----
>  drivers/fpga/altera-freeze-bridge.c | 18 +++++++++++++---
>  drivers/fpga/altera-hps2fpga.c      | 16 +++++++++++---
>  drivers/fpga/fpga-bridge.c          | 43 ++++++++++++++-----------------------
>  drivers/fpga/xilinx-pr-decoupler.c  | 15 ++++++++++---
>  include/linux/fpga/fpga-bridge.h    |  7 +++---
>  6 files changed, 76 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
> index d4eeb74388da..a4593c0f5e42 100644
> --- a/drivers/fpga/altera-fpga2sdram.c
> +++ b/drivers/fpga/altera-fpga2sdram.c
> @@ -106,10 +106,15 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct alt_fpga2sdram_data *priv;
> +       struct fpga_bridge *br;
>         u32 enable;
>         struct regmap *sysmgr;
>         int ret = 0;
>
> +       br = devm_kzalloc(dev, sizeof(*br), GFP_KERNEL);
> +       if (!br)
> +               return -ENOMEM;
> +
>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
> @@ -131,8 +136,13 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>         /* Get f2s bridge configuration saved in handoff register */
>         regmap_read(sysmgr, SYSMGR_ISWGRP_HANDOFF3, &priv->mask);
>
> -       ret = fpga_bridge_register(dev, F2S_BRIDGE_NAME,
> -                                  &altera_fpga2sdram_br_ops, priv);
> +       br->parent = dev;
> +       br->name = F2S_BRIDGE_NAME;
> +       br->br_ops = &altera_fpga2sdram_br_ops;
> +       br->priv = priv;
> +       platform_set_drvdata(pdev, br);
> +
> +       ret = fpga_bridge_register(br);
>         if (ret)
>                 return ret;
>
> @@ -146,7 +156,7 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>                                  (enable ? "enabling" : "disabling"));
>                         ret = _alt_fpga2sdram_enable_set(priv, enable);
>                         if (ret) {
> -                               fpga_bridge_unregister(&pdev->dev);
> +                               fpga_bridge_unregister(br);
>                                 return ret;
>                         }
>                 }
> @@ -157,7 +167,9 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>
>  static int alt_fpga_bridge_remove(struct platform_device *pdev)
>  {
> -       fpga_bridge_unregister(&pdev->dev);
> +       struct fpga_bridge *br = platform_get_drvdata(pdev);
> +
> +       fpga_bridge_unregister(br);
>
>         return 0;
>  }
> diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
> index 6159cfcf78a2..498bc6c1d533 100644
> --- a/drivers/fpga/altera-freeze-bridge.c
> +++ b/drivers/fpga/altera-freeze-bridge.c
> @@ -219,6 +219,7 @@ static int altera_freeze_br_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct device_node *np = pdev->dev.of_node;
> +       struct fpga_bridge *br;
>         void __iomem *base_addr;
>         struct altera_freeze_br_data *priv;
>         struct resource *res;
> @@ -227,6 +228,10 @@ static int altera_freeze_br_probe(struct platform_device *pdev)
>         if (!np)
>                 return -ENODEV;
>
> +       br = devm_kzalloc(dev, sizeof(*br), GFP_KERNEL);
> +       if (!br)
> +               return -ENOMEM;
> +
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         base_addr = devm_ioremap_resource(dev, res);
>         if (IS_ERR(base_addr))
> @@ -254,13 +259,20 @@ static int altera_freeze_br_probe(struct platform_device *pdev)
>
>         priv->base_addr = base_addr;
>
> -       return fpga_bridge_register(dev, FREEZE_BRIDGE_NAME,
> -                                   &altera_freeze_br_br_ops, priv);
> +       br->parent = dev;
> +       br->name = FREEZE_BRIDGE_NAME;
> +       br->br_ops = &altera_freeze_br_br_ops;
> +       br->priv = priv;
> +       platform_set_drvdata(pdev, br);
> +
> +       return fpga_bridge_register(br);
>  }
>
>  static int altera_freeze_br_remove(struct platform_device *pdev)
>  {
> -       fpga_bridge_unregister(&pdev->dev);
> +       struct fpga_bridge *br = platform_get_drvdata(pdev);
> +
> +       fpga_bridge_unregister(br);
>
>         return 0;
>  }
> diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
> index 406d2f10741f..2a695f53962d 100644
> --- a/drivers/fpga/altera-hps2fpga.c
> +++ b/drivers/fpga/altera-hps2fpga.c
> @@ -139,6 +139,7 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct altera_hps2fpga_data *priv;
>         const struct of_device_id *of_id;
> +       struct fpga_bridge *br;
>         u32 enable;
>         int ret;
>
> @@ -150,6 +151,10 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>
>         priv = (struct altera_hps2fpga_data *)of_id->data;
>
> +       br = devm_kzalloc(dev, sizeof(*br), GFP_KERNEL);
> +       if (!br)
> +               return -ENOMEM;
> +
>         priv->bridge_reset = of_reset_control_get_exclusive_by_index(dev->of_node,
>                                                                      0);
>         if (IS_ERR(priv->bridge_reset)) {
> @@ -190,8 +195,13 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>                 }
>         }
>
> -       ret = fpga_bridge_register(dev, priv->name, &altera_hps2fpga_br_ops,
> -                                  priv);
> +       br->parent = dev;
> +       br->name = priv->name;
> +       br->br_ops = &altera_hps2fpga_br_ops;
> +       br->priv = priv;
> +       platform_set_drvdata(pdev, br);
> +
> +       ret = fpga_bridge_register(br);
>  err:
>         if (ret)
>                 clk_disable_unprepare(priv->clk);
> @@ -204,7 +214,7 @@ static int alt_fpga_bridge_remove(struct platform_device *pdev)
>         struct fpga_bridge *bridge = platform_get_drvdata(pdev);
>         struct altera_hps2fpga_data *priv = bridge->priv;
>
> -       fpga_bridge_unregister(&pdev->dev);
> +       fpga_bridge_unregister(bridge);
>
>         clk_disable_unprepare(priv->clk);
>
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 31bd2c59c305..ac40e3ae8921 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -329,48 +329,42 @@ ATTRIBUTE_GROUPS(fpga_bridge);
>
>  /**
>   * fpga_bridge_register - register a fpga bridge driver
> - * @dev:       FPGA bridge device from pdev
> - * @name:      FPGA bridge name
> - * @br_ops:    pointer to structure of fpga bridge ops
> - * @priv:      FPGA bridge private data
> + * @bridge:    FPGA bridge struct
> + *
> + * The following fields must be set in the bridge struct:
> + * name, br_ops, and parent.
>   *
>   * Return: 0 for success, error code otherwise.
>   */
> -int fpga_bridge_register(struct device *dev, const char *name,
> -                        const struct fpga_bridge_ops *br_ops, void *priv)
> +int fpga_bridge_register(struct fpga_bridge *bridge)
>  {
> -       struct fpga_bridge *bridge;
> +       struct device *dev = bridge->parent;
> +       const char *name = bridge->name;
>         int id, ret = 0;
>
> +       if (!dev) {
> +               pr_err("Attempt to register fpga bridge without parent\n");
> +               return -EINVAL;
> +       }
> +
>         if (!name || !strlen(name)) {
>                 dev_err(dev, "Attempt to register with no name!\n");
>                 return -EINVAL;
>         }
>
> -       bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
> -       if (!bridge)
> -               return -ENOMEM;
> -
>         id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
> -       if (id < 0) {
> -               ret = id;
> -               goto error_kfree;
> -       }
> +       if (id < 0)
> +               return id;
>
>         mutex_init(&bridge->mutex);
>         INIT_LIST_HEAD(&bridge->node);
>
> -       bridge->name = name;
> -       bridge->br_ops = br_ops;
> -       bridge->priv = priv;
> -
>         device_initialize(&bridge->dev);
> -       bridge->dev.groups = br_ops->groups;
> +       bridge->dev.groups = bridge->br_ops->groups;
>         bridge->dev.class = fpga_bridge_class;
>         bridge->dev.parent = dev;
>         bridge->dev.of_node = dev->of_node;
>         bridge->dev.id = id;
> -       dev_set_drvdata(dev, bridge);
>
>         ret = dev_set_name(&bridge->dev, "br%d", id);
>         if (ret)
> @@ -389,8 +383,6 @@ int fpga_bridge_register(struct device *dev, const char *name,
>
>  error_device:
>         ida_simple_remove(&fpga_bridge_ida, id);
> -error_kfree:
> -       kfree(bridge);
>
>         return ret;
>  }
> @@ -400,10 +392,8 @@ EXPORT_SYMBOL_GPL(fpga_bridge_register);
>   * fpga_bridge_unregister - unregister a fpga bridge driver
>   * @dev: FPGA bridge device from pdev
>   */
> -void fpga_bridge_unregister(struct device *dev)
> +void fpga_bridge_unregister(struct fpga_bridge *bridge)
>  {
> -       struct fpga_bridge *bridge = dev_get_drvdata(dev);
> -
>         /*
>          * If the low level driver provides a method for putting bridge into
>          * a desired state upon unregister, do it.
> @@ -420,7 +410,6 @@ static void fpga_bridge_dev_release(struct device *dev)
>         struct fpga_bridge *bridge = to_fpga_bridge(dev);
>
>         ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
> -       kfree(bridge);
>  }
>
>  static int __init fpga_bridge_dev_init(void)
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index 0d7743089414..629337bd3768 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -94,9 +94,14 @@ MODULE_DEVICE_TABLE(of, xlnx_pr_decoupler_of_match);
>  static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>  {
>         struct xlnx_pr_decoupler_data *priv;
> +       struct fpga_bridge *br;
>         int err;
>         struct resource *res;
>
> +       br = devm_kzalloc(&pdev->dev, sizeof(*br), GFP_KERNEL);
> +       if (!br)
> +               return -ENOMEM;
> +
>         priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
> @@ -120,9 +125,13 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>
>         clk_disable(priv->clk);
>
> -       err = fpga_bridge_register(&pdev->dev, "Xilinx PR Decoupler",
> -                                  &xlnx_pr_decoupler_br_ops, priv);
> +       br->parent = &pdev->dev;
> +       br->name = "Xilinx PR Decoupler";
> +       br->br_ops = &xlnx_pr_decoupler_br_ops;
> +       br->priv = priv;
> +       platform_set_drvdata(pdev, br);
>
> +       err = fpga_bridge_register(br);
>         if (err) {
>                 dev_err(&pdev->dev, "unable to register Xilinx PR Decoupler");
>                 clk_unprepare(priv->clk);
> @@ -137,7 +146,7 @@ static int xlnx_pr_decoupler_remove(struct platform_device *pdev)
>         struct fpga_bridge *bridge = platform_get_drvdata(pdev);
>         struct xlnx_pr_decoupler_data *p = bridge->priv;
>
> -       fpga_bridge_unregister(&pdev->dev);
> +       fpga_bridge_unregister(bridge);
>
>         clk_unprepare(p->clk);
>
> diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
> index 3694821a6d2d..c46b7ac0a4bd 100644
> --- a/include/linux/fpga/fpga-bridge.h
> +++ b/include/linux/fpga/fpga-bridge.h
> @@ -26,6 +26,7 @@ struct fpga_bridge_ops {
>   * struct fpga_bridge - FPGA bridge structure
>   * @name: name of low level FPGA bridge
>   * @dev: FPGA bridge device
> + * @parent: parent device
>   * @mutex: enforces exclusive reference to bridge
>   * @br_ops: pointer to struct of FPGA bridge ops
>   * @info: fpga image specific information
> @@ -35,6 +36,7 @@ struct fpga_bridge_ops {
>  struct fpga_bridge {
>         const char *name;
>         struct device dev;
> +       struct device *parent;
>         struct mutex mutex; /* for exclusive reference to bridge */
>         const struct fpga_bridge_ops *br_ops;
>         struct fpga_image_info *info;
> @@ -62,8 +64,7 @@ int of_fpga_bridge_get_to_list(struct device_node *np,
>                                struct fpga_image_info *info,
>                                struct list_head *bridge_list);
>
> -int fpga_bridge_register(struct device *dev, const char *name,
> -                        const struct fpga_bridge_ops *br_ops, void *priv);
> -void fpga_bridge_unregister(struct device *dev);
> +int fpga_bridge_register(struct fpga_bridge *br);
> +void fpga_bridge_unregister(struct fpga_bridge *br);
>
>  #endif /* _LINUX_FPGA_BRIDGE_H */
> --
> 2.14.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Moritz
