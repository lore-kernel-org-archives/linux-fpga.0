Date: Wed, 4 Jul 2018 15:51:16 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [RFC PATCH v2 1/2] fpga: fpga-mgr: Add readback support
Message-ID: <20180704225116.GA18835@archbox>
References: <1530683993-27179-1-git-send-email-appana.durga.rao@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <1530683993-27179-1-git-send-email-appana.durga.rao@xilinx.com>
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc: atull@kernel.org, mdf@kernel.org, michal.simek@xilinx.com, navam@xilinx.com, linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kedare06@gmail.com
List-ID: <linux-fpga@vger.kernel.org>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Appana,

a bunch of minor stuff:

On Wed, Jul 04, 2018 at 11:29:53AM +0530, Appana Durga Kedareswara rao wrot=
e:
> Inorder to debug issues with fpga's users would
In order to debug issues with FPGAs [...]
> like to read the fpga configuration information.
> This patch adds readback support for fpga configuration data

Add readback support for FPGA configuration data [...]

> in the framework through debugfs interface.
>=20
> Usage:
>         cat /sys/kernel/debug/fpga/fpga0/image

Do we generally wanna make this part of the framework? If yes, maybe we
want to actually put it into sysfs?

>=20
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> ---
> Changes for v2:
> --> Fixed debug attribute path and name
> as suggested by Alan
> --> Add config entry for DEBUG as suggested by Alan
> --> Fixed trival coding style issues.
>=20
>  drivers/fpga/Kconfig          |  7 +++++
>  drivers/fpga/fpga-mgr.c       | 68 +++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/fpga/fpga-mgr.h |  5 ++++
>  3 files changed, 80 insertions(+)
>=20
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 53d3f55..838ad4e 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -11,6 +11,13 @@ menuconfig FPGA
> =20
>  if FPGA
> =20
> +config FPGA_MGR_DEBUG_FS
> +	tristate "FPGA Debug fs"
> +	select DEBUG_FS
> +	help
> +	  FPGA manager debug provides support for reading fpga configuration
> +	  information.
Enable support for reading back FPGA configuration information?
> +
>  config FPGA_MGR_SOCFPGA
>  	tristate "Altera SOCFPGA FPGA Manager"
>  	depends on ARCH_SOCFPGA || COMPILE_TEST
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 9939d2c..4bea860 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -484,6 +484,48 @@ void fpga_mgr_put(struct fpga_manager *mgr)
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
> =20
> +#ifdef CONFIG_FPGA_MGR_DEBUG_FS
> +#include <linux/debugfs.h>
> +
> +static int fpga_mgr_read(struct seq_file *s, void *data)
> +{
> +	struct fpga_manager *mgr =3D (struct fpga_manager *)s->private;
> +	int ret =3D 0;
> +
> +	if (!mgr->mops->read)
> +		return -ENOENT;
> +
> +	if (!mutex_trylock(&mgr->ref_mutex))
> +		return -EBUSY;
> +
> +	if (mgr->state !=3D FPGA_MGR_STATE_OPERATING) {
> +		ret =3D -EPERM;
> +		goto err_unlock;
> +	}
> +
> +	/* Read the FPGA configuration data from the fabric */
> +	ret =3D mgr->mops->read(mgr, s);
> +	if (ret)
> +		dev_err(&mgr->dev, "Error while reading configuration data from FPGA\n=
");
> +
> +err_unlock:
> +	mutex_unlock(&mgr->ref_mutex);
> +
> +	return ret;
> +}
> +
> +static int fpga_mgr_read_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, fpga_mgr_read, inode->i_private);
> +}
> +
> +static const struct file_operations fpga_mgr_ops_image =3D {
> +	.owner =3D THIS_MODULE,
> +	.open =3D fpga_mgr_read_open,
> +	.read =3D seq_read,
> +};
> +#endif
> +
>  /**
>   * fpga_mgr_lock - Lock FPGA manager for exclusive use
>   * @mgr:	fpga manager
> @@ -581,6 +623,29 @@ int fpga_mgr_register(struct device *dev, const char=
 *name,
>  	if (ret)
>  		goto error_device;
> =20
> +#ifdef CONFIG_FPGA_MGR_DEBUG_FS
> +	struct dentry *d, *parent;
> +
> +	mgr->dir =3D debugfs_create_dir("fpga", NULL);
> +	if (!mgr->dir)
> +		goto error_device;
> +
> +	parent =3D mgr->dir;
> +	d =3D debugfs_create_dir(mgr->dev.kobj.name, parent);
> +	if (!d) {
> +		debugfs_remove_recursive(parent);
> +		goto error_device;
> +	}
> +
> +	parent =3D d;
> +	d =3D debugfs_create_file("image", 0644, parent, mgr,
> +				&fpga_mgr_ops_image);
> +	if (!d) {
> +		debugfs_remove_recursive(mgr->dir);
> +		goto error_device;
> +	}
> +#endif
> +
>  	dev_info(&mgr->dev, "%s registered\n", mgr->name);
> =20
>  	return 0;
> @@ -604,6 +669,9 @@ void fpga_mgr_unregister(struct device *dev)
> =20
>  	dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
> =20
> +#ifdef CONFIG_FPGA_MGR_DEBUG_FS
> +	debugfs_remove_recursive(mgr->dir);
> +#endif
>  	/*
>  	 * If the low level driver provides a method for putting fpga into
>  	 * a desired state upon unregister, do it.
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 3c6de23..e9e17a9 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -114,6 +114,7 @@ struct fpga_image_info {
>   * @write: write count bytes of configuration data to the FPGA
>   * @write_sg: write the scatter list of configuration data to the FPGA
>   * @write_complete: set FPGA to operating state after writing is done
> + * @read: optional: read FPGA configuration information
>   * @fpga_remove: optional: Set FPGA into a specific state during driver =
remove
>   * @groups: optional attribute groups.
>   *
> @@ -131,6 +132,7 @@ struct fpga_manager_ops {
>  	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
>  	int (*write_complete)(struct fpga_manager *mgr,
>  			      struct fpga_image_info *info);
> +	int (*read)(struct fpga_manager *mgr, struct seq_file *s);
>  	void (*fpga_remove)(struct fpga_manager *mgr);
>  	const struct attribute_group **groups;
>  };
> @@ -151,6 +153,9 @@ struct fpga_manager {
>  	enum fpga_mgr_states state;
>  	const struct fpga_manager_ops *mops;
>  	void *priv;
> +#ifdef CONFIG_FPGA_MGR_DEBUG_FS
> +	struct dentry *dir;
> +#endif
>  };
> =20
>  #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
> --=20
> 2.7.4
>=20

Thanks,
Moritz

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAls9T14ACgkQUVwKRFcJ
cNiIkwgAx20f+9bA0o87Ds9rukoWDCykOgW2cuuWICPdB0/XViF9k6wy846ItUxX
k5YE/hxC4S+9+30Y4WyTskUVFZ8zSxuQLL5FwUdYuZwGx+m+vzWS6N6qRGEJQA92
J1k/jBaHBljQQRXzjV1Ji6y0bynubTV846wJgB9h0F7oc5QGHxIrC8ARiPUwqNxD
TRWYGx9BUHRvQQjVRbldIaCZbBe6LFFd1dSOmV2Ij1hrpqzCHkFpKbJspuizzsyI
TyUDjDqJCfytulRJlYF6lMCoNt143PkVNDbIZtH1OB6+J5Pf1BhhCNqjIbT/tyEs
k4vTtoc+jsHc/eFBHikxJSZprLamfA==
=QP+S
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
