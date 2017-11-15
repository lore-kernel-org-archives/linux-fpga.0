Return-Path: <SRS0=zy8y=CN=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=zy8y=CN=ettus.com=moritz.fischer@kernel.org>
Date: Wed, 15 Nov 2017 07:49:36 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v5 11/18] fpga: region: add fpga-region.h header
Message-ID: <20171115154936.GE21681@tyrael.ni.corp.natinst.com>
References: <20171017212031.3770-1-atull@kernel.org>
 <20171017212031.3770-12-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017212031.3770-12-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Oct 17, 2017 at 04:20:24PM -0500, Alan Tull wrote:
> * Create fpga-region.h.
> * Export fpga_region_program_fpga.
> * Move struct fpga_region and other things to the header.
> 
> This is a step in separating FPGA region common code
> from Device Tree support.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: split out from another patch
>     update author email
> v3: changes due to fpga_region_program_fpga() removed info param
> v4: no change to this patch in this version of patchset
> v5: fpga-region.h - move #ifndef before #includes
> ---
>  drivers/fpga/fpga-region.c       | 24 ++++--------------------
>  include/linux/fpga/fpga-region.h | 28 ++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 20 deletions(-)
>  create mode 100644 include/linux/fpga/fpga-region.h
> 
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index 2a8621d..402d0b6 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -18,6 +18,7 @@
>  
>  #include <linux/fpga/fpga-bridge.h>
>  #include <linux/fpga/fpga-mgr.h>
> +#include <linux/fpga/fpga-region.h>
>  #include <linux/idr.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -26,24 +27,6 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  
> -/**
> - * struct fpga_region - FPGA Region structure
> - * @dev: FPGA Region device
> - * @mutex: enforces exclusive reference to region
> - * @bridge_list: list of FPGA bridges specified in region
> - * @mgr: FPGA manager
> - * @info: fpga image specific information
> - */
> -struct fpga_region {
> -	struct device dev;
> -	struct mutex mutex; /* for exclusive reference to region */
> -	struct list_head bridge_list;
> -	struct fpga_manager *mgr;
> -	struct fpga_image_info *info;
> -};
> -
> -#define to_fpga_region(d) container_of(d, struct fpga_region, dev)
> -
>  static DEFINE_IDA(fpga_region_ida);
>  static struct class *fpga_region_class;
>  
> @@ -226,7 +209,7 @@ static int fpga_region_get_bridges(struct fpga_region *region,
>   * Program an FPGA using fpga image info (region->info).
>   * Return 0 for success or negative error code.
>   */
> -static int fpga_region_program_fpga(struct fpga_region *region)
> +int fpga_region_program_fpga(struct fpga_region *region)
>  {
>  	struct device *dev = &region->dev;
>  	struct fpga_image_info *info = region->info;
> @@ -282,6 +265,7 @@ static int fpga_region_program_fpga(struct fpga_region *region)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(fpga_region_program_fpga);
>  
>  /**
>   * child_regions_with_firmware
> @@ -667,5 +651,5 @@ subsys_initcall(fpga_region_init);
>  module_exit(fpga_region_exit);
>  
>  MODULE_DESCRIPTION("FPGA Region");
> -MODULE_AUTHOR("Alan Tull <atull@opensource.altera.com>");
> +MODULE_AUTHOR("Alan Tull <atull@kernel.org>");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
> new file mode 100644
> index 0000000..8a35517
> --- /dev/null
> +++ b/include/linux/fpga/fpga-region.h
> @@ -0,0 +1,28 @@
> +#ifndef _FPGA_REGION_H
> +#define _FPGA_REGION_H
> +
> +#include <linux/device.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/fpga/fpga-bridge.h>
> +
> +/**
> + * struct fpga_region - FPGA Region structure
> + * @dev: FPGA Region device
> + * @mutex: enforces exclusive reference to region
> + * @bridge_list: list of FPGA bridges specified in region
> + * @mgr: FPGA manager
> + * @info: FPGA image info
> + */
> +struct fpga_region {
> +	struct device dev;
> +	struct mutex mutex; /* for exclusive reference to region */
> +	struct list_head bridge_list;
> +	struct fpga_manager *mgr;
> +	struct fpga_image_info *info;
> +};
> +
> +#define to_fpga_region(d) container_of(d, struct fpga_region, dev)
> +
> +int fpga_region_program_fpga(struct fpga_region *region);
> +
> +#endif /* _FPGA_REGION_H */
> -- 
> 2.7.4
> 
