Return-Path: <SRS0=MxXm=22=xilinx.com=michal.simek@kernel.org>
Return-Path: <SRS0=MxXm=22=xilinx.com=michal.simek@kernel.org>
Subject: Re: [PATCH v2 1/2] doc: Add bindings document for Xilinx LogiCore PR
 Decoupler
References: <1489711910-17443-1-git-send-email-mdf@kernel.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <9f823c88-ccd5-7534-9999-019c8a9f082a@xilinx.com>
Date: Fri, 17 Mar 2017 10:57:18 +0100
MIME-Version: 1.0
In-Reply-To: <1489711910-17443-1-git-send-email-mdf@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, "Michal Simek  <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?=" <soren.brinkmann@xilinx.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 17.3.2017 01:51, Moritz Fischer wrote:
> This adds the binding documentation for the Xilinx LogiCORE PR
> Decoupler soft core.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
> 
> Changes from v1:
> - Added clock names & clock to example
> - Merged some of the description from Michal's version
> 
> ---
>  .../bindings/fpga/xilinx-pr-decoupler.txt          | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> new file mode 100644
> index 0000000..2080006
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> @@ -0,0 +1,32 @@
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
> +PR Decouples which can bhe handled independently or chaines via decouple/
> +decouple_status signals.
> +
> +Required properties:
> +- compatible		: Should contain "xlnx,pr-decoupler-1.00"

should

I would tend to do this as
"xlnx,pr-decoupler-1.00" and/or  "xlnx,pr_decoupler"


> +- regs			: base address and size for decoupler module
> +- clocks		: input clock to IP
> +- clock-names		: should contain "aclk"
> +
> +Optional properties:
> +- bridge-enable		: 0 if driver should disable bridge at startup
> +			  1 if driver should enable bridge at startup
> +			  Default is to leave bridge in current state.

Interesting that this is not a bool.
But anyway this should be link to bridge binding because I expect this
is the same for all.

> +
> +Example:
> +	fpga-bridge@100000450 {
> +		compatible = "xlnx,pr-decoupler-1.00";

"xlnx,pr-decoupler-1.00", "xlnx,pr_decoupler";

> +		regs = <0x1000 0x10>;
> +		clocks = <&clkc 15>;
> +		clock-names = "aclk";
> +		bridge-enable = <0>;
> +	};
> 

Thanks,
Michal
