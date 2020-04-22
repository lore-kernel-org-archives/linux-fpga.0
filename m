Return-Path: <SRS0=h/oP=6G=redhat.com=trix@kernel.org>
Return-Path: <SRS0=h/oP=6G=redhat.com=trix@kernel.org>
Subject: Re: How to upload fpga firmware
References: <20200422114432.GM1694@pengutronix.de>
From: Tom Rix <trix@redhat.com>
Message-ID: <cba38c9a-4f13-ce6b-1705-0266b991261f@redhat.com>
Date: Wed, 22 Apr 2020 11:24:49 -0700
MIME-Version: 1.0
In-Reply-To: <20200422114432.GM1694@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer@pengutronix.de>, linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

I believe you need to use OPAE, user level interface to the kernel.

Here is a good starting point.

https://opae.github.io/latest/docs/fpga_tools/fpgaconf/fpgaconf.html

Tom

On 4/22/20 4:44 AM, Sascha Hauer wrote:
> Hi,
>
> I wonder what can be done with the mainline state of drivers/fpga/. The
> entry to the framework seems to be fpga_mgr_load(). The only user of
> this function is fpga_region_program_fpga(). This in turn is only called
> in response of applying a device tree overlay. A device tree overlay is
> applied with of_overlay_fdt_apply() which has no users in the Kernel.
>
> My current task is to load a firmware to a FPGA. The code all seems to
> be there in the Kernel, it only lacks a way to trigger it. I am not very
> interested in device tree overlays since the FPGA appears as a PCI
> device (although applying a dtbo could enable the PCIe controller device
> tree node). Is there some mainline way to upload FPGA firmware? At the
> moment we are using the attached patch to trigger loading the firmware
> from userspace. Would something like this be acceptable for mainline?
>
> Sascha
>
> ---------------------------8<----------------------------------
>
> From 71a5ea845dd673d4011391f9e57fdaf427767ed5 Mon Sep 17 00:00:00 2001
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Date: Tue, 2 Oct 2018 17:13:40 +0200
> Subject: [PATCH] fpga: region: Add sysfs attribute for loading firmware
>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>  drivers/fpga/fpga-region.c | 50 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index bde5a9d460c5..ca6dc830fadf 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -5,6 +5,7 @@
>   *  Copyright (C) 2013-2016 Altera Corporation
>   *  Copyright (C) 2017 Intel Corporation
>   */
> +#include <linux/device.h>
>  #include <linux/fpga/fpga-bridge.h>
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/fpga/fpga-region.h>
> @@ -170,11 +171,58 @@ static ssize_t compat_id_show(struct device *dev,
>  		       (unsigned long long)region->compat_id->id_h,
>  		       (unsigned long long)region->compat_id->id_l);
>  }
> -
>  static DEVICE_ATTR_RO(compat_id);
>  
> +static ssize_t firmware_name_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct fpga_region *region = to_fpga_region(dev);
> +
> +	if (!region->info || !region->info->firmware_name)
> +		return 0;
> +
> +	return sprintf(buf, "%s\n", region->info->firmware_name);
> +}
> +
> +static ssize_t firmware_name_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *firmware_name, size_t count)
> +{
> +	struct fpga_region *region = to_fpga_region(dev);
> +	struct fpga_image_info *info = region->info;
> +	int error;
> +
> +	if (!info) {
> +		info = fpga_image_info_alloc(dev);
> +		if (!info)
> +			return -ENOMEM;
> +	} else if (info->firmware_name) {
> +		devm_kfree(dev, info->firmware_name);
> +	}
> +
> +	info->firmware_name = devm_kstrdup(dev, firmware_name, GFP_KERNEL);
> +	if (!info->firmware_name)
> +		return -ENOMEM;
> +
> +	if (count >  0 && info->firmware_name[count - 1] == '\n')
> +		info->firmware_name[count - 1] = '\0';
> +
> +	region->info = info;
> +	error = fpga_region_program_fpga(region);
> +	if (error) {
> +		devm_kfree(dev, info->firmware_name);
> +		info->firmware_name = NULL;
> +	}
> +
> +	return error ? error : count;
> +}
> +
> +static DEVICE_ATTR_RW(firmware_name);
> +
>  static struct attribute *fpga_region_attrs[] = {
>  	&dev_attr_compat_id.attr,
> +	&dev_attr_firmware_name.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(fpga_region);
