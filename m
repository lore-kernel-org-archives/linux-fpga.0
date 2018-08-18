MIME-Version: 1.0
In-Reply-To: <20180817234049.9624-1-mdf@kernel.org>
References: <20180817234049.9624-1-mdf@kernel.org>
Date: Fri, 17 Aug 2018 17:44:14 -0700
Message-ID: <CAJYdmeOBWt3rdbBGfCR5OFxO8pQHn62msXb0q2ukxBFGHQQqog@mail.gmail.com>
Subject: Re: [PATCH] fpga: dfl: region: Restory symmetry in probe()/remove()
From: Moritz Fischer <moritz.fischer.private@gmail.com>
Content-Type: text/plain; charset="UTF-8"
To: Wu Hao <hao.wu@intel.com>
Cc: Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Aug 17, 2018 at 4:40 PM, Moritz Fischer <mdf@kernel.org> wrote:
> Replace dev_get_drvdata() with platform_get_drvdata() to
> match the platform_set_drvdata() in the probe function of
> the platform driver.
>
> Fixes commit bb61b9be3e6b ("fpga: dfl: add fpga region platform driver for
> FME")
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-fme-region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> index 0b7e19c27c6d..ce7ebe4b3212 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -65,7 +65,7 @@ static int fme_region_probe(struct platform_device *pdev)
>
>  static int fme_region_remove(struct platform_device *pdev)
>  {
> -       struct fpga_region *region = dev_get_drvdata(&pdev->dev);
> +       struct fpga_region *region = platform_get_drvdata(&pdev->dev);
Blergh ... that doesn't even compile. I'll resubmit next week. Sorry
for the noise.
Should of course be platform_get_drvdata(pdev);

- Moritz
