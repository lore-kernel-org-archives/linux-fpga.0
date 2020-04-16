Return-Path: <SRS0=veau=6A=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=veau=6A=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH v4 1/7] fpga: dfl: parse interrupt info for feature
 devices on enumeration
Date: Thu, 16 Apr 2020 09:15:17 +0000
Message-ID: <DM6PR11MB3819224A2E26AC7DD6FA2B3485D80@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1586945255-30823-1-git-send-email-yilun.xu@intel.com>
 <1586945255-30823-2-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1586945255-30823-2-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Xu, Yilun" <yilun.xu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "trix@redhat.com" <trix@redhat.com>, "bhu@redhat.com" <bhu@redhat.com>, "Kang, Luwei" <luwei.kang@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Wednesday, April 15, 2020 6:07 PM
> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: trix@redhat.com; bhu@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
> Kang, Luwei <luwei.kang@intel.com>; Wu, Hao <hao.wu@intel.com>
> Subject: [PATCH v4 1/7] fpga: dfl: parse interrupt info for feature devic=
es on
> enumeration
>=20
> DFL based FPGA devices could support interrupts for different purposes,
> but current DFL framework only supports feature device enumeration with
> given MMIO resources information via common DFL headers. This patch
> introduces one new API dfl_fpga_enum_info_add_irq for low level bus
> drivers (e.g. PCIe device driver) to pass its interrupt resources
> information to DFL framework for enumeration, and also adds interrupt
> enumeration code in framework to parse and assign interrupt resources
> for enumerated feature devices and their own sub features.
>=20
> With this patch, DFL framework enumerates interrupt resources for core
> features, including PORT Error Reporting, FME (FPGA Management Engine)
> Error Reporting and also AFU User Interrupts.
>=20
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>

Patch looks good, only a few minor comments inline.=20
With related changes, you can add

Acked-by: Wu Hao <hao.wu@intel.com>

