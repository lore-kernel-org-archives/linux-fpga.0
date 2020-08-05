Return-Path: <SRS0=xNcZ=BP=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=xNcZ=BP=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH v3 3/4] fpga: dfl: create a dfl bus type to support DFL
 devices
Date: Wed, 5 Aug 2020 10:29:11 +0000
Message-ID: <DM6PR11MB38194B629A3DC70FC0E8A010854B0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
 <1596524715-18038-4-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1596524715-18038-4-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Xu, Yilun" <yilun.xu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "trix@redhat.com" <trix@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, "Weight, Russell H" <russell.h.weight@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

> Subject: [PATCH v3 3/4] fpga: dfl: create a dfl bus type to support DFL d=
evices
>=20
> A new bus type "dfl" is introduced for private features which are not
> initialized by DFL feature drivers (dfl-fme & dfl-afu drivers). So these
> private features could be handled by separate driver modules.
>=20
> DFL feature drivers (dfl-fme, dfl-port) will create DFL devices on
> enumeration. DFL drivers could be registered on this bus to match these
> DFL devices. They are matched by dfl type & feature_id.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v2: change the bus uevent format.
>     change the dfl device's sysfs name format.
>     refactor dfl_dev_add().
>     minor fixes for comments from Hao and Tom.
> v3: no change.
> ---
>  Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
>  drivers/fpga/dfl.c                      | 254 ++++++++++++++++++++++++++=
+++++-
>  drivers/fpga/dfl.h                      |  84 +++++++++++
>  3 files changed, 345 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl
> b/Documentation/ABI/testing/sysfs-bus-dfl
> new file mode 100644
> index 0000000..b1eea30
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-dfl
> @@ -0,0 +1,15 @@
> +What:		/sys/bus/dfl/devices/.../type

So it will be clear, that it's always dfl_dev.X/type here?

> +Date:		July 2020
> +KernelVersion:	5.9

Same as the other patches.

> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns type of DFL FIU of the device. Now DF=
L
> +		supports 2 FIU types, 0 for FME, 1 for PORT.
> +		Format: 0x%x
> +
> +What:		/sys/bus/dfl/devices/.../feature_id

Same?

> +Date:		July 2020
> +KernelVersion:	5.9

Ditto

> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns feature identifier local to its DFL F=
IU
> +		type.
> +		Format: 0x%x
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index c649239..978d182 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -30,12 +30,6 @@ static DEFINE_MUTEX(dfl_id_mutex);
>   * index to dfl_chardevs table. If no chardev support just set devt_type
>   * as one invalid index (DFL_FPGA_DEVT_MAX).
>   */
> -enum dfl_id_type {
> -	FME_ID,		/* fme id allocation and mapping */
> -	PORT_ID,	/* port id allocation and mapping */
> -	DFL_ID_MAX,
> -};
> -
>  enum dfl_fpga_devt_type {
>  	DFL_FPGA_DEVT_FME,
>  	DFL_FPGA_DEVT_PORT,
> @@ -250,6 +244,236 @@ int dfl_fpga_check_port_id(struct platform_device
> *pdev, void *pport_id)
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
>=20
> +static DEFINE_IDA(dfl_device_ida);
> +
> +static const struct dfl_device_id *
> +dfl_match_one_device(const struct dfl_device_id *id, struct dfl_device
> *ddev)
> +{
> +	if (id->type =3D=3D ddev->type && id->feature_id =3D=3D ddev->feature_i=
d)
> +		return id;
> +
> +	return NULL;
> +}
> +
> +static int dfl_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> +	struct dfl_driver *ddrv =3D to_dfl_drv(drv);
> +	const struct dfl_device_id *id_entry =3D ddrv->id_table;
> +
> +	if (id_entry) {
> +		while (id_entry->feature_id) {
> +			if (dfl_match_one_device(id_entry, ddev)) {
> +				ddev->id_entry =3D id_entry;
> +				return 1;
> +			}
> +			id_entry++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int dfl_bus_probe(struct device *dev)
> +{
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> +	struct dfl_driver *ddrv =3D to_dfl_drv(dev->driver);
> +
> +	return ddrv->probe(ddev);
> +}
> +
> +static int dfl_bus_remove(struct device *dev)
> +{
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> +	struct dfl_driver *ddrv =3D to_dfl_drv(dev->driver);
> +
> +	if (ddrv->remove)
> +		ddrv->remove(ddev);
> +
> +	return 0;
> +}
> +
> +static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *en=
v)
> +{
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> +
> +	return add_uevent_var(env, "MODALIAS=3Ddfl:t%08Xf%04X",
> +			      ddev->type, ddev->feature_id);

Then we only print 12bit of feature_id will be enough?
should we make type shorter as well as feature id?
And do you think if we should add a new field for dfl version?

> +}
> +
> +/* show dfl info fields */
> +#define dfl_info_attr(field, format_string)				\
> +static ssize_t								\
> +field##_show(struct device *dev, struct device_attribute *attr,
> 	\
> +	     char *buf)							\
> +{									\
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);			\
> +									\
> +	return sprintf(buf, format_string, ddev->field);		\
> +}									\
> +static DEVICE_ATTR_RO(field)
> +
> +dfl_info_attr(type, "0x%x\n");
> +dfl_info_attr(feature_id, "0x%x\n");
> +
> +static struct attribute *dfl_dev_attrs[] =3D {
> +	&dev_attr_type.attr,
> +	&dev_attr_feature_id.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(dfl_dev);
> +
> +static struct bus_type dfl_bus_type =3D {
> +	.name		=3D "dfl",
> +	.match		=3D dfl_bus_match,
> +	.probe		=3D dfl_bus_probe,
> +	.remove		=3D dfl_bus_remove,
> +	.uevent		=3D dfl_bus_uevent,
> +	.dev_groups	=3D dfl_dev_groups,
> +};
> +
> +static void release_dfl_dev(struct device *dev)
> +{
> +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> +
> +	if (ddev->mmio_res.parent)
> +		release_resource(&ddev->mmio_res);
> +
> +	ida_simple_remove(&dfl_device_ida, ddev->id);
> +	kfree(ddev->irqs);
> +	kfree(ddev);
> +}
> +
> +static struct dfl_device *
> +dfl_dev_add(struct dfl_feature_platform_data *pdata,
> +	    struct dfl_feature *feature)
> +{
> +	struct platform_device *pdev =3D pdata->dev;
> +	struct resource *parent_res;
> +	struct dfl_device *ddev;
> +	int id, i, ret;
> +
> +	ddev =3D kzalloc(sizeof(*ddev), GFP_KERNEL);

If we only consider add dfl device during initialization of=20
FME/PORT device, then it should be able to use devm_xx version?

> +	if (!ddev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	id =3D ida_simple_get(&dfl_device_ida, 0, 0, GFP_KERNEL);
> +	if (id < 0) {
> +		dev_err(&pdev->dev, "unable to get id\n");
> +		kfree(ddev);
> +		return ERR_PTR(id);
> +	}
> +
> +	/* freeing resources by put_device() after device_initialize() */
> +	device_initialize(&ddev->dev);
> +	ddev->dev.parent =3D &pdev->dev;
> +	ddev->dev.bus =3D &dfl_bus_type;
> +	ddev->dev.release =3D release_dfl_dev;
> +	ddev->id =3D id;
> +	ret =3D dev_set_name(&ddev->dev, "dfl_dev.%d", id);
> +	if (ret)
> +		goto put_dev;
> +
> +	ddev->type =3D feature_dev_id_type(pdev);
> +	ddev->feature_id =3D feature->id;
> +	ddev->cdev =3D pdata->dfl_cdev;
> +
> +	/* add mmio resource */
> +	parent_res =3D &pdev->resource[feature->resource_index];
> +	ddev->mmio_res.flags =3D IORESOURCE_MEM;
> +	ddev->mmio_res.start =3D parent_res->start;
> +	ddev->mmio_res.end =3D parent_res->end;
> +	ddev->mmio_res.name =3D dev_name(&ddev->dev);
> +	ret =3D insert_resource(parent_res, &ddev->mmio_res);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s failed to claim resource: %pR\n",
> +			dev_name(&ddev->dev), &ddev->mmio_res);
> +		goto put_dev;
> +	}
> +
> +	/* then add irq resource */
> +	if (feature->nr_irqs) {
> +		ddev->irqs =3D kcalloc(feature->nr_irqs,
> +				     sizeof(*ddev->irqs), GFP_KERNEL);
> +		if (!ddev->irqs) {
> +			ret =3D -ENOMEM;
> +			goto put_dev;
> +		}
> +
> +		for (i =3D 0; i < feature->nr_irqs; i++)
> +			ddev->irqs[i] =3D feature->irq_ctx[i].irq;
> +
> +		ddev->num_irqs =3D feature->nr_irqs;

Do we need to consider using IORESOURCE_IRQ here as well?

> +	}
> +
> +	ret =3D device_add(&ddev->dev);
> +	if (ret)
> +		goto put_dev;
> +
> +	dev_info(&pdev->dev, "add dfl_dev: %s\n", dev_name(&ddev->dev));
> +	return ddev;
> +
> +put_dev:
> +	/* calls release_dfl_dev() which does the clean up  */
> +	put_device(&ddev->dev);
> +	return ERR_PTR(ret);
> +}
> +
> +static void dfl_devs_uinit(struct dfl_feature_platform_data *pdata)
> +{
> +	struct dfl_device *ddev;
> +	struct dfl_feature *feature;
> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> +		if (!feature->ioaddr && feature->priv) {

Maybe we can add a new filed for ddev, then it will simplify
the checking. How do you think?

> +			ddev =3D feature->priv;
> +			device_unregister(&ddev->dev);
> +			feature->priv =3D NULL;
> +		}
> +	}
> +}
> +
> +static int dfl_devs_init(struct platform_device *pdev)
> +{
> +	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> +	struct dfl_feature *feature;
> +	struct dfl_device *ddev;
> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> +		if (feature->ioaddr || feature->priv)

Why checks priv here?

> +			continue;
> +
> +		ddev =3D dfl_dev_add(pdata, feature);
> +		if (IS_ERR(ddev)) {
> +			dfl_devs_uinit(pdata);
> +			return PTR_ERR(ddev);
> +		}
> +
> +		feature->priv =3D ddev;
> +	}
> +
> +	return 0;
> +}
> +
> +int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *own=
er)
> +{
> +	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
> +		return -EINVAL;
> +
> +	dfl_drv->drv.owner =3D owner;
> +	dfl_drv->drv.bus =3D &dfl_bus_type;
> +
> +	return driver_register(&dfl_drv->drv);
> +}
> +EXPORT_SYMBOL(__dfl_driver_register);
> +
> +void dfl_driver_unregister(struct dfl_driver *dfl_drv)
> +{
> +	driver_unregister(&dfl_drv->drv);
> +}
> +EXPORT_SYMBOL(dfl_driver_unregister);
> +
>  #define is_header_feature(feature) ((feature)->id =3D=3D
> FEATURE_ID_FIU_HEADER)
>=20
>  /**
> @@ -261,12 +485,15 @@ void dfl_fpga_dev_feature_uinit(struct
> platform_device *pdev)
>  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
>  	struct dfl_feature *feature;
>=20
> -	dfl_fpga_dev_for_each_feature(pdata, feature)
> +	dfl_devs_uinit(pdata);

Then you loop each feature twice, but they can be done in one loop ideally?

> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
>  		if (feature->ops) {
>  			if (feature->ops->uinit)
>  				feature->ops->uinit(pdev, feature);
>  			feature->ops =3D NULL;
>  		}
> +	}
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_uinit);
>=20
> @@ -347,6 +574,10 @@ int dfl_fpga_dev_feature_init(struct
> platform_device *pdev,
>  		drv++;
>  	}
>=20
> +	ret =3D dfl_devs_init(pdev);
> +	if (ret)
> +		goto exit;
> +
>  	return 0;
>  exit:
>  	dfl_fpga_dev_feature_uinit(pdev);
> @@ -1284,11 +1515,17 @@ static int __init dfl_fpga_init(void)
>  {
>  	int ret;
>=20
> +	ret =3D bus_register(&dfl_bus_type);
> +	if (ret)
> +		return ret;
> +
>  	dfl_ids_init();
>=20
>  	ret =3D dfl_chardev_init();
> -	if (ret)
> +	if (ret) {
>  		dfl_ids_destroy();
> +		bus_unregister(&dfl_bus_type);
> +	}
>=20
>  	return ret;
>  }
> @@ -1626,6 +1863,7 @@ static void __exit dfl_fpga_exit(void)
>  {
>  	dfl_chardev_uinit();
>  	dfl_ids_destroy();
> +	bus_unregister(&dfl_bus_type);
>  }
>=20
>  module_init(dfl_fpga_init);
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 5973769..667e1c9 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -514,4 +514,88 @@ long dfl_feature_ioctl_set_irq(struct
> platform_device *pdev,
>  			       struct dfl_feature *feature,
>  			       unsigned long arg);
>=20
> +/**
> + * enum dfl_id_type - define the DFL FIU types
> + */
> +enum dfl_id_type {
> +	FME_ID,
> +	PORT_ID,
> +	DFL_ID_MAX,
> +};
> +
> +/**
> + * struct dfl_device_id -  dfl device identifier
> + * @type: Type of DFL FIU of the device. See enum dfl_id_type.
> + * @feature_id: 16 bits feature identifier local to its DFL FIU type.

Actually 12bits are used.

> + * @driver_data: Driver specific data
> + */
> +struct dfl_device_id {
> +	unsigned int type;
> +	u16 feature_id;
> +	unsigned long driver_data;
> +};
> +
> +/**
> + * struct dfl_device - represent an dfl device on dfl bus
> + *
> + * @dev: Generic device interface.
> + * @id: id of the dfl device
> + * @type: Type of DFL FIU of the device. See enum dfl_id_type.
> + * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> + * @mmio_res: MMIO resource of this dfl device.
> + * @irqs: List of Linux IRQ numbers of this dfl device.
> + * @num_irqs: number of IRQs supported by this dfl device.
> + * @cdev: pointer to DFL FPGA container device this dfl device belongs t=
o.
> + * @id_entry: matched id entry in dfl driver's id table.
> + */
> +struct dfl_device {
> +	struct device dev;
> +	int id;
> +	unsigned int type;
> +	u16 feature_id;
> +	struct resource mmio_res;
> +	int *irqs;
> +	unsigned int num_irqs;
> +	struct dfl_fpga_cdev *cdev;
> +	const struct dfl_device_id *id_entry;
> +};
> +
> +/**
> + * struct dfl_driver - represent an dfl device driver
> + *
> + * @drv: Driver model structure.
> + * @id_table: Pointer to table of device IDs the driver is interested in=
.
> + *	      { } member terminated.
> + * @probe: Callback for device binding.

Please add "Mandatory callback" in the description.

Thanks
Hao

> + * @remove: Callback for device unbinding.
> + */
> +struct dfl_driver {
> +	struct device_driver drv;
> +	const struct dfl_device_id *id_table;
> +
> +	int (*probe)(struct dfl_device *dfl_dev);
> +	void (*remove)(struct dfl_device *dfl_dev);
> +};
> +
> +#define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
> +#define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
> +
> +/*
> + * use a macro to avoid include chaining to get THIS_MODULE
> + */
> +#define dfl_driver_register(drv) \
> +	__dfl_driver_register(drv, THIS_MODULE)
> +int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *own=
er);
> +void dfl_driver_unregister(struct dfl_driver *dfl_drv);
> +
> +/*
> + * module_dfl_driver() - Helper macro for drivers that don't do
> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces module_init() and module_exit()
> + */
> +#define module_dfl_driver(__dfl_driver) \
> +	module_driver(__dfl_driver, dfl_driver_register, \
> +		      dfl_driver_unregister)
> +
>  #endif /* __FPGA_DFL_H */
> --
> 2.7.4
