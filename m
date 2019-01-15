Return-Path: <dinguyen@kernel.org>
Return-Path: <dinguyen@kernel.org>
Subject: Re: [PATCH v2] fpga: altera_freeze_bridge: remove restriction to
 socfpga
References: <20190114223312.3254-1-atull@kernel.org>
From: Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <0574de1a-a238-7ad3-1bc2-24d27ff50cba@kernel.org>
Date: Tue, 15 Jan 2019 11:47:36 -0600
MIME-Version: 1.0
In-Reply-To: <20190114223312.3254-1-atull@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

minor nit

On 1/14/19 4:33 PM, Alan Tull wrote:
> The Altera Freeze Bridge should not be restricted to ARCH_SOCFPGA
> since it can be used on other platforms such as Stratix10.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
>  drivers/fpga/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 0bb7b5c..da5786a 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -104,7 +104,8 @@ config SOCFPGA_FPGA_BRIDGE
>  
>  config ALTERA_FREEZE_BRIDGE
>  	tristate "Altera FPGA Freeze Bridge"
> -	depends on ARCH_SOCFPGA && FPGA_BRIDGE
> +	depends on FPGA_BRIDGE
> +	depends on HAS_IOMEM

can just be:

depends on FPGA_BRIDGE && HAS_IOMEM

Dinh
