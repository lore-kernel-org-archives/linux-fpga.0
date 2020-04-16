Return-Path: <SRS0=veau=6A=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=veau=6A=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH v4 4/7] fpga: dfl: afu: add interrupt support for port
 error reporting
Date: Thu, 16 Apr 2020 09:45:46 +0000
Message-ID: <DM6PR11MB3819E93B47AD06083F4DC5BB85D80@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1586945255-30823-1-git-send-email-yilun.xu@intel.com>
 <1586945255-30823-5-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1586945255-30823-5-git-send-email-yilun.xu@intel.com>
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
> Subject: [PATCH v4 4/7] fpga: dfl: afu: add interrupt support for port er=
ror
> reporting
>=20
> Error reporting interrupt is very useful to notify users that some
> errors are detected by the hardware. Once users are notified, they
> could query hardware logged error states, no need to continuously
> poll on these states.
>=20
> This patch adds interrupt support for port error reporting sub feature.
> It follows the common DFL interrupt notification and handling mechanism,
> implements two ioctl commands below for user to query number of irqs
> supported, and set/unset interrupt triggers.
>=20
>  Ioctls:
>  * DFL_FPGA_PORT_ERR_GET_IRQ_NUM
>    get the number of irqs, which is used to determine whether/how many
>    interrupts error reporting feature supports.
>=20
>  * DFL_FPGA_PORT_ERR_SET_IRQ
>    set/unset given eventfds as error interrupt triggers.
>=20
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ----
> v2: use DFL_FPGA_PORT_ERR_GET_IRQ_NUM instead of
>     DFL_FPGA_PORT_ERR_GET_INFO
>     Delete flag field for DFL_FPGA_PORT_ERR_SET_IRQ param
> v3: put_user() instead of copy_to_user()
>     improves comments
> v4: use common functions to handle irq ioctls
> ---
>  drivers/fpga/dfl-afu-error.c  | 22 ++++++++++++++++++++++
>  drivers/fpga/dfl-afu-main.c   |  4 ++++
>  include/uapi/linux/fpga-dfl.h | 23 +++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index c1467ae..facbd7b 100644
> --- a/drivers/fpga/dfl-afu-error.c
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -15,6 +15,7 @@
>   */
>=20
>  #include <linux/uaccess.h>
> +#include <linux/fpga-dfl.h>

Same.  : )

>=20
>  #include "dfl-afu.h"
>=20
> @@ -219,6 +220,26 @@ static void port_err_uinit(struct platform_device
> *pdev,
>  	afu_port_err_mask(&pdev->dev, true);
>  }
>=20
> +static long
> +port_err_ioctl(struct platform_device *pdev, struct dfl_feature *feature=
,
> +	       unsigned int cmd, unsigned long arg)
> +{
> +	long ret =3D -ENODEV;
> +
> +	switch (cmd) {
> +	case DFL_FPGA_PORT_ERR_GET_IRQ_NUM:
> +		ret =3D dfl_feature_ioctl_get_num_irqs(pdev, feature, arg);
> +		break;
> +	case DFL_FPGA_PORT_ERR_SET_IRQ:
> +		ret =3D dfl_feature_ioctl_set_irq(pdev, feature, arg);
> +		break;
> +	default:
> +		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
> +	}
> +
> +	return ret;
> +}

Looks like we don't have to introduce this local 'ret'.

With above fixings:

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao
