Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180820171818.7710-1-mdf@kernel.org>
References: <20180820171818.7710-1-mdf@kernel.org>
From: Alan Tull <atull@kernel.org>
Date: Mon, 20 Aug 2018 12:46:32 -0500
Message-ID: <CANk1AXSMSLGCcaRcZo4TWKEJW+YUQqbHWEuHpz_csF5J1m-Sew@mail.gmail.com>
Subject: Re: [PATCH v2] fpga: dfl: region: Restory symmetry in probe()/remove()
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Aug 20, 2018 at 12:18 PM, Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

> Replace dev_get_drvdata() with platform_get_drvdata() to
> match the platform_set_drvdata() in the probe function of
> the platform driver.
>
> Fixes commit bb61b9be3e6b ("fpga: dfl: add fpga region platform driver for FME")
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>
> Changes from v1:
> - Still compile after change ...
>
> ---
>  drivers/fpga/dfl-fme-region.c | 2 +-

Thanks for catching this.  of-fpga-region.c does a similar thing and
needs s/dev_set_drvdata/platform_set_drvdata/ in the probe.  Could you
fix it here too?

Alan

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
