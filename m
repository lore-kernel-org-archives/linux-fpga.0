Date: Wed, 22 Apr 2020 18:36:51 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: How to upload fpga firmware
Message-ID: <20200423013648.GA2430@epycbox.lan>
References: <20200422114432.GM1694@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422114432.GM1694@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Sascha,

On Wed, Apr 22, 2020 at 01:44:32PM +0200, Sascha Hauer wrote:
> Hi,
> 
> I wonder what can be done with the mainline state of drivers/fpga/. The
> entry to the framework seems to be fpga_mgr_load(). The only user of
> this function is fpga_region_program_fpga(). This in turn is only called
> in response of applying a device tree overlay. A device tree overlay is
> applied with of_overlay_fdt_apply() which has no users in the Kernel.

Yes. It is waiting for dt_overlays one way or another. I personally
don't currently have the bandwidth to work actively on this.

> My current task is to load a firmware to a FPGA. The code all seems to
> be there in the Kernel, it only lacks a way to trigger it. I am not very
> interested in device tree overlays since the FPGA appears as a PCI
> device (although applying a dtbo could enable the PCIe controller device
> tree node). Is there some mainline way to upload FPGA firmware? At the
> moment we are using the attached patch to trigger loading the firmware
> from userspace. Would something like this be acceptable for mainline?

We've looked into this sort of patches over the years and never came to
a general interface that really works.

The OPAE folks (and other users I know of) usually use FPGA Manager with
a higher layer on top of it that moves the bitstream into the kernel via
an ioctl().

One concept I had toyed with mentally, but haven't really gotten around
to implement is a 'discoverable' region, that would deal with the
necessary re-enumeration via a callback and have a sysfs interface
similar to what the patch below has.
This would essentially cover use-cases where you have a discoverable
device implemented in FPGA logic, such as say an FPGA hanging off of
PCIe bus that can get loaded over USB, a CPLD or some other side-band
mechanism. After loading the image you'd have to rescan the PCIe bus -
which - imho is the kernel's job.

What I really wanna avoid is creating another /dev/fpga0 / /dev/xdevcfg
that completely leaves the kernel in the dark about the fact that it
reconfigures a bit of hardware hanging off the bus.

In my ideal world you'd create a pci driver that binds to your device,
and creates mfd style subdevices for whatever you'd want your design to
do. One of these devices would be an FPGA and a FPGA region attached to
that FPGA manager. Your top level driver would co-ordinate the fact that
you are re-programming parts of the FPGA and create / destroy devices as
needed for the hardware contained in the bitstream.

[..]
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

Cheers,
Moritz
