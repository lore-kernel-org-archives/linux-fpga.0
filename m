Return-Path: <SRS0=W4OC=A4=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=W4OC=A4=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH 1/2] fpga: dfl: map feature mmio resources in their own
 feature drivers
Date: Fri, 17 Jul 2020 09:48:55 +0000
Message-ID: <DM6PR11MB38191364DD24B9C301AB9A1F857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <1594791498-14495-2-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1594791498-14495-2-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Xu, Yilun" <yilun.xu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "trix@redhat.com" <trix@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, "Weight, Russell H" <russell.h.weight@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

> -----Original Message-----
> From: linux-fpga-owner@vger.kernel.org <linux-fpga-owner@vger.kernel.org>
> On Behalf Of Xu Yilun
> Sent: Wednesday, July 15, 2020 1:38 PM
> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: trix@redhat.com; lgoncalv@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
> Wu, Hao <hao.wu@intel.com>; Matthew Gerlach
> <matthew.gerlach@linux.intel.com>; Weight, Russell H
> <russell.h.weight@intel.com>
> Subject: [PATCH 1/2] fpga: dfl: map feature mmio resources in their own
> feature drivers
>=20
> This patch makes preparation for modularization of DFL sub feature
> drivers.
>=20
> Currently, if we need to support a new DFL sub feature, an entry should
> be added to fme/port_feature_drvs[] in dfl-fme/port-main.c. And we need
> to re-compile the whole DFL modules. That make the DFL drivers hard to be
> extended.
>=20
> Another consideration is that DFL may contain some IP blocks which are
> already supported by kernel, most of them are supported by platform
> device drivers. We could create platform devices for these IP blocks and
> get them supported by these drivers.
>=20
> An important issue is that platform device drivers usually requests mmio
> resources on probe. But now dfl mmio is mapped in dfl bus driver (e.g.
> dfl-pci) as a whole region. Then platform device drivers for sub features
> can't request their own mmio resources again. This is what the patch
> trying to resolve.
>=20
> This patch changes the DFL enumeration. DFL bus driver will unmap mmio
> resources after first step enumeration and pass enumeration info to DFL
> framework. Then DFL framework will map the mmio resources again, do 2nd
> step enumeration, and also unmap the mmio resources. In this way, sub
> feature drivers could then request their own mmio resources as needed.
>=20
> An exception is that mmio resource of FIU headers are still mapped in dfl
> bus driver. The FIU headers have some fundamental functions (sriov set,
> port enable/disable) needed for dfl bus devices and other sub features.
> They should not be unmapped as long as dfl bus device is alive.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/dfl-pci.c |  21 ++++--
>  drivers/fpga/dfl.c     | 187 +++++++++++++++++++++++++++++++++++--------=
---
> ---
>  drivers/fpga/dfl.h     |   6 +-
>  3 files changed, 152 insertions(+), 62 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index e220bec..22dc025 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -39,6 +39,11 @@ static void __iomem *cci_pci_ioremap_bar(struct
> pci_dev *pcidev, int bar)
>  	return pcim_iomap_table(pcidev)[bar];
>  }
>=20
> +static void cci_pci_iounmap_bars(struct pci_dev *pcidev, int mapped_bars=
)
> +{
> +	pcim_iounmap_regions(pcidev, mapped_bars);
> +}
> +
>  static int cci_pci_alloc_irq(struct pci_dev *pcidev)
>  {
>  	int ret, nvec =3D pci_msix_vec_count(pcidev);
> @@ -123,7 +128,7 @@ static int *cci_pci_create_irq_table(struct pci_dev
> *pcidev, unsigned int nvec)
>  static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>  {
>  	struct cci_drvdata *drvdata =3D pci_get_drvdata(pcidev);
> -	int port_num, bar, i, nvec, ret =3D 0;
> +	int port_num, bar, i, nvec, mapped_bars, ret =3D 0;
>  	struct dfl_fpga_enum_info *info;
>  	struct dfl_fpga_cdev *cdev;
>  	resource_size_t start, len;
> @@ -163,6 +168,8 @@ static int cci_enumerate_feature_devs(struct pci_dev
> *pcidev)
>  		goto irq_free_exit;
>  	}
>=20
> +	mapped_bars =3D BIT(0);
> +
>  	/*
>  	 * PF device has FME and Ports/AFUs, and VF device only has one
>  	 * Port/AFU. Check them and add related "Device Feature List" info
> @@ -172,7 +179,7 @@ static int cci_enumerate_feature_devs(struct pci_dev
> *pcidev)
>  		start =3D pci_resource_start(pcidev, 0);
>  		len =3D pci_resource_len(pcidev, 0);
>=20
> -		dfl_fpga_enum_info_add_dfl(info, start, len, base);
> +		dfl_fpga_enum_info_add_dfl(info, start, len);
>=20
>  		/*
>  		 * find more Device Feature Lists (e.g. Ports) per information
> @@ -200,22 +207,26 @@ static int cci_enumerate_feature_devs(struct
> pci_dev *pcidev)
>  			if (!base)
>  				continue;
>=20
> +			mapped_bars |=3D BIT(bar);
> +
>  			start =3D pci_resource_start(pcidev, bar) + offset;
>  			len =3D pci_resource_len(pcidev, bar) - offset;
>=20
> -			dfl_fpga_enum_info_add_dfl(info, start, len,
> -						   base + offset);
> +			dfl_fpga_enum_info_add_dfl(info, start, len);
>  		}
>  	} else if (dfl_feature_is_port(base)) {
>  		start =3D pci_resource_start(pcidev, 0);
>  		len =3D pci_resource_len(pcidev, 0);
>=20
> -		dfl_fpga_enum_info_add_dfl(info, start, len, base);
> +		dfl_fpga_enum_info_add_dfl(info, start, len);
>  	} else {
>  		ret =3D -ENODEV;
>  		goto irq_free_exit;
>  	}
>=20
> +	/* release I/O mappings for next step enumeration */
> +	cci_pci_iounmap_bars(pcidev, mapped_bars);
> +
>  	/* start enumeration with prepared enumeration information */
>  	cdev =3D dfl_fpga_feature_devs_enumerate(info);
>  	if (IS_ERR(cdev)) {
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 649958a..7dc6411 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -250,6 +250,11 @@ int dfl_fpga_check_port_id(struct platform_device
> *pdev, void *pport_id)
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
>=20
> +static bool is_header_feature(struct dfl_feature *feature)
> +{
> +	return feature->id =3D=3D FEATURE_ID_FIU_HEADER;
> +}
> +
>  /**
>   * dfl_fpga_dev_feature_uinit - uinit for sub features of dfl feature de=
vice
>   * @pdev: feature device.
> @@ -273,8 +278,20 @@ static int dfl_feature_instance_init(struct
> platform_device *pdev,
>  				     struct dfl_feature *feature,
>  				     struct dfl_feature_driver *drv)
>  {
> +	void __iomem *base;
>  	int ret =3D 0;
>=20
> +	if (!is_header_feature(feature)) {
> +		base =3D devm_platform_ioremap_resource(pdev,
> +						      feature->resource_index);
> +		if (IS_ERR(base)) {
> +			dev_err(&pdev->dev, "fail to get iomem
> resource!\n");

Maybe you want to show which feature failed with ioremap here?

> +			return PTR_ERR(base);
> +		}
> +
> +		feature->ioaddr =3D base;
> +	}
> +
>  	if (drv->ops->init) {
>  		ret =3D drv->ops->init(pdev, feature);
>  		if (ret)
> @@ -427,7 +444,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
>   * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq inde=
x of
>   *	       this device.
>   * @feature_dev: current feature device.
> - * @ioaddr: header register region address of feature device in enumerat=
ion.
> + * @ioaddr: header register region address of current FIU in enumeration=
.
> + * @start: register resource start of current FIU.
> + * @len: max register resource length of current FIU.
>   * @sub_features: a sub features linked list for feature device in
> enumeration.
>   * @feature_num: number of sub features for feature device in
> enumeration.
>   */
> @@ -439,6 +458,9 @@ struct build_feature_devs_info {
>=20
>  	struct platform_device *feature_dev;
>  	void __iomem *ioaddr;
> +	resource_size_t start;
> +	resource_size_t len;
> +
>  	struct list_head sub_features;
>  	int feature_num;
>  };
> @@ -484,10 +506,7 @@ static int build_info_commit_dev(struct
> build_feature_devs_info *binfo)
>  	struct dfl_feature_platform_data *pdata;
>  	struct dfl_feature_info *finfo, *p;
>  	enum dfl_id_type type;
> -	int ret, index =3D 0;
> -
> -	if (!fdev)
> -		return 0;

Why you remove this checking?

> +	int ret, index =3D 0, res_idx =3D 0;
>=20
>  	type =3D feature_dev_id_type(fdev);
>  	if (WARN_ON_ONCE(type >=3D DFL_ID_MAX))
> @@ -530,16 +549,30 @@ static int build_info_commit_dev(struct
> build_feature_devs_info *binfo)
>=20
>  	/* fill features and resource information for feature dev */
>  	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
> -		struct dfl_feature *feature =3D &pdata->features[index];
> +		struct dfl_feature *feature =3D &pdata->features[index++];
>  		struct dfl_feature_irq_ctx *ctx;
>  		unsigned int i;
>=20
>  		/* save resource information for each feature */
>  		feature->dev =3D fdev;
>  		feature->id =3D finfo->fid;
> -		feature->resource_index =3D index;
> -		feature->ioaddr =3D finfo->ioaddr;
> -		fdev->resource[index++] =3D finfo->mmio_res;
> +
> +		/*
> +		 * map header resource for dfl bus device. Don't add header
> +		 * resource to feature devices, or the resource tree will be
> +		 * disordered and cause warning on resource release
> +		 */
> +		if (is_header_feature(feature)) {
> +			feature->resource_index =3D -1;
> +			feature->ioaddr =3D
> +				devm_ioremap_resource(binfo->dev,
> +						      &finfo->mmio_res);
> +			if (IS_ERR(feature->ioaddr))
> +				return PTR_ERR(feature->ioaddr);

For current device, this should work, I am not sure if we still need pass
the resource to header features, but if we consider that some header
features want to mmap resource to userspace, then only passing ioaddr
may not be enough for that case.

> +		} else {
> +			feature->resource_index =3D res_idx;
> +			fdev->resource[res_idx++] =3D finfo->mmio_res;
> +		}
>=20
>  		if (finfo->nr_irqs) {
>  			ctx =3D devm_kcalloc(binfo->dev, finfo->nr_irqs,
> @@ -582,19 +615,13 @@ static int build_info_commit_dev(struct
> build_feature_devs_info *binfo)
>=20
>  static int
>  build_info_create_dev(struct build_feature_devs_info *binfo,
> -		      enum dfl_id_type type, void __iomem *ioaddr)
> +		      enum dfl_id_type type)
>  {
>  	struct platform_device *fdev;
> -	int ret;
>=20
>  	if (type >=3D DFL_ID_MAX)
>  		return -EINVAL;
>=20
> -	/* we will create a new device, commit current device first */
> -	ret =3D build_info_commit_dev(binfo);
> -	if (ret)
> -		return ret;
> -
>  	/*
>  	 * we use -ENODEV as the initialization indicator which indicates
>  	 * whether the id need to be reclaimed
> @@ -605,7 +632,7 @@ build_info_create_dev(struct
> build_feature_devs_info *binfo,
>=20
>  	binfo->feature_dev =3D fdev;
>  	binfo->feature_num =3D 0;
> -	binfo->ioaddr =3D ioaddr;
> +
>  	INIT_LIST_HEAD(&binfo->sub_features);
>=20
>  	fdev->id =3D dfl_id_alloc(type, &fdev->dev);
> @@ -747,18 +774,17 @@ static int parse_feature_irqs(struct
> build_feature_devs_info *binfo,
>   */
>  static int
>  create_feature_instance(struct build_feature_devs_info *binfo,
> -			struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst,
> -			resource_size_t size, u64 fid)
> +			resource_size_t ofst, resource_size_t size, u64 fid)
>  {
>  	unsigned int irq_base, nr_irqs;
>  	struct dfl_feature_info *finfo;
>  	int ret;
>=20
>  	/* read feature size and id if inputs are invalid */
> -	size =3D size ? size : feature_size(dfl->ioaddr + ofst);
> -	fid =3D fid ? fid : feature_id(dfl->ioaddr + ofst);
> +	size =3D size ? size : feature_size(binfo->ioaddr + ofst);
> +	fid =3D fid ? fid : feature_id(binfo->ioaddr + ofst);
>=20
> -	if (dfl->len - ofst < size)
> +	if (binfo->len - ofst < size)
>  		return -EINVAL;
>=20
>  	ret =3D parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
> @@ -770,12 +796,11 @@ create_feature_instance(struct
> build_feature_devs_info *binfo,
>  		return -ENOMEM;
>=20
>  	finfo->fid =3D fid;
> -	finfo->mmio_res.start =3D dfl->start + ofst;
> +	finfo->mmio_res.start =3D binfo->start + ofst;
>  	finfo->mmio_res.end =3D finfo->mmio_res.start + size - 1;
>  	finfo->mmio_res.flags =3D IORESOURCE_MEM;
>  	finfo->irq_base =3D irq_base;
>  	finfo->nr_irqs =3D nr_irqs;
> -	finfo->ioaddr =3D dfl->ioaddr + ofst;
>=20
>  	list_add_tail(&finfo->node, &binfo->sub_features);
>  	binfo->feature_num++;
> @@ -784,7 +809,6 @@ create_feature_instance(struct
> build_feature_devs_info *binfo,
>  }
>=20
>  static int parse_feature_port_afu(struct build_feature_devs_info *binfo,
> -				  struct dfl_fpga_enum_dfl *dfl,
>  				  resource_size_t ofst)
>  {
>  	u64 v =3D readq(binfo->ioaddr + PORT_HDR_CAP);
> @@ -792,11 +816,10 @@ static int parse_feature_port_afu(struct
> build_feature_devs_info *binfo,
>=20
>  	WARN_ON(!size);
>=20
> -	return create_feature_instance(binfo, dfl, ofst, size,
> FEATURE_ID_AFU);
> +	return create_feature_instance(binfo, ofst, size, FEATURE_ID_AFU);
>  }
>=20
>  static int parse_feature_afu(struct build_feature_devs_info *binfo,
> -			     struct dfl_fpga_enum_dfl *dfl,
>  			     resource_size_t ofst)
>  {
>  	if (!binfo->feature_dev) {
> @@ -806,7 +829,7 @@ static int parse_feature_afu(struct
> build_feature_devs_info *binfo,
>=20
>  	switch (feature_dev_id_type(binfo->feature_dev)) {
>  	case PORT_ID:
> -		return parse_feature_port_afu(binfo, dfl, ofst);
> +		return parse_feature_port_afu(binfo, ofst);
>  	default:
>  		dev_info(binfo->dev, "AFU belonging to FIU %s is not
> supported yet.\n",
>  			 binfo->feature_dev->name);
> @@ -815,35 +838,91 @@ static int parse_feature_afu(struct
> build_feature_devs_info *binfo,
>  	return 0;
>  }
>=20
> +static bool is_feature_dev_detected(struct build_feature_devs_info *binf=
o)
> +{
> +	return !!binfo->feature_dev;
> +}
> +
> +static void dfl_binfo_shift(struct build_feature_devs_info *binfo,
> +			    resource_size_t ofst)
> +{
> +	binfo->start =3D binfo->start + ofst;
> +	binfo->len =3D binfo->len - ofst;
> +}
> +
> +static int dfl_binfo_prepare(struct build_feature_devs_info *binfo,
> +			     resource_size_t start, resource_size_t len)
> +{
> +	struct device *dev =3D binfo->dev;
> +	void __iomem *ioaddr;
> +
> +	if (!devm_request_mem_region(dev, start, len, dev_name(dev))) {
> +		dev_err(dev, "request region fail, start:%pa, len:%pa\n",
> +			&start, &len);
> +		return -ENOMEM;

Why ENOMEM? Or -EBUSY is better?

> +	}
> +
> +	ioaddr =3D devm_ioremap(dev, start, len);
> +	if (!ioaddr) {
> +		dev_err(dev, "ioremap region fail, start:%pa, len:%pa\n",
> +			&start, &len);
> +		devm_release_mem_region(dev, start, len);
> +		return -EFAULT;

Why EFAULT? Or -ENOMEM?

> +	}
> +
> +	binfo->start =3D start;
> +	binfo->len =3D len;
> +	binfo->ioaddr =3D ioaddr;
> +
> +	return 0;
> +}
> +
> +static void dfl_binfo_finish(struct build_feature_devs_info *binfo)
> +{
> +	devm_iounmap(binfo->dev, binfo->ioaddr);
> +	devm_release_mem_region(binfo->dev, binfo->start, binfo->len);
> +}
> +
>  static int parse_feature_fiu(struct build_feature_devs_info *binfo,
> -			     struct dfl_fpga_enum_dfl *dfl,
>  			     resource_size_t ofst)
>  {
>  	u32 id, offset;
>  	u64 v;
>  	int ret =3D 0;
>=20
> -	v =3D readq(dfl->ioaddr + ofst + DFH);
> +	if (is_feature_dev_detected(binfo)) {
> +		dfl_binfo_finish(binfo);
> +
> +		ret =3D build_info_commit_dev(binfo);
> +		if (ret)
> +			return ret;
> +
> +		dfl_binfo_prepare(binfo, binfo->start + ofst,
> +				  binfo->len - ofst);
> +	} else {
> +		dfl_binfo_shift(binfo, ofst);

Any possibility that it can fall into this case? or we can just drop it?

> +	}
> +
> +	v =3D readq(binfo->ioaddr + DFH);

And if you do shift start and len in binfo, but no shift to ioaddr here?

>  	id =3D FIELD_GET(DFH_ID, v);
>=20
>  	/* create platform device for dfl feature dev */
> -	ret =3D build_info_create_dev(binfo, dfh_id_to_type(id),
> -				    dfl->ioaddr + ofst);
> +	ret =3D build_info_create_dev(binfo, dfh_id_to_type(id));
>  	if (ret)
>  		return ret;
>=20
> -	ret =3D create_feature_instance(binfo, dfl, ofst, 0, 0);
> +	ret =3D create_feature_instance(binfo, 0, 0, 0);
>  	if (ret)
>  		return ret;
>  	/*
>  	 * find and parse FIU's child AFU via its NEXT_AFU register.
>  	 * please note that only Port has valid NEXT_AFU pointer per spec.
>  	 */
> -	v =3D readq(dfl->ioaddr + ofst + NEXT_AFU);
> +	v =3D readq(binfo->ioaddr + NEXT_AFU);
>=20
>  	offset =3D FIELD_GET(NEXT_AFU_NEXT_DFH_OFST, v);
>  	if (offset)
> -		return parse_feature_afu(binfo, dfl, ofst + offset);
> +		return parse_feature_afu(binfo, offset);
>=20
>  	dev_dbg(binfo->dev, "No AFUs detected on FIU %d\n", id);
>=20
> @@ -851,16 +930,15 @@ static int parse_feature_fiu(struct
> build_feature_devs_info *binfo,
>  }
>=20
>  static int parse_feature_private(struct build_feature_devs_info *binfo,
> -				 struct dfl_fpga_enum_dfl *dfl,
>  				 resource_size_t ofst)
>  {
>  	if (!binfo->feature_dev) {
>  		dev_err(binfo->dev, "the private feature %llx does not belong
> to any AFU.\n",
> -			(unsigned long long)feature_id(dfl->ioaddr + ofst));
> +			(unsigned long long)feature_id(binfo->ioaddr + ofst));
>  		return -EINVAL;
>  	}
>=20
> -	return create_feature_instance(binfo, dfl, ofst, 0, 0);
> +	return create_feature_instance(binfo, ofst, 0, 0);
>  }
>=20
>  /**
> @@ -868,24 +946,24 @@ static int parse_feature_private(struct
> build_feature_devs_info *binfo,
>   *
>   * @binfo: build feature devices information.
>   * @dfl: device feature list to parse
> - * @ofst: offset to feature header on this device feature list
> + * @ofst: offset to current FIU header
>   */
>  static int parse_feature(struct build_feature_devs_info *binfo,
> -			 struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst)
> +			 resource_size_t ofst)
>  {
>  	u64 v;
>  	u32 type;
>=20
> -	v =3D readq(dfl->ioaddr + ofst + DFH);
> +	v =3D readq(binfo->ioaddr + ofst + DFH);
>  	type =3D FIELD_GET(DFH_TYPE, v);
>=20
>  	switch (type) {
>  	case DFH_TYPE_AFU:
> -		return parse_feature_afu(binfo, dfl, ofst);
> +		return parse_feature_afu(binfo, ofst);
>  	case DFH_TYPE_PRIVATE:
> -		return parse_feature_private(binfo, dfl, ofst);
> +		return parse_feature_private(binfo, ofst);
>  	case DFH_TYPE_FIU:
> -		return parse_feature_fiu(binfo, dfl, ofst);
> +		return parse_feature_fiu(binfo, ofst);
>  	default:
>  		dev_info(binfo->dev,
>  			 "Feature Type %x is not supported.\n", type);
> @@ -897,12 +975,18 @@ static int parse_feature(struct
> build_feature_devs_info *binfo,
>  static int parse_feature_list(struct build_feature_devs_info *binfo,
>  			      struct dfl_fpga_enum_dfl *dfl)
>  {
> -	void __iomem *start =3D dfl->ioaddr;
> -	void __iomem *end =3D dfl->ioaddr + dfl->len;
> +	resource_size_t start, end;
>  	int ret =3D 0;
>  	u32 ofst =3D 0;
>  	u64 v;
>=20
> +	ret =3D dfl_binfo_prepare(binfo, dfl->start, dfl->len);

Hm.. looks like dfl is only used for some initialization work, could we jus=
t pass
Start and len from the function parameters? Then all parse_feature_xx funct=
ions
don't need to know dfl data structure any more.

> +	if (ret)
> +		return ret;
> +
> +	start =3D dfl->start;
> +	end =3D start + dfl->len;

Above lines can be replaced with binfo, right?

> +
>  	/* walk through the device feature list via DFH's next DFH pointer. */
>  	for (; start < end; start +=3D ofst) {
>  		if (end - start < DFH_SIZE) {
> @@ -910,11 +994,11 @@ static int parse_feature_list(struct
> build_feature_devs_info *binfo,
>  			return -EINVAL;
>  		}
>=20
> -		ret =3D parse_feature(binfo, dfl, start - dfl->ioaddr);
> +		ret =3D parse_feature(binfo, start - binfo->start);
>  		if (ret)
>  			return ret;
>=20
> -		v =3D readq(start + DFH);
> +		v =3D readq(binfo->ioaddr + start - binfo->start + DFH);
>  		ofst =3D FIELD_GET(DFH_NEXT_HDR_OFST, v);
>=20
>  		/* stop parsing if EOL(End of List) is set or offset is 0 */
> @@ -923,6 +1007,8 @@ static int parse_feature_list(struct
> build_feature_devs_info *binfo,
>  	}
>=20
>  	/* commit current feature device when reach the end of list */
> +	dfl_binfo_finish(binfo);

Or complete a better name for this function?

> +
>  	return build_info_commit_dev(binfo);
>  }
>=20
> @@ -976,7 +1062,6 @@ EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_free);
>   * @info: ptr to dfl_fpga_enum_info
>   * @start: mmio resource address of the device feature list.
>   * @len: mmio resource length of the device feature list.
> - * @ioaddr: mapped mmio resource address of the device feature list.
>   *
>   * One FPGA device may have one or more Device Feature Lists (DFLs), use
> this
>   * function to add information of each DFL to common data structure for
> next
> @@ -985,8 +1070,7 @@ EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_free);
>   * Return: 0 on success, negative error code otherwise.
>   */
>  int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
> -			       resource_size_t start, resource_size_t len,
> -			       void __iomem *ioaddr)
> +			       resource_size_t start, resource_size_t len)
>  {
>  	struct dfl_fpga_enum_dfl *dfl;
>=20
> @@ -996,7 +1080,6 @@ int dfl_fpga_enum_info_add_dfl(struct
> dfl_fpga_enum_info *info,
>=20
>  	dfl->start =3D start;
>  	dfl->len =3D len;
> -	dfl->ioaddr =3D ioaddr;
>=20
>  	list_add_tail(&dfl->node, &info->dfls);
>=20
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index a32dfba..f605c28 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -441,22 +441,18 @@ struct dfl_fpga_enum_info {
>   *
>   * @start: base address of this device feature list.
>   * @len: size of this device feature list.
> - * @ioaddr: mapped base address of this device feature list.
>   * @node: node in list of device feature lists.
>   */
>  struct dfl_fpga_enum_dfl {
>  	resource_size_t start;
>  	resource_size_t len;
>=20
> -	void __iomem *ioaddr;
> -
>  	struct list_head node;
>  };
>=20
>  struct dfl_fpga_enum_info *dfl_fpga_enum_info_alloc(struct device *dev);
>  int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
> -			       resource_size_t start, resource_size_t len,
> -			       void __iomem *ioaddr);
> +			       resource_size_t start, resource_size_t len);
>  int dfl_fpga_enum_info_add_irq(struct dfl_fpga_enum_info *info,
>  			       unsigned int nr_irqs, int *irq_table);
>  void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);
> --
> 2.7.4
