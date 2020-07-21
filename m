Return-Path: <SRS0=uruc=BA=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=uruc=BA=intel.com=yilun.xu@kernel.org>
Date: Tue, 21 Jul 2020 22:39:18 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/2] fpga: dfl: create a dfl bus type to support DFL
  devices
Message-ID: <20200721143918.GA20733@yilunxu-OptiPlex-7050>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <1594791498-14495-3-git-send-email-yilun.xu@intel.com>
 <0776e674-d94d-da97-342a-b043c5dc24f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0776e674-d94d-da97-342a-b043c5dc24f3@redhat.com>
To: Tom Rix <trix@redhat.com>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, Russ Weight <russell.h.weight@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

> > +static int dfl_devs_init(struct platform_device *pdev)
> > +{
> > +	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > +	struct dfl_feature *feature;
> > +	struct dfl_device *dfl_dev;
> > +
> > +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> > +		if (feature->ioaddr || feature->priv)
> > +			continue;
> > +
> > +		dfl_dev = dfl_dev_add(pdata, feature);
> > +		if (IS_ERR(dfl_dev)) {
> > +			dfl_devs_uinit(pdata);
> > +			return PTR_ERR(dfl_dev);
> What happens to dfl_dev's that were successful. Need a clean up ?

Yes, the already added dfl devices under this pdev will be unregistered
in function dfl_devs_uinit()

> > +		}
> > +
> > +		feature->priv = dfl_dev;
> > +	}
> > +
> > +	return 0;
> > +}
