Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1530607463-6287-1-git-send-email-appana.durga.rao@xilinx.com>
References: <1530607463-6287-1-git-send-email-appana.durga.rao@xilinx.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 3 Jul 2018 10:16:41 -0500
Message-ID: <CANk1AXRhRDmsqUxVi4p+vE-X+OL0ayQ=4zpM-4PxZBqJXjPsRw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] fpga: fpga-mgr: Add readback support
Content-Type: text/plain; charset="UTF-8"
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc: Moritz Fischer <mdf@kernel.org>, Michal Simek <michal.simek@xilinx.com>, navam@xilinx.com, linux-fpga@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Jul 3, 2018 at 3:44 AM, Appana Durga Kedareswara rao
<appana.durga.rao@xilinx.com> wrote:

Hi Appana,

> Inorder to debug issues with fpga's users would
> like to read the fpga configuration information.
> This patch adds readback support for fpga configuration data
> in the framework through debugfs interface.
>
> Usage:
>         cat /sys/kernel/debug/fpga/readback

Two things here: I'd prefer calling the attribute "image" rather than "readback"

This should be an entry per fpga manager, not one entry for the whole
framework, so

cat /sys/kernel/debug/fpga/fpga0/image

>
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> ---
>  drivers/fpga/fpga-mgr.c       | 52 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fpga/fpga-mgr.h |  6 +++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 9939d2c..7a9fd7c 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -484,6 +484,39 @@ void fpga_mgr_put(struct fpga_manager *mgr)
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
>
> +#ifdef CONFIG_DEBUG_FS
> +#include <linux/debugfs.h>
> +
> +static int fpga_mgr_read(struct seq_file *s, void *data)
> +{
> +       struct fpga_manager *mgr = (struct fpga_manager *)s->private;
> +       int ret = 0;

Here you should return an error for mgr's that don't support read function:

if (!mgr->mops->read)
    return -ENOENT;

Then you probably should lock the mgr so that nobody tries to write it
while you are reading.  If you can't lock it, return -EBUSY.

> +
> +       if (mgr->state != FPGA_MGR_STATE_OPERATING)
> +               return -EBUSY;

If the FPGA isn't programmed, I'm not sure that EBUSY would be the
correct error.

> +
> +       /* Read the FPGA configuration data from the fabric */
> +       ret = mgr->mops->read(mgr, s);
> +       if (ret) {
> +               dev_err(&mgr->dev, "Error while reading configuration data from FPGA\n");
> +               return ret;

Don't need this return here since we return right afterwards anyway.

> +       }
> +
> +       return ret;
> +}
> +
> +static int fpga_mgr_read_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, fpga_mgr_read, inode->i_private);
> +}
> +
> +static const struct file_operations fpga_mgr_debugops = {

Suggest including the name of the debugfs file in the name since more
debugfs files will be added over time, so

s/fpga_mgr_debugops/fpga_mgr_ops_image/ or something.

> +       .owner = THIS_MODULE,
> +       .open = fpga_mgr_read_open,
> +       .read = seq_read,
> +};
> +#endif
> +
>  /**
>   * fpga_mgr_lock - Lock FPGA manager for exclusive use
>   * @mgr:       fpga manager
> @@ -581,6 +614,21 @@ int fpga_mgr_register(struct device *dev, const char *name,
>         if (ret)
>                 goto error_device;
>
> +#ifdef CONFIG_DEBUG_FS

I'd prefer an added config such as CONFIG_FPGA_MGR_DEBUG_FS.

> +       mgr->dir = debugfs_create_dir("fpga", NULL);
> +       if (!mgr->dir)
> +               goto error_device;
> +
> +       mgr->parent = mgr->dir;
> +       mgr->dir = debugfs_create_file("readback", 0644, mgr->parent, mgr,
> +                                      &fpga_mgr_debugops);
> +       if (!mgr->dir) {
> +               debugfs_remove_recursive(mgr->parent);
> +               mgr->parent = NULL;
> +               goto error_device;
> +       }
> +#endif
> +
>         dev_info(&mgr->dev, "%s registered\n", mgr->name);
>
>         return 0;
> @@ -604,6 +652,10 @@ void fpga_mgr_unregister(struct device *dev)
>
>         dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
>
> +#ifdef CONFIG_DEBUG_FS
> +       debugfs_remove_recursive(mgr->parent);
> +       mgr->parent = NULL;
> +#endif
>         /*
>          * If the low level driver provides a method for putting fpga into
>          * a desired state upon unregister, do it.
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 3c6de23..6013809 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -114,6 +114,7 @@ struct fpga_image_info {
>   * @write: write count bytes of configuration data to the FPGA
>   * @write_sg: write the scatter list of configuration data to the FPGA
>   * @write_complete: set FPGA to operating state after writing is done
> + * @read: read FPGA configuration information

Please add note that the read ops is optional similar to below.

>   * @fpga_remove: optional: Set FPGA into a specific state during driver remove
>   * @groups: optional attribute groups.
>   *
> @@ -131,6 +132,7 @@ struct fpga_manager_ops {
>         int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
>         int (*write_complete)(struct fpga_manager *mgr,
>                               struct fpga_image_info *info);
> +       int (*read)(struct fpga_manager *mgr, struct seq_file *s);
>         void (*fpga_remove)(struct fpga_manager *mgr);
>         const struct attribute_group **groups;
>  };
> @@ -151,6 +153,10 @@ struct fpga_manager {
>         enum fpga_mgr_states state;
>         const struct fpga_manager_ops *mops;
>         void *priv;
> +#ifdef CONFIG_DEBUG_FS
> +       struct dentry *dir;
> +       struct dentry *parent;
> +#endif
>  };
>
>  #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Alan
