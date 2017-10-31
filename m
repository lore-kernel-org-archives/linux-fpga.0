Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171031205924.p37uv6mfsmackhbj@us-sjc-wireless-10-16-34-58.amer.corp.natinst.com>
References: <1509482535-4921-1-git-send-email-atull@kernel.org>
 <1509482535-4921-3-git-send-email-atull@kernel.org> <20171031205924.p37uv6mfsmackhbj@us-sjc-wireless-10-16-34-58.amer.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 31 Oct 2017 16:45:54 -0500
Message-ID: <CANk1AXSpp=t71FmwRyX+gqY2r27JLzPKSg0e6yfMe35OsAv3Hw@mail.gmail.com>
Subject: Re: [PATCH 2/3] fpga: manager: don't use drvdata in common fpga code
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Oct 31, 2017 at 3:59 PM, Moritz Fischer <mdf@kernel.org> wrote:
> On Tue, Oct 31, 2017 at 08:42:14PM +0000, Alan Tull wrote:
>> Changes to the fpga manager code to not use drvdata in common
>> code.
>>
>> Change fpga_mgr_register to not set or use drvdata.
>>
>> Change the register/unregister function parameters to take the mgr
>> struct:
>> * int fpga_mgr_register(struct device *dev,
>>                         struct fpga_manager *mgr);
>> * void fpga_mgr_unregister(struct fpga_manager *mgr);
>>
>> Change the drivers that call fpga_mgr_register to alloc the struct
>> fpga_manager (using devm_kzalloc) and partly fill it, adding name,
>> ops, and priv.
>>
>> The rationale is that setting drvdata is fine for DT based devices
>> that will have one manager, bridge, or region per platform device.
>> However PCIe based devices may have multiple FPGA mgr/bridge/regions
>> under one pcie device.  Without these changes, the PCIe solution has
>> to create an extra device for each child mgr/bridge/region to hold
>> drvdata.
>
> This looks very common, in fact several subsystems provide this two step
> way of registering things.
>
> - Allocate fpga_mgr via fpga_mgr_alloc() where you pass in the size of
>   the private data
> - Fill in some fields
> - fpga_mgr_register() where you pass in the fpga_mgr as suggested
>
> See for example the alloc_etherdev() for ethernet devices.
>

Yes, I considered it when I was writing this.  I've seen it both ways.
In the case you mention, they've got reasons they absolutely needed to
do it that way.  alloc_etherdev() calls eventually to
alloc_netdev_mqs() which is about 100 lines of alloc'ing and
initializing a network device struct.

> The benefit of the API you proposed is that one could embed the fpga_mgr
> struct inside of another struct and get to the container via
> container_of() I guess ...

Yes, let's keep it simple for now, as that gives us greater
flexibility.  We can add alloc functions when it becomes clear that it
won't get in the way of someone's use.

Alan

