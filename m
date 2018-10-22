Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20181020084805.29103-1-nava.manne@xilinx.com> <20181020084805.29103-3-nava.manne@xilinx.com>
In-Reply-To: <20181020084805.29103-3-nava.manne@xilinx.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 22 Oct 2018 12:41:56 -0500
Message-ID: <CANk1AXQ_AFGX9_80YM7-GYncfZ8pOhaYdSb=O-ZpYCWuHx71vA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
Content-Type: text/plain; charset="UTF-8"
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michal Simek <michal.simek@xilinx.com>, rajanv@xilinx.com, jollys@xilinx.com, linux-fpga@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, kishore m <chinnikishore369@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Oct 19, 2018 at 3:49 AM Nava kishore Manne
<nava.manne@xilinx.com> wrote:

Hi Nava,

Just some nits, below.

>
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v1:
>                 Created a Seperate(New) DT binding file as
>                 suggested by Rob.
>
> Changes for RFC-V2:
>                 -Moved pcap node as a child to firwmare
>                  node as suggested by Rob.
>
>  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> new file mode 100644
> index 000000000000..248ff0ee60a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> @@ -0,0 +1,17 @@
> +--------------------------------------------------------------------------

Please get rid of all these '----' separators (in 4 places).

> +Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC controlled
> +using ZynqMP SoC firmware interface
> +--------------------------------------------------------------------------
> +For Bitstream configuration on ZynqMp Soc uses processor configuration
> +port(PCAP) to configure the programmable logic(PL) through PS by using
> +FW interface.
> +
> +Required properties:
> +- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> +
> +-------
> +Example

Nit: please add a colon so 'Example:'
> +-------
> +       zynqmp_pcap: pcap {
> +               compatible = "xlnx,zynqmp-pcap-fpga";
> +       };
> --
> 2.18.0
>

Thanks,
Alan
