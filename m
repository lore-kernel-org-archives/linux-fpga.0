Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20181129231016.4580-1-colin.king@canonical.com>
In-Reply-To: <20181129231016.4580-1-colin.king@canonical.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 24 Jan 2019 11:16:28 -0600
Message-ID: <CANk1AXRP-65fK48vqQ+Dy9-cz-4XQ1bWNyDCvzJK8rkoA2F24g@mail.gmail.com>
Subject: Re: [PATCH] fpga: mgr: altera-ps-spi: make array dummy static,
 shrinks object size
Content-Type: text/plain; charset="UTF-8"
To: Colin King <colin.king@canonical.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Nov 29, 2018 at 5:10 PM Colin King <colin.king@canonical.com> wrote:

Hi Colin,

Thanks!

>
> From: Colin Ian King <colin.king@canonical.com>
>
> Don't populate the const array dummy on the stack but instead
> make it static. Makes the object code smaller by 26 bytes:
>
> Before:
>    text    data     bss     dec     hex filename
>    7371    2032       0    9403    24bb drivers/fpga/altera-ps-spi.o
>
> After:
>    text    data     bss     dec     hex filename
>    7281    2096       0    9377    24a1 drivers/fpga/altera-ps-spi.o
>
> (gcc version 8.2.0 x86_64)
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Alan Tull <atull@kernel.org>


> ---
>  drivers/fpga/altera-ps-spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index 8c18beec6b57..678d0115f840 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -205,7 +205,7 @@ static int altera_ps_write_complete(struct fpga_manager *mgr,
>                                     struct fpga_image_info *info)
>  {
>         struct altera_ps_conf *conf = mgr->priv;
> -       const char dummy[] = {0};
> +       static const char dummy[] = {0};
>         int ret;
>
>         if (gpiod_get_value_cansleep(conf->status)) {
> --
> 2.19.1
>
