Return-Path: <SRS0=jT5i=7H=redhat.com=mtosatti@kernel.org>
Return-Path: <SRS0=jT5i=7H=redhat.com=mtosatti@kernel.org>
Date: Mon, 25 May 2020 16:23:55 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v5 4/7] fpga: dfl: afu: add interrupt support for port
 error reporting
Message-ID: <20200525192355.GD22266@fuller.cnet>
References: <1587370303-25568-1-git-send-email-yilun.xu@intel.com>
 <1587370303-25568-5-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587370303-25568-5-git-send-email-yilun.xu@intel.com>
To: Xu Yilun <yilun.xu@intel.com>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com, bhu@redhat.com, Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Apr 20, 2020 at 04:11:40PM +0800, Xu Yilun wrote:
> Error reporting interrupt is very useful to notify users that some
> errors are detected by the hardware. Once users are notified, they
> could query hardware logged error states, no need to continuously
> poll on these states.
> 
> This patch adds interrupt support for port error reporting sub feature.
> It follows the common DFL interrupt notification and handling mechanism,
> implements two ioctl commands below for user to query number of irqs
> supported, and set/unset interrupt triggers.
> 
>  Ioctls:
>  * DFL_FPGA_PORT_ERR_GET_IRQ_NUM
>    get the number of irqs, which is used to determine whether/how many
>    interrupts error reporting feature supports.
> 
>  * DFL_FPGA_PORT_ERR_SET_IRQ
>    set/unset given eventfds as error interrupt triggers.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ----
> v2: use DFL_FPGA_PORT_ERR_GET_IRQ_NUM instead of
>     DFL_FPGA_PORT_ERR_GET_INFO
>     Delete flag field for DFL_FPGA_PORT_ERR_SET_IRQ param
> v3: put_user() instead of copy_to_user()
>     improves comments
> v4: use common functions to handle irq ioctls
> v5: minor fixes for Hao's comments
> ---
>  drivers/fpga/dfl-afu-error.c  | 17 +++++++++++++++++
>  drivers/fpga/dfl-afu-main.c   |  4 ++++
>  include/uapi/linux/fpga-dfl.h | 23 +++++++++++++++++++++++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index c1467ae..c469118 100644
> --- a/drivers/fpga/dfl-afu-error.c
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -14,6 +14,7 @@
>   *   Mitchel Henry <henry.mitchel@intel.com>
>   */
>  
> +#include <linux/fpga-dfl.h>
>  #include <linux/uaccess.h>
>  
>  #include "dfl-afu.h"
> @@ -219,6 +220,21 @@ static void port_err_uinit(struct platform_device *pdev,
>  	afu_port_err_mask(&pdev->dev, true);
>  }
>  
> +static long
> +port_err_ioctl(struct platform_device *pdev, struct dfl_feature *feature,
> +	       unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +	case DFL_FPGA_PORT_ERR_GET_IRQ_NUM:
> +		return dfl_feature_ioctl_get_num_irqs(pdev, feature, arg);
> +	case DFL_FPGA_PORT_ERR_SET_IRQ:
> +		return dfl_feature_ioctl_set_irq(pdev, feature, arg);
> +	default:
> +		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
> +		return -ENODEV;
> +	}
> +}
> +
>  const struct dfl_feature_id port_err_id_table[] = {
>  	{.id = PORT_FEATURE_ID_ERROR,},
>  	{0,}
> @@ -227,4 +243,5 @@ const struct dfl_feature_id port_err_id_table[] = {
>  const struct dfl_feature_ops port_err_ops = {
>  	.init = port_err_init,
>  	.uinit = port_err_uinit,
> +	.ioctl = port_err_ioctl,
>  };
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 3fa2c59..b1ed7b4 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -578,6 +578,7 @@ static int afu_release(struct inode *inode, struct file *filp)
>  {
>  	struct platform_device *pdev = filp->private_data;
>  	struct dfl_feature_platform_data *pdata;
> +	struct dfl_feature *feature;
>  
>  	dev_dbg(&pdev->dev, "Device File Release\n");
>  
> @@ -587,6 +588,9 @@ static int afu_release(struct inode *inode, struct file *filp)
>  	dfl_feature_dev_use_end(pdata);
>  
>  	if (!dfl_feature_dev_use_count(pdata)) {
> +		dfl_fpga_dev_for_each_feature(pdata, feature)
> +			dfl_fpga_set_irq_triggers(feature, 0,
> +						  feature->nr_irqs, NULL);
>  		__port_reset(pdev);
>  		afu_dma_region_destroy(pdata);
>  	}
> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
> index 7331350..6c71c9d 100644
> --- a/include/uapi/linux/fpga-dfl.h
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -164,6 +164,29 @@ struct dfl_fpga_irq_set {
>  	__s32 evtfds[];
>  };
>  
> +/**
> + * DFL_FPGA_PORT_ERR_GET_IRQ_NUM - _IOR(DFL_FPGA_MAGIC, DFL_PORT_BASE + 5,
> + *								__u32 num_irqs)
> + *
> + * Get the number of irqs supported by the fpga port error reporting private
> + * feature. Currently hardware supports up to 1 irq.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_PORT_ERR_GET_IRQ_NUM	_IOR(DFL_FPGA_MAGIC,	\
> +					     DFL_PORT_BASE + 5, __u32)
> +
> +/**
> + * DFL_FPGA_PORT_ERR_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_PORT_BASE + 6,
> + *						struct dfl_fpga_irq_set)
> + *
> + * Set fpga port error reporting interrupt trigger if evtfds[n] is valid.
> + * Unset related interrupt trigger if evtfds[n] is a negative value.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_PORT_ERR_SET_IRQ	_IOW(DFL_FPGA_MAGIC,	\
> +					     DFL_PORT_BASE + 6,	\
> +					     struct dfl_fpga_irq_set)
> +
>  /* IOCTLs for FME file descriptor */
>  
>  /**
> -- 
> 2.7.4


Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
