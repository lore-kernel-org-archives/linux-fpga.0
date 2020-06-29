Return-Path: <SRS0=QT4I=AK=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=QT4I=AK=intel.com=yilun.xu@kernel.org>
Date: Mon, 29 Jun 2020 10:19:24 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH] fpga: dfl: improve configuration of dfl pci devices
Message-ID: <20200629021924.GB2620@yilunxu-OptiPlex-7050>
References: <20200628151813.7679-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628151813.7679-1-trix@redhat.com>
To: trix@redhat.com
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, hao.wu@intel.com, matthew.gerlach@linux.intel.com
List-ID: <linux-fpga@vger.kernel.org>

I think maybe we don't have to select them all. It is now possible for
FPGA DFL boards to work without FME or AFU, providing limited
functionality. It is possible designers trim the bitstream for their
purpose, and also need a smaller driver set.

I think we may add "default FPGA_DFL" for FPGA_DFL_FME,
FPGA_DFL_FME_MGR and others to make life easier.

How do you think?

On Sun, Jun 28, 2020 at 08:18:13AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> To use a dfl pci device, several dfl configs need to be selected.
> This is tedious and error prone.
> 
> So automagically select the needed configs when FPGA_DFL_PCI
> is selected.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/Kconfig | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 7cd5a29fc437..4b9e05af5426 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -138,6 +138,27 @@ config OF_FPGA_REGION
>  	  Support for loading FPGA images by applying a Device Tree
>  	  overlay.
>  
> +config FPGA_DFL_PCI
> +	tristate "FPGA DFL PCIe Device Driver"
> +	depends on PCI
> +	select FPGA_DFL
> +	select FPGA_DFL_FME
> +	select FPGA_DFL_FME_MGR
> +	select FPGA_DFL_FME_BRIDGE
> +	select FPGA_DFL_FME_REGION
> +	select FPGA_DFL_AFU
> +	help
> +	  Select this option to enable PCIe driver for PCIe-based
> +	  Field-Programmable Gate Array (FPGA) solutions which implement
> +	  the Device Feature List (DFL). This driver provides interfaces
> +	  for userspace applications to configure, enumerate, open and access
> +	  FPGA accelerators on the FPGA DFL devices, enables system level
> +	  management functions such as FPGA partial reconfiguration, power
> +	  management and virtualization with DFL framework and DFL feature
> +	  device drivers.
> +
> +	  To compile this as a module, choose M here.
> +
>  config FPGA_DFL
>  	tristate "FPGA Device Feature List (DFL) support"
>  	select FPGA_BRIDGE
> @@ -191,21 +212,6 @@ config FPGA_DFL_AFU
>  	  to the FPGA infrastructure via a Port. There may be more than one
>  	  Port/AFU per DFL based FPGA device.
>  
> -config FPGA_DFL_PCI
> -	tristate "FPGA DFL PCIe Device Driver"
> -	depends on PCI && FPGA_DFL
> -	help
> -	  Select this option to enable PCIe driver for PCIe-based
> -	  Field-Programmable Gate Array (FPGA) solutions which implement
> -	  the Device Feature List (DFL). This driver provides interfaces
> -	  for userspace applications to configure, enumerate, open and access
> -	  FPGA accelerators on the FPGA DFL devices, enables system level
> -	  management functions such as FPGA partial reconfiguration, power
> -	  management and virtualization with DFL framework and DFL feature
> -	  device drivers.
> -
> -	  To compile this as a module, choose M here.
> -
>  config FPGA_MGR_ZYNQMP_FPGA
>  	tristate "Xilinx ZynqMP FPGA"
>  	depends on ZYNQMP_FIRMWARE || (!ZYNQMP_FIRMWARE && COMPILE_TEST)
> -- 
> 2.18.1
