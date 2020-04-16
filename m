Return-Path: <SRS0=veau=6A=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=veau=6A=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH v4 5/7] fpga: dfl: fme: add interrupt support for global
 error reporting
Date: Thu, 16 Apr 2020 09:47:53 +0000
Message-ID: <DM6PR11MB3819E22A4BBA27F532476B4485D80@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1586945255-30823-1-git-send-email-yilun.xu@intel.com>
 <1586945255-30823-6-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1586945255-30823-6-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Xu, Yilun" <yilun.xu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "trix@redhat.com" <trix@redhat.com>, "bhu@redhat.com" <bhu@redhat.com>, "Kang, Luwei" <luwei.kang@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Wednesday, April 15, 2020 6:08 PM
> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: trix@redhat.com; bhu@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
> Kang, Luwei <luwei.kang@intel.com>; Wu, Hao <hao.wu@intel.com>
> Subject: [PATCH v4 5/7] fpga: dfl: fme: add interrupt support for global =
error
> reporting
>=20
> Error reporting interrupt is very useful to notify users that some
> errors are detected by the hardware. Once users are notified, they
> could query hardware logged error states, no need to continuously
> poll on these states.
>=20
> This patch adds interrupt support for fme global error reporting sub
> feature. It follows the common DFL interrupt notification and handling
> mechanism. And it implements two ioctls below for user to query
> number of irqs supported, and set/unset interrupt triggers.
>=20
>  Ioctls:
>  * DFL_FPGA_FME_ERR_GET_IRQ_NUM
>    get the number of irqs, which is used to determine whether/how many
>    interrupts fme error reporting feature supports.
>=20
>  * DFL_FPGA_FME_ERR_SET_IRQ
>    set/unset given eventfds as fme error reporting interrupt triggers.
>=20
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ----
> v2: use DFL_FPGA_FME_ERR_GET_IRQ_NUM instead of
>     DFL_FPGA_FME_ERR_GET_INFO
>     Delete flags field for DFL_FPGA_FME_ERR_SET_IRQ
> v3: put_user() instead of copy_to_user()
>     improves comments
> v4: use common functions to handle irq ioctls
> ---
>  drivers/fpga/dfl-fme-error.c  | 23 +++++++++++++++++++++++
>  drivers/fpga/dfl-fme-main.c   |  6 ++++++
>  include/uapi/linux/fpga-dfl.h | 23 +++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
> index f897d41..a4cbf8c 100644
> --- a/drivers/fpga/dfl-fme-error.c
> +++ b/drivers/fpga/dfl-fme-error.c
> @@ -16,6 +16,7 @@
>   */
>=20
>  #include <linux/uaccess.h>
> +#include <linux/fpga-dfl.h>
>=20
>  #include "dfl.h"
>  #include "dfl-fme.h"
> @@ -348,6 +349,27 @@ static void fme_global_err_uinit(struct
> platform_device *pdev,
>  	fme_err_mask(&pdev->dev, true);
>  }
>=20
> +static long
> +fme_global_error_ioctl(struct platform_device *pdev,
> +		       struct dfl_feature *feature,
> +		       unsigned int cmd, unsigned long arg)
> +{
> +	long ret =3D -ENODEV;

Same case for patch #5 and #6.=20
Other place looks good to me.

Thanks
Hao

> +
> +	switch (cmd) {
> +	case DFL_FPGA_FME_ERR_GET_IRQ_NUM:
> +		ret =3D dfl_feature_ioctl_get_num_irqs(pdev, feature, arg);
> +		break;
> +	case DFL_FPGA_FME_ERR_SET_IRQ:
> +		ret =3D dfl_feature_ioctl_set_irq(pdev, feature, arg);
> +		break;
> +	default:
> +		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
> +	}
> +
> +	return ret;
> +}
> +
>  const struct dfl_feature_id fme_global_err_id_table[] =3D {
>  	{.id =3D FME_FEATURE_ID_GLOBAL_ERR,},
>  	{0,}
> @@ -356,4 +378,5 @@ const struct dfl_feature_id fme_global_err_id_table[]
> =3D {
>  const struct dfl_feature_ops fme_global_err_ops =3D {
>  	.init =3D fme_global_err_init,
>  	.uinit =3D fme_global_err_uinit,
> +	.ioctl =3D fme_global_error_ioctl,
>  };
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 56d720c..ab3722d 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -616,11 +616,17 @@ static int fme_release(struct inode *inode, struct
> file *filp)
>  {
>  	struct dfl_feature_platform_data *pdata =3D filp->private_data;
>  	struct platform_device *pdev =3D pdata->dev;
> +	struct dfl_feature *feature;
>=20
>  	dev_dbg(&pdev->dev, "Device File Release\n");
>=20
>  	mutex_lock(&pdata->lock);
>  	dfl_feature_dev_use_end(pdata);
> +
> +	if (!dfl_feature_dev_use_count(pdata))
> +		dfl_fpga_dev_for_each_feature(pdata, feature)
> +			dfl_fpga_set_irq_triggers(feature, 0,
> +						  feature->nr_irqs, NULL);
>  	mutex_unlock(&pdata->lock);
>=20
>  	return 0;
> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.=
h
> index fbe1e99..9e12fff 100644
> --- a/include/uapi/linux/fpga-dfl.h
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -230,4 +230,27 @@ struct dfl_fpga_fme_port_pr {
>   */
>  #define DFL_FPGA_FME_PORT_ASSIGN     _IOW(DFL_FPGA_MAGIC,
> DFL_FME_BASE + 2, int)
>=20
> +/**
> + * DFL_FPGA_FME_ERR_GET_IRQ_NUM - _IOR(DFL_FPGA_MAGIC,
> DFL_FME_BASE + 3,
> + *							__u32 num_irqs)
> + *
> + * Get the number of irqs supported by the fpga fme error reporting priv=
ate
> + * feature. Currently hardware supports up to 1 irq.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_FME_ERR_GET_IRQ_NUM	_IOR(DFL_FPGA_MAGIC,
> 	\
> +					     DFL_FME_BASE + 3, __u32)
> +
> +/**
> + * DFL_FPGA_FME_ERR_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_FME_BASE
> + 4,
> + *						struct dfl_fpga_irq_set)
> + *
> + * Set fpga fme error reporting interrupt trigger if evtfds[n] is valid.
> + * Unset related interrupt trigger if evtfds[n] is a negative value.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_FME_ERR_SET_IRQ	_IOW(DFL_FPGA_MAGIC,
> 	\
> +					     DFL_FME_BASE + 4,	\
> +					     struct dfl_fpga_irq_set)
> +
>  #endif /* _UAPI_LINUX_FPGA_DFL_H */
> --
> 2.7.4
