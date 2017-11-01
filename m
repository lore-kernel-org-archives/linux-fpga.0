Return-Path: <SRS0=1J59=B7=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=1J59=B7=ettus.com=moritz.fischer@kernel.org>
Date: Tue, 31 Oct 2017 18:34:28 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 2/3] fpga: manager: don't use drvdata in common fpga code
Message-ID: <20171101013428.GA21728@tyrael.ni.corp.natinst.com>
References: <1509482535-4921-1-git-send-email-atull@kernel.org>
 <1509482535-4921-3-git-send-email-atull@kernel.org>
 <20171031205924.p37uv6mfsmackhbj@us-sjc-wireless-10-16-34-58.amer.corp.natinst.com>
 <CANk1AXSpp=t71FmwRyX+gqY2r27JLzPKSg0e6yfMe35OsAv3Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <CANk1AXSpp=t71FmwRyX+gqY2r27JLzPKSg0e6yfMe35OsAv3Hw@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2017 at 04:45:54PM -0500, Alan Tull wrote:
> On Tue, Oct 31, 2017 at 3:59 PM, Moritz Fischer <mdf@kernel.org> wrote:
> > On Tue, Oct 31, 2017 at 08:42:14PM +0000, Alan Tull wrote:
> >> Changes to the fpga manager code to not use drvdata in common
> >> code.
> >>
> >> Change fpga_mgr_register to not set or use drvdata.
> >>
> >> Change the register/unregister function parameters to take the mgr
> >> struct:
> >> * int fpga_mgr_register(struct device *dev,
> >>                         struct fpga_manager *mgr);
> >> * void fpga_mgr_unregister(struct fpga_manager *mgr);
> >>
> >> Change the drivers that call fpga_mgr_register to alloc the struct
> >> fpga_manager (using devm_kzalloc) and partly fill it, adding name,
> >> ops, and priv.
> >>
> >> The rationale is that setting drvdata is fine for DT based devices
> >> that will have one manager, bridge, or region per platform device.
> >> However PCIe based devices may have multiple FPGA mgr/bridge/regions
> >> under one pcie device.  Without these changes, the PCIe solution has
> >> to create an extra device for each child mgr/bridge/region to hold
> >> drvdata.
> >
> > This looks very common, in fact several subsystems provide this two step
> > way of registering things.
> >
> > - Allocate fpga_mgr via fpga_mgr_alloc() where you pass in the size of
> >   the private data
> > - Fill in some fields
> > - fpga_mgr_register() where you pass in the fpga_mgr as suggested
> >
> > See for example the alloc_etherdev() for ethernet devices.
> >
>=20
> Yes, I considered it when I was writing this.  I've seen it both ways.
> In the case you mention, they've got reasons they absolutely needed to
> do it that way.  alloc_etherdev() calls eventually to
> alloc_netdev_mqs() which is about 100 lines of alloc'ing and
> initializing a network device struct.

Yeah, sure. I looked around some more. Other subsystems just alloc
manually, seems fine with me.
>=20
> > The benefit of the API you proposed is that one could embed the fpga_mgr
> > struct inside of another struct and get to the container via
> > container_of() I guess ...
>=20
> Yes, let's keep it simple for now, as that gives us greater
> flexibility.  We can add alloc functions when it becomes clear that it
> won't get in the way of someone's use.

