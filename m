Date: Sun, 1 Mar 2020 08:31:28 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCHv1 7/7] firmware: intel_stratix10_service: add depend on
 agilex
Message-ID: <20200301163126.GB7992@epycbox.lan>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
 <1581696052-11540-8-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581696052-11540-8-git-send-email-richard.gong@linux.intel.com>
To: richard.gong@linux.intel.com
Cc: gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Feb 14, 2020 at 10:00:52AM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add depend on Agilex for Intel Agilex SoC platform.
> 
Acked-by: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  drivers/firmware/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index ea869ad..8007d4a 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -206,7 +206,7 @@ config FW_CFG_SYSFS_CMDLINE
>  
>  config INTEL_STRATIX10_SERVICE
>  	tristate "Intel Stratix10 Service Layer"
> -	depends on ARCH_STRATIX10 && HAVE_ARM_SMCCC
> +	depends on (ARCH_STRATIX10 || ARCH_AGILEX) && HAVE_ARM_SMCCC
>  	default n
>  	help
>  	  Intel Stratix10 service layer runs at privileged exception level,
> -- 
> 2.7.4
> 