> ----
> v2: early validating irq table for each feature in parse_feature_irq().
>     Some code improvement and minor fix for Hao's comments.
> v3: put parse_feature_irqs() inside create_feature_instance()
>     some minor fixes and more comments
> v4: no need to include asm/irq.h.
>     fail the dfl enumeration when irq parsing error happens.
> ---
>  drivers/fpga/dfl.c | 155
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl.h |  40 ++++++++++++++
>  2 files changed, 195 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 9909948..9e5930e 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -421,6 +421,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
>   *
>   * @dev: device to enumerate.
>   * @cdev: the container device for all feature devices.
> + * @nr_irqs: number of irqs for all feature devices.
> + * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq inde=
x of
> + *	       this device.
>   * @feature_dev: current feature device.
>   * @ioaddr: header register region address of feature device in enumerat=
ion.
>   * @sub_features: a sub features linked list for feature device in
> enumeration.
> @@ -429,6 +432,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
>  struct build_feature_devs_info {
>  	struct device *dev;
>  	struct dfl_fpga_cdev *cdev;
> +	unsigned int nr_irqs;
> +	int *irq_table;
> +
>  	struct platform_device *feature_dev;
>  	void __iomem *ioaddr;
>  	struct list_head sub_features;
> @@ -442,12 +448,16 @@ struct build_feature_devs_info {
>   * @mmio_res: mmio resource of this sub feature.
>   * @ioaddr: mapped base address of mmio resource.
>   * @node: node in sub_features linked list.
> + * @irq_base: start of irq index in this sub feature.
> + * @nr_irqs: number of irqs of this sub feature.
>   */
>  struct dfl_feature_info {
>  	u64 fid;
>  	struct resource mmio_res;
>  	void __iomem *ioaddr;
>  	struct list_head node;
> +	unsigned int irq_base;
> +	unsigned int nr_irqs;
>  };
>=20
>  static void dfl_fpga_cdev_add_port_dev(struct dfl_fpga_cdev *cdev,
> @@ -520,6 +530,8 @@ static int build_info_commit_dev(struct
> build_feature_devs_info *binfo)
>  	/* fill features and resource information for feature dev */
>  	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
>  		struct dfl_feature *feature =3D &pdata->features[index];
> +		struct dfl_feature_irq_ctx *ctx;
> +		unsigned int i;
>=20
>  		/* save resource information for each feature */
>  		feature->id =3D finfo->fid;
> @@ -527,6 +539,20 @@ static int build_info_commit_dev(struct
> build_feature_devs_info *binfo)
>  		feature->ioaddr =3D finfo->ioaddr;
>  		fdev->resource[index++] =3D finfo->mmio_res;
>=20
> +		if (finfo->nr_irqs) {
> +			ctx =3D devm_kcalloc(binfo->dev, finfo->nr_irqs,
> +					   sizeof(*ctx), GFP_KERNEL);
> +			if (!ctx)
> +				return -ENOMEM;
> +
> +			for (i =3D 0; i < finfo->nr_irqs; i++)
> +				ctx[i].irq =3D
> +					binfo->irq_table[finfo->irq_base + i];
> +
> +			feature->irq_ctx =3D ctx;
> +			feature->nr_irqs =3D finfo->nr_irqs;
> +		}
> +
>  		list_del(&finfo->node);
>  		kfree(finfo);
>  	}
> @@ -638,6 +664,80 @@ static u64 feature_id(void __iomem *start)
>  	return 0;
>  }
>=20
> +static int parse_feature_irqs(struct build_feature_devs_info *binfo,
> +			      resource_size_t ofst, u64 fid,
> +			      unsigned int *irq_base, unsigned int *nr_irqs)
> +{
> +	void __iomem *base =3D binfo->ioaddr + ofst;
> +	unsigned int i, ibase, inr =3D 0;
> +	int virq;
> +	u64 v;
> +
> +	/*
> +	 * Ideally DFL framework should only read info from DFL header, but
> +	 * current version DFL only provides mmio resources information for
> +	 * each feature in DFL Header, no field for interrupt resources.
> +	 * Some interrupt resources information are provided by specific
> +	 * mmio registers of each components (e.g. different private features)

s/components/component/=20
maybe use private feature instead.

> +	 * which supports interrupt. So in order to parse and assign irq
> +	 * resources to different components, DFL framework has to look
> into
> +	 * specific capability registers of these core private features.
> +	 *
> +	 * Once future DFL version supports generic interrupt resources
> +	 * information in common DFL headers, some generic interrupt
> parsing
> +	 * code could be added. But in order to be compatible to old version
> +	 * DFL, driver may still fall back to these quirks.
> +	 */
> +	switch (fid) {
> +	case PORT_FEATURE_ID_UINT:
> +		v =3D readq(base + PORT_UINT_CAP);
> +		ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> +		inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> +		break;
> +	case PORT_FEATURE_ID_ERROR:
> +		v =3D readq(base + PORT_ERROR_CAP);
> +		ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> +		inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +		break;
> +	case FME_FEATURE_ID_GLOBAL_ERR:
> +		v =3D readq(base + FME_ERROR_CAP);
> +		ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> +		inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> +		break;
> +	}
> +
> +	if (!inr) {
> +		*irq_base =3D 0;
> +		*nr_irqs =3D 0;
> +		return 0;
> +	}
> +
> +	dev_dbg(binfo->dev, "feature: 0x%llx, irq_base: %u, nr_irqs: %u\n",
> +		(unsigned long long)fid, ibase, inr);
> +
> +	if (ibase + inr > binfo->nr_irqs) {
> +		dev_err(binfo->dev,
> +			"Invalid interrupt number in feature 0x%llx\n",
> +			(unsigned long long)fid);
> +		return -EINVAL;
> +	}
> +
> +	for (i =3D 0; i < inr; i++) {
> +		virq =3D binfo->irq_table[ibase + i];
> +		if (virq < 0 || virq > NR_IRQS) {
> +			dev_err(binfo->dev,
> +				"Invalid irq table entry for feature 0x%llx\n",
> +				(unsigned long long)fid);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	*irq_base =3D (unsigned int)ibase;
> +	*nr_irqs =3D (unsigned int)inr;
> +
> +	return 0;
> +}
> +
>  /*
>   * when create sub feature instances, for private features, it doesn't n=
eed
>   * to provide resource size and feature id as they could be read from DF=
H
> @@ -650,7 +750,9 @@ create_feature_instance(struct
> build_feature_devs_info *binfo,
>  			struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst,
>  			resource_size_t size, u64 fid)
>  {
> +	unsigned int irq_base, nr_irqs;
>  	struct dfl_feature_info *finfo;
> +	int ret;
>=20
>  	/* read feature size and id if inputs are invalid */
>  	size =3D size ? size : feature_size(dfl->ioaddr + ofst);
> @@ -659,6 +761,10 @@ create_feature_instance(struct
> build_feature_devs_info *binfo,
>  	if (dfl->len - ofst < size)
>  		return -EINVAL;
>=20
> +	ret =3D parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
> +	if (ret)
> +		return ret;
> +
>  	finfo =3D kzalloc(sizeof(*finfo), GFP_KERNEL);
>  	if (!finfo)
>  		return -ENOMEM;
> @@ -667,6 +773,8 @@ create_feature_instance(struct
> build_feature_devs_info *binfo,
>  	finfo->mmio_res.start =3D dfl->start + ofst;
>  	finfo->mmio_res.end =3D finfo->mmio_res.start + size - 1;
>  	finfo->mmio_res.flags =3D IORESOURCE_MEM;
> +	finfo->irq_base =3D irq_base;
> +	finfo->nr_irqs =3D nr_irqs;
>  	finfo->ioaddr =3D dfl->ioaddr + ofst;
>=20
>  	list_add_tail(&finfo->node, &binfo->sub_features);
> @@ -853,6 +961,10 @@ void dfl_fpga_enum_info_free(struct
> dfl_fpga_enum_info *info)
>  		devm_kfree(dev, dfl);
>  	}
>=20
> +	/* remove irq table */
> +	if (info->irq_table)
> +		devm_kfree(dev, info->irq_table);
> +
>  	devm_kfree(dev, info);
>  	put_device(dev);
>  }
> @@ -892,6 +1004,45 @@ int dfl_fpga_enum_info_add_dfl(struct
> dfl_fpga_enum_info *info,
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_add_dfl);
>=20
> +/**
> + * dfl_fpga_enum_info_add_irq - add irq table to enum info
> + *
> + * @info: ptr to dfl_fpga_enum_info
> + * @nr_irqs: number of irqs of the DFL fpga device to be enumerated.
> + * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq inde=
x of
> + *	       this device.
> + *
> + * One FPGA device may have several interrupts. This function adds irq
> + * information of the DFL fpga device to enum info for next step
> enumeration.
> + * This function should be called before
> dfl_fpga_feature_devs_enumerate().
> + * As we only support one irq domain for all DFLs in the same enum info,
> adding
> + * irq table a second time for the same enum info will return error.
> + *
> + * If we need to enumerate DFLs which belong to different irq domains, w=
e
> + * should fill more enum info and enumerate them one by one.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int dfl_fpga_enum_info_add_irq(struct dfl_fpga_enum_info *info,
> +			       unsigned int nr_irqs, int *irq_table)
> +{
> +	if (!nr_irqs)
> +		return -EINVAL;
> +
> +	if (info->irq_table)
> +		return -EEXIST;
> +
> +	info->irq_table =3D devm_kmemdup(info->dev, irq_table,
> +				       sizeof(int) * nr_irqs, GFP_KERNEL);

Do we need to do NULL ptr check for irq_table?

> +	if (!info->irq_table)
> +		return -ENOMEM;
> +
> +	info->nr_irqs =3D nr_irqs;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_add_irq);
> +
>  static int remove_feature_dev(struct device *dev, void *data)
>  {
>  	struct platform_device *pdev =3D to_platform_device(dev);
> @@ -959,6 +1110,10 @@ dfl_fpga_feature_devs_enumerate(struct
> dfl_fpga_enum_info *info)
>  	binfo->dev =3D info->dev;
>  	binfo->cdev =3D cdev;
>=20
> +	binfo->nr_irqs =3D info->nr_irqs;
> +	if (info->nr_irqs)
> +		binfo->irq_table =3D info->irq_table;
> +
>  	/*
>  	 * start enumeration for all feature devices based on Device Feature
>  	 * Lists.
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 74784d3..4bc165f 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -112,6 +112,13 @@
>  #define FME_PORT_OFST_ACC_VF	1
>  #define FME_PORT_OFST_IMP	BIT_ULL(60)
>=20
> +/* FME Error Capability Register */
> +#define FME_ERROR_CAP		0x70
> +
> +/* FME Error Capability Register Bitfield */
> +#define FME_ERROR_CAP_SUPP_INT	BIT_ULL(0)		/* Interrupt
> Support */
> +#define FME_ERROR_CAP_INT_VECT	GENMASK_ULL(12, 1)	/* Interrupt
> vector */
> +
>  /* PORT Header Register Set */
>  #define PORT_HDR_DFH		DFH
>  #define PORT_HDR_GUID_L		GUID_L
> @@ -145,6 +152,20 @@
>  #define PORT_STS_PWR_STATE_AP2	2			/* 90%
> throttling */
>  #define PORT_STS_PWR_STATE_AP6	6			/* 100%
> throttling */
>=20
> +/* Port Error Capability Register */
> +#define PORT_ERROR_CAP		0x38
> +
> +/* Port Error Capability Register Bitfield */
> +#define PORT_ERROR_CAP_SUPP_INT	BIT_ULL(0)		/* Interrupt
> Support */
> +#define PORT_ERROR_CAP_INT_VECT	GENMASK_ULL(12, 1)	/* Interrupt
> vector */
> +
> +/* Port Uint Capability Register */
> +#define PORT_UINT_CAP		0x8
> +
> +/* Port Uint Capability Register Bitfield */
> +#define PORT_UINT_CAP_INT_NUM	GENMASK_ULL(11, 0)	/* Interrupts
> num */
> +#define PORT_UINT_CAP_FST_VECT	GENMASK_ULL(23, 12)	/* First Vector
> */
> +
>  /**
>   * struct dfl_fpga_port_ops - port ops
>   *
> @@ -189,6 +210,15 @@ struct dfl_feature_driver {
>  };
>=20
>  /**
> + * struct dfl_feature_irq_ctx - dfl private feature interrupt context
> + *
> + * @irq: Linux IRQ number of this interrupt.
> + */
> +struct dfl_feature_irq_ctx {
> +	int irq;
> +};
> +
> +/**
>   * struct dfl_feature - sub feature of the feature devices
>   *
>   * @id: sub feature id.
> @@ -196,12 +226,16 @@ struct dfl_feature_driver {
>   *		    this index is used to find its mmio resource from the
>   *		    feature dev (platform device)'s reources.
>   * @ioaddr: mapped mmio resource address.
> + * @irq_ctx: interrupt context list.
> + * @nr_irqs: number of interrupt contexts.
>   * @ops: ops of this sub feature.
>   */
>  struct dfl_feature {
>  	u64 id;
>  	int resource_index;
>  	void __iomem *ioaddr;
> +	struct dfl_feature_irq_ctx *irq_ctx;
> +	unsigned int nr_irqs;
>  	const struct dfl_feature_ops *ops;
>  };
>=20
> @@ -388,10 +422,14 @@ static inline u8 dfl_feature_revision(void __iomem
> *base)
>   *
>   * @dev: parent device.
>   * @dfls: list of device feature lists.
> + * @nr_irqs: number of irqs for all feature devices.
> + * @irq_table: Linux IRQ numbers for all irqs, indexed by hw irq numbers=
.
>   */
>  struct dfl_fpga_enum_info {
>  	struct device *dev;
>  	struct list_head dfls;
> +	unsigned int nr_irqs;
> +	int *irq_table;
>  };
>=20
>  /**
> @@ -415,6 +453,8 @@ struct dfl_fpga_enum_info
> *dfl_fpga_enum_info_alloc(struct device *dev);
>  int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
>  			       resource_size_t start, resource_size_t len,
>  			       void __iomem *ioaddr);
> +int dfl_fpga_enum_info_add_irq(struct dfl_fpga_enum_info *info,
> +			       unsigned int nr_irqs, int *irq_table);
>  void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);
>=20
>  /**
> --
> 2.7.4
