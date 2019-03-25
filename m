Return-Path: <SRS0=R/SX=R4=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=R/SX=R4=gmail.com=robherring2@kernel.org>
Date: Mon, 25 Mar 2019 14:18:49 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Message-ID: <20190315235422.GA29658@bogus>
References: <20190314140122.23372-1-nava.manne@xilinx.com>
 <20190314140122.23372-7-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314140122.23372-7-nava.manne@xilinx.com>
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: atull@kernel.org, mdf@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com, jollys@xilinx.com, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chinnikishore369@gmail.com
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Mar 14, 2019 at 07:31:22PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v4:
> 		-Modified binding description as suggested by Moritz Fischer.
> Changes for v3:
>                 -Removed PCAP as a child node to the FW and Created
> 		 an independent node since PCAP driver is a consumer
> 		 not a provider.

Huh?

It was the fpga-regions that I suggested should perhaps be at the 
top-level. As long as pcap is a function exposed by the firmware it 
should be a child of it.

> 
>  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt           | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> new file mode 100644
> index 000000000000..6d7f10775d9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> @@ -0,0 +1,11 @@
> +Devicetree bindings for Zynq Ultrascale MPSoC FPGA Manager.
> +The ZynqMP SoC uses the PCAP (Processor configuration Port) to configure the
> +Programmable Logic (PL). The configuration uses  the firmware interface.
> +
> +Required properties:
> +- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> +
> +Example:
> +	zynqmp_pcap: pcap {
> +		compatible = "xlnx,zynqmp-pcap-fpga";
> +	};
> -- 
> 2.18.0
> 