>
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> Reported-by: Jiuyue Ma <majiuyue@huawei.com>
>> ---
>>  Documentation/fpga/fpga-mgr.txt  | 23 ++++++++++++++++-------
>>  drivers/fpga/altera-cvp.c        | 17 +++++++++++++----
>>  drivers/fpga/altera-pr-ip-core.c | 16 ++++++++++++++--
>>  drivers/fpga/altera-ps-spi.c     | 17 ++++++++++++++---
>>  drivers/fpga/fpga-mgr.c          | 28 +++++++---------------------
>>  drivers/fpga/ice40-spi.c         | 19 +++++++++++++++----
>>  drivers/fpga/socfpga-a10.c       | 15 ++++++++++++---
>>  drivers/fpga/socfpga.c           | 17 ++++++++++++++---
>>  drivers/fpga/ts73xx-fpga.c       | 17 ++++++++++++++---
>>  drivers/fpga/xilinx-spi.c        | 17 ++++++++++++++---
>>  drivers/fpga/zynq-fpga.c         | 15 ++++++++++++---
>>  include/linux/fpga/fpga-mgr.h    |  6 ++----
>>  12 files changed, 147 insertions(+), 60 deletions(-)
>>
>> diff --git a/Documentation/fpga/fpga-mgr.txt b/Documentation/fpga/fpga-mgr.txt
>> index cc6413e..7e5e5c8 100644
>> --- a/Documentation/fpga/fpga-mgr.txt
>> +++ b/Documentation/fpga/fpga-mgr.txt
>> @@ -67,11 +67,9 @@ fpga_mgr_unlock when done programming the FPGA.
>>  To register or unregister the low level FPGA-specific driver:
>>  -------------------------------------------------------------
>>
>> -     int fpga_mgr_register(struct device *dev, const char *name,
>> -                           const struct fpga_manager_ops *mops,
>> -                           void *priv);
>> +     int fpga_mgr_register(struct device *dev, struct fpga_manager *mgr);
>>
>> -     void fpga_mgr_unregister(struct device *dev);
>> +     void fpga_mgr_unregister(struct fpga_manager *mgr);
>>
>>  Use of these two functions is described below in "How To Support a new FPGA
>>  device."
>> @@ -148,8 +146,13 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>>  {
>>       struct device *dev = &pdev->dev;
>>       struct socfpga_fpga_priv *priv;
>> +     struct fpga_manager *mgr;
>>       int ret;
>>
>> +     mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
>> +     if (!mgr)
>> +             return -ENOMEM;
>> +
>>       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>       if (!priv)
>>               return -ENOMEM;
>> @@ -157,13 +160,19 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>>       /* ... do ioremaps, get interrupts, etc. and save
>>          them in priv... */
>>
>> -     return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
>> -                              &socfpga_fpga_ops, priv);
>> +     mgr->name = "Altera SOCFPGA FPGA Manager";
>> +     mgr->mops = &socfpga_fpga_ops;
>> +     mgr->priv = priv;
>> +     platform_set_drvdata(pdev, mgr);
>> +
>> +     return fpga_mgr_register(dev, mgr);
>>  }
>>
>>  static int socfpga_fpga_remove(struct platform_device *pdev)
>>  {
>> -     fpga_mgr_unregister(&pdev->dev);
>> +     struct fpga_manager *mgr = platform_get_drvdata(pdev);
>> +
>> +     fpga_mgr_unregister(mgr);
>>
>>       return 0;
>>  }
>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>> index 00e73d2..63320ad 100644
>> --- a/drivers/fpga/altera-cvp.c
>> +++ b/drivers/fpga/altera-cvp.c
>> @@ -403,6 +403,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>>                           const struct pci_device_id *dev_id)
>>  {
>>       struct altera_cvp_conf *conf;
>> +     struct fpga_manager *mgr;
>>       u16 cmd, val;
>>       int ret;
>>
>> @@ -421,6 +422,10 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>>       if (!conf)
>>               return -ENOMEM;
>>
>> +     mgr = devm_kzalloc(&pdev->dev, sizeof(*mgr), GFP_KERNEL);
>> +     if (!mgr)
>> +             return -ENOMEM;
>> +
>>       /*
>>        * Enable memory BAR access. We cannot use pci_enable_device() here
>>        * because it will make the driver unusable with FPGA devices that
>> @@ -454,8 +459,12 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>>       snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
>>                ALTERA_CVP_MGR_NAME, pci_name(pdev));
>>
>> -     ret = fpga_mgr_register(&pdev->dev, conf->mgr_name,
>> -                             &altera_cvp_ops, conf);
>> +     mgr->name = conf->mgr_name;
>> +     mgr->mops = &altera_cvp_ops;
>> +     mgr->priv = conf;
>> +     pci_set_drvdata(pdev, mgr);
>> +
>> +     ret = fpga_mgr_register(&pdev->dev, mgr);
>>       if (ret)
>>               goto err_unmap;
>>
>> @@ -463,7 +472,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>>                                &driver_attr_chkcfg);
>>       if (ret) {
>>               dev_err(&pdev->dev, "Can't create sysfs chkcfg file\n");
>> -             fpga_mgr_unregister(&pdev->dev);
>> +             fpga_mgr_unregister(mgr);
>>               goto err_unmap;
>>       }
>>
>> @@ -485,7 +494,7 @@ static void altera_cvp_remove(struct pci_dev *pdev)
>>       u16 cmd;
>>
>>       driver_remove_file(&altera_cvp_driver.driver, &driver_attr_chkcfg);
>> -     fpga_mgr_unregister(&pdev->dev);
>> +     fpga_mgr_unregister(mgr);
>>       pci_iounmap(pdev, conf->map);
>>       pci_release_region(pdev, CVP_BAR);
>>       pci_read_config_word(pdev, PCI_COMMAND, &cmd);
>> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
>> index a7b31f9..f09e54f 100644
>> --- a/drivers/fpga/altera-pr-ip-core.c
>> +++ b/drivers/fpga/altera-pr-ip-core.c
>> @@ -187,8 +187,13 @@ static const struct fpga_manager_ops alt_pr_ops = {
>>  int alt_pr_register(struct device *dev, void __iomem *reg_base)
>>  {
>>       struct alt_pr_priv *priv;
>> +     struct fpga_manager *mgr;
>>       u32 val;
>>
>> +     mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
>> +     if (!mgr)
>> +             return -ENOMEM;
>> +
>>       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>       if (!priv)
>>               return -ENOMEM;
>> @@ -201,15 +206,22 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
>>               (val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
>>               (int)(val & ALT_PR_CSR_PR_START));
>>
>> -     return fpga_mgr_register(dev, dev_name(dev), &alt_pr_ops, priv);
>> +     mgr->name = dev_name(dev);
>> +     mgr->mops = &alt_pr_ops;
>> +     mgr->priv = priv;
>> +     dev_set_drvdata(dev, mgr);
>> +
>> +     return fpga_mgr_register(dev, mgr);
>>  }
>>  EXPORT_SYMBOL_GPL(alt_pr_register);
>>
>>  int alt_pr_unregister(struct device *dev)
>>  {
>> +     struct fpga_manager *mgr = dev_get_drvdata(dev);
>> +
>>       dev_dbg(dev, "%s\n", __func__);
>>
>> -     fpga_mgr_unregister(dev);
>> +     fpga_mgr_unregister(mgr);
>>
>>       return 0;
>>  }
>> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
>> index 14f14ef..aee6517 100644
>> --- a/drivers/fpga/altera-ps-spi.c
>> +++ b/drivers/fpga/altera-ps-spi.c
>> @@ -238,6 +238,11 @@ static int altera_ps_probe(struct spi_device *spi)
>>  {
>>       struct altera_ps_conf *conf;
>>       const struct of_device_id *of_id;
>> +     struct fpga_manager *mgr;
>> +
>> +     mgr = devm_kzalloc(&spi->dev, sizeof(*mgr), GFP_KERNEL);
>> +     if (!mgr)
>> +             return -ENOMEM;
>>
>>       conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
>>       if (!conf)
>> @@ -273,13 +278,19 @@ static int altera_ps_probe(struct spi_device *spi)
>>       snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
>>                dev_driver_string(&spi->dev), dev_name(&spi->dev));
>>
>> -     return fpga_mgr_register(&spi->dev, conf->mgr_name,
>> -                              &altera_ps_ops, conf);
>> +     mgr->name = conf->mgr_name;
>> +     mgr->mops = &altera_ps_ops;
>> +     mgr->priv = conf;
>> +     spi_set_drvdata(spi, mgr);
>> +
>> +     return fpga_mgr_register(&spi->dev, mgr);
>>  }
>>
>>  static int altera_ps_remove(struct spi_device *spi)
>>  {
>> -     fpga_mgr_unregister(&spi->dev);
>> +     struct fpga_manager *mgr = spi_get_drvdata(spi);
>> +
>> +     fpga_mgr_unregister(mgr);
>>
>>       return 0;
>>  }
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index 223f240..6f1c59bf4 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -525,13 +525,13 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>>   *
>>   * Return: 0 on success, negative error code otherwise.
>>   */
>> -int fpga_mgr_register(struct device *dev, const char *name,
>> -                   const struct fpga_manager_ops *mops,
>> -                   void *priv)
>> +int fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)
>>  {
>> -     struct fpga_manager *mgr;
>> +     const char *name;
>> +     const struct fpga_manager_ops *mops;
>>       int id, ret;
>>
>> +     mops = mgr->mops;
>>       if (!mops || !mops->write_complete || !mops->state ||
>>           !mops->write_init || (!mops->write && !mops->write_sg) ||
>>           (mops->write && mops->write_sg)) {
>> @@ -539,27 +539,19 @@ int fpga_mgr_register(struct device *dev, const char *name,
>>               return -EINVAL;
>>       }
>>
>> +     name = mgr->name;
>>       if (!name || !strlen(name)) {
>>               dev_err(dev, "Attempt to register with no name!\n");
>>               return -EINVAL;
>>       }
>>
>> -     mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
>> -     if (!mgr)
>> -             return -ENOMEM;
>> -
>>       id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
>>       if (id < 0) {
>> -             ret = id;
>> -             goto error_kfree;
>> +             return id;
>>       }
>>
>>       mutex_init(&mgr->ref_mutex);
>>
>> -     mgr->name = name;
>> -     mgr->mops = mops;
>> -     mgr->priv = priv;
>> -
>>       /*
>>        * Initialize framework state by requesting low level driver read state
>>        * from device.  FPGA may be in reset mode or may have been programmed
>> @@ -573,7 +565,6 @@ int fpga_mgr_register(struct device *dev, const char *name,
>>       mgr->dev.parent = dev;
>>       mgr->dev.of_node = dev->of_node;
>>       mgr->dev.id = id;
>> -     dev_set_drvdata(dev, mgr);
>>
>>       ret = dev_set_name(&mgr->dev, "fpga%d", id);
>>       if (ret)
>> @@ -589,8 +580,6 @@ int fpga_mgr_register(struct device *dev, const char *name,
>>
>>  error_device:
>>       ida_simple_remove(&fpga_mgr_ida, id);
>> -error_kfree:
>> -     kfree(mgr);
>>
>>       return ret;
>>  }
>> @@ -600,10 +589,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register);
>>   * fpga_mgr_unregister - unregister a low level fpga manager driver
>>   * @dev:     fpga manager device from pdev
>>   */
>> -void fpga_mgr_unregister(struct device *dev)
>> +void fpga_mgr_unregister(struct fpga_manager *mgr)
>>  {
>> -     struct fpga_manager *mgr = dev_get_drvdata(dev);
>> -
>>       dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
>>
>>       /*
>> @@ -622,7 +609,6 @@ static void fpga_mgr_dev_release(struct device *dev)
>>       struct fpga_manager *mgr = to_fpga_manager(dev);
>>
>>       ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
>> -     kfree(mgr);
>>  }
>>
>>  static int __init fpga_mgr_class_init(void)
>> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
>> index 7fca820..92da328 100644
>> --- a/drivers/fpga/ice40-spi.c
>> +++ b/drivers/fpga/ice40-spi.c
>> @@ -133,8 +133,13 @@ static int ice40_fpga_probe(struct spi_device *spi)
>>  {
>>       struct device *dev = &spi->dev;
>>       struct ice40_fpga_priv *priv;
>> +     struct fpga_manager *mgr;
>>       int ret;
>>
>> +     mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
>> +     if (!mgr)
>> +             return -ENOMEM;
>> +
>>       priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
>>       if (!priv)
>>               return -ENOMEM;
>> @@ -174,14 +179,20 @@ static int ice40_fpga_probe(struct spi_device *spi)
>>               return ret;
>>       }
>>
>> -     /* Register with the FPGA manager */
>> -     return fpga_mgr_register(dev, "Lattice iCE40 FPGA Manager",
>> -                              &ice40_fpga_ops, priv);
>> +     mgr->name = "Lattice iCE40 FPGA Manager";
>> +     mgr->mops = &ice40_fpga_ops;
>> +     mgr->priv = priv;
>> +     spi_set_drvdata(spi, mgr);
>> +
>> +     return fpga_mgr_register(dev, mgr);
>>  }
>>
>>  static int ice40_fpga_remove(struct spi_device *spi)
>>  {
>> -     fpga_mgr_unregister(&spi->dev);
>> +     struct fpga_manager *mgr = spi_get_drvdata(spi);
>> +
>> +     fpga_mgr_unregister(mgr);
>> +
>>       return 0;
>>  }
>>
>> diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
>> index f8770af..3c0eae5 100644
>> --- a/drivers/fpga/socfpga-a10.c
>> +++ b/drivers/fpga/socfpga-a10.c
>> @@ -482,6 +482,7 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>>       struct device *dev = &pdev->dev;
>>       struct a10_fpga_priv *priv;
>>       void __iomem *reg_base;
>> +     struct fpga_manager *mgr;
>>       struct resource *res;
>>       int ret;
>>
>> @@ -519,8 +520,16 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>>               return -EBUSY;
>>       }
>>
>> -     return fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
>> -                              &socfpga_a10_fpga_mgr_ops, priv);
>> +     mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
>> +     if (!mgr)
>> +             return -ENOMEM;
>> +
>> +     mgr->name = "SoCFPGA Arria10 FPGA Manager";
>> +     mgr->mops = &socfpga_a10_fpga_mgr_ops;
>> +     mgr->priv = priv;
>> +     platform_set_drvdata(pdev, mgr);
>> +
>> +     return fpga_mgr_register(dev, mgr);
>>  }
>>
>>  static int socfpga_a10_fpga_remove(struct platform_device *pdev)
>> @@ -528,7 +537,7 @@ static int socfpga_a10_fpga_remove(struct platform_device *pdev)
>>       struct fpga_manager *mgr = platform_get_drvdata(pdev);
>>       struct a10_fpga_priv *priv = mgr->priv;
>>
>> -     fpga_mgr_unregister(&pdev->dev);
>> +     fpga_mgr_unregister(mgr);
>>       clk_disable_unprepare(priv->clk);
>>
>>       return 0;
>> diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
>> index b6672e6..47723d3 100644
>> --- a/drivers/fpga/socfpga.c
>> +++ b/drivers/fpga/socfpga.c
>> @@ -555,9 +555,14 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>>  {
>>       struct device *dev = &pdev->dev;
>>       struct socfpga_fpga_priv *priv;
>> +     struct fpga_manager *mgr;
>>       struct resource *res;
>>       int ret;
>>
>> +     mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
>> +     if (!mgr)
>> +             return -ENOMEM;
>> +
>>       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>       if (!priv)
>>               return -ENOMEM;
>> @@ -581,13 +586,19 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>>       if (ret)
>>               return ret;
>>
>> -     return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
>> -                              &socfpga_fpga_ops, priv);
>> +     mgr->name = "Altera SOCFPGA FPGA Manager";
>> +     mgr->mops = &socfpga_fpga_ops;
>> +     mgr->priv = priv;
>> +     platform_set_drvdata(pdev, mgr);
>> +
>> +     return fpga_mgr_register(dev, mgr);
>>  }
>>
>>  static int socfpga_fpga_remove(struct platform_device *pdev)
>>  {
>> -     fpga_mgr_unregister(&pdev->dev);
>> +     struct fpga_manager *mgr = platform_get_drvdata(pdev);
>> +
>> +     fpga_mgr_unregister(mgr);
>>
>>       return 0;
>>  }
>> diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
>> index f6a96b4..e32a918 100644
>> --- a/drivers/fpga/ts73xx-fpga.c
>> +++ b/drivers/fpga/ts73xx-fpga.c
>> @@ -116,8 +116,13 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
>>  {
>>       struct device *kdev = &pdev->dev;
>>       struct ts73xx_fpga_priv *priv;
>> +     struct fpga_manager *mgr;
>>       struct resource *res;
>>
>> +     mgr = devm_kzalloc(kdev, sizeof(*mgr), GFP_KERNEL);
>> +     if (!mgr)
>> +             return -ENOMEM;
>> +
>>       priv = devm_kzalloc(kdev, sizeof(*priv), GFP_KERNEL);
>>       if (!priv)
>>               return -ENOMEM;
>> @@ -131,13 +136,19 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
>>               return PTR_ERR(priv->io_base);
>>       }
>>
>> -     return fpga_mgr_register(kdev, "TS-73xx FPGA Manager",
>> -                              &ts73xx_fpga_ops, priv);
>> +     mgr->name = "TS-73xx FPGA Manager";
>> +     mgr->mops = &ts73xx_fpga_ops;
>> +     mgr->priv = priv;
>> +     platform_set_drvdata(pdev, mgr);
>> +
>> +     return fpga_mgr_register(kdev, mgr);
>>  }
>>
>>  static int ts73xx_fpga_remove(struct platform_device *pdev)
>>  {
>> -     fpga_mgr_unregister(&pdev->dev);
>> +     struct fpga_manager *mgr = platform_get_drvdata(pdev);
>> +
>> +     fpga_mgr_unregister(mgr);
>>
>>       return 0;
>>  }
>> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
>> index 9b62a4c..601802a 100644
>> --- a/drivers/fpga/xilinx-spi.c
>> +++ b/drivers/fpga/xilinx-spi.c
>> @@ -143,6 +143,11 @@ static const struct fpga_manager_ops xilinx_spi_ops = {
>>  static int xilinx_spi_probe(struct spi_device *spi)
>>  {
>>       struct xilinx_spi_conf *conf;
>> +     struct fpga_manager *mgr;
>> +
>> +     mgr = devm_kzalloc(&spi->dev, sizeof(*mgr), GFP_KERNEL);
>> +     if (!mgr)
>> +             return -ENOMEM;
>>
>>       conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
>>       if (!conf)
>> @@ -165,13 +170,19 @@ static int xilinx_spi_probe(struct spi_device *spi)
>>               return PTR_ERR(conf->done);
>>       }
>>
>> -     return fpga_mgr_register(&spi->dev, "Xilinx Slave Serial FPGA Manager",
>> -                              &xilinx_spi_ops, conf);
>> +     mgr->name = "Xilinx Slave Serial FPGA Manager";
>> +     mgr->mops = &xilinx_spi_ops;
>> +     mgr->priv = conf;
>> +     spi_set_drvdata(spi, mgr);
>> +
>> +     return fpga_mgr_register(&spi->dev, mgr);
>>  }
>>
>>  static int xilinx_spi_remove(struct spi_device *spi)
>>  {
>> -     fpga_mgr_unregister(&spi->dev);
>> +     struct fpga_manager *mgr = spi_get_drvdata(spi);
>> +
>> +     fpga_mgr_unregister(mgr);
>>
>>       return 0;
>>  }
>> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
>> index 70b15b3..820bb91 100644
>> --- a/drivers/fpga/zynq-fpga.c
>> +++ b/drivers/fpga/zynq-fpga.c
>> @@ -558,9 +558,14 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>>  {
>>       struct device *dev = &pdev->dev;
>>       struct zynq_fpga_priv *priv;
>> +     struct fpga_manager *mgr;
>>       struct resource *res;
>>       int err;
>>
>> +     mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
>> +     if (!mgr)
>> +             return -ENOMEM;
>> +
>
>>       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>       if (!priv)
>>               return -ENOMEM;
>> @@ -613,8 +618,12 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>>
>>       clk_disable(priv->clk);
>>
>> -     err = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
>> -                             &zynq_fpga_ops, priv);
>> +     mgr->name = "Xilinx Zynq FPGA Manager";
>> +     mgr->mops = &zynq_fpga_ops;
>> +     mgr->priv = priv;
>> +     platform_set_drvdata(pdev, mgr);
>> +
>> +     err = fpga_mgr_register(dev, mgr);
>>       if (err) {
>>               dev_err(dev, "unable to register FPGA manager\n");
>>               clk_unprepare(priv->clk);
>> @@ -632,7 +641,7 @@ static int zynq_fpga_remove(struct platform_device *pdev)
>>       mgr = platform_get_drvdata(pdev);
>>       priv = mgr->priv;
>>
>> -     fpga_mgr_unregister(&pdev->dev);
>> +     fpga_mgr_unregister(mgr);
>>
>>       clk_unprepare(priv->clk);
>>
>> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
>> index 3c6de23..8b3a529 100644
>> --- a/include/linux/fpga/fpga-mgr.h
>> +++ b/include/linux/fpga/fpga-mgr.h
>> @@ -170,9 +170,7 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
>>
>>  void fpga_mgr_put(struct fpga_manager *mgr);
>>
>> -int fpga_mgr_register(struct device *dev, const char *name,
>> -                   const struct fpga_manager_ops *mops, void *priv);
>> -
>> -void fpga_mgr_unregister(struct device *dev);
>> +int fpga_mgr_register(struct device *dev, struct fpga_manager *mgr);
>> +void fpga_mgr_unregister(struct fpga_manager *mgr);
>>
>>  #endif /*_LINUX_FPGA_MGR_H */
>> --
>> 2.7.4
>>
> Cheers,
>
> Moritz
