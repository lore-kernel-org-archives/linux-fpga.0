Return-Path: <SRS0=gN2n=VW=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=gN2n=VW=ettus.com=moritz.fischer@kernel.org>
Date: Thu, 25 Jul 2019 13:52:33 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 1/1] fpga: altera-ps-spi: Fix getting of optional confd
 gpio
Message-ID: <20190725205233.GA13647@archbox>
References: <1564022925-40402-1-git-send-email-preid@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564022925-40402-1-git-send-email-preid@electromag.com.au>
To: Phil Reid <preid@electromag.com.au>
Cc: atull@kernel.org, mdf@kernel.org, colin.king@canonical.com, agust@denx.de, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jul 25, 2019 at 10:48:45AM +0800, Phil Reid wrote:
> Currently the driver does not handle EPROBE_DEFER for the confd gpio.
> Use devm_gpiod_get_optional() instead of devm_gpiod_get() and return
> error codes from altera_ps_probe().
> 
> Fixes: 5692fae0742d ("fpga manager: Add altera-ps-spi driver for Altera FPGAs")
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
> 
> Notes:
>     Compile tested only. I currently don't have hardware to test.
>     I was reviewing the driver prior to a board design and noticed
>     the problem.
> 
>  drivers/fpga/altera-ps-spi.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index 678d0115f840..a02b88d63f89 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -213,7 +213,7 @@ static int altera_ps_write_complete(struct fpga_manager *mgr,
>  		return -EIO;
>  	}
>  
> -	if (!IS_ERR(conf->confd)) {
> +	if (conf->confd) {
>  		if (!gpiod_get_raw_value_cansleep(conf->confd)) {
>  			dev_err(&mgr->dev, "CONF_DONE is inactive!\n");
>  			return -EIO;
> @@ -292,10 +292,13 @@ static int altera_ps_probe(struct spi_device *spi)
>  		return PTR_ERR(conf->status);
>  	}
>  
> -	conf->confd = devm_gpiod_get(&spi->dev, "confd", GPIOD_IN);
> +	conf->confd = devm_gpiod_get_optional(&spi->dev, "confd", GPIOD_IN);
>  	if (IS_ERR(conf->confd)) {
> -		dev_warn(&spi->dev, "Not using confd gpio: %ld\n",
> -			 PTR_ERR(conf->confd));
> +		dev_err(&spi->dev, "Failed to get confd gpio: %ld\n",
> +			PTR_ERR(conf->confd));
> +		return PTR_ERR(conf->confd);
> +	} else if (!conf->confd) {
> +		dev_warn(&spi->dev, "Not using confd gpio");
>  	}
>  
>  	/* Register manager with unique name */
> -- 
> 1.8.3.1
> 
Applied, thanks.

Moritz
