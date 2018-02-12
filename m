Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180201222004.15949-1-agust@denx.de>
References: <20180201222004.15949-1-agust@denx.de>
From: Alan Tull <atull@kernel.org>
Date: Mon, 12 Feb 2018 10:02:13 -0600
Message-ID: <CANk1AXQDWM4Y674Qpqa939z6A1EMGE2gm89SbLOsvCdBFD3EbA@mail.gmail.com>
Subject: Re: [PATCH] fpga-manager: altera-ps-spi: preserve nCONFIG state
Content-Type: text/plain; charset="UTF-8"
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Joshua Clayton <stillcompiling@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Feb 1, 2018 at 4:20 PM, Anatolij Gustschin <agust@denx.de> wrote:

Hi Anatolij,

> If the driver module is loaded when FPGA is configured, the FPGA
> is reset because nconfig is pulled low (low-active gpio inited
> with GPIOD_OUT_HIGH activates the signal which means setting its
> value to low). Init nconfig with GPIOD_OUT_LOW to prevent this.

Yes, makes sense.

>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan

> ---
>  drivers/fpga/altera-ps-spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index c593f33d8db9..6891933d072d 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -258,7 +258,7 @@ static int altera_ps_probe(struct spi_device *spi)
>         }
>
>         conf->spi = spi;
> -       conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_HIGH);
> +       conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
>         if (IS_ERR(conf->config)) {
>                 dev_err(&spi->dev, "Failed to get config gpio: %ld\n",
>                         PTR_ERR(conf->config));
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
