Return-Path: <SRS0=Ip7l=76=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=Ip7l=76=gmail.com=robherring2@kernel.org>
Date: Wed, 17 Jun 2020 16:39:55 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/5] dt-bindings: fpga: xilinx-slave-serial: add optional
 INIT_B GPIO
Message-ID: <20200617223955.GA2967317@bogus>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
 <20200611211144.9421-4-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611211144.9421-4-luca@lucaceresoli.net>
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jun 11, 2020 at 11:11:43PM +0200, Luca Ceresoli wrote:
> The INIT_B is used by the 6 and 7 series to report the programming status,
> providing more control and information about programming errors.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  .../devicetree/bindings/fpga/xilinx-slave-serial.txt       | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> index 9f103f3872e8..a049082e1513 100644
> --- a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> +++ b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> @@ -16,6 +16,10 @@ Required properties:
>  - prog_b-gpios: config pin (referred to as PROGRAM_B in the manual)
>  - done-gpios: config status pin (referred to as DONE in the manual)
>  
> +Optional properties:
> +- init_b-gpios: initialization status and configuration error pin
> +                (referred to as INIT_B in the manual)

Don't use '_' in property names:

init-b-gpios

> +
>  Example for full FPGA configuration:
>  
>  	fpga-region0 {
> @@ -40,7 +44,8 @@ Example for full FPGA configuration:
>  			spi-max-frequency = <60000000>;
>  			spi-cpha;
>  			reg = <0>;
> -			done-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
>  			prog_b-gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
> +			init_b-gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
> +			done-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
>  		};
>  	};
> -- 
> 2.27.0
> 
