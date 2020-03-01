Date: Sun, 1 Mar 2020 08:23:03 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCHv1 1/7] dt-bindings: fpga: add compatible value to
 Stratix10 SoC FPGA manager binding
Message-ID: <20200301162302.GD7593@epycbox.lan>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
 <1581696052-11540-2-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581696052-11540-2-git-send-email-richard.gong@linux.intel.com>
To: richard.gong@linux.intel.com
Cc: gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Feb 14, 2020 at 10:00:46AM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add a compatible property value to Stratix10 SoC FPGA manager binding file
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt          | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> index 6e03f79..0f87413 100644
> --- a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> +++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> @@ -4,7 +4,8 @@ Required properties:
>  The fpga_mgr node has the following mandatory property, must be located under
>  firmware/svc node.
>  
> -- compatible : should contain "intel,stratix10-soc-fpga-mgr"
> +- compatible : should contain "intel,stratix10-soc-fpga-mgr" or
> +	       "intel,agilex-soc-fpga-mgr"
>  
>  Example:
>  
> -- 
> 2.7.4
> 
Applied to for-next,

Thanks
