Return-Path: <SRS0=kmud=L4=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=kmud=L4=intel.com=hao.wu@kernel.org>
Date: Fri, 14 Sep 2018 18:23:21 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH -next] fpga: dfl: fme: remove set but not used variable
 'priv'
Message-ID: <20180914102321.GA21810@hao-dev>
References: <1536888816-51700-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536888816-51700-1-git-send-email-yuehaibing@huawei.com>
To: YueHaibing <yuehaibing@huawei.com>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Sep 14, 2018 at 01:33:36AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/fpga/dfl-fme-pr.c: In function 'pr_mgmt_uinit':
> drivers/fpga/dfl-fme-pr.c:447:18: warning:
>  variable 'priv' set but not used [-Wunused-but-set-variable]

Looks good to me, thanks for this fixing.

Thanks
Hao

> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/fpga/dfl-fme-pr.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> index 0b84053..fe5a557 100644
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -444,10 +444,8 @@ static void pr_mgmt_uinit(struct platform_device *pdev,
>  			  struct dfl_feature *feature)
>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> -	struct dfl_fme *priv;
>  
>  	mutex_lock(&pdata->lock);
> -	priv = dfl_fpga_pdata_get_private(pdata);
>  
>  	dfl_fme_destroy_regions(pdata);
>  	dfl_fme_destroy_bridges(pdata);
