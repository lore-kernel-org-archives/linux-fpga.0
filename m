Date: Sun, 1 Mar 2020 08:23:27 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCHv1 2/7] arm64: dts: agilex: correct FPGA manager driver's
 compatible value
Message-ID: <20200301162325.GE7593@epycbox.lan>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
 <1581696052-11540-3-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581696052-11540-3-git-send-email-richard.gong@linux.intel.com>
To: richard.gong@linux.intel.com
Cc: gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Feb 14, 2020 at 10:00:47AM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Correct the compatible property value for FPGA manager driver on
> Intel Agilex SoC platform.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> index e1d357e..8c29853 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> @@ -544,7 +544,7 @@
>  				memory-region = <&service_reserved>;
>  
>  				fpga_mgr: fpga-mgr {
> -					compatible = "intel,stratix10-soc-fpga-mgr";
> +					compatible = "intel,agilex-soc-fpga-mgr";
>  				};
>  			};
>  		};
> -- 
> 2.7.4
> 
Applied to for-next,

Thanks
