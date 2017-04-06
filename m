Date: Wed, 5 Apr 2017 21:25:01 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 5/5] fpga-region: separate out common code from dt
 specific code
Message-ID: <20170406042501.GB5981@tyrael.amer.corp.natinst.com>
References: <20170313215333.3008-1-atull@kernel.org>
 <20170313215333.3008-6-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170313215333.3008-6-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan,

first pass ... need to get back to it.

On Mon, Mar 13, 2017 at 04:53:33PM -0500, Alan Tull wrote:
> FPGA region is a layer above the FPGA manager and FPGA bridge
> frameworks.  Currently, FPGA region is dependent on device tree.
> This commit separates the device tree specific code from the
> common code, separating fpga-region.c into fpga-region.c,
> of-fpga-region.c, and fpga-region.h.
> 
> Functons exported from fpga-region.c:
> * fpga_region_register
> * fpga_region_unregister
>   Create/remove a FPGA region.  Caller will supply the region
>   struct initialized with a pointer to a FPGA manager and
>   a method to get the FPGA bridges.
> 
> * of_fpga_region_find
>   Find a fpga region, given the node pointer
> 
> * fpga_region_alloc_image_info
> * fpga_region_free_image_info
>   Alloc/free fpga_image_info struct
> 
> * fpga_region_program_fpga
>   Program an FPGA region
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
>  drivers/fpga/Kconfig          |  12 +-
>  drivers/fpga/Makefile         |   1 +
>  drivers/fpga/fpga-region.c    | 475 +++++++-----------------------------------
>  drivers/fpga/fpga-region.h    |  50 +++++
>  drivers/fpga/of-fpga-region.c | 453 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/fpga/fpga-mgr.h |   6 +-
>  6 files changed, 599 insertions(+), 398 deletions(-)
>  create mode 100644 drivers/fpga/fpga-region.h
>  create mode 100644 drivers/fpga/of-fpga-region.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index ce861a2..be9c23d 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -15,10 +15,18 @@ if FPGA
>  
>  config FPGA_REGION
>  	tristate "FPGA Region"
> -	depends on OF && FPGA_BRIDGE
> +	depends on FPGA_BRIDGE
> +	help
> +	  FPGA Region common code.  A FPGA Region controls a FPGA Manager
> +	  and the FPGA Bridges associated with either a reconfigurable
> +	  region of an FPGA or a whole FPGA.
> +
> +config OF_FPGA_REGION
> +	tristate "FPGA Region Device Tree Overlay Support"
> +	depends on FPGA_REGION

Doesn't this one now need depends on FPGA_REGION & OF ? Since
FPGA_REGION no longer depends on OF, or does FPGA_BRIDGE pull it in?

