Return-Path: <SRS0=kXu+=GR=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=kXu+=GR=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:37645 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeC0ULa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Mar 2018 16:11:30 -0400
Received: by mail-io0-f196.google.com with SMTP id y128so770550iod.4
        for <linux-fpga@vger.kernel.org>; Tue, 27 Mar 2018 13:11:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180327195957.3878-3-atull@kernel.org>
References: <20180327195957.3878-1-atull@kernel.org> <20180327195957.3878-3-atull@kernel.org>
From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Tue, 27 Mar 2018 13:11:27 -0700
Message-ID: <CAAtXAHeo_CGLqUPF=QfXojX2ZM0OJJ79PvrK6pmgn190zs0dLA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/4] fpga: manager: don't use drvdata in common
 fpga code
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Anatolij Gustschin <agust@denx.de>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, Joel Holdsworth <joel@airwebreathe.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Joshua Clayton <stillcompiling@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org

On Tue, Mar 27, 2018 at 12:59 PM, Alan Tull <atull@kernel.org> wrote:
> Change fpga_mgr_register to not set or use drvdata.
>
> Change the register/unregister function parameters to take the mgr
> struct:
> * int fpga_mgr_register(struct fpga_manager *mgr);
> * void fpga_mgr_unregister(struct fpga_manager *mgr);
>
> Change the drivers that call fpga_mgr_register to alloc the struct
> fpga_manager (using devm_kzalloc) and partly fill it, adding name,
> ops, parent device, and priv.
>
> The rationale is that setting drvdata is fine for DT based devices
> that will have one manager, bridge, or region per platform device.
> However PCIe based devices may have multiple FPGA mgr/bridge/regions
> under one PCIe device.  Without these changes, the PCIe solution has
> to create an extra device for each child mgr/bridge/region to hold
> drvdata.
>
> Signed-off-by: Alan Tull <atull@kernel.org>
> Reported-by: Jiuyue Ma <majiuyue@huawei.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: change fpga_mgr_register to not need parent device param
> v3: minor changes to make diffs smaller and more obviously correct
>     rebased to current next branch
> ---
>  Documentation/fpga/fpga-mgr.txt  | 24 +++++++++++++++++-------
>  drivers/fpga/altera-cvp.c        | 18 ++++++++++++++----
>  drivers/fpga/altera-pr-ip-core.c | 17 +++++++++++++++--
>  drivers/fpga/altera-ps-spi.c     | 18 +++++++++++++++---
>  drivers/fpga/fpga-mgr.c          | 39 ++++++++++++++-------------------------
>  drivers/fpga/ice40-spi.c         | 20 ++++++++++++++++----
>  drivers/fpga/socfpga-a10.c       | 16 +++++++++++++---
>  drivers/fpga/socfpga.c           | 18 +++++++++++++++---
>  drivers/fpga/ts73xx-fpga.c       | 18 +++++++++++++++---
>  drivers/fpga/xilinx-spi.c        | 18 +++++++++++++++---
>  drivers/fpga/zynq-fpga.c         | 16 +++++++++++++---
>  include/linux/fpga/fpga-mgr.h    |  8 ++++----
>  12 files changed, 166 insertions(+), 64 deletions(-)
>
> diff --git a/Documentation/fpga/fpga-mgr.txt b/Documentation/fpga/fpga-mgr.txt
> index cc6413ed6fc9..3cea6b57c156 100644
> --- a/Documentation/fpga/fpga-mgr.txt
> +++ b/Documentation/fpga/fpga-mgr.txt
> @@ -67,11 +67,9 @@ fpga_mgr_unlock when done programming the FPGA.
>  To register or unregister the low level FPGA-specific driver:
>  -------------------------------------------------------------
>
> -       int fpga_mgr_register(struct device *dev, const char *name,
> -                             const struct fpga_manager_ops *mops,
> -                             void *priv);
> +       int fpga_mgr_register(struct fpga_manager *mgr);
>
> -       void fpga_mgr_unregister(struct device *dev);
> +       void fpga_mgr_unregister(struct fpga_manager *mgr);
>
>  Use of these two functions is described below in "How To Support a new FPGA
>  device."
> @@ -148,8 +146,13 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct socfpga_fpga_priv *priv;
> +       struct fpga_manager *mgr;
>         int ret;
>
> +       mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
> +       if (!mgr)
> +               return -ENOMEM;
> +
>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
> @@ -157,13 +160,20 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>         /* ... do ioremaps, get interrupts, etc. and save
>            them in priv... */
>
> -       return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
> -                                &socfpga_fpga_ops, priv);
> +       mgr->parent = dev;
> +       mgr->name = "Altera SOCFPGA FPGA Manager";
> +       mgr->mops = &socfpga_fpga_ops;
> +       mgr->priv = priv;
> +       platform_set_drvdata(pdev, mgr);
> +
> +       return fpga_mgr_register(mgr);
>  }
>
>  static int socfpga_fpga_remove(struct platform_device *pdev)
>  {
> -       fpga_mgr_unregister(&pdev->dev);
> +       struct fpga_manager *mgr = platform_get_drvdata(pdev);
> +
> +       fpga_mgr_unregister(mgr);
>
>         return 0;
>  }
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 77b04e4b3254..6bbfc4fb95ee 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -401,6 +401,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>                             const struct pci_device_id *dev_id)
>  {
>         struct altera_cvp_conf *conf;
> +       struct fpga_manager *mgr;
>         u16 cmd, val;
>         int ret;
>
> @@ -419,6 +420,10 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>         if (!conf)
>                 return -ENOMEM;
>
> +       mgr = devm_kzalloc(&pdev->dev, sizeof(*mgr), GFP_KERNEL);
> +       if (!mgr)
> +               return -ENOMEM;
> +
>         /*
>          * Enable memory BAR access. We cannot use pci_enable_device() here
>          * because it will make the driver unusable with FPGA devices that
> @@ -452,8 +457,13 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>         snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
>                  ALTERA_CVP_MGR_NAME, pci_name(pdev));
>
> -       ret = fpga_mgr_register(&pdev->dev, conf->mgr_name,
> -                               &altera_cvp_ops, conf);
> +       mgr->parent = &pdev->dev;
> +       mgr->name = conf->mgr_name;
> +       mgr->mops = &altera_cvp_ops;
> +       mgr->priv = conf;
> +       pci_set_drvdata(pdev, mgr);
> +
> +       ret = fpga_mgr_register(mgr);
>         if (ret)
>                 goto err_unmap;
>
> @@ -461,7 +471,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>                                  &driver_attr_chkcfg);
>         if (ret) {
>                 dev_err(&pdev->dev, "Can't create sysfs chkcfg file\n");
> -               fpga_mgr_unregister(&pdev->dev);
> +               fpga_mgr_unregister(mgr);
>                 goto err_unmap;
>         }
>
> @@ -483,7 +493,7 @@ static void altera_cvp_remove(struct pci_dev *pdev)
>         u16 cmd;
>
>         driver_remove_file(&altera_cvp_driver.driver, &driver_attr_chkcfg);
> -       fpga_mgr_unregister(&pdev->dev);
> +       fpga_mgr_unregister(mgr);
>         pci_iounmap(pdev, conf->map);
>         pci_release_region(pdev, CVP_BAR);
>         pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> index a7b31f9797ce..9d60cdc39c55 100644
> --- a/drivers/fpga/altera-pr-ip-core.c
> +++ b/drivers/fpga/altera-pr-ip-core.c
> @@ -187,8 +187,13 @@ static const struct fpga_manager_ops alt_pr_ops = {
>  int alt_pr_register(struct device *dev, void __iomem *reg_base)
>  {
>         struct alt_pr_priv *priv;
> +       struct fpga_manager *mgr;
>         u32 val;
>
> +       mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
> +       if (!mgr)
> +               return -ENOMEM;
> +
>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
> @@ -201,15 +206,23 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
>                 (val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
>                 (int)(val & ALT_PR_CSR_PR_START));
>
> -       return fpga_mgr_register(dev, dev_name(dev), &alt_pr_ops, priv);
> +       mgr->parent = dev;
> +       mgr->name = dev_name(dev);
> +       mgr->mops = &alt_pr_ops;
> +       mgr->priv = priv;
> +       dev_set_drvdata(dev, mgr);
> +
> +       return fpga_mgr_register(mgr);
>  }
>  EXPORT_SYMBOL_GPL(alt_pr_register);
>
>  int alt_pr_unregister(struct device *dev)
>  {
> +       struct fpga_manager *mgr = dev_get_drvdata(dev);
> +
>         dev_dbg(dev, "%s\n", __func__);
>
> -       fpga_mgr_unregister(dev);
> +       fpga_mgr_unregister(mgr);
>
>         return 0;
>  }
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index 14f14efdf0d5..b061408bf0ae 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -238,6 +238,11 @@ static int altera_ps_probe(struct spi_device *spi)
>  {
>         struct altera_ps_conf *conf;
>         const struct of_device_id *of_id;
> +       struct fpga_manager *mgr;
> +
> +       mgr = devm_kzalloc(&spi->dev, sizeof(*mgr), GFP_KERNEL);
> +       if (!mgr)
> +               return -ENOMEM;
>
>         conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
>         if (!conf)
> @@ -273,13 +278,20 @@ static int altera_ps_probe(struct spi_device *spi)
>         snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
>                  dev_driver_string(&spi->dev), dev_name(&spi->dev));
>
> -       return fpga_mgr_register(&spi->dev, conf->mgr_name,
> -                                &altera_ps_ops, conf);
> +       mgr->parent = &spi->dev;
> +       mgr->name = conf->mgr_name;
> +       mgr->mops = &altera_ps_ops;
> +       mgr->priv = conf;
> +       spi_set_drvdata(spi, mgr);
> +
> +       return fpga_mgr_register(mgr);
>  }
>
>  static int altera_ps_remove(struct spi_device *spi)
>  {
> -       fpga_mgr_unregister(&spi->dev);
> +       struct fpga_manager *mgr = spi_get_drvdata(spi);
> +
> +       fpga_mgr_unregister(mgr);
>
>         return 0;
>  }
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 9939d2cbc9a6..245e7a6efb6a 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -516,20 +516,24 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>
>  /**
>   * fpga_mgr_register - register a low level fpga manager driver
> - * @dev:       fpga manager device from pdev
> - * @name:      fpga manager name
> - * @mops:      pointer to structure of fpga manager ops
> - * @priv:      fpga manager private data
> + * @mgr:       fpga manager struct
> + *
> + * The following fields of mgr must be set: name, mops, and parent.
>   *
>   * Return: 0 on success, negative error code otherwise.
>   */
> -int fpga_mgr_register(struct device *dev, const char *name,
> -                     const struct fpga_manager_ops *mops,
> -                     void *priv)
> +int fpga_mgr_register(struct fpga_manager *mgr)
>  {
> -       struct fpga_manager *mgr;
> +       struct device *dev = mgr->parent;
> +       const struct fpga_manager_ops *mops = mgr->mops;
> +       const char *name = mgr->name;
>         int id, ret;
>
> +       if (!dev) {
> +               pr_err("Attempt to register fpga manager without parent\n");
> +               return -EINVAL;
> +       }
> +
>         if (!mops || !mops->write_complete || !mops->state ||
>             !mops->write_init || (!mops->write && !mops->write_sg) ||
>             (mops->write && mops->write_sg)) {
> @@ -542,22 +546,13 @@ int fpga_mgr_register(struct device *dev, const char *name,
>                 return -EINVAL;
>         }
>
> -       mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
> -       if (!mgr)
> -               return -ENOMEM;
> -
>         id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
>         if (id < 0) {
> -               ret = id;
> -               goto error_kfree;
> +               return id;
>         }
>
>         mutex_init(&mgr->ref_mutex);
>
> -       mgr->name = name;
> -       mgr->mops = mops;
> -       mgr->priv = priv;
> -
>         /*
>          * Initialize framework state by requesting low level driver read state
>          * from device.  FPGA may be in reset mode or may have been programmed
> @@ -571,7 +566,6 @@ int fpga_mgr_register(struct device *dev, const char *name,
>         mgr->dev.parent = dev;
>         mgr->dev.of_node = dev->of_node;
>         mgr->dev.id = id;
> -       dev_set_drvdata(dev, mgr);
>
>         ret = dev_set_name(&mgr->dev, "fpga%d", id);
>         if (ret)
> @@ -587,8 +581,6 @@ int fpga_mgr_register(struct device *dev, const char *name,
>
>  error_device:
>         ida_simple_remove(&fpga_mgr_ida, id);
> -error_kfree:
> -       kfree(mgr);
>
>         return ret;
>  }
> @@ -598,10 +590,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register);
>   * fpga_mgr_unregister - unregister a low level fpga manager driver
>   * @dev:       fpga manager device from pdev
>   */
> -void fpga_mgr_unregister(struct device *dev)
> +void fpga_mgr_unregister(struct fpga_manager *mgr)
>  {
> -       struct fpga_manager *mgr = dev_get_drvdata(dev);
> -
>         dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
>
>         /*
> @@ -620,7 +610,6 @@ static void fpga_mgr_dev_release(struct device *dev)
>         struct fpga_manager *mgr = to_fpga_manager(dev);
>
>         ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> -       kfree(mgr);
>  }
>
>  static int __init fpga_mgr_class_init(void)
> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
> index 7fca82023062..912746735c71 100644
> --- a/drivers/fpga/ice40-spi.c
> +++ b/drivers/fpga/ice40-spi.c
> @@ -133,8 +133,13 @@ static int ice40_fpga_probe(struct spi_device *spi)
>  {
>         struct device *dev = &spi->dev;
>         struct ice40_fpga_priv *priv;
> +       struct fpga_manager *mgr;
>         int ret;
>
> +       mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
> +       if (!mgr)
> +               return -ENOMEM;
> +
>         priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
> @@ -174,14 +179,21 @@ static int ice40_fpga_probe(struct spi_device *spi)
>                 return ret;
>         }
>
> -       /* Register with the FPGA manager */
> -       return fpga_mgr_register(dev, "Lattice iCE40 FPGA Manager",
> -                                &ice40_fpga_ops, priv);
> +       mgr->parent = dev;
> +       mgr->name = "Lattice iCE40 FPGA Manager";
> +       mgr->mops = &ice40_fpga_ops;
> +       mgr->priv = priv;
> +       spi_set_drvdata(spi, mgr);
> +
> +       return fpga_mgr_register(mgr);
>  }
>
>  static int ice40_fpga_remove(struct spi_device *spi)
>  {
> -       fpga_mgr_unregister(&spi->dev);
> +       struct fpga_manager *mgr = spi_get_drvdata(spi);
> +
> +       fpga_mgr_unregister(mgr);
> +
>         return 0;
>  }
>
> diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
> index a46e343a5b72..16f642a5e40e 100644
> --- a/drivers/fpga/socfpga-a10.c
> +++ b/drivers/fpga/socfpga-a10.c
> @@ -482,6 +482,7 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct a10_fpga_priv *priv;
>         void __iomem *reg_base;
> +       struct fpga_manager *mgr;
>         struct resource *res;
>         int ret;
>
> @@ -519,8 +520,17 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>                 return -EBUSY;
>         }
>
> -       ret = fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
> -                                &socfpga_a10_fpga_mgr_ops, priv);
> +       mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
> +       if (!mgr)
> +               return -ENOMEM;
> +
> +       mgr->parent = dev;
> +       mgr->name = "SoCFPGA Arria10 FPGA Manager";
> +       mgr->mops = &socfpga_a10_fpga_mgr_ops;
> +       mgr->priv = priv;
> +       platform_set_drvdata(pdev, mgr);
> +
> +       ret = fpga_mgr_register(mgr);
>         if (ret) {
>                 clk_disable_unprepare(priv->clk);
>                 return ret;
> @@ -534,7 +544,7 @@ static int socfpga_a10_fpga_remove(struct platform_device *pdev)
>         struct fpga_manager *mgr = platform_get_drvdata(pdev);
>         struct a10_fpga_priv *priv = mgr->priv;
>
> -       fpga_mgr_unregister(&pdev->dev);
> +       fpga_mgr_unregister(mgr);
>         clk_disable_unprepare(priv->clk);
>
>         return 0;
> diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
> index b6672e66cda6..2e764f5393fb 100644
> --- a/drivers/fpga/socfpga.c
> +++ b/drivers/fpga/socfpga.c
> @@ -555,9 +555,14 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct socfpga_fpga_priv *priv;
> +       struct fpga_manager *mgr;
>         struct resource *res;
>         int ret;
>
> +       mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
> +       if (!mgr)
> +               return -ENOMEM;
> +
>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
> @@ -581,13 +586,20 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> -       return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
> -                                &socfpga_fpga_ops, priv);
> +       mgr->parent = dev;
> +       mgr->name = "Altera SOCFPGA FPGA Manager";
> +       mgr->mops = &socfpga_fpga_ops;
> +       mgr->priv = priv;
> +       platform_set_drvdata(pdev, mgr);
> +
> +       return fpga_mgr_register(mgr);
>  }
>
>  static int socfpga_fpga_remove(struct platform_device *pdev)
>  {
> -       fpga_mgr_unregister(&pdev->dev);
> +       struct fpga_manager *mgr = platform_get_drvdata(pdev);
> +
> +       fpga_mgr_unregister(mgr);
>
>         return 0;
>  }
> diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
> index f6a96b42e2ca..33dd92626ea1 100644
> --- a/drivers/fpga/ts73xx-fpga.c
> +++ b/drivers/fpga/ts73xx-fpga.c
> @@ -116,8 +116,13 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
>  {
>         struct device *kdev = &pdev->dev;
>         struct ts73xx_fpga_priv *priv;
> +       struct fpga_manager *mgr;
>         struct resource *res;
>
> +       mgr = devm_kzalloc(kdev, sizeof(*mgr), GFP_KERNEL);
> +       if (!mgr)
> +               return -ENOMEM;
> +
>         priv = devm_kzalloc(kdev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
> @@ -131,13 +136,20 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
>                 return PTR_ERR(priv->io_base);
>         }
>
> -       return fpga_mgr_register(kdev, "TS-73xx FPGA Manager",
> -                                &ts73xx_fpga_ops, priv);
> +       mgr->parent = kdev;
> +       mgr->name = "TS-73xx FPGA Manager";
> +       mgr->mops = &ts73xx_fpga_ops;
> +       mgr->priv = priv;
> +       platform_set_drvdata(pdev, mgr);
> +
> +       return fpga_mgr_register(mgr);
>  }
>
>  static int ts73xx_fpga_remove(struct platform_device *pdev)
>  {
> -       fpga_mgr_unregister(&pdev->dev);
> +       struct fpga_manager *mgr = platform_get_drvdata(pdev);
> +
> +       fpga_mgr_unregister(mgr);
>
>         return 0;
>  }
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 9b62a4c2a3df..4775480ab3bd 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -143,6 +143,11 @@ static const struct fpga_manager_ops xilinx_spi_ops = {
>  static int xilinx_spi_probe(struct spi_device *spi)
>  {
>         struct xilinx_spi_conf *conf;
> +       struct fpga_manager *mgr;
> +
> +       mgr = devm_kzalloc(&spi->dev, sizeof(*mgr), GFP_KERNEL);
> +       if (!mgr)
> +               return -ENOMEM;
>
>         conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
>         if (!conf)
> @@ -165,13 +170,20 @@ static int xilinx_spi_probe(struct spi_device *spi)
>                 return PTR_ERR(conf->done);
>         }
>
> -       return fpga_mgr_register(&spi->dev, "Xilinx Slave Serial FPGA Manager",
> -                                &xilinx_spi_ops, conf);
> +       mgr->parent = &spi->dev;
> +       mgr->name = "Xilinx Slave Serial FPGA Manager";
> +       mgr->mops = &xilinx_spi_ops;
> +       mgr->priv = conf;
> +       spi_set_drvdata(spi, mgr);
> +
> +       return fpga_mgr_register(mgr);
>  }
>
>  static int xilinx_spi_remove(struct spi_device *spi)
>  {
> -       fpga_mgr_unregister(&spi->dev);
> +       struct fpga_manager *mgr = spi_get_drvdata(spi);
> +
> +       fpga_mgr_unregister(mgr);
>
>         return 0;
>  }
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 70b15b303471..2f9da8b2a354 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -558,9 +558,14 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct zynq_fpga_priv *priv;
> +       struct fpga_manager *mgr;
>         struct resource *res;
>         int err;
>
> +       mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
> +       if (!mgr)
> +               return -ENOMEM;
> +
>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
> @@ -613,8 +618,13 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>
>         clk_disable(priv->clk);
>
> -       err = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
> -                               &zynq_fpga_ops, priv);
> +       mgr->parent = dev;
> +       mgr->name = "Xilinx Zynq FPGA Manager";
> +       mgr->mops = &zynq_fpga_ops;
> +       mgr->priv = priv;
> +       platform_set_drvdata(pdev, mgr);
> +
> +       err = fpga_mgr_register(mgr);
>         if (err) {
>                 dev_err(dev, "unable to register FPGA manager\n");
>                 clk_unprepare(priv->clk);
> @@ -632,7 +642,7 @@ static int zynq_fpga_remove(struct platform_device *pdev)
>         mgr = platform_get_drvdata(pdev);
>         priv = mgr->priv;
>
> -       fpga_mgr_unregister(&pdev->dev);
> +       fpga_mgr_unregister(mgr);
>
>         clk_unprepare(priv->clk);
>
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 3c6de23aabdf..1ad482286b40 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -138,6 +138,7 @@ struct fpga_manager_ops {
>  /**
>   * struct fpga_manager - fpga manager structure
>   * @name: name of low level fpga manager
> + * @parent: parent device
>   * @dev: fpga manager device
>   * @ref_mutex: only allows one reference to fpga manager
>   * @state: state of fpga manager
> @@ -146,6 +147,7 @@ struct fpga_manager_ops {
>   */
>  struct fpga_manager {
>         const char *name;
> +       struct device *parent;
>         struct device dev;
>         struct mutex ref_mutex;
>         enum fpga_mgr_states state;
> @@ -170,9 +172,7 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
>
>  void fpga_mgr_put(struct fpga_manager *mgr);
>
> -int fpga_mgr_register(struct device *dev, const char *name,
> -                     const struct fpga_manager_ops *mops, void *priv);
> -
> -void fpga_mgr_unregister(struct device *dev);
> +int fpga_mgr_register(struct fpga_manager *mgr);
> +void fpga_mgr_unregister(struct fpga_manager *mgr);
>
>  #endif /*_LINUX_FPGA_MGR_H */
> --
> 2.14.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Moritz
