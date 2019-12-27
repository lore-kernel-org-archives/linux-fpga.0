Date: Fri, 27 Dec 2019 14:58:12 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: dfl: afu: remove set but not used variable 'afu'
Message-ID: <20191227225809.GB1643@archbook>
References: <20191226121533.6017-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191226121533.6017-1-yukuai3@huawei.com>
To: yu kuai <yukuai3@huawei.com>
Cc: hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawe.com, zhengbin13@huawei.com
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Dec 26, 2019 at 08:15:33PM +0800, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/fpga/dfl-afu-main.c: In function ‘afu_dev_destroy’:
> drivers/fpga/dfl-afu-main.c:816:18: warning: variable ‘afu’
> set but not used [-Wunused-but-set-variable]
> 
> It is never used, and so can be removed.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>  drivers/fpga/dfl-afu-main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index e4a34dc7947f..65437b6a6842 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -813,10 +813,8 @@ static int afu_dev_init(struct platform_device *pdev)
>  static int afu_dev_destroy(struct platform_device *pdev)
>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> -	struct dfl_afu *afu;
>  
>  	mutex_lock(&pdata->lock);
> -	afu = dfl_fpga_pdata_get_private(pdata);
>  	afu_mmio_region_destroy(pdata);
>  	afu_dma_region_destroy(pdata);
>  	dfl_fpga_pdata_set_private(pdata, NULL);
> -- 
> 2.17.2
> 
Acked-by: Moritz Fischer <mdf@kernel.org>

I'll get to the patches in the new year.

Thanks,
Moritz
