Return-Path: <SRS0=oYh2=7F=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=oYh2=7F=intel.com=hao.wu@kernel.org>
Date: Thu, 3 Aug 2017 15:53:35 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH RFC] fpga: add FPGA Bus device framework
Message-ID: <20170803075335.GA4120@hao-dev>
References: <1501676385-32551-1-git-send-email-hao.wu@intel.com>
 <CANk1AXQs4bTwV9JeVC2B3HoEd+q39R4i3z4pvcZaRjj0bsLr0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXQs4bTwV9JeVC2B3HoEd+q39R4i3z4pvcZaRjj0bsLr0g@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Aug 02, 2017 at 04:16:32PM -0500, Alan Tull wrote:
> On Wed, Aug 2, 2017 at 7:19 AM, Wu Hao <hao.wu@intel.com> wrote:
> > This patch is a RFC patch which replaces the patch[1] which
> > creates 'fpga-dev' class as container device. It introduces
> > a 'fpga' bus type, and provides interfaces to create/destroy
> > fpga bus devices. This fpga bus device only could be used as
> > a container device, and no drivers needed for it.
> >
> > There is no interface change, so this patch could be used
> > together with other patches of the original patch set[2].
> >
> 
> I am wondering whether this could be added to fpga-bridge.c so that
> fpga-bridge becomes the fpga bus and fpga bus devices are under it.
> The reasons for doing this are discussed in the other thread.
> 
> > This following APIs are provided by FPGA Bus device framework:
> > * fpga_dev_create
> >   Create fpga bus device under the given parent device.
> > * fpga_dev_destroy
> >   Destroy fpga bus device
> 
> This is being used in such that each fpga-dev is a container for
> platform devices rather than fpga devices.  That's not what I was
> expecting. :)

Hi Alan

So does that mean in Intel FPGA PCIe driver, it needs to create
a fpga-bridge (as base bridge?), and this fpga-bridge should register
a fpga-bus and have a fpga bus device as its child, after that we can
use this fpga bus device as container device, and create sub feature
devices (e.g AFU and FME platform device) under it, and user application
could locate it in /sys/bus/fpga/devices/. Is my understanding correct? :)

And if we have second level fpga-bridge for PR regions, then they
should register fpga-bus and fpga bus type device as child too?
If yes, then we need a method for user application to distinguish
which one represents the FPGA device in /sys/bus/fpga/devices/, right?
It seems to be a similar case that we see a lot of regions in
/sys/class/fpga_region/ but not sure which one is the base region. :)

> 
> Alan
> 
> >
> > The following sysfs files are created:
> > * /sys/bus/fpga/devices/<fpga.x>/name
> >   Name of the fpga bus device.
> >
> > [1] http://marc.info/?l=linux-fpga&m=149844237209829&w=2
> > [2] http://marc.info/?l=linux-fpga&m=149844232609819&w=2
> >
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-fpga |   5 ++
> >  drivers/fpga/Kconfig                     |   6 ++
> >  drivers/fpga/Makefile                    |   3 +
> >  drivers/fpga/fpga-dev.c                  | 132 +++++++++++++++++++++++++++++++
> >  include/linux/fpga/fpga-dev.h            |  31 ++++++++
> >  5 files changed, 177 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-fpga
> >  create mode 100644 drivers/fpga/fpga-dev.c
> >  create mode 100644 include/linux/fpga/fpga-dev.h
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-fpga b/Documentation/ABI/testing/sysfs-bus-fpga
> > new file mode 100644
> > index 0000000..414e946
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-fpga
> > @@ -0,0 +1,5 @@
> > +What:          /sys/bus/fpga/devices/<fpga.x>/name
> > +Date:          August 2017
> > +KernelVersion: 4.13
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Name of FPGA bus device
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index d89eb52..b97a90e 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -12,6 +12,12 @@ config FPGA
> >           manager drivers.
> >
> >  if FPGA
> > +config FPGA_DEVICE
> > +       tristate "FPGA Bus Device Framework"
> > +       help
> > +         Say Y here if you want support for FPGA Bus devices from the
> > +         kernel. The FPGA Bus Device Framework adds a FPGA Bus type and
> > +         provide interfaces to create FPGA devices on the bus.
> >
> >  config FPGA_REGION
> >         tristate "FPGA Region"
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > index 08fc728..3eb254e 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -5,6 +5,9 @@
> >  # Core FPGA Manager Framework
> >  obj-$(CONFIG_FPGA)                     += fpga-mgr.o
> >
> > +# FPGA Bus Device Framework
> > +obj-$(CONFIG_FPGA_DEVICE)              += fpga-dev.o
> > +
> >  # FPGA Manager Drivers
> >  obj-$(CONFIG_FPGA_MGR_ICE40_SPI)       += ice40-spi.o
> >  obj-$(CONFIG_FPGA_MGR_SOCFPGA)         += socfpga.o
> > diff --git a/drivers/fpga/fpga-dev.c b/drivers/fpga/fpga-dev.c
> > new file mode 100644
> > index 0000000..ddf67bb
> > --- /dev/null
> > +++ b/drivers/fpga/fpga-dev.c
> > @@ -0,0 +1,132 @@
> > +/*
> > + * FPGA Bus Device Framework Driver
> > + *
> > + * Copyright (C) 2017 Intel Corporation, Inc.
> > + *
> > + * This work is licensed under the terms of the GNU GPL version 2. See
> > + * the COPYING file in the top-level directory.
> > + */
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/fpga/fpga-dev.h>
> > +
> > +static DEFINE_IDA(fpga_dev_ida);
> > +static bool is_bus_registered;
> 
> I wouldn't think init will be called more than once.  Did you run into
> a problem where it did?