Agreed.
>=20
> Alan
>=20
> >
> >>
> >> Signed-off-by: Alan Tull <atull@kernel.org>
> >> Reported-by: Jiuyue Ma <majiuyue@huawei.com>
> >> ---
> >>  Documentation/fpga/fpga-mgr.txt  | 23 ++++++++++++++++-------
> >>  drivers/fpga/altera-cvp.c        | 17 +++++++++++++----
> >>  drivers/fpga/altera-pr-ip-core.c | 16 ++++++++++++++--
> >>  drivers/fpga/altera-ps-spi.c     | 17 ++++++++++++++---
> >>  drivers/fpga/fpga-mgr.c          | 28 +++++++---------------------
> >>  drivers/fpga/ice40-spi.c         | 19 +++++++++++++++----
> >>  drivers/fpga/socfpga-a10.c       | 15 ++++++++++++---
> >>  drivers/fpga/socfpga.c           | 17 ++++++++++++++---
> >>  drivers/fpga/ts73xx-fpga.c       | 17 ++++++++++++++---
> >>  drivers/fpga/xilinx-spi.c        | 17 ++++++++++++++---
> >>  drivers/fpga/zynq-fpga.c         | 15 ++++++++++++---
> >>  include/linux/fpga/fpga-mgr.h    |  6 ++----
> >>  12 files changed, 147 insertions(+), 60 deletions(-)
> >>
> >> diff --git a/Documentation/fpga/fpga-mgr.txt b/Documentation/fpga/fpga=
-mgr.txt
> >> index cc6413e..7e5e5c8 100644
> >> --- a/Documentation/fpga/fpga-mgr.txt
> >> +++ b/Documentation/fpga/fpga-mgr.txt
> >> @@ -67,11 +67,9 @@ fpga_mgr_unlock when done programming the FPGA.
> >>  To register or unregister the low level FPGA-specific driver:
> >>  -------------------------------------------------------------
> >>
> >> -     int fpga_mgr_register(struct device *dev, const char *name,
> >> -                           const struct fpga_manager_ops *mops,
> >> -                           void *priv);
> >> +     int fpga_mgr_register(struct device *dev, struct fpga_manager *m=
gr);

At that point you could also just give the struct fpga_manager a
->parent or ->dev that you populate with &pdev->dev or &spi->dev etc instea=
d of
making it a separate parameter, this makes an odd mix of half and half here.
> >>
> >> -     void fpga_mgr_unregister(struct device *dev);
> >> +     void fpga_mgr_unregister(struct fpga_manager *mgr);
> >>
> >>  Use of these two functions is described below in "How To Support a ne=
w FPGA
> >>  device."
> >> @@ -148,8 +146,13 @@ static int socfpga_fpga_probe(struct platform_dev=
ice *pdev)
> >>  {
> >>       struct device *dev =3D &pdev->dev;
> >>       struct socfpga_fpga_priv *priv;
> >> +     struct fpga_manager *mgr;
> >>       int ret;
> >>
> >> +     mgr =3D devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
> >> +     if (!mgr)
> >> +             return -ENOMEM;
> >> +
> >>       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >>       if (!priv)
> >>               return -ENOMEM;
> >> @@ -157,13 +160,19 @@ static int socfpga_fpga_probe(struct platform_de=
vice *pdev)
> >>       /* ... do ioremaps, get interrupts, etc. and save
> >>          them in priv... */
> >>
> >> -     return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
> >> -                              &socfpga_fpga_ops, priv);
> >> +     mgr->name =3D "Altera SOCFPGA FPGA Manager";
> >> +     mgr->mops =3D &socfpga_fpga_ops;
> >> +     mgr->priv =3D priv;
Like here: mgr->dev =3D &pdev->dev

