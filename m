Return-Path: <SRS0=p8Yu=QZ=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=p8Yu=QZ=gmail.com=robherring2@kernel.org>
Date: Mon, 18 Feb 2019 11:28:02 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Message-ID: <20190218172802.GA1376@bogus>
References: <20190211161736.23844-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211161736.23844-1-nava.manne@xilinx.com>
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: atull@kernel.org, mdf@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com, jollys@xilinx.com, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chinnikishore369@gmail.com
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Feb 11, 2019 at 09:47:36PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.

I thought I was told in the review of the firmware binding that is went 
away...

> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
> 		-Created patches on top of 5.0-rc5.
>                  No functional changes.
> Changes for v2:
>                 -Removed "----" separators.
> Changes for v1:
>                 -Created a Seperate(New) DT binding file as
>                  suggested by Rob.
> 
> Changes for RFC-V2:
>                 -Moved pcap node as a child to firwmare
>                  node as suggested by Rob.
> 
>  .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt      | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> new file mode 100644
> index 0000000..1f6f588
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> @@ -0,0 +1,13 @@
> +Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC controlled
> +using ZynqMP SoC firmware interface
> +For Bitstream configuration on ZynqMp Soc uses processor configuration
> +port(PCAP) to configure the programmable logic(PL) through PS by using
> +FW interface.
> +
> +Required properties:
> +- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> +
> +Example:
> +	zynqmp_pcap: pcap {
> +		compatible = "xlnx,zynqmp-pcap-fpga";

There's no DT resources here, so there's no need for this in DT. Just 
have the parent (the firmware driver) instantiate the driver.

Rob
