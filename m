Date: Thu, 2 Jan 2020 20:49:25 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: dfl: fme: remove set but not used variable 'fme'
Message-ID: <20200103044924.GB20838@epycbox.lan>
References: <20191226121638.10507-1-yukuai3@huawei.com>
 <20191227225726.GA1643@archbook>
 <20191230015140.GA6839@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191230015140.GA6839@hao-dev>
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, yu kuai <yukuai3@huawei.com>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawe.com, zhengbin13@huawei.com
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Dec 30, 2019 at 09:51:40AM +0800, Wu Hao wrote:
> On Fri, Dec 27, 2019 at 02:57:26PM -0800, Moritz Fischer wrote:
> > On Thu, Dec 26, 2019 at 08:16:38PM +0800, yu kuai wrote:
> > > Fixes gcc '-Wunused-but-set-variable' warning:
> > > 
> > > drivers/fpga/dfl-fme-main.c: In function ‘fme_dev_destroy’:
> > > drivers/fpga/dfl-fme-main.c:678:18: warning: variable ‘fme’ set but not
> > > used [-Wunused-but-set-variable]
> > > 
> > > It is never used and so can be removed.
> > > 
> > > Signed-off-by: yu kuai <yukuai3@huawei.com>
> > > ---
> > >  drivers/fpga/dfl-fme-main.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> > > index 7c930e6b314d..1d4690c99268 100644
> > > --- a/drivers/fpga/dfl-fme-main.c
> > > +++ b/drivers/fpga/dfl-fme-main.c
> > > @@ -675,10 +675,8 @@ static int fme_dev_init(struct platform_device *pdev)
> > >  static void fme_dev_destroy(struct platform_device *pdev)
> > >  {
> > >  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > > -	struct dfl_fme *fme;
> > >  
> > >  	mutex_lock(&pdata->lock);
> > > -	fme = dfl_fpga_pdata_get_private(pdata);
> > >  	dfl_fpga_pdata_set_private(pdata, NULL);
> > >  	mutex_unlock(&pdata->lock);
> > >  }
> > > -- 
> > > 2.17.2
> > > 
> > Acked-by: Moritz Fischer <mdf@kernel.org>
> 
> Acked-by: Wu Hao <hao.wu@intel.com>
> 
> Thanks
> Hao
> 
> > 
> > Thanks,
> > Moritz

Applied to for-next.

Thanks,
Moritz
