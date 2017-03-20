Return-Path: <SRS0=FVIH=25=xilinx.com=michal.simek@kernel.org>
Return-Path: <SRS0=FVIH=25=xilinx.com=michal.simek@kernel.org>
Subject: Re: [PATCH v3 1/2] doc: Add bindings document for Xilinx LogiCore PR
 Decoupler
References: <1489781473-30772-1-git-send-email-mdf@kernel.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <bc6ea50e-321c-3eb4-b1c3-10dadf984d81@xilinx.com>
Date: Mon, 20 Mar 2017 11:03:02 +0100
MIME-Version: 1.0
In-Reply-To: <1489781473-30772-1-git-send-email-mdf@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, "Michal Simek  <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?=" <soren.brinkmann@xilinx.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 17.3.2017 21:11, Moritz Fischer wrote:
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
> Changes from v2:
> - Added refence to generic fpga-region bindings
> - Fixed up reg property in example
> - Added fallback to "xlnx,pr-decoupler" without version
> 
> Changes from v1:
> - Added clock names & clock to example
> - Merged some of the description from Michal's version
> 
> ---
>  .../bindings/fpga/xilinx-pr-decoupler.txt          | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> new file mode 100644
> index 0000000..16141bd
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
> +PR Decouples which can bhe handled independently or chaines via decouple/
> +decouple_status signals.
> +
> +Required properties:
> +- compatible		: Should contain "xlnx,pr-decoupler-1.00"

here should be also that "xlnx-pr-decoupler" too.

Other than this all looks good.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
