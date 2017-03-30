Return-Path: <SRS0=7/Tb=3H=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=7/Tb=3H=gmail.com=robherring2@kernel.org>
Date: Thu, 30 Mar 2017 17:44:29 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] doc: Add bindings document for Xilinx LogiCore PR
 Decoupler
Message-ID: <20170330224429.yo42hgnr7nhm2ljv@rob-hp-laptop>
References: <20170324153321.4168-1-atull@kernel.org>
 <20170324153321.4168-2-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170324153321.4168-2-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Moritz Fischer <moritz.fischer@ettus.com>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Michal Simek <michal.simek@xilinx.com>, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, devicetree@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Mar 24, 2017 at 10:33:20AM -0500, Alan Tull wrote:
> From: Moritz Fischer <mdf@kernel.org>

Please use "dt-bindings: fpga: ..." for the subject.


> 
> This adds the binding documentation for the Xilinx LogiCORE PR
> Decoupler soft core.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Acked-by: Alan Tull <atull@kernel.org>

I'm confused why you are sending these instead of Moritz? If it goes 
through you, then it should have your S-o-B too.

> Cc: S�ren Brinkmann <soren.brinkmann@xilinx.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  .../bindings/fpga/xilinx-pr-decoupler.txt          | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> new file mode 100644
> index 000000000000..2c527ac30398
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> @@ -0,0 +1,35 @@
> +Xilinx LogiCORE Partial Reconfig Decoupler Softcore
> +
> +The Xilinx LogiCORE Partial Reconfig Decoupler manages one or more
> +decouplers / fpga bridges.
> +The controller can decouple/disable the bridges which prevents signal
> +changes from passing through the bridge.  The controller can also
> +couple / enable the bridges which allows traffic to pass through the
> +bridge normally.
> +
> +The Driver supports only MMIO handling. A PR region can have multiple
> +PR Decouplers which can be handled independently or chained via decouple/
> +decouple_status signals.
> +
> +Required properties:
> +- compatible		: Should contain "xlnx,pr-decoupler-1.00" or "xlnx,pr-decoupler"

I'd drop xlnx,pr-decoupler, but in any case, it should not be OR rather 
"followed by". Plus the example has both.

> +- regs			: base address and size for decoupler module
> +- clocks		: input clock to IP
> +- clock-names		: should contain "aclk"
> +
> +Optional properties:
> +- bridge-enable		: 0 if driver should disable bridge at startup
> +			  1 if driver should enable bridge at startup
> +			  Default is to leave bridge in current state.
> +
> +See Documentation/devicetree/bindings/fpga/fpga-region.txt for generic bindings.
> +
> +Example:
> +	fpga-bridge@100000450 {
> +		compatible = "xlnx,pr-decoupler-1.00",
> +			     "xlnx-pr-decoupler";
> +		regs = <0x10000045 0x10>;
> +		clocks = <&clkc 15>;
> +		clock-names = "aclk";
> +		bridge-enable = <0>;
> +	};
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
