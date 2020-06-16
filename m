Date: Mon, 15 Jun 2020 21:42:04 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: fpga: xilinx-slave-serial: valid for
 the 7 Series too
Message-ID: <20200616044202.GA46300@epycbox.lan>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611211144.9421-1-luca@lucaceresoli.net>
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jun 11, 2020 at 11:11:40PM +0200, Luca Ceresoli wrote:
> The Xilinx 7-series uses the same protocol, mention that.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  .../devicetree/bindings/fpga/xilinx-slave-serial.txt     | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> index cfa4ed42b62f..9f103f3872e8 100644
> --- a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> +++ b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> @@ -1,11 +1,14 @@
>  Xilinx Slave Serial SPI FPGA Manager
>  
> -Xilinx Spartan-6 FPGAs support a method of loading the bitstream over
> -what is referred to as "slave serial" interface.
> +Xilinx Spartan-6 and 7 Series FPGAs support a method of loading the
> +bitstream over what is referred to as "slave serial" interface.
>  The slave serial link is not technically SPI, and might require extra
>  circuits in order to play nicely with other SPI slaves on the same bus.
>  
> -See https://www.xilinx.com/support/documentation/user_guides/ug380.pdf
> +See:
> +- https://www.xilinx.com/support/documentation/user_guides/ug380.pdf
> +- https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
> +- https://www.xilinx.com/support/documentation/application_notes/xapp583-fpga-configuration.pdf
>  
>  Required properties:
>  - compatible: should contain "xlnx,fpga-slave-serial"
> -- 
> 2.27.0
> 
