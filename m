Return-Path: <SRS0=NaWT=F5=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=NaWT=F5=gmail.com=robherring2@kernel.org>
Date: Wed, 7 Mar 2018 13:47:45 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv2 4/7] dt-bindings: fpga: add Stratix10 SoC FPGA manager
 binding
Message-ID: <20180307194745.657ewa6rtcta6eqm@rob-hp-laptop>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
 <1519949975-13548-5-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519949975-13548-5-git-send-email-richard.gong@linux.intel.com>
To: richard.gong@linux.intel.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, yves.vandervennet@linux.intel.com
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Mar 01, 2018 at 06:19:32PM -0600, richard.gong@linux.intel.com wrote:
> From: Alan Tull <atull@kernel.org>
> 
> Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
> v2: this patch is added in patch set version 2
> ---
>  .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> new file mode 100644
> index 0000000..78de689
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> @@ -0,0 +1,10 @@
> +Intel Stratix10 SoC FPGA Manager
> +
> +Required properties:
> +- compatible : should contain "intel,stratix10-soc-fpga-mgr"
> +
> +Example:
> +
> +	fpga_mgr: fpga-mgr@0 {
> +		compatible = "intel,stratix10-soc-fpga-mgr";

No reg or anything else? Is that because it all goes thru the service 
layer firmware? Just get the service layer driver to instantiate a 
device for this driver or get rid of the 2 layers if that's all the 
firmware interface does. DT is not a Linux driver instantiation 
mechanism.

And build your dts files with "W=1" because there's an error in this 
example.

Rob
