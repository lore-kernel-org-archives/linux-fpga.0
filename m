Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20180824152513.8336-1-mdf@kernel.org> <20180824152513.8336-2-mdf@kernel.org>
In-Reply-To: <20180824152513.8336-2-mdf@kernel.org>
From: Alan Tull <atull@kernel.org>
Date: Sun, 26 Aug 2018 16:21:19 -0500
Message-ID: <CANk1AXSTKorR6mJ81sN-yo0bpyT9B+7XvE5chTkUu-tiMWSOww@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpga: dfl-fme-region: Use platform_get_drvdata()
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Aug 24, 2018 at 10:26 AM Moritz Fischer <mdf@kernel.org> wrote:
>
> Use platform_get_drvdata() in remove() function of
> the platform driver rather than dev_get_drvdata()
> to match the platform_set_drvdata in the probe().
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan


> ---
>  drivers/fpga/dfl-fme-region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> index 0b7e19c27c6d..11d3c23a8936 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -65,7 +65,7 @@ static int fme_region_probe(struct platform_device *pdev)
>
>  static int fme_region_remove(struct platform_device *pdev)
>  {
> -       struct fpga_region *region = dev_get_drvdata(&pdev->dev);
> +       struct fpga_region *region = platform_get_drvdata(pdev);
>
>         fpga_region_unregister(region);
>         fpga_mgr_put(region->mgr);
> --
> 2.18.0
>
