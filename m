Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20180824152513.8336-1-mdf@kernel.org>
In-Reply-To: <20180824152513.8336-1-mdf@kernel.org>
From: Alan Tull <atull@kernel.org>
Date: Sun, 26 Aug 2018 16:20:39 -0500
Message-ID: <CANk1AXTuVbJLmtv_+L3Dr2GyQ+2gTjJFGwrtFsh0rMu2RbYzkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fpga: of-fpga-region: Use platform_set_drvdata
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Aug 24, 2018 at 10:26 AM Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

Looks good.  Thanks for the patches!

>
> Use platform_set_drvdata rather than dev_set_drvdata
> to match the platform_get_drvdata in the _remove()
> function of the platform driver.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>

> ---
>  drivers/fpga/of-fpga-region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index 35fabb8083fb..8c6120e30930 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -421,7 +421,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
>                 goto eprobe_free;
>
>         of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
> -       dev_set_drvdata(dev, region);
> +       platform_set_drvdata(pdev, region);
>
>         dev_info(dev, "FPGA Region probed\n");
>
> --
> 2.18.0
>
