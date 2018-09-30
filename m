Return-Path: <SRS0=gLnB=MM=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=gLnB=MM=linuxfoundation.org=gregkh@kernel.org>
Date: Sun, 30 Sep 2018 08:48:45 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5/5] fpga: dfl-fme-region: Use platform_get_drvdata()
Message-ID: <20180930154845.GA13200@kroah.com>
References: <20180912144327.3130-1-atull@kernel.org>
 <20180912144327.3130-6-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912144327.3130-6-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Sep 12, 2018 at 09:43:27AM -0500, Alan Tull wrote:
> From: Moritz Fischer <mdf@kernel.org>
> 
> Use platform_get_drvdata() in remove() function of
> the platform driver rather than dev_get_drvdata()
> to match the platform_set_drvdata in the probe().
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Acked-by: Alan Tull <atull@kernel.org>
> ---
>  drivers/fpga/dfl-fme-region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> index 51a5ac2..3fa0de2 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -66,7 +66,7 @@ static int fme_region_probe(struct platform_device *pdev)
>  
>  static int fme_region_remove(struct platform_device *pdev)
>  {
> -	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
> +	struct fpga_region *region = platform_get_drvdata(pdev);

This is nice, but not a bugfix.  I'll wait for 4.20-rc1 for this patch.

thanks,

greg k-h