> >> +     platform_set_drvdata(pdev, mgr);
> >> +
> >> +     return fpga_mgr_register(dev, mgr);
> >>  }
> >>
> >>  static int socfpga_fpga_remove(struct platform_device *pdev)
> >>  {
> >> -     fpga_mgr_unregister(&pdev->dev);
> >> +     struct fpga_manager *mgr =3D platform_get_drvdata(pdev);
> >> +
> >> +     fpga_mgr_unregister(mgr);
> >>
> >>       return 0;
> >>  }
> >> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> >> index 00e73d2..63320ad 100644
> >> --- a/drivers/fpga/altera-cvp.c
> >> +++ b/drivers/fpga/altera-cvp.c
> >> @@ -403,6 +403,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> >>                           const struct pci_device_id *dev_id)
> >>  {
> >>       struct altera_cvp_conf *conf;
> >> +     struct fpga_manager *mgr;
> >>       u16 cmd, val;
> >>       int ret;
> >>
> >> @@ -421,6 +422,10 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> >>       if (!conf)
> >>               return -ENOMEM;
> >>
> >> +     mgr =3D devm_kzalloc(&pdev->dev, sizeof(*mgr), GFP_KERNEL);
> >> +     if (!mgr)
> >> +             return -ENOMEM;
> >> +
> >>       /*
> >>        * Enable memory BAR access. We cannot use pci_enable_device() h=
ere
> >>        * because it will make the driver unusable with FPGA devices th=
at
> >> @@ -454,8 +459,12 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> >>       snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
> >>                ALTERA_CVP_MGR_NAME, pci_name(pdev));
> >>
> >> -     ret =3D fpga_mgr_register(&pdev->dev, conf->mgr_name,
> >> -                             &altera_cvp_ops, conf);
> >> +     mgr->name =3D conf->mgr_name;
> >> +     mgr->mops =3D &altera_cvp_ops;
> >> +     mgr->priv =3D conf;
> >> +     pci_set_drvdata(pdev, mgr);
> >> +
> >> +     ret =3D fpga_mgr_register(&pdev->dev, mgr);
> >>       if (ret)
> >>               goto err_unmap;
> >>
> >> @@ -463,7 +472,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> >>                                &driver_attr_chkcfg);
> >>       if (ret) {
> >>               dev_err(&pdev->dev, "Can't create sysfs chkcfg file\n");
> >> -             fpga_mgr_unregister(&pdev->dev);
> >> +             fpga_mgr_unregister(mgr);
> >>               goto err_unmap;
> >>       }
> >>
> >> @@ -485,7 +494,7 @@ static void altera_cvp_remove(struct pci_dev *pdev)
> >>       u16 cmd;
> >>
> >>       driver_remove_file(&altera_cvp_driver.driver, &driver_attr_chkcf=
g);
> >> -     fpga_mgr_unregister(&pdev->dev);
> >> +     fpga_mgr_unregister(mgr);
> >>       pci_iounmap(pdev, conf->map);
> >>       pci_release_region(pdev, CVP_BAR);
> >>       pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> >> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr=
-ip-core.c
> >> index a7b31f9..f09e54f 100644
> >> --- a/drivers/fpga/altera-pr-ip-core.c
> >> +++ b/drivers/fpga/altera-pr-ip-core.c
> >> @@ -187,8 +187,13 @@ static const struct fpga_manager_ops alt_pr_ops =
=3D {
> >>  int alt_pr_register(struct device *dev, void __iomem *reg_base)
> >>  {
> >>       struct alt_pr_priv *priv;
> >> +     struct fpga_manager *mgr;
> >>       u32 val;
> >>
> >> +     mgr =3D devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
> >> +     if (!mgr)
> >> +             return -ENOMEM;
> >> +
> >>       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >>       if (!priv)
> >>               return -ENOMEM;
> >> @@ -201,15 +206,22 @@ int alt_pr_register(struct device *dev, void __i=
omem *reg_base)
> >>               (val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
> >>               (int)(val & ALT_PR_CSR_PR_START));
> >>
> >> -     return fpga_mgr_register(dev, dev_name(dev), &alt_pr_ops, priv);
> >> +     mgr->name =3D dev_name(dev);
> >> +     mgr->mops =3D &alt_pr_ops;
> >> +     mgr->priv =3D priv;
> >> +     dev_set_drvdata(dev, mgr);
> >> +
> >> +     return fpga_mgr_register(dev, mgr);
> >>  }
> >>  EXPORT_SYMBOL_GPL(alt_pr_register);
> >>
> >>  int alt_pr_unregister(struct device *dev)
> >>  {
> >> +     struct fpga_manager *mgr =3D dev_get_drvdata(dev);
> >> +
> >>       dev_dbg(dev, "%s\n", __func__);
> >>
> >> -     fpga_mgr_unregister(dev);
> >> +     fpga_mgr_unregister(mgr);
> >>
> >>       return 0;
> >>  }
> >> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi=
=2Ec
> >> index 14f14ef..aee6517 100644
> >> --- a/drivers/fpga/altera-ps-spi.c
> >> +++ b/drivers/fpga/altera-ps-spi.c
> >> @@ -238,6 +238,11 @@ static int altera_ps_probe(struct spi_device *spi)
> >>  {
> >>       struct altera_ps_conf *conf;
> >>       const struct of_device_id *of_id;
> >> +     struct fpga_manager *mgr;
> >> +
> >> +     mgr =3D devm_kzalloc(&spi->dev, sizeof(*mgr), GFP_KERNEL);
> >> +     if (!mgr)
> >> +             return -ENOMEM;
> >>
> >>       conf =3D devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
> >>       if (!conf)
> >> @@ -273,13 +278,19 @@ static int altera_ps_probe(struct spi_device *sp=
i)
> >>       snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
> >>                dev_driver_string(&spi->dev), dev_name(&spi->dev));
> >>
> >> -     return fpga_mgr_register(&spi->dev, conf->mgr_name,
> >> -                              &altera_ps_ops, conf);
> >> +     mgr->name =3D conf->mgr_name;
> >> +     mgr->mops =3D &altera_ps_ops;
> >> +     mgr->priv =3D conf;
> >> +     spi_set_drvdata(spi, mgr);
> >> +
> >> +     return fpga_mgr_register(&spi->dev, mgr);
> >>  }
> >>
> >>  static int altera_ps_remove(struct spi_device *spi)
> >>  {
> >> -     fpga_mgr_unregister(&spi->dev);
> >> +     struct fpga_manager *mgr =3D spi_get_drvdata(spi);
> >> +
> >> +     fpga_mgr_unregister(mgr);
> >>
> >>       return 0;
> >>  }
> >> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> >> index 223f240..6f1c59bf4 100644
> >> --- a/drivers/fpga/fpga-mgr.c
> >> +++ b/drivers/fpga/fpga-mgr.c
> >> @@ -525,13 +525,13 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
> >>   *
> >>   * Return: 0 on success, negative error code otherwise.
> >>   */
> >> -int fpga_mgr_register(struct device *dev, const char *name,
> >> -                   const struct fpga_manager_ops *mops,
> >> -                   void *priv)
> >> +int fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)
> >>  {
> >> -     struct fpga_manager *mgr;
> >> +     const char *name;
> >> +     const struct fpga_manager_ops *mops;
> >>       int id, ret;
> >>
> >> +     mops =3D mgr->mops;
> >>       if (!mops || !mops->write_complete || !mops->state ||
> >>           !mops->write_init || (!mops->write && !mops->write_sg) ||
> >>           (mops->write && mops->write_sg)) {
> >> @@ -539,27 +539,19 @@ int fpga_mgr_register(struct device *dev, const =
char *name,
> >>               return -EINVAL;
> >>       }
> >>
> >> +     name =3D mgr->name;
> >>       if (!name || !strlen(name)) {
> >>               dev_err(dev, "Attempt to register with no name!\n");
> >>               return -EINVAL;
> >>       }
> >>
> >> -     mgr =3D kzalloc(sizeof(*mgr), GFP_KERNEL);
> >> -     if (!mgr)
> >> -             return -ENOMEM;
> >> -
> >>       id =3D ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
> >>       if (id < 0) {
> >> -             ret =3D id;
> >> -             goto error_kfree;
> >> +             return id;
> >>       }
> >>
> >>       mutex_init(&mgr->ref_mutex);
> >>
> >> -     mgr->name =3D name;
> >> -     mgr->mops =3D mops;
> >> -     mgr->priv =3D priv;
> >> -
> >>       /*
> >>        * Initialize framework state by requesting low level driver rea=
d state
> >>        * from device.  FPGA may be in reset mode or may have been prog=
rammed
> >> @@ -573,7 +565,6 @@ int fpga_mgr_register(struct device *dev, const ch=
ar *name,
> >>       mgr->dev.parent =3D dev;
> >>       mgr->dev.of_node =3D dev->of_node;
> >>       mgr->dev.id =3D id;
> >> -     dev_set_drvdata(dev, mgr);
> >>
> >>       ret =3D dev_set_name(&mgr->dev, "fpga%d", id);
> >>       if (ret)
> >> @@ -589,8 +580,6 @@ int fpga_mgr_register(struct device *dev, const ch=
ar *name,
> >>
> >>  error_device:
> >>       ida_simple_remove(&fpga_mgr_ida, id);
> >> -error_kfree:
> >> -     kfree(mgr);
> >>
> >>       return ret;
> >>  }
> >> @@ -600,10 +589,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register);
> >>   * fpga_mgr_unregister - unregister a low level fpga manager driver
> >>   * @dev:     fpga manager device from pdev
> >>   */
> >> -void fpga_mgr_unregister(struct device *dev)
> >> +void fpga_mgr_unregister(struct fpga_manager *mgr)
> >>  {
> >> -     struct fpga_manager *mgr =3D dev_get_drvdata(dev);
> >> -
> >>       dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
> >>
> >>       /*
> >> @@ -622,7 +609,6 @@ static void fpga_mgr_dev_release(struct device *de=
v)
> >>       struct fpga_manager *mgr =3D to_fpga_manager(dev);
> >>
> >>       ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> >> -     kfree(mgr);
> >>  }
> >>
> >>  static int __init fpga_mgr_class_init(void)
> >> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
> >> index 7fca820..92da328 100644
> >> --- a/drivers/fpga/ice40-spi.c
> >> +++ b/drivers/fpga/ice40-spi.c
> >> @@ -133,8 +133,13 @@ static int ice40_fpga_probe(struct spi_device *sp=
i)
> >>  {
> >>       struct device *dev =3D &spi->dev;
> >>       struct ice40_fpga_priv *priv;
> >> +     struct fpga_manager *mgr;
> >>       int ret;
> >>
> >> +     mgr =3D devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
> >> +     if (!mgr)
> >> +             return -ENOMEM;
> >> +
> >>       priv =3D devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
> >>       if (!priv)
> >>               return -ENOMEM;
> >> @@ -174,14 +179,20 @@ static int ice40_fpga_probe(struct spi_device *s=
pi)
> >>               return ret;
> >>       }
> >>
> >> -     /* Register with the FPGA manager */
> >> -     return fpga_mgr_register(dev, "Lattice iCE40 FPGA Manager",
> >> -                              &ice40_fpga_ops, priv);
> >> +     mgr->name =3D "Lattice iCE40 FPGA Manager";
> >> +     mgr->mops =3D &ice40_fpga_ops;
> >> +     mgr->priv =3D priv;
> >> +     spi_set_drvdata(spi, mgr);
> >> +
> >> +     return fpga_mgr_register(dev, mgr);
> >>  }
> >>
> >>  static int ice40_fpga_remove(struct spi_device *spi)
> >>  {
> >> -     fpga_mgr_unregister(&spi->dev);
> >> +     struct fpga_manager *mgr =3D spi_get_drvdata(spi);
> >> +
> >> +     fpga_mgr_unregister(mgr);
> >> +
> >>       return 0;
> >>  }
> >>
> >> diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
> >> index f8770af..3c0eae5 100644
> >> --- a/drivers/fpga/socfpga-a10.c
> >> +++ b/drivers/fpga/socfpga-a10.c
> >> @@ -482,6 +482,7 @@ static int socfpga_a10_fpga_probe(struct platform_=
device *pdev)
> >>       struct device *dev =3D &pdev->dev;
> >>       struct a10_fpga_priv *priv;
> >>       void __iomem *reg_base;
> >> +     struct fpga_manager *mgr;
> >>       struct resource *res;
> >>       int ret;
> >>
> >> @@ -519,8 +520,16 @@ static int socfpga_a10_fpga_probe(struct platform=
_device *pdev)
> >>               return -EBUSY;
> >>       }
> >>
> >> -     return fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
> >> -                              &socfpga_a10_fpga_mgr_ops, priv);
> >> +     mgr =3D devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
> >> +     if (!mgr)
> >> +             return -ENOMEM;
> >> +
> >> +     mgr->name =3D "SoCFPGA Arria10 FPGA Manager";
> >> +     mgr->mops =3D &socfpga_a10_fpga_mgr_ops;
> >> +     mgr->priv =3D priv;
> >> +     platform_set_drvdata(pdev, mgr);
> >> +
> >> +     return fpga_mgr_register(dev, mgr);
> >>  }
> >>
> >>  static int socfpga_a10_fpga_remove(struct platform_device *pdev)
> >> @@ -528,7 +537,7 @@ static int socfpga_a10_fpga_remove(struct platform=
_device *pdev)
> >>       struct fpga_manager *mgr =3D platform_get_drvdata(pdev);
> >>       struct a10_fpga_priv *priv =3D mgr->priv;
> >>
> >> -     fpga_mgr_unregister(&pdev->dev);
> >> +     fpga_mgr_unregister(mgr);
> >>       clk_disable_unprepare(priv->clk);
> >>
> >>       return 0;
> >> diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
> >> index b6672e6..47723d3 100644
> >> --- a/drivers/fpga/socfpga.c
> >> +++ b/drivers/fpga/socfpga.c
> >> @@ -555,9 +555,14 @@ static int socfpga_fpga_probe(struct platform_dev=
ice *pdev)
> >>  {
> >>       struct device *dev =3D &pdev->dev;
> >>       struct socfpga_fpga_priv *priv;
> >> +     struct fpga_manager *mgr;
> >>       struct resource *res;
> >>       int ret;
> >>
> >> +     mgr =3D devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
> >> +     if (!mgr)
> >> +             return -ENOMEM;
> >> +
> >>       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >>       if (!priv)
> >>               return -ENOMEM;
> >> @@ -581,13 +586,19 @@ static int socfpga_fpga_probe(struct platform_de=
vice *pdev)
> >>       if (ret)
> >>               return ret;
> >>
> >> -     return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
> >> -                              &socfpga_fpga_ops, priv);
> >> +     mgr->name =3D "Altera SOCFPGA FPGA Manager";
> >> +     mgr->mops =3D &socfpga_fpga_ops;
> >> +     mgr->priv =3D priv;
> >> +     platform_set_drvdata(pdev, mgr);
> >> +
> >> +     return fpga_mgr_register(dev, mgr);
> >>  }
> >>
> >>  static int socfpga_fpga_remove(struct platform_device *pdev)
> >>  {
> >> -     fpga_mgr_unregister(&pdev->dev);
> >> +     struct fpga_manager *mgr =3D platform_get_drvdata(pdev);
> >> +
> >> +     fpga_mgr_unregister(mgr);
> >>
> >>       return 0;
> >>  }
> >> diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
> >> index f6a96b4..e32a918 100644
> >> --- a/drivers/fpga/ts73xx-fpga.c
> >> +++ b/drivers/fpga/ts73xx-fpga.c
> >> @@ -116,8 +116,13 @@ static int ts73xx_fpga_probe(struct platform_devi=
ce *pdev)
> >>  {
> >>       struct device *kdev =3D &pdev->dev;
> >>       struct ts73xx_fpga_priv *priv;
> >> +     struct fpga_manager *mgr;
> >>       struct resource *res;
> >>
> >> +     mgr =3D devm_kzalloc(kdev, sizeof(*mgr), GFP_KERNEL);
> >> +     if (!mgr)
> >> +             return -ENOMEM;
> >> +
> >>       priv =3D devm_kzalloc(kdev, sizeof(*priv), GFP_KERNEL);
> >>       if (!priv)
> >>               return -ENOMEM;
> >> @@ -131,13 +136,19 @@ static int ts73xx_fpga_probe(struct platform_dev=
ice *pdev)
> >>               return PTR_ERR(priv->io_base);
> >>       }
> >>
> >> -     return fpga_mgr_register(kdev, "TS-73xx FPGA Manager",
> >> -                              &ts73xx_fpga_ops, priv);
> >> +     mgr->name =3D "TS-73xx FPGA Manager";
> >> +     mgr->mops =3D &ts73xx_fpga_ops;
> >> +     mgr->priv =3D priv;
> >> +     platform_set_drvdata(pdev, mgr);
> >> +
> >> +     return fpga_mgr_register(kdev, mgr);
> >>  }
> >>
> >>  static int ts73xx_fpga_remove(struct platform_device *pdev)
> >>  {
> >> -     fpga_mgr_unregister(&pdev->dev);
> >> +     struct fpga_manager *mgr =3D platform_get_drvdata(pdev);
> >> +
> >> +     fpga_mgr_unregister(mgr);
> >>
> >>       return 0;
> >>  }
> >> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> >> index 9b62a4c..601802a 100644
> >> --- a/drivers/fpga/xilinx-spi.c
> >> +++ b/drivers/fpga/xilinx-spi.c
> >> @@ -143,6 +143,11 @@ static const struct fpga_manager_ops xilinx_spi_o=
ps =3D {
> >>  static int xilinx_spi_probe(struct spi_device *spi)
> >>  {
> >>       struct xilinx_spi_conf *conf;
> >> +     struct fpga_manager *mgr;
> >> +
> >> +     mgr =3D devm_kzalloc(&spi->dev, sizeof(*mgr), GFP_KERNEL);
> >> +     if (!mgr)
> >> +             return -ENOMEM;
> >>
> >>       conf =3D devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
> >>       if (!conf)
> >> @@ -165,13 +170,19 @@ static int xilinx_spi_probe(struct spi_device *s=
pi)
> >>               return PTR_ERR(conf->done);
> >>       }
> >>
> >> -     return fpga_mgr_register(&spi->dev, "Xilinx Slave Serial FPGA Ma=
nager",
> >> -                              &xilinx_spi_ops, conf);
> >> +     mgr->name =3D "Xilinx Slave Serial FPGA Manager";
> >> +     mgr->mops =3D &xilinx_spi_ops;
> >> +     mgr->priv =3D conf;
> >> +     spi_set_drvdata(spi, mgr);
> >> +
> >> +     return fpga_mgr_register(&spi->dev, mgr);
> >>  }
> >>
> >>  static int xilinx_spi_remove(struct spi_device *spi)
> >>  {
> >> -     fpga_mgr_unregister(&spi->dev);
> >> +     struct fpga_manager *mgr =3D spi_get_drvdata(spi);
> >> +
> >> +     fpga_mgr_unregister(mgr);
> >>
> >>       return 0;
> >>  }
> >> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> >> index 70b15b3..820bb91 100644
> >> --- a/drivers/fpga/zynq-fpga.c
> >> +++ b/drivers/fpga/zynq-fpga.c
> >> @@ -558,9 +558,14 @@ static int zynq_fpga_probe(struct platform_device=
 *pdev)
