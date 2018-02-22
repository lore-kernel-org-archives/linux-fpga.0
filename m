Return-Path: <SRS0=R79Y=FQ=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=R79Y=FQ=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-sn1nam01on0069.outbound.protection.outlook.com ([104.47.32.69]:19755
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751687AbeBVHMf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 22 Feb 2018 02:12:35 -0500
Subject: Re: [PATCH] dt-bindings: fpga: Consolidate bridge properties
References: <20180221173306.17265-1-mdf@kernel.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <8751fd85-fc84-f422-94e7-dd5689cb6922@xilinx.com>
Date: Thu, 22 Feb 2018 08:12:19 +0100
MIME-Version: 1.0
In-Reply-To: <20180221173306.17265-1-mdf@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, atull@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, devicetree@vger.kernel.org

On 21.2.2018 18:33, Moritz Fischer wrote:
> Consolidate bridge properties in a single file, instead of duplicating
> the same optional property over and over again.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  .../devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt |  5 +----
>  .../devicetree/bindings/fpga/altera-freeze-bridge.txt     |  5 +----
>  .../devicetree/bindings/fpga/altera-hps2fpga-bridge.txt   |  5 +----
>  Documentation/devicetree/bindings/fpga/fpga-bridge.txt    | 15 +++++++++++++++
>  .../devicetree/bindings/fpga/xilinx-pr-decoupler.txt      |  8 ++------
>  5 files changed, 20 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
> index 817a8d4bf903..5dd0ff0f7b4e 100644
> --- a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
> +++ b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
> @@ -3,10 +3,7 @@ Altera FPGA To SDRAM Bridge Driver
>  Required properties:
>  - compatible		: Should contain "altr,socfpga-fpga2sdram-bridge"
>  
> -Optional properties:
> -- bridge-enable		: 0 if driver should disable bridge at startup
> -			  1 if driver should enable bridge at startup
> -			  Default is to leave bridge in current state.
> +See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
>  
>  Example:
>  	fpga_bridge3: fpga-bridge@ffc25080 {
> diff --git a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> index f8e288c71b2d..8b26fbcff3c6 100644
> --- a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> +++ b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> @@ -10,10 +10,7 @@ Required properties:
>  - compatible		: Should contain "altr,freeze-bridge-controller"
>  - regs			: base address and size for freeze bridge module
>  
> -Optional properties:
> -- bridge-enable		: 0 if driver should disable bridge at startup
> -			  1 if driver should enable bridge at startup
> -			  Default is to leave bridge in current state.
> +See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
>  
>  Example:
>  	freeze-controller@100000450 {
> diff --git a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
> index 6406f9337eeb..68cce3945b10 100644
> --- a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
> +++ b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
> @@ -9,10 +9,7 @@ Required properties:
>  - resets	: Phandle and reset specifier for this bridge's reset
>  - clocks	: Clocks used by this module.
>  
> -Optional properties:
> -- bridge-enable	: 0 if driver should disable bridge at startup.
> -		  1 if driver should enable bridge at startup.
> -		  Default is to leave bridge in its current state.
> +See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
>  
>  Example:
>  	fpga_bridge0: fpga-bridge@ff400000 {
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-bridge.txt b/Documentation/devicetree/bindings/fpga/fpga-bridge.txt
> new file mode 100644
> index 000000000000..82607b23a287
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/fpga-bridge.txt
> @@ -0,0 +1,15 @@
> +FPGA Bridge Device Tree Binding
> +
> +Moritz Fischer 2018 (Consolidated from previous bindings)

nit: I would remove your name and year - it is visible from git log.

> +
> +Optional properties:
> +- bridge-enable		: 0 if driver should disable bridge at startup
> +			  1 if driver should enable bridge at startup
> +			  Default is to leave bridge in current state.
> +
> +Example:
> +	fpga_bridge3: fpga-bridge@ffc25080 {
> +		compatible = "altr,socfpga-fpga2sdram-bridge";
> +		reg = <0xffc25080 0x4>;
> +		bridge-enable = <0>;
> +	};
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> index 8dcfba926bc7..4284d293fa61 100644
> --- a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> +++ b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> @@ -18,12 +18,8 @@ Required properties:
>  - clocks		: input clock to IP
>  - clock-names		: should contain "aclk"
>  
> -Optional properties:
> -- bridge-enable		: 0 if driver should disable bridge at startup
> -			  1 if driver should enable bridge at startup
> -			  Default is to leave bridge in current state.
> -
> -See Documentation/devicetree/bindings/fpga/fpga-region.txt for generic bindings.
> +See Documentation/devicetree/bindings/fpga/fpga-region.txt and
> +Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
>  
>  Example:
>  	fpga-bridge@100000450 {
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
