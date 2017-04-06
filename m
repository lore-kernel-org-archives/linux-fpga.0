Date: Wed, 5 Apr 2017 21:07:00 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 4/5] fpga-mgr: separate getting/locking FPGA manager
Message-ID: <20170406040700.GA5981@tyrael.amer.corp.natinst.com>
References: <20170313215333.3008-1-atull@kernel.org>
 <20170313215333.3008-5-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170313215333.3008-5-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan,

minor nits, inline

On Mon, Mar 13, 2017 at 04:53:32PM -0500, Alan Tull wrote:
> Add fpga_mgr_lock/unlock functions that get a mutex for
> exclusive use.
> 
> of_fpga_mgr_get, fpga_mgr_get, and fpga_mgr_put no longer lock
> the FPGA manager mutex.
> 
> This makes it more straightforward to save a reference to
> a FPGA manager and only attempting to lock it when programming
> the FPGA.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
>  drivers/fpga/fpga-mgr.c       | 44 +++++++++++++++++++++++++++++++------------
>  drivers/fpga/fpga-region.c    | 13 +++++++++++--
>  include/linux/fpga/fpga-mgr.h |  3 +++
>  3 files changed, 46 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index fde605b..f7c3648 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -376,28 +376,19 @@ ATTRIBUTE_GROUPS(fpga_mgr);
>  struct fpga_manager *__fpga_mgr_get(struct device *dev)
>  {
>  	struct fpga_manager *mgr;
> -	int ret = -ENODEV;
>  
>  	mgr = to_fpga_manager(dev);
>  	if (!mgr)
>  		goto err_dev;
>  
> -	/* Get exclusive use of fpga manager */
> -	if (!mutex_trylock(&mgr->ref_mutex)) {
> -		ret = -EBUSY;
> -		goto err_dev;
> -	}
> -
>  	if (!try_module_get(dev->parent->driver->owner))
> -		goto err_ll_mod;
> +		goto err_dev;
>  
>  	return mgr;
>  
> -err_ll_mod:
> -	mutex_unlock(&mgr->ref_mutex);
>  err_dev:
>  	put_device(dev);
> -	return ERR_PTR(ret);
> +	return ERR_PTR(-ENODEV);
>  }
>  
>  static int fpga_mgr_dev_match(struct device *dev, const void *data)
> @@ -457,12 +448,41 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
>  void fpga_mgr_put(struct fpga_manager *mgr)
>  {
>  	module_put(mgr->dev.parent->driver->owner);
> -	mutex_unlock(&mgr->ref_mutex);
>  	put_device(&mgr->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
>  
>  /**
> + * fpga_mgr_lock - Lock FPGA manager for exclusive use
> + * @mgr:	fpga manager
> + *
> + * Given a pointer to FPGA Manager (from fpga_mgr_get() or
> + * of_fpga_mgr_put()) attempt to get the mutex.
> + *
> + * Return: 0 for success or -EBUSY
> + */
> +int fpga_mgr_lock(struct fpga_manager *mgr)
> +{
> +	if (!mutex_trylock(&mgr->ref_mutex)) {
> +		dev_err(&mgr->dev, "FPGA manager is in use.\n");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fpga_mgr_lock);
> +
> +/**
> + * fpga_mgr_unlock - Unlock FPGA manager
> + * @mgr:	fpga manager
> + */
> +void fpga_mgr_unlock(struct fpga_manager *mgr)
> +{
> +	mutex_unlock(&mgr->ref_mutex);
> +}
> +EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
> +
> +/**
>   * fpga_mgr_register - register a low level fpga manager driver
>   * @dev:	fpga manager device from pdev
>   * @name:	fpga manager name
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index 294556e..815f178 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -125,7 +125,7 @@ static void fpga_region_put(struct fpga_region *region)
>  }
>  
>  /**
> - * fpga_region_get_manager - get exclusive reference for FPGA manager
> + * fpga_region_get_manager - get reference for FPGA manager
>   * @region: FPGA region
>   *
>   * Get FPGA Manager from "fpga-mgr" property or from ancestor region.
> @@ -245,10 +245,16 @@ static int fpga_region_program_fpga(struct fpga_region *region,
>  		return PTR_ERR(mgr);
>  	}
>  
> +	ret = fpga_mgr_lock(mgr);
> +	if (ret) {
> +		pr_err("FPGA manager is busy\n");

Am I missing something here, or could you use dev_err(&mgr->dev, ...)
here?

> +		goto err_put_mgr;
> +	}
> +
>  	ret = fpga_region_get_bridges(region, overlay);
>  	if (ret) {
>  		pr_err("failed to get fpga region bridges\n");

Same here, (I know this is not part of this patch), maybe the above is
for consistency reasons then. Maybe I'm missing something.
> -		goto err_put_mgr;
> +		goto err_unlock_mgr;
>  	}
>  
>  	ret = fpga_bridges_disable(&region->bridge_list);
> @@ -269,6 +275,7 @@ static int fpga_region_program_fpga(struct fpga_region *region,
>  		goto err_put_br;
>  	}
>  
> +	fpga_mgr_unlock(mgr);
>  	fpga_mgr_put(mgr);
>  	fpga_region_put(region);
>  
> @@ -276,6 +283,8 @@ static int fpga_region_program_fpga(struct fpga_region *region,
>  
>  err_put_br:
>  	fpga_bridges_put(&region->bridge_list);
> +err_unlock_mgr:
> +	fpga_mgr_unlock(mgr);
>  err_put_mgr:
>  	fpga_mgr_put(mgr);
>  	fpga_region_put(region);
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 45df05a..ae970ca 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -149,6 +149,9 @@ int fpga_mgr_firmware_load(struct fpga_manager *mgr,
>  
>  int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info);
>  
> +int fpga_mgr_lock(struct fpga_manager *mgr);
> +void fpga_mgr_unlock(struct fpga_manager *mgr);
> +
>  struct fpga_manager *of_fpga_mgr_get(struct device_node *node);
>  
>  struct fpga_manager *fpga_mgr_get(struct device *dev);
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,

Moritz