> >>  {
> >>       struct device *dev =3D &pdev->dev;
> >>       struct zynq_fpga_priv *priv;
> >> +     struct fpga_manager *mgr;
> >>       struct resource *res;
> >>       int err;
> >>
> >> +     mgr =3D devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
> >> +     if (!mgr)
> >> +             return -ENOMEM;
> >> +
> >
> >>       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >>       if (!priv)
> >>               return -ENOMEM;
> >> @@ -613,8 +618,12 @@ static int zynq_fpga_probe(struct platform_device=
 *pdev)
> >>
> >>       clk_disable(priv->clk);
> >>
> >> -     err =3D fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
> >> -                             &zynq_fpga_ops, priv);
> >> +     mgr->name =3D "Xilinx Zynq FPGA Manager";
> >> +     mgr->mops =3D &zynq_fpga_ops;
> >> +     mgr->priv =3D priv;
> >> +     platform_set_drvdata(pdev, mgr);
> >> +
> >> +     err =3D fpga_mgr_register(dev, mgr);
> >>       if (err) {
> >>               dev_err(dev, "unable to register FPGA manager\n");
> >>               clk_unprepare(priv->clk);
> >> @@ -632,7 +641,7 @@ static int zynq_fpga_remove(struct platform_device=
 *pdev)
> >>       mgr =3D platform_get_drvdata(pdev);
> >>       priv =3D mgr->priv;
> >>
> >> -     fpga_mgr_unregister(&pdev->dev);
> >> +     fpga_mgr_unregister(mgr);
> >>
> >>       clk_unprepare(priv->clk);
> >>
> >> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-m=
gr.h
> >> index 3c6de23..8b3a529 100644
> >> --- a/include/linux/fpga/fpga-mgr.h
> >> +++ b/include/linux/fpga/fpga-mgr.h
> >> @@ -170,9 +170,7 @@ struct fpga_manager *fpga_mgr_get(struct device *d=
ev);
> >>
> >>  void fpga_mgr_put(struct fpga_manager *mgr);
> >>
> >> -int fpga_mgr_register(struct device *dev, const char *name,
> >> -                   const struct fpga_manager_ops *mops, void *priv);
> >> -
> >> -void fpga_mgr_unregister(struct device *dev);
> >> +int fpga_mgr_register(struct device *dev, struct fpga_manager *mgr);
> >> +void fpga_mgr_unregister(struct fpga_manager *mgr);
> >>
> >>  #endif /*_LINUX_FPGA_MGR_H */
> >> --
> >> 2.7.4
> >>
> > Cheers,
> >
> > Moritz

Cheers,

Moritz

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAln5JKAACgkQUVwKRFcJ
cNjKjAgAg6il0v0sfFXQI1goz78/WJW4GUNLSY0gT3KSw3xE6+aTr/1BAv2Mv5mo
KLvUk+l080I9Wj2vQwRjA3yz2TnK0uM/cvl3P0TjjKsr8gWeZpdsz3WVFPKPa8sk
mkhlv2Uodu1nDuLSwNAa2E3bd6B9oSbreK/gyQirK30VUywC1TLa4gf75NsdwAaL
0mdFrpnl9VGBHm5oAH2la8Lf2GC09JcaCcm+YPGeLKpG3IZvlEZjOKXdrUYjMB3S
ci0l38EIIz/LNAmJNrL/vSVddqVq9vjiWuO5HgyeUWkUTxEdcufruXUu2D+B65Si
bfif66aNTTzUVtCp5D6gCwqLo+zJBw==
=0FLO
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
