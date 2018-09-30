Return-Path: <SRS0=gLnB=MM=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=gLnB=MM=linuxfoundation.org=gregkh@kernel.org>
Date: Sun, 30 Sep 2018 08:49:21 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/5] fpga: of-fpga-region: Use platform_set_drvdata
Message-ID: <20180930154921.GB13200@kroah.com>
References: <20180912144327.3130-1-atull@kernel.org>
 <20180912144327.3130-5-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912144327.3130-5-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Sep 12, 2018 at 09:43:26AM -0500, Alan Tull wrote:
> From: Moritz Fischer <mdf@kernel.org>
> 
> Use platform_set_drvdata rather than dev_set_drvdata
> to match the platform_get_drvdata in the _remove()
> function of the platform driver.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Acked-by: Alan Tull <atull@kernel.org>
> ---
>  drivers/fpga/of-fpga-region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index 052a134..d6a70e4 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -421,7 +421,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
>  		goto eprobe_free;
>  
>  	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
> -	dev_set_drvdata(dev, region);
> +	platform_set_drvdata(pdev, region);

Again, not really a bugfix :)
