Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20180904212237.3078-1-atull@kernel.org> <20180904212237.3078-4-atull@kernel.org>
 <CAJYdmeO0RegP4q1tVow1U0=Zc42GEHMuqsHsvHvMqp89zZ6Wpw@mail.gmail.com>
In-Reply-To: <CAJYdmeO0RegP4q1tVow1U0=Zc42GEHMuqsHsvHvMqp89zZ6Wpw@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 5 Sep 2018 10:38:53 -0500
Message-ID: <CANk1AXQaSLziycCv4X50xufehu7AgV34pxydxs8H14uFREy4YQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] fpga: bridge: add devm_fpga_bridge_create
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <moritz.fischer.private@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Sep 5, 2018 at 10:22 AM Moritz Fischer
<moritz.fischer.private@gmail.com> wrote:
>
> Hi Alan,
>
> looks good to me: Small nit inline. Not a showstopper.
> On Tue, Sep 4, 2018 at 2:22 PM Alan Tull <atull@kernel.org> wrote:
> >
> > Add devm_fpga_bridge_create() which is the managed
> > version of fpga_bridge_create().
> >
> > Change current bridge drivers to use
> > devm_fpga_bridge_create().
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> > Suggested-by: Federico Vaga <federico.vaga@cern.ch>
> > ---
> > v2: add suggested-by
> > ---
> >  Documentation/driver-api/fpga/fpga-bridge.rst |  3 ++
> >  drivers/fpga/altera-fpga2sdram.c              |  8 ++-
> >  drivers/fpga/altera-freeze-bridge.c           | 13 ++---
> >  drivers/fpga/altera-hps2fpga.c                |  7 ++-
> >  drivers/fpga/dfl-fme-br.c                     | 11 ++--
> >  drivers/fpga/fpga-bridge.c                    | 72 +++++++++++++++++++++++----
> >  drivers/fpga/xilinx-pr-decoupler.c            |  4 +-
> >  include/linux/fpga/fpga-bridge.h              |  4 ++
> >  8 files changed, 84 insertions(+), 38 deletions(-)
> >
> > diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
> > index 2c2aaca..ebbcbde 100644
> > --- a/Documentation/driver-api/fpga/fpga-bridge.rst
> > +++ b/Documentation/driver-api/fpga/fpga-bridge.rst
> > @@ -11,6 +11,9 @@ API to implement a new FPGA bridge
> >     :functions: fpga_bridge_ops
> >
> >  .. kernel-doc:: drivers/fpga/fpga-bridge.c
> > +   :functions: devm_fpga_bridge_create
> > +
> > +.. kernel-doc:: drivers/fpga/fpga-bridge.c
> >     :functions: fpga_bridge_create
> >
> >  .. kernel-doc:: drivers/fpga/fpga-bridge.c
> > diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
> > index 23660cc..a78e49c 100644
> > --- a/drivers/fpga/altera-fpga2sdram.c
> > +++ b/drivers/fpga/altera-fpga2sdram.c
> > @@ -121,18 +121,16 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
> >         /* Get f2s bridge configuration saved in handoff register */
> >         regmap_read(sysmgr, SYSMGR_ISWGRP_HANDOFF3, &priv->mask);
> >
> > -       br = fpga_bridge_create(dev, F2S_BRIDGE_NAME,
> > -                               &altera_fpga2sdram_br_ops, priv);
> > +       br = devm_fpga_bridge_create(dev, F2S_BRIDGE_NAME,
> > +                                    &altera_fpga2sdram_br_ops, priv);
> >         if (!br)
> >                 return -ENOMEM;
> >
> >         platform_set_drvdata(pdev, br);
> >
> >         ret = fpga_bridge_register(br);
> > -       if (ret) {
> > -               fpga_bridge_free(br);
> > +       if (ret)
> >                 return ret;
> > -       }
> >
> >         dev_info(dev, "driver initialized with handoff %08x\n", priv->mask);
> >
> > diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
> > index ffd586c..dd58c4a 100644
> > --- a/drivers/fpga/altera-freeze-bridge.c
> > +++ b/drivers/fpga/altera-freeze-bridge.c
> > @@ -213,7 +213,6 @@ static int altera_freeze_br_probe(struct platform_device *pdev)
> >         struct fpga_bridge *br;
> >         struct resource *res;
> >         u32 status, revision;
> > -       int ret;
> >
> >         if (!np)
> >                 return -ENODEV;
> > @@ -245,20 +244,14 @@ static int altera_freeze_br_probe(struct platform_device *pdev)
> >
> >         priv->base_addr = base_addr;
> >
> > -       br = fpga_bridge_create(dev, FREEZE_BRIDGE_NAME,
> > -                               &altera_freeze_br_br_ops, priv);
> > +       br = devm_fpga_bridge_create(dev, FREEZE_BRIDGE_NAME,
> > +                                    &altera_freeze_br_br_ops, priv);
> >         if (!br)
> >                 return -ENOMEM;
> >
> >         platform_set_drvdata(pdev, br);
> >
> > -       ret = fpga_bridge_register(br);
> > -       if (ret) {
> > -               fpga_bridge_free(br);
> > -               return ret;
> > -       }
> > -
> > -       return 0;
> > +       return fpga_bridge_register(br);
> >  }
> >
> >  static int altera_freeze_br_remove(struct platform_device *pdev)
> > diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
> > index a974d3f..77b95f2 100644
> > --- a/drivers/fpga/altera-hps2fpga.c
> > +++ b/drivers/fpga/altera-hps2fpga.c
> > @@ -180,7 +180,8 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
> >                 }
> >         }
> >
> > -       br = fpga_bridge_create(dev, priv->name, &altera_hps2fpga_br_ops, priv);
> > +       br = devm_fpga_bridge_create(dev, priv->name,
> > +                                    &altera_hps2fpga_br_ops, priv);
> >         if (!br) {
> >                 ret = -ENOMEM;
> >                 goto err;
> > @@ -190,12 +191,10 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
> >
> >         ret = fpga_bridge_register(br);
> >         if (ret)
> > -               goto err_free;
> > +               goto err;
> >
> >         return 0;
> >
> > -err_free:
> > -       fpga_bridge_free(br);
> >  err:
> >         clk_disable_unprepare(priv->clk);
> >
> > diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
> > index 7cc041d..3ff9f3a 100644
> > --- a/drivers/fpga/dfl-fme-br.c
> > +++ b/drivers/fpga/dfl-fme-br.c
> > @@ -61,7 +61,6 @@ static int fme_br_probe(struct platform_device *pdev)
> >         struct device *dev = &pdev->dev;
> >         struct fme_br_priv *priv;
> >         struct fpga_bridge *br;
> > -       int ret;
> >
> >         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >         if (!priv)
> > @@ -69,18 +68,14 @@ static int fme_br_probe(struct platform_device *pdev)
> >
> >         priv->pdata = dev_get_platdata(dev);
> >
> > -       br = fpga_bridge_create(dev, "DFL FPGA FME Bridge",
> > -                               &fme_bridge_ops, priv);
> > +       br = devm_fpga_bridge_create(dev, "DFL FPGA FME Bridge",
> > +                                    &fme_bridge_ops, priv);
> >         if (!br)
> >                 return -ENOMEM;
> >
> >         platform_set_drvdata(pdev, br);
> >
> > -       ret = fpga_bridge_register(br);
> > -       if (ret)
> > -               fpga_bridge_free(br);
> > -
> > -       return ret;
> > +       return fpga_bridge_register(br);
> >  }
> >
> >  static int fme_br_remove(struct platform_device *pdev)
> > diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> > index 24b8f98..c39d35f 100644
> > --- a/drivers/fpga/fpga-bridge.c
> > +++ b/drivers/fpga/fpga-bridge.c
> > @@ -324,6 +324,9 @@ ATTRIBUTE_GROUPS(fpga_bridge);
> >   * @br_ops:    pointer to structure of fpga bridge ops
> >   * @priv:      FPGA bridge private data
> >   *
> > + * The caller of this function is responsible for freeing the bridge with
> > + * fpga_bridge_free().  Using devm_fpga_bridge_create() instead is recommended.
> > + *
> >   * Return: struct fpga_bridge or NULL
> >   */
> >  struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
> > @@ -378,8 +381,8 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
> >  EXPORT_SYMBOL_GPL(fpga_bridge_create);
> >
> >  /**
> > - * fpga_bridge_free - free a fpga bridge and its id
> > - * @bridge:    FPGA bridge struct created by fpga_bridge_create
> > + * fpga_bridge_free - free a fpga bridge created by fpga_bridge_create()
> > + * @bridge:    FPGA bridge struct
> >   */
> >  void fpga_bridge_free(struct fpga_bridge *bridge)
> >  {
> > @@ -388,9 +391,56 @@ void fpga_bridge_free(struct fpga_bridge *bridge)
> >  }
> >  EXPORT_SYMBOL_GPL(fpga_bridge_free);
> >
> > +static void devm_fpga_bridge_release(struct device *dev, void *res)
> > +{
> > +       struct fpga_bridge *bridge = *(struct fpga_bridge **)res;
> > +
> > +       fpga_bridge_free(bridge);
> > +}
> > +
> >  /**
> > - * fpga_bridge_register - register a fpga bridge
> > - * @bridge:    FPGA bridge struct created by fpga_bridge_create
> > + * devm_fpga_bridge_create - create and init a managed struct fpga_bridge
> > + * @dev:       FPGA bridge device from pdev
> > + * @name:      FPGA bridge name
> > + * @br_ops:    pointer to structure of fpga bridge ops
> > + * @priv:      FPGA bridge private data
> > + *
> > + * This function is intended for use in a FPGA bridge driver's probe function.
> > + * After the bridge driver creates the struct with devm_fpga_bridge_create(), it
> > + * should register the bridge with fpga_bridge_register().  The bridge driver's
> > + * remove function should call fpga_bridge_unregister().  The bridge struct
> > + * allocated with this function will be freed automatically on driver detach.
> > + * This includes the case of a probe function returning error before calling
> > + * fpga_bridge_register(), the struct will still get cleaned up.
> > + *
> > + *  Return: struct fpga_bridge or NULL
> > + */
> > +struct fpga_bridge
> > +*devm_fpga_bridge_create(struct device *dev, const char *name,
> > +                        const struct fpga_bridge_ops *br_ops, void *priv)
> > +{
> > +       struct fpga_bridge **ptr, *bridge;
> > +
> > +       ptr = devres_alloc(devm_fpga_bridge_release, sizeof(*ptr), GFP_KERNEL);
> > +       if (!ptr)
> > +               return NULL;
> > +
> > +       bridge = fpga_bridge_create(dev, name, br_ops, priv);
> > +       if (!bridge) {
> > +               devres_free(ptr);
> > +       } else {
> > +               *ptr = bridge;
> > +               devres_add(dev, ptr);
> > +       }
> > +
> > +       return bridge;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_fpga_bridge_create);
> > +
> > +/**
> > + * fpga_bridge_register - register a FPGA bridge
> > + *
> > + * @bridge: FPGA bridge struct
> >   *
> >   * Return: 0 for success, error code otherwise.
> >   */
> > @@ -412,8 +462,15 @@ int fpga_bridge_register(struct fpga_bridge *bridge)
> >  EXPORT_SYMBOL_GPL(fpga_bridge_register);
> >
> >  /**
> > - * fpga_bridge_unregister - unregister and free a fpga bridge
> > - * @bridge:    FPGA bridge struct created by fpga_bridge_create
> > + * fpga_bridge_unregister - unregister a FPGA bridge
> > + *
> > + * @bridge: FPGA bridge struct
> > + *
> > + * This function is intended for use in a FPGA bridge driver's remove function.
> > + * If the bridge was created with devm_fpga_bridge_create(), the bridge struct
> > + * will be automatically freed.  If the bridge was created with
> > + * fpga_bridge_create(), the caller is responsible for freeing the bridge with
> > + * fpga_bridge_free().
>
> I find the formulation somewhat confusing, since it could be
> interpreted as if you
> used the devm_() functions you don't have to call unregister().

Yes I'm being too verbose and it's making things muddled.  How about
if I take out the part that starts with "If bridge was created..."?
That just leaves "This function is intended for use in a FPGA bridge
driver's remove function."

Alan

> >   */
> >  void fpga_bridge_unregister(struct fpga_bridge *bridge)
> >  {
> > @@ -430,9 +487,6 @@ EXPORT_SYMBOL_GPL(fpga_bridge_unregister);
> >
> >  static void fpga_bridge_dev_release(struct device *dev)
> >  {
> > -       struct fpga_bridge *bridge = to_fpga_bridge(dev);
> > -
> > -       fpga_bridge_free(bridge);
> >  }
> >
> >  static int __init fpga_bridge_dev_init(void)
> > diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> > index 07ba153..6410361 100644
> > --- a/drivers/fpga/xilinx-pr-decoupler.c
> > +++ b/drivers/fpga/xilinx-pr-decoupler.c
> > @@ -121,8 +121,8 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
> >
> >         clk_disable(priv->clk);
> >
> > -       br = fpga_bridge_create(&pdev->dev, "Xilinx PR Decoupler",
> > -                               &xlnx_pr_decoupler_br_ops, priv);
> > +       br = devm_fpga_bridge_create(&pdev->dev, "Xilinx PR Decoupler",
> > +                                    &xlnx_pr_decoupler_br_ops, priv);
> >         if (!br) {
> >                 err = -ENOMEM;
> >                 goto err_clk;
> > diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
> > index ce550fc..817600a 100644
> > --- a/include/linux/fpga/fpga-bridge.h
> > +++ b/include/linux/fpga/fpga-bridge.h
> > @@ -69,4 +69,8 @@ void fpga_bridge_free(struct fpga_bridge *br);
> >  int fpga_bridge_register(struct fpga_bridge *br);
> >  void fpga_bridge_unregister(struct fpga_bridge *br);
> >
> > +struct fpga_bridge
> > +*devm_fpga_bridge_create(struct device *dev, const char *name,
> > +                        const struct fpga_bridge_ops *br_ops, void *priv);
> > +
> >  #endif /* _LINUX_FPGA_BRIDGE_H */
> > --
> > 2.7.4
> >
>
> Thanks,
>
> Moritz
