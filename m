Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180201223115.16420-1-agust@denx.de>
References: <20180201223115.16420-1-agust@denx.de>
From: Alan Tull <atull@kernel.org>
Date: Mon, 12 Feb 2018 10:19:06 -0600
Message-ID: <CANk1AXQ7-caSN=7Xtqokpq80Rh77XTZhP7d7P4L7d9V6mgoq4w@mail.gmail.com>
Subject: Re: [PATCH] fpga-manager: altera-ps-spi: enable usage on non-dt platforms
Content-Type: text/plain; charset="UTF-8"
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Joshua Clayton <stillcompiling@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Feb 1, 2018 at 4:31 PM, Anatolij Gustschin <agust@denx.de> wrote:

Hi Anatolij,

> Driver probing fails on non-dt platforms since of_match_device()
> always returns NULL here. Add device names and matching driver
> data to the spi_device_id table. This allows driver binding to
> dynamically added PS-SPI devices (e.g. added via spi_new_device()
> after hot-plugging).
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  drivers/fpga/altera-ps-spi.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index 14f14efdf0d5..c593f33d8db9 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -238,16 +238,25 @@ static int altera_ps_probe(struct spi_device *spi)
>  {
>         struct altera_ps_conf *conf;
>         const struct of_device_id *of_id;
> +       const struct spi_device_id *id;
>
>         conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
>         if (!conf)
>                 return -ENOMEM;
>
> -       of_id = of_match_device(of_ef_match, &spi->dev);
> -       if (!of_id)
> -               return -ENODEV;
> +       if (spi->dev.of_node) {
> +               of_id = of_match_device(of_ef_match, &spi->dev);
> +               if (!of_id)
> +                       return -ENODEV;
> +
> +               conf->data = of_id->data;
> +       } else {
> +               id = spi_get_device_id(spi);
> +               if (!id)
> +                       return -ENODEV;

Is it actually possible for !id at this point?  Seems like if we are
in this probe function and we get this far, this would always succeed.

Alan

> +               conf->data = (struct altera_ps_data *)id->driver_data;
> +       }
>
> -       conf->data = of_id->data;
>         conf->spi = spi;
>         conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
>         if (IS_ERR(conf->config)) {
> @@ -285,7 +294,9 @@ static int altera_ps_remove(struct spi_device *spi)
>  }
>
>  static const struct spi_device_id altera_ps_spi_ids[] = {
> -       {"cyclone-ps-spi", 0},
> +       {"cyclone-ps-spi", (kernel_ulong_t)&c5_data},
> +       {"fpga-passive-serial", (kernel_ulong_t)&c5_data},
> +       {"fpga-arria10-passive-serial", (kernel_ulong_t)&a10_data},
>         {}
>  };
>  MODULE_DEVICE_TABLE(spi, altera_ps_spi_ids);
> --
> 2.11.0
>
