Date: Sat, 9 May 2020 11:57:52 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: zynqmp: fix modular build
Message-ID: <20200509185750.GA6715@epycbox.lan>
References: <20200505140041.231844-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505140041.231844-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Moritz Fischer <mdf@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rajan Vaja <rajan.vaja@xilinx.com>, Jolly Shah <jolly.shah@xilinx.com>, Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, May 05, 2020 at 04:00:11PM +0200, Arnd Bergmann wrote:
> Two symbols need to be exported to allow the zynqmp-fpga module
> to get loaded dynamically:
> 
> ERROR: modpost: "zynqmp_pm_fpga_load" [drivers/fpga/zynqmp-fpga.ko] undefined!
> ERROR: modpost: "zynqmp_pm_fpga_get_status" [drivers/fpga/zynqmp-fpga.ko] undefined!
> 
> To ensure this is done correctly, also fix the Kconfig dependency
> to only allow building the fpga driver when the firmware driver is
> either disabled, or when it is reachable. With that, the dependency
> on the SoC itself can be removed, and there are no surprises when
> the fpga driver is built-in but the firmware a module.
> 
> Fixes: 4db8180ffe7c ("firmware: xilinx: Remove eemi ops for fpga related APIs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/fpga/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index b2408a710662..7cd5a29fc437 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -208,7 +208,7 @@ config FPGA_DFL_PCI
>  
>  config FPGA_MGR_ZYNQMP_FPGA
>  	tristate "Xilinx ZynqMP FPGA"
> -	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on ZYNQMP_FIRMWARE || (!ZYNQMP_FIRMWARE && COMPILE_TEST)
>  	help
>  	  FPGA manager driver support for Xilinx ZynqMP FPGAs.
>  	  This driver uses the processor configuration port(PCAP)
> -- 
> 2.26.0
> 
Applied to fixes,

Thanks