It's used to prevent bus device creation if bus_register function
returns error. 

Thanks
Hao

> 
> > +
> > +static void fpga_dev_release(struct device *dev)
> > +{
> > +       struct fpga_dev *fdev = to_fpga_dev(dev);
> > +
> > +       ida_simple_remove(&fpga_dev_ida, fdev->dev.id);
> > +       kfree(fdev);
> > +}
> > +
> > +static const struct device_type fpga_dev_type = {
> > +       .name           = "fpga_dev",
> > +       .release        = fpga_dev_release,
> > +};
> > +
> > +static ssize_t name_show(struct device *dev,
> > +                        struct device_attribute *attr, char *buf)
> > +{
> > +       struct fpga_dev *fdev = to_fpga_dev(dev);
> > +
> > +       return sprintf(buf, "%s\n", fdev->name);
> > +}
> > +static DEVICE_ATTR_RO(name);
> > +
> > +static struct attribute *fpga_dev_attrs[] = {
> > +       &dev_attr_name.attr,
> > +       NULL,
> > +};
> > +ATTRIBUTE_GROUPS(fpga_dev);
> > +
> > +static struct bus_type fpga_bus_type = {
> > +       .name           = "fpga",
> > +};
> > +
> > +/**
> > + * fpga_dev_create - create a fpga device on fpga bus
> > + * @parent: parent device
> > + * @name: fpga bus device name
> > + *
> > + * Return fpga_dev struct for success, error code otherwise.
> > + */
> > +struct fpga_dev *fpga_dev_create(struct device *parent, const char *name)
> > +{
> > +       struct fpga_dev *fdev;
> > +       int id, ret = 0;
> > +
> > +       if (WARN_ON(!is_bus_registered))
> > +               return ERR_PTR(-ENODEV);
> > +
> > +       if (!name || !strlen(name)) {
> > +               dev_err(parent, "Attempt to register with no name!\n");
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       fdev = kzalloc(sizeof(*fdev), GFP_KERNEL);
> > +       if (!fdev)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       id = ida_simple_get(&fpga_dev_ida, 0, 0, GFP_KERNEL);
> > +       if (id < 0) {
> > +               ret = id;
> > +               goto error_kfree;
> > +       }
> > +
> > +       fdev->name = name;
> > +
> > +       device_initialize(&fdev->dev);
> > +       fdev->dev.type = &fpga_dev_type;
> > +       fdev->dev.bus = &fpga_bus_type;
> > +       fdev->dev.groups = fpga_dev_groups;
> > +       fdev->dev.parent = parent;
> > +       fdev->dev.id = id;
> > +
> > +       ret = dev_set_name(&fdev->dev, "fpga.%d", id);
> > +       if (ret)
> > +               goto error_device;
> > +
> > +       ret = device_add(&fdev->dev);
> > +       if (ret)
> > +               goto error_device;
> > +
> > +       dev_dbg(fdev->dev.parent, "fpga bus device [%s] created\n", fdev->name);
> > +
> > +       return fdev;
> > +
> > +error_device:
> > +       ida_simple_remove(&fpga_dev_ida, id);
> > +error_kfree:
> > +       kfree(fdev);
> > +
> > +       return ERR_PTR(ret);
> > +}
> > +EXPORT_SYMBOL_GPL(fpga_dev_create);
> > +
> > +static int __init fpga_bus_init(void)
> > +{
> > +       int ret;
> > +
> > +       pr_info("FPGA Bus Device Framework\n");
> > +
> > +       ret = bus_register(&fpga_bus_type);
> > +       if (ret)
> > +               return ret;
> > +
> > +       is_bus_registered = true;
> > +       return 0;
> > +}
> > +
> > +static void __exit fpga_bus_exit(void)
> > +{
> > +       bus_unregister(&fpga_bus_type);
> > +}
> > +
> > +MODULE_DESCRIPTION("FPGA Bus Device Framework");
> > +MODULE_LICENSE("GPL v2");
> > +
> > +subsys_initcall(fpga_bus_init);
> > +module_exit(fpga_bus_exit);
> > diff --git a/include/linux/fpga/fpga-dev.h b/include/linux/fpga/fpga-dev.h
> > new file mode 100644
> > index 0000000..7f6deb4
> > --- /dev/null
> > +++ b/include/linux/fpga/fpga-dev.h
> > @@ -0,0 +1,31 @@
> > +/*
> > + * FPGA Bus Device Framework driver Header
> > + *
> > + * Copyright (C) 2017 Intel Corporation, Inc.
> > + *
> > + * This work is licensed under the terms of the GNU GPL version 2. See
> > + * the COPYING file in the top-level directory.
> > + */
> > +#ifndef _LINUX_FPGA_DEV_H
> > +#define _LINUX_FPGA_DEV_H
> > +
> > +/**
> > + * struct fpga_dev - fpga bus device structure
> > + * @name: name of fpga bus device
> > + * @dev: fpga bus device
> > + */
> > +struct fpga_dev {
> > +       const char *name;
> > +       struct device dev;
> > +};
> > +
> > +#define to_fpga_dev(d) container_of(d, struct fpga_dev, dev)
> > +
> > +struct fpga_dev *fpga_dev_create(struct device *parent, const char *name);
> > +
> > +static inline void fpga_dev_destroy(struct fpga_dev *fdev)
> > +{
> > +       device_unregister(&fdev->dev);
> > +}
> > +
> > +#endif
> > --
> > 1.8.3.1
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
