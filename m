Return-Path: <dinguyen@kernel.org>
Return-Path: <dinguyen@kernel.org>
Subject: Re: [PATCH] ARM: socfpga: fix base address of SDR controller
References: <20190129200858.19773-1-goldsimon@gmx.de>
From: Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <0711a2e0-b4fb-fa12-7c5c-0b5da73c8b02@kernel.org>
Date: Tue, 29 Jan 2019 18:16:04 -0600
MIME-Version: 1.0
In-Reply-To: <20190129200858.19773-1-goldsimon@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alan Tull <atull@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-fpga@vger.kernel.org>



On 1/29/19 2:08 PM, Simon Goldschmidt wrote:
> From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> 
> The documentation for socfpga gen5 says the base address of the sdram
> controller is 0xffc20000, while the current devicetree says it is at
> 0xffc25000.
> 
> While this is not a problem for Linux, as it only accesses the registers
> above 0xffc25000, it *is* a problem for U-Boot because the lower registers
> are used during DDR calibration (up to now, the U-Boot driver does not use
> the dts address, but that should change).
> 
> To keep Linux and U-Boot devicetrees in sync, this patch changes the base
> address to 0xffc20000 and adapts the 2 files where it is currently used.
> 
> This patch changes the dts and 2 drivers with one commit to prevent
> breaking the code if dts change and driver change would be split.
> 
> Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> ---
> 
>  arch/arm/boot/dts/socfpga.dtsi       | 4 ++--
>  arch/arm/mach-socfpga/self-refresh.S | 4 ++--
>  drivers/fpga/altera-fpga2sdram.c     | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index f365003f0..8f6c1a5d6 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -788,9 +788,9 @@
>  			reg = <0xfffec000 0x100>;
>  		};
>  
> -		sdr: sdr@ffc25000 {
> +		sdr: sdr@ffc20000 {
>  			compatible = "altr,sdr-ctl", "syscon";
> -			reg = <0xffc25000 0x1000>;
> +			reg = <0xffc20000 0x6000>;

I don't see the U-Boot device tree having this change. Yes, the
documentation does state that the SDR address starts at 0xffc20000, but
all of the pertinent registers start at 0x5000 offset. Thus, the
starting address should be 0xffc25000.[1]

[1]
https://www.intel.com/content/www/us/en/programmable/documentation/sfo1410143707420.html#sfo1411577366917

Dinh