>  	help
>  	  FPGA Regions allow loading FPGA images under control of
> -	  the Device Tree.
> +	  Device Tree Overlays.
>  
>  config FPGA_MGR_SOCFPGA
>  	tristate "Altera SOCFPGA FPGA Manager"
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 8df07bc..fb88fb0 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+= altera-freeze-bridge.o
>  
>  # High Level Interfaces
>  obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
> +obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index 815f178..c06f2f7 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -16,53 +16,64 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +/* todo: prevent programming if region has child regions or overlay applied */
> +
>  #include <linux/fpga/fpga-bridge.h>
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/idr.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> -#include <linux/of_platform.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include "fpga-region.h"
>  
> -/**
> - * struct fpga_region - FPGA Region structure
> - * @dev: FPGA Region device
> - * @mutex: enforces exclusive reference to region
> - * @bridge_list: list of FPGA bridges specified in region
> - * @info: fpga image specific information
> - */
> -struct fpga_region {
> -	struct device dev;
> -	struct mutex mutex; /* for exclusive reference to region */
> -	struct list_head bridge_list;
> +static DEFINE_IDA(fpga_region_ida);
> +struct class *fpga_region_class;
> +
> +struct fpga_image_info *fpga_region_alloc_image_info(struct fpga_region *region)
> +{
> +	struct device *dev = &region->dev;
>  	struct fpga_image_info *info;
> -};
>  
> -#define to_fpga_region(d) container_of(d, struct fpga_region, dev)
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return ERR_PTR(-ENOMEM);
>  
> -static DEFINE_IDA(fpga_region_ida);
> -static struct class *fpga_region_class;
> +	return info;
> +}
> +EXPORT_SYMBOL_GPL(fpga_region_alloc_image_info);
>  
> -static const struct of_device_id fpga_region_of_match[] = {
> -	{ .compatible = "fpga-region", },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, fpga_region_of_match);
> +void fpga_region_free_image_info(struct fpga_region *region,
> +				 struct fpga_image_info *info)
> +{
> +	struct device *dev = &region->dev;
> +
> +	if (!info)
> +		return;
> +
> +	if (info->firmware_name)
> +		devm_kfree(dev, info->firmware_name);
>  
> +	devm_kfree(dev, info);
> +}
> +EXPORT_SYMBOL_GPL(fpga_region_free_image_info);
> +
> +#if IS_ENABLED(CONFIG_OF_FPGA_REGION)
>  static int fpga_region_of_node_match(struct device *dev, const void *data)
>  {
>  	return dev->of_node == data;
>  }
>  
>  /**
> - * fpga_region_find - find FPGA region
> + * of_fpga_region_find - find FPGA region
>   * @np: device node of FPGA Region
> + *
>   * Caller will need to put_device(&region->dev) when done.
> + *
>   * Returns FPGA Region struct or NULL
>   */
> -static struct fpga_region *fpga_region_find(struct device_node *np)
> +struct fpga_region *of_fpga_region_find(struct device_node *np)
>  {
>  	struct device *dev;
>  
> @@ -73,6 +84,9 @@ static struct fpga_region *fpga_region_find(struct device_node *np)
>  
>  	return to_fpga_region(dev);
>  }
> +EXPORT_SYMBOL_GPL(of_fpga_region_find);
> +
> +#endif /* CONFIG_OF_FPGA_REGION */
>  
>  /**
>   * fpga_region_get - get an exclusive reference to a fpga region
> @@ -94,9 +108,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
>  	}
>  
>  	get_device(dev);
> -	of_node_get(dev->of_node);
>  	if (!try_module_get(dev->parent->driver->owner)) {
> -		of_node_put(dev->of_node);
>  		put_device(dev);
>  		mutex_unlock(&region->mutex);
>  		return ERR_PTR(-ENODEV);
> @@ -119,397 +131,103 @@ static void fpga_region_put(struct fpga_region *region)
>  	dev_dbg(&region->dev, "put\n");
>  
>  	module_put(dev->parent->driver->owner);
> -	of_node_put(dev->of_node);
>  	put_device(dev);
>  	mutex_unlock(&region->mutex);
>  }
>  
>  /**
> - * fpga_region_get_manager - get reference for FPGA manager
> - * @region: FPGA region
> - *
> - * Get FPGA Manager from "fpga-mgr" property or from ancestor region.
> - *
> - * Caller should call fpga_mgr_put() when done with manager.
> - *
> - * Return: fpga manager struct or IS_ERR() condition containing error code.
> - */
> -static struct fpga_manager *fpga_region_get_manager(struct fpga_region *region)
> -{
> -	struct device *dev = &region->dev;
> -	struct device_node *np = dev->of_node;
> -	struct device_node  *mgr_node;
> -	struct fpga_manager *mgr;
> -
> -	of_node_get(np);
> -	while (np) {
> -		if (of_device_is_compatible(np, "fpga-region")) {
> -			mgr_node = of_parse_phandle(np, "fpga-mgr", 0);
> -			if (mgr_node) {
> -				mgr = of_fpga_mgr_get(mgr_node);
> -				of_node_put(np);
> -				return mgr;
> -			}
> -		}
> -		np = of_get_next_parent(np);
> -	}
> -	of_node_put(np);
> -
> -	return ERR_PTR(-EINVAL);
> -}
> -
> -/**
> - * fpga_region_get_bridges - create a list of bridges
> - * @region: FPGA region
> - * @overlay: device node of the overlay
> - *
> - * Create a list of bridges including the parent bridge and the bridges
> - * specified by "fpga-bridges" property.  Note that the
> - * fpga_bridges_enable/disable/put functions are all fine with an empty list
> - * if that happens.
> - *
> - * Caller should call fpga_bridges_put(&region->bridge_list) when
> - * done with the bridges.
> - *
> - * Return 0 for success (even if there are no bridges specified)
> - * or -EBUSY if any of the bridges are in use.
> - */
> -static int fpga_region_get_bridges(struct fpga_region *region,
> -				   struct device_node *overlay)
> -{
> -	struct device *dev = &region->dev;
> -	struct device_node *region_np = dev->of_node;
> -	struct device_node *br, *np, *parent_br = NULL;
> -	int i, ret;
> -
> -	/* If parent is a bridge, add to list */
> -	ret = of_fpga_bridge_get_to_list(region_np->parent, region->info,
> -					 &region->bridge_list);
> -	if (ret == -EBUSY)
> -		return ret;
> -
> -	if (!ret)
> -		parent_br = region_np->parent;
> -
> -	/* If overlay has a list of bridges, use it. */
> -	if (of_parse_phandle(overlay, "fpga-bridges", 0))
> -		np = overlay;
> -	else
> -		np = region_np;
> -
> -	for (i = 0; ; i++) {
> -		br = of_parse_phandle(np, "fpga-bridges", i);
> -		if (!br)
> -			break;
> -
> -		/* If parent bridge is in list, skip it. */
> -		if (br == parent_br)
> -			continue;
> -
> -		/* If node is a bridge, get it and add to list */
> -		ret = of_fpga_bridge_get_to_list(br, region->info,
> -						 &region->bridge_list);
> -
> -		/* If any of the bridges are in use, give up */
> -		if (ret == -EBUSY) {
> -			fpga_bridges_put(&region->bridge_list);
> -			return -EBUSY;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -/**
>   * fpga_region_program_fpga - program FPGA
>   * @region: FPGA region
>   * @overlay: device node of the overlay
>   * Program an FPGA using information in the region's fpga image info.
>   * Return 0 for success or negative error code.
>   */
> -static int fpga_region_program_fpga(struct fpga_region *region,
> -				    struct device_node *overlay)
> +int fpga_region_program_fpga(struct fpga_region *region,
> +			     struct fpga_image_info *info)
>  {
> -	struct fpga_manager *mgr;
> +	struct device *dev = &region->dev;
>  	int ret;
>  
> -	region = fpga_region_get(region);
> -	if (IS_ERR(region)) {
> -		pr_err("failed to get fpga region\n");
> +	if (region->info) {
> +		dev_err(dev, "region already programmed\n");
>  		return PTR_ERR(region);
>  	}
>  
> -	mgr = fpga_region_get_manager(region);
> -	if (IS_ERR(mgr)) {
> -		pr_err("failed to get fpga region manager\n");
> -		return PTR_ERR(mgr);
> +	region = fpga_region_get(region);
> +	if (IS_ERR(region)) {
> +		dev_err(dev, "failed to get fpga region\n");
> +		return PTR_ERR(region);
>  	}
>  
> -	ret = fpga_mgr_lock(mgr);
> -	if (ret) {
> -		pr_err("FPGA manager is busy\n");
> -		goto err_put_mgr;
> +	ret = fpga_mgr_lock(region->mgr);
> +	if (ret < 0) {
> +		dev_err(dev, "fpga manager is busy\n");
> +		goto err_put_region;
>  	}
>  
> -	ret = fpga_region_get_bridges(region, overlay);
> -	if (ret) {
> -		pr_err("failed to get fpga region bridges\n");
> -		goto err_unlock_mgr;
> +	/*
> +	 * In some cases, we already have a list of bridges in the
> +	 * fpga region struct.  Or we don't have any bridges.
> +	 */
> +	if (region->get_bridges) {
> +		ret = region->get_bridges(region, info);
> +		if (ret) {
> +			dev_err(dev, "failed to get fpga region bridges\n");
> +			goto err_unlock_mgr;
> +		}
>  	}
>  
>  	ret = fpga_bridges_disable(&region->bridge_list);
>  	if (ret) {
> -		pr_err("failed to disable region bridges\n");
> +		dev_err(dev, "failed to disable region bridges\n");
>  		goto err_put_br;
>  	}
>  
> -	ret = fpga_mgr_load(mgr, region->info);
> +	ret = fpga_mgr_load(region->mgr, info);
>  	if (ret) {
> -		pr_err("failed to load fpga image\n");
> +		dev_err(dev, "failed to load fpga image\n");
>  		goto err_put_br;
>  	}
>  
>  	ret = fpga_bridges_enable(&region->bridge_list);
>  	if (ret) {
> -		pr_err("failed to enable region bridges\n");
> +		dev_err(dev, "failed to enable region bridges\n");
>  		goto err_put_br;
>  	}
>  
> -	fpga_mgr_unlock(mgr);
> -	fpga_mgr_put(mgr);
> +	region->info = info;
> +
> +	fpga_mgr_unlock(region->mgr);
>  	fpga_region_put(region);
>  
>  	return 0;
>  
>  err_put_br:
> -	fpga_bridges_put(&region->bridge_list);
> +	if (region->get_bridges)
> +		fpga_bridges_put(&region->bridge_list);
>  err_unlock_mgr:
> -	fpga_mgr_unlock(mgr);
> -err_put_mgr:
> -	fpga_mgr_put(mgr);
> +	fpga_mgr_unlock(region->mgr);
> +err_put_region:
>  	fpga_region_put(region);
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(fpga_region_program_fpga);
>  
> -/**
> - * child_regions_with_firmware
> - * @overlay: device node of the overlay
> - *
> - * If the overlay adds child FPGA regions, they are not allowed to have
> - * firmware-name property.
> - *
> - * Return 0 for OK or -EINVAL if child FPGA region adds firmware-name.
> - */
> -static int child_regions_with_firmware(struct device_node *overlay)
> +int fpga_region_register(struct device *dev, struct fpga_region *region)
>  {
> -	struct device_node *child_region;
> -	const char *child_firmware_name;
> -	int ret = 0;
> -
> -	of_node_get(overlay);
> -
> -	child_region = of_find_matching_node(overlay, fpga_region_of_match);
> -	while (child_region) {
> -		if (!of_property_read_string(child_region, "firmware-name",
> -					     &child_firmware_name)) {
> -			ret = -EINVAL;
> -			break;
> -		}
> -		child_region = of_find_matching_node(child_region,
> -						     fpga_region_of_match);
> -	}
> -
> -	of_node_put(child_region);
> -
> -	if (ret)
> -		pr_err("firmware-name not allowed in child FPGA region: %s",
> -		       child_region->full_name);
> -
> -	return ret;
> -}
> -
> -/**
> - * fpga_region_notify_pre_apply - pre-apply overlay notification
> - *
> - * @region: FPGA region that the overlay was applied to
> - * @nd: overlay notification data
> - *
> - * Called after when an overlay targeted to a FPGA Region is about to be
> - * applied.  Function will check the properties that will be added to the FPGA
> - * region.  If the checks pass, it will program the FPGA.
> - *
> - * The checks are:
> - * The overlay must add either firmware-name or external-fpga-config property
> - * to the FPGA Region.
> - *
> - *   firmware-name        : program the FPGA
> - *   external-fpga-config : FPGA is already programmed
> - *
> - * The overlay can add other FPGA regions, but child FPGA regions cannot have a
> - * firmware-name property since those regions don't exist yet.
> - *
> - * If the overlay that breaks the rules, notifier returns an error and the
> - * overlay is rejected before it goes into the main tree.
> - *
> - * Returns 0 for success or negative error code for failure.
> - */
> -static int fpga_region_notify_pre_apply(struct fpga_region *region,
> -					struct of_overlay_notify_data *nd)
> -{
> -	struct fpga_image_info *info;
> -	int ret;
> -
> -	info = devm_kzalloc(&region->dev, sizeof(*info), GFP_KERNEL);
> -	if (!info)
> -		return -ENOMEM;
> -
> -	region->info = info;
> -
> -	/* Reject overlay if child FPGA Regions have firmware-name property */
> -	ret = child_regions_with_firmware(nd->overlay);
> -	if (ret)
> -		return ret;
> -
> -	/* Read FPGA region properties from the overlay */
> -	if (of_property_read_bool(nd->overlay, "partial-fpga-config"))
> -		info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
> -
> -	if (of_property_read_bool(nd->overlay, "external-fpga-config"))
> -		info->flags |= FPGA_MGR_EXTERNAL_CONFIG;
> -
> -	of_property_read_string(nd->overlay, "firmware-name",
> -				&info->firmware_name);
> -
> -	of_property_read_u32(nd->overlay, "region-unfreeze-timeout-us",
> -			     &info->enable_timeout_us);
> -
> -	of_property_read_u32(nd->overlay, "region-freeze-timeout-us",
> -			     &info->disable_timeout_us);
> -
> -	/* If FPGA was externally programmed, don't specify firmware */
> -	if ((info->flags & FPGA_MGR_EXTERNAL_CONFIG) && info->firmware_name) {
> -		pr_err("error: specified firmware and external-fpga-config");
> -		return -EINVAL;
> -	}
> -
> -	/* FPGA is already configured externally.  We're done. */
> -	if (info->flags & FPGA_MGR_EXTERNAL_CONFIG)
> -		return 0;
> -
> -	/* If we got this far, we should be programming the FPGA */
> -	if (!info->firmware_name) {
> -		pr_err("should specify firmware-name or external-fpga-config\n");
> -		return -EINVAL;
> -	}
> -
> -	return fpga_region_program_fpga(region, nd->overlay);
> -}
> -
> -/**
> - * fpga_region_notify_post_remove - post-remove overlay notification
> - *
> - * @region: FPGA region that was targeted by the overlay that was removed
> - * @nd: overlay notification data
> - *
> - * Called after an overlay has been removed if the overlay's target was a
> - * FPGA region.
> - */
> -static void fpga_region_notify_post_remove(struct fpga_region *region,
> -					   struct of_overlay_notify_data *nd)
> -{
> -	fpga_bridges_disable(&region->bridge_list);
> -	fpga_bridges_put(&region->bridge_list);
> -	devm_kfree(&region->dev, region->info);
> -	region->info = NULL;
> -}
> -
> -/**
> - * of_fpga_region_notify - reconfig notifier for dynamic DT changes
> - * @nb:		notifier block
> - * @action:	notifier action
> - * @arg:	reconfig data
> - *
> - * This notifier handles programming a FPGA when a "firmware-name" property is
> - * added to a fpga-region.
> - *
> - * Returns NOTIFY_OK or error if FPGA programming fails.
> - */
> -static int of_fpga_region_notify(struct notifier_block *nb,
> -				 unsigned long action, void *arg)
> -{
> -	struct of_overlay_notify_data *nd = arg;
> -	struct fpga_region *region;
> -	int ret;
> -
> -	switch (action) {
> -	case OF_OVERLAY_PRE_APPLY:
> -		pr_debug("%s OF_OVERLAY_PRE_APPLY\n", __func__);
> -		break;
> -	case OF_OVERLAY_POST_APPLY:
> -		pr_debug("%s OF_OVERLAY_POST_APPLY\n", __func__);
> -		return NOTIFY_OK;       /* not for us */
> -	case OF_OVERLAY_PRE_REMOVE:
> -		pr_debug("%s OF_OVERLAY_PRE_REMOVE\n", __func__);
> -		return NOTIFY_OK;       /* not for us */
> -	case OF_OVERLAY_POST_REMOVE:
> -		pr_debug("%s OF_OVERLAY_POST_REMOVE\n", __func__);
> -		break;
> -	default:			/* should not happen */
> -		return NOTIFY_OK;
> -	}
> -
> -	region = fpga_region_find(nd->target);
> -	if (!region)
> -		return NOTIFY_OK;
> -
> -	ret = 0;
> -	switch (action) {
> -	case OF_OVERLAY_PRE_APPLY:
> -		ret = fpga_region_notify_pre_apply(region, nd);
> -		break;
> -
> -	case OF_OVERLAY_POST_REMOVE:
> -		fpga_region_notify_post_remove(region, nd);
> -		break;
> -	}
> -
> -	put_device(&region->dev);
> -
> -	if (ret)
> -		return notifier_from_errno(ret);
> -
> -	return NOTIFY_OK;
> -}
> -
> -static struct notifier_block fpga_region_of_nb = {
> -	.notifier_call = of_fpga_region_notify,
> -};
> -
> -static int fpga_region_probe(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct device_node *np = dev->of_node;
> -	struct fpga_region *region;
>  	int id, ret = 0;
>  
> -	region = kzalloc(sizeof(*region), GFP_KERNEL);
> -	if (!region)
> -		return -ENOMEM;
> -
>  	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0) {
> -		ret = id;
> -		goto err_kfree;
> -	}
> +	if (id < 0)
> +		return id;
>  
>  	mutex_init(&region->mutex);
>  	INIT_LIST_HEAD(&region->bridge_list);
> -
>  	device_initialize(&region->dev);
>  	region->dev.class = fpga_region_class;
>  	region->dev.parent = dev;
> -	region->dev.of_node = np;
> +	region->dev.of_node = dev->of_node;
>  	region->dev.id = id;
>  	dev_set_drvdata(dev, region);
>  
> @@ -521,82 +239,49 @@ static int fpga_region_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_remove;
>  
> -	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
> -
>  	dev_info(dev, "FPGA Region probed\n");
>  
>  	return 0;
>  
>  err_remove:
>  	ida_simple_remove(&fpga_region_ida, id);
> -err_kfree:
> -	kfree(region);
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(fpga_region_register);
>  
> -static int fpga_region_remove(struct platform_device *pdev)
> +int fpga_region_unregister(struct fpga_region *region)
>  {
> -	struct fpga_region *region = platform_get_drvdata(pdev);
> -
>  	device_unregister(&region->dev);
>  
>  	return 0;
>  }
> -
> -static struct platform_driver fpga_region_driver = {
> -	.probe = fpga_region_probe,
> -	.remove = fpga_region_remove,
> -	.driver = {
> -		.name	= "fpga-region",
> -		.of_match_table = of_match_ptr(fpga_region_of_match),
> -	},
> -};
> +EXPORT_SYMBOL_GPL(fpga_region_unregister);
>  
>  static void fpga_region_dev_release(struct device *dev)
>  {
>  	struct fpga_region *region = to_fpga_region(dev);
>  
>  	ida_simple_remove(&fpga_region_ida, region->dev.id);
> -	kfree(region);
>  }
>  
>  /**
>   * fpga_region_init - init function for fpga_region class
> - * Creates the fpga_region class and registers a reconfig notifier.
> + * Creates the fpga_region class.
>   */
>  static int __init fpga_region_init(void)
>  {
> -	int ret;
> -
>  	fpga_region_class = class_create(THIS_MODULE, "fpga_region");
>  	if (IS_ERR(fpga_region_class))
>  		return PTR_ERR(fpga_region_class);
>  
>  	fpga_region_class->dev_release = fpga_region_dev_release;
>  
> -	ret = of_overlay_notifier_register(&fpga_region_of_nb);
> -	if (ret)
> -		goto err_class;
> -
> -	ret = platform_driver_register(&fpga_region_driver);
> -	if (ret)
> -		goto err_plat;
> -
>  	return 0;
> -
> -err_plat:
> -	of_overlay_notifier_unregister(&fpga_region_of_nb);
> -err_class:
> -	class_destroy(fpga_region_class);
> -	ida_destroy(&fpga_region_ida);
> -	return ret;
>  }
>  
>  static void __exit fpga_region_exit(void)
>  {
> -	platform_driver_unregister(&fpga_region_driver);
> -	of_overlay_notifier_unregister(&fpga_region_of_nb);
>  	class_destroy(fpga_region_class);
>  	ida_destroy(&fpga_region_ida);
>  }
> diff --git a/drivers/fpga/fpga-region.h b/drivers/fpga/fpga-region.h
> new file mode 100644
> index 0000000..472f2f9
> --- /dev/null
> +++ b/drivers/fpga/fpga-region.h
> @@ -0,0 +1,50 @@
> +#include <linux/device.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/fpga/fpga-bridge.h>
> +
> +#ifndef _FPGA_REGION_H
> +#define _FPGA_REGION_H
> +
> +/**
> + * struct fpga_region - FPGA Region structure
> + * @dev: FPGA Region device
> + * @mutex: enforces exclusive reference to region
> + * @bridge_list: list of FPGA bridges specified in region
> + * @overlays: list of struct region_overlay_info
> + * @mgr_dev: device of fpga manager
> + * @priv: private data
> + */
> +struct fpga_region {
> +	struct device dev;
> +	struct mutex mutex; /* for exclusive reference to region */
> +	struct list_head bridge_list;
> +	struct fpga_manager *mgr;
> +	struct fpga_image_info *info;
> +	void *priv;
> +	int (*get_bridges)(struct fpga_region *region,
> +			   struct fpga_image_info *image_info);
> +};
> +
> +#define to_fpga_region(d) container_of(d, struct fpga_region, dev)
> +
> +#ifdef CONFIG_OF
> +struct fpga_region *of_fpga_region_find(struct device_node *np);
> +#else
> +struct fpga_region *of_fpga_region_find(struct device_node *np)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_OF */
> +
> +struct fpga_image_info *fpga_region_alloc_image_info(
> +				struct fpga_region *region);
> +void fpga_region_free_image_info(struct fpga_region *region,
> +				 struct fpga_image_info *image_info);
> +
> +int fpga_region_program_fpga(struct fpga_region *region,
> +			     struct fpga_image_info *image_info);
> +
> +int fpga_region_register(struct device *dev, struct fpga_region *region);
> +int fpga_region_unregister(struct fpga_region *region);
> +
> +#endif /* _FPGA_REGION_H */
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> new file mode 100644
> index 0000000..7809036
> --- /dev/null
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -0,0 +1,453 @@
> +/*
> + * FPGA Region - Device Tree support for FPGA programming under Linux
> + *
> + *  Copyright (C) 2013-2016 Altera Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/fpga/fpga-bridge.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/idr.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include "fpga-region.h"
> +
> +/**
> + * of_fpga_region_get_manager - get pointer for FPGA Manager
> + * @dev: FPGA region's device
> + *
> + * Get FPGA Manager from "fpga-mgr" property in region or in ancestor region.
> + *
> + * Caller should call fpga_mgr_put() when done with manager.
> + *
> + * Return: fpga manager struct or IS_ERR() condition containing error code.
> + */
> +static struct fpga_manager *of_fpga_region_get_mgr(struct device_node *np)
> +{
> +	struct device_node  *mgr_node;
> +	struct fpga_manager *mgr;
> +
> +	of_node_get(np);
> +	while (np) {
> +		if (of_device_is_compatible(np, "fpga-region")) {
> +			mgr_node = of_parse_phandle(np, "fpga-mgr", 0);
> +			if (mgr_node) {
> +				mgr = of_fpga_mgr_get(mgr_node);
> +				of_node_put(np);
> +				return mgr;
> +			}
> +		}
> +		np = of_get_next_parent(np);
> +	}
> +	of_node_put(np);
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +/**
> + * of_fpga_region_get_bridges - create a list of bridges
> + * @region: FPGA region
> + * @image_info: FPGA image info
> + *
> + * Create a list of bridges including the parent bridge and the bridges
> + * specified by "fpga-bridges" property.  Note that the
> + * fpga_bridges_enable/disable/put functions are all fine with an empty list
> + * if that happens.
> + *
> + * Caller should call fpga_bridges_put(&region->bridge_list) when
> + * done with the bridges.
> + *
> + * Return 0 for success (even if there are no bridges specified)
> + * or -EBUSY if any of the bridges are in use.
> + */
> +static int of_fpga_region_get_bridges(struct fpga_region *region,
> +				      struct fpga_image_info *image_info)
> +{
> +	struct device *dev = &region->dev;
> +	struct device_node *region_np = dev->of_node;
> +	struct device_node *br, *np, *parent_br = NULL;
> +	int i, ret;
> +
> +	/* If parent is a bridge, add to list */
> +	ret = of_fpga_bridge_get_to_list(region_np->parent,
> +					 image_info,
> +					 &region->bridge_list);
> +	if (ret == -EBUSY)
> +		return ret;

Would a if (ret) do here? Otherwise what happens on if (ret)?
If you can replace the above if (ret == ...) the if (!ret) can go away.
> +
> +	if (!ret)
> +		parent_br = region_np->parent;
> +
> +	/* If overlay has a list of bridges, use it. */
> +	if (of_parse_phandle(image_info->overlay, "fpga-bridges", 0))
> +		np = image_info->overlay;
> +	else
> +		np = region_np;
> +
> +	for (i = 0; ; i++) {
> +		br = of_parse_phandle(np, "fpga-bridges", i);
> +		if (!br)
> +			break;
> +
> +		/* If parent bridge is in list, skip it. */
> +		if (br == parent_br)
> +			continue;
> +
> +		/* If node is a bridge, get it and add to list */
> +		ret = of_fpga_bridge_get_to_list(br, image_info,
> +						 &region->bridge_list);
> +
> +		/* If any of the bridges are in use, give up */
> +		if (ret == -EBUSY) {
> +			fpga_bridges_put(&region->bridge_list);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id fpga_region_of_match[] = {
> +	{ .compatible = "fpga-region", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, fpga_region_of_match);
> +
> +/**
> + * child_regions_with_firmware
> + * @overlay: device node of the overlay
> + *
> + * If the overlay adds child FPGA regions, they are not allowed to have
> + * firmware-name property.
> + *
> + * Return 0 for OK or -EINVAL if child FPGA region adds firmware-name.
> + */
> +static int child_regions_with_firmware(struct device_node *overlay)
> +{
> +	struct device_node *child_region;
> +	const char *child_firmware_name;
> +	int ret = 0;
> +
> +	of_node_get(overlay);
> +
> +	child_region = of_find_matching_node(overlay, fpga_region_of_match);
> +	while (child_region) {
> +		if (!of_property_read_string(child_region, "firmware-name",
> +					     &child_firmware_name)) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +		child_region = of_find_matching_node(child_region,
> +						     fpga_region_of_match);
> +	}
> +
> +	of_node_put(child_region);
> +
> +	if (ret)
> +		pr_err("firmware-name not allowed in child FPGA region: %s",
> +		       child_region->full_name);
> +
> +	return ret;
> +}
> +
> +/**
> + * of_fpga_region_parse_ov - parse and check overlay applied to region
> + *
> + * @region: FPGA region
> + * @overlay: overlay applied to the FPGA region
> + *
> + * Given an overlay applied to a FPGA region, parse the FPGA image specific
> + * info in the overlay and do some checking.
> + *
> + * Returns:
> + *   NULL if overlay doesn't direct us to program the FPGA.
> + *   fpga_image_info struct if there is an image to program.
> + *   error code for invalid overlay.
> + */
> +static struct fpga_image_info *of_fpga_region_parse_ov(
> +						struct fpga_region *region,
> +						struct device_node *overlay)
> +{
> +	struct device *dev = &region->dev;
> +	struct fpga_image_info *info;
> +	const char *firmware_name;
> +	int ret;
> +
> +	/*
> +	 * Reject overlay if child FPGA Regions added in the overlay have
> +	 * firmware-name property (would mean that an FPGA region that has
> +	 * not been added to the live tree yet is doing FPGA programming).
> +	 */
> +	ret = child_regions_with_firmware(overlay);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	info = fpga_region_alloc_image_info(region);
> +	if (!info)
> +		return ERR_PTR(-ENOMEM);
> +
> +	info->overlay = overlay;
> +
> +	if (of_property_read_bool(overlay, "partial-fpga-config"))
> +		info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
> +
> +	if (of_property_read_bool(overlay, "external-fpga-config"))
> +		info->flags |= FPGA_MGR_EXTERNAL_CONFIG;
> +
> +	if (!of_property_read_string(overlay, "firmware-name",
> +				     &firmware_name)) {
> +		info->firmware_name = devm_kstrdup(dev, firmware_name,
> +						   GFP_KERNEL);
> +		if (!info->firmware_name)
> +			return ERR_PTR(-ENOMEM);
> +	}
> +
> +	of_property_read_u32(overlay, "region-unfreeze-timeout-us",
> +			     &info->enable_timeout_us);
> +
> +	of_property_read_u32(overlay, "region-freeze-timeout-us",
> +			     &info->disable_timeout_us);
> +
> +	/* If overlay is not programming the FPGA, don't need FPGA image info */
> +	if (!info->firmware_name) {
> +		ret = 0;
> +		goto ret_no_info;
> +	}
> +
> +	/*
> +	 * If overlay informs us FPGA was externally programmed, specifying
> +	 * firmware here would be ambiguous.
> +	 */
> +	if (info->flags & FPGA_MGR_EXTERNAL_CONFIG) {
> +		dev_err(dev, "error: specified firmware and external-fpga-config");
> +		ret = -EINVAL;
> +		goto ret_no_info;
> +	}
> +
> +	return info;
> +ret_no_info:
> +	fpga_region_free_image_info(region, info);
> +	return ERR_PTR(ret);
> +}
> +
> +/**
> + * of_fpga_region_notify_pre_apply - pre-apply overlay notification
> + *
> + * @region: FPGA region that the overlay will be applied to
> + * @nd: overlay notification data
> + *
> + * Called when an overlay targeted to a FPGA Region is about to be applied.
> + * Parses the overlay for properties that influence how the FPGA will be
> + * programmed and does some checking. If the checks pass, programs the FPGA.
> + *
> + * If the overlay that breaks the rules, notifier returns an error and the
> + * overlay is rejected, preventing it from being added to the main tree.
> + *
> + * Return: 0 for success or negative error code for failure.
> + */
> +static int of_fpga_region_notify_pre_apply(struct fpga_region *region,
> +					   struct of_overlay_notify_data *nd)
> +{
> +	struct fpga_image_info *info;
> +	int ret;
> +
> +	if (region->info) {
> +		dev_err(&region->dev, "Region already has overlay applied.\n");
> +		return -EINVAL;
> +	}
> +
> +	info = of_fpga_region_parse_ov(region, nd->overlay);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
> +
> +	if (info) {
> +		ret = fpga_region_program_fpga(region, info);
> +		if (ret)
> +			goto pre_a_err;
> +	}
> +
> +	return 0;
> +
> +pre_a_err:
> +	fpga_region_free_image_info(region, info);
> +	return ret;
> +}
> +
> +/**
> + * of_fpga_region_notify_post_remove - post-remove overlay notification
> + *
> + * @region: FPGA region that was targeted by the overlay that was removed
> + * @nd: overlay notification data
> + *
> + * Called after an overlay has been removed if the overlay's target was a
> + * FPGA region.
> + */
> +static void of_fpga_region_notify_post_remove(struct fpga_region *region,
> +					      struct of_overlay_notify_data *nd)
> +{
> +	fpga_bridges_disable(&region->bridge_list);
> +	fpga_bridges_put(&region->bridge_list);
> +	fpga_region_free_image_info(region, region->info);
> +	region->info = NULL;
> +}
> +
> +/**
> + * of_fpga_region_notify - reconfig notifier for dynamic DT changes
> + * @nb:		notifier block
> + * @action:	notifier action
> + * @arg:	reconfig data
> + *
> + * This notifier handles programming a FPGA when a "firmware-name" property is
> + * added to a fpga-region.
> + *
> + * Returns NOTIFY_OK or error if FPGA programming fails.
> + */
> +static int of_fpga_region_notify(struct notifier_block *nb,
> +				 unsigned long action, void *arg)
> +{
> +	struct of_overlay_notify_data *nd = arg;
> +	struct fpga_region *region;
> +	int ret;
> +
> +	switch (action) {
> +	case OF_OVERLAY_PRE_APPLY:
> +		pr_debug("%s OF_OVERLAY_PRE_APPLY\n", __func__);
> +		break;
> +	case OF_OVERLAY_POST_APPLY:
> +		pr_debug("%s OF_OVERLAY_POST_APPLY\n", __func__);
> +		return NOTIFY_OK;       /* not for us */
> +	case OF_OVERLAY_PRE_REMOVE:
> +		pr_debug("%s OF_OVERLAY_PRE_REMOVE\n", __func__);
> +		return NOTIFY_OK;       /* not for us */
> +	case OF_OVERLAY_POST_REMOVE:
> +		pr_debug("%s OF_OVERLAY_POST_REMOVE\n", __func__);
> +		break;
> +	default:			/* should not happen */
> +		return NOTIFY_OK;
> +	}
> +
> +	region = of_fpga_region_find(nd->target);
> +	if (!region)
> +		return NOTIFY_OK;
> +
> +	ret = 0;
> +	switch (action) {
> +	case OF_OVERLAY_PRE_APPLY:
> +		ret = of_fpga_region_notify_pre_apply(region, nd);
> +		break;
> +
> +	case OF_OVERLAY_POST_REMOVE:
> +		of_fpga_region_notify_post_remove(region, nd);
> +		break;
> +	}
> +
> +	put_device(&region->dev);
> +
> +	if (ret)
> +		return notifier_from_errno(ret);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block fpga_region_of_nb = {
> +	.notifier_call = of_fpga_region_notify,
> +};
> +
> +static int of_fpga_region_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct fpga_manager *mgr;
> +	struct fpga_region *region;
> +	int ret;
> +
> +	region = devm_kzalloc(dev, sizeof(*region), GFP_KERNEL);
> +	if (!region)
> +		return -ENOMEM;
> +
> +	/* Find the FPGA mgr specified by region or parent region. */
> +	mgr = of_fpga_region_get_mgr(np);
> +	if (IS_ERR(mgr)) {
> +		ret = PTR_ERR(mgr);
> +		goto err_kfree;
> +	}
> +	region->mgr = mgr;
> +
> +	/* Specify how to get bridges for this type of region. */
> +	region->get_bridges = of_fpga_region_get_bridges;
> +
> +	ret = fpga_region_register(dev, region);
> +	if (ret)
> +		goto err_put_mgr;
> +
> +	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
> +	dev_info(dev, "FPGA Region probed\n");
> +
> +	return ret;
> +
> +err_put_mgr:
> +	fpga_mgr_put(mgr);
> +err_kfree:
> +	devm_kfree(dev, region);
> +
> +	return ret;
> +}
> +
> +static int of_fpga_region_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct fpga_region *region = platform_get_drvdata(pdev);
> +
> +	fpga_region_unregister(region);
> +	devm_kfree(dev, region);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver fpga_region_driver = {
> +	.probe = of_fpga_region_probe,
> +	.remove = of_fpga_region_remove,
> +	.driver = {
> +		.name	= "fpga-region",
> +		.of_match_table = of_match_ptr(fpga_region_of_match),
> +	},
> +};
> +
> +static int __init of_fpga_region_notifier_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&fpga_region_driver);
> +	if (ret)
> +		return ret;
> +
> +	return of_overlay_notifier_register(&fpga_region_of_nb);
> +}
> +
> +static void __exit of_fpga_region_notifier_exit(void)
> +{
> +	of_overlay_notifier_unregister(&fpga_region_of_nb);
> +	platform_driver_unregister(&fpga_region_driver);
> +}
> +
> +device_initcall(of_fpga_region_notifier_init);
> +module_exit(of_fpga_region_notifier_exit);
> +
> +MODULE_DESCRIPTION("OF FPGA Region");
> +MODULE_AUTHOR("Alan Tull <atull@opensource.altera.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index ae970ca..0f5072c 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -80,15 +80,19 @@ enum fpga_mgr_states {
>   * @sgt: scatter/gather table containing FPGA image
>   * @buf: contiguous buffer containing FPGA image
>   * @count: size of buf
> + * @overlay: Device Tree overlay
>   */
>  struct fpga_image_info {
>  	u32 flags;
>  	u32 enable_timeout_us;
>  	u32 disable_timeout_us;
> -	const char *firmware_name;
> +	char *firmware_name;
>  	struct sg_table *sgt;
>  	const char *buf;
>  	size_t count;
> +#ifdef CONFIG_OF
> +	struct device_node *overlay;
> +#endif
>  };
>  
>  /**
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,

Moritz
