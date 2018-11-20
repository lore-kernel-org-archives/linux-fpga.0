Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20181115235803.25316-1-agust@denx.de>
In-Reply-To: <20181115235803.25316-1-agust@denx.de>
From: Alan Tull <atull@kernel.org>
Date: Tue, 20 Nov 2018 09:42:38 -0600
Message-ID: <CANk1AXQJ6iLFBPQANF+Vy=7O-+zQjQf+sJRJqiWpWuEgYXEvgQ@mail.gmail.com>
Subject: Re: [PATCH v4] fpga: mgr: altera-ps-spi: enable usage on non-dt platforms
Content-Type: text/plain; charset="UTF-8"
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Nov 15, 2018 at 5:58 PM Anatolij Gustschin <agust@denx.de> wrote:
>
> Driver probing fails on non-dt platforms since of_match_device()
> always returns NULL here. Add spi ids with device names and
> matching driver data as an index of a map array with data for
> supported devices. Add this map array and Alan's code to map

I suggested reworks to get rid of a loop and make it more readable.
Not really my code.

> spi ids to driver data. This allows driver binding to dynamically
> added PS-SPI devices (e.g. when added via spi_new_device() after
> hot-plugging).
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> Changes in v4:
>  - reword commit message to describe code changes
>  - rework mapping code as suggested by Alan
>  - add comment about index with driver data map
>
> Changes in v3:
>  - don't use pointers to device data struct in driver_data
>
> Changes in v2:
>  - removed not necessary braces {}
>  - dropped not needed !id check
>
>  drivers/fpga/altera-ps-spi.c | 40 +++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index 33aafda50af5..8c18beec6b57 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -75,6 +75,12 @@ static struct altera_ps_data a10_data = {
>         .t_st2ck_us = 10, /* min(t_ST2CK) */
>  };
>
> +/* Array index is enum altera_ps_devtype */
> +static const struct altera_ps_data *altera_ps_data_map[] = {
> +       &c5_data,
> +       &a10_data,
> +};
> +
>  static const struct of_device_id of_ef_match[] = {
>         { .compatible = "altr,fpga-passive-serial", .data = &c5_data },
>         { .compatible = "altr,fpga-arria10-passive-serial", .data = &a10_data },
> @@ -234,6 +240,22 @@ static const struct fpga_manager_ops altera_ps_ops = {
>         .write_complete = altera_ps_write_complete,
>  };
>
> +static const struct altera_ps_data *id_to_data(const struct spi_device_id *id)
> +{
> +       kernel_ulong_t devtype = id->driver_data;
> +       const struct altera_ps_data *data;
> +
> +       /* someone added a altera_ps_devtype without adding to the map array */
> +       if (devtype >= ARRAY_SIZE(altera_ps_data_map))
> +               return NULL;
> +
> +       data = altera_ps_data_map[devtype];
> +       if (!data || data->devtype != devtype)
> +               return NULL;
> +
> +       return data;
> +}
> +
>  static int altera_ps_probe(struct spi_device *spi)
>  {
>         struct altera_ps_conf *conf;
> @@ -244,11 +266,17 @@ static int altera_ps_probe(struct spi_device *spi)
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
> +               conf->data = of_id->data;
> +       } else {
> +               conf->data = id_to_data(spi_get_device_id(spi));
> +               if (!conf->data)
> +                       return -ENODEV;
> +       }
>
> -       conf->data = of_id->data;
>         conf->spi = spi;
>         conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
>         if (IS_ERR(conf->config)) {
> @@ -294,7 +322,9 @@ static int altera_ps_remove(struct spi_device *spi)
>  }
>
>  static const struct spi_device_id altera_ps_spi_ids[] = {
> -       {"cyclone-ps-spi", 0},
> +       { "cyclone-ps-spi", CYCLONE5 },
> +       { "fpga-passive-serial", CYCLONE5 },
> +       { "fpga-arria10-passive-serial", ARRIA10 },
>         {}
>  };
>  MODULE_DEVICE_TABLE(spi, altera_ps_spi_ids);
> --
> 2.17.1
>
