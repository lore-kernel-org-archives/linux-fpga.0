Date: Mon, 8 Jul 2019 17:05:29 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga-manager: altera-ps-spi: Fix build error
Message-ID: <20190709000527.GA1587@archbook>
References: <20190708071356.50928-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708071356.50928-1-yuehaibing@huawei.com>
To: YueHaibing <yuehaibing@huawei.com>
Cc: mdf@kernel.org, stillcompiling@gmail.com, atull@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Jul 08, 2019 at 03:13:56PM +0800, YueHaibing wrote:
> If BITREVERSE is m and FPGA_MGR_ALTERA_PS_SPI is y,
> build fails:
> 
> drivers/fpga/altera-ps-spi.o: In function `altera_ps_write':
> altera-ps-spi.c:(.text+0x4ec): undefined reference to `byte_rev_table'
> 
> Select BITREVERSE to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: fcfe18f885f6 ("fpga-manager: altera-ps-spi: use bitrev8x4")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/fpga/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 474f304..cdd4f73 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -40,6 +40,7 @@ config ALTERA_PR_IP_CORE_PLAT
>  config FPGA_MGR_ALTERA_PS_SPI
>  	tristate "Altera FPGA Passive Serial over SPI"
>  	depends on SPI
> +	select BITREVERSE
>  	help
>  	  FPGA manager driver support for Altera Arria/Cyclone/Stratix
>  	  using the passive serial interface over SPI.
> -- 
> 2.7.4
> 
> 
Acked-by: Moritz Fischer <mdf@kernel.org>
