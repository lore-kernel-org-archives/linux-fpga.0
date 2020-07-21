Return-Path: <SRS0=uruc=BA=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=uruc=BA=intel.com=yilun.xu@kernel.org>
Date: Tue, 21 Jul 2020 22:44:18 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/2] fpga: dfl: create a dfl bus type to support DFL
   devices
Message-ID: <20200721144418.GB20733@yilunxu-OptiPlex-7050>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <1594791498-14495-3-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB38195AA712F8089090695CE5857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200721083030.GG17091@yilunxu-OptiPlex-7050>
 <DM6PR11MB381958D370FD3BF0173BBD5685780@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB381958D370FD3BF0173BBD5685780@DM6PR11MB3819.namprd11.prod.outlook.com>
To: "Wu, Hao" <hao.wu@intel.com>
Cc: "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "trix@redhat.com" <trix@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, "Weight, Russell H" <russell.h.weight@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Jul 21, 2020 at 07:41:27PM +0800, Wu, Hao wrote:
> > > > +}
> > > > +
> > > > +dfl_dev->type = feature_dev_id_type(pdev);
> > > > +dfl_dev->feature_id = (unsigned long long)feature->id;
> > > > +
> > > > +dfl_dev->dev.parent  = &pdev->dev;
> > > > +dfl_dev->dev.bus     = &dfl_bus_type;
> > > > +dfl_dev->dev.release = release_dfl_dev;
> > > > +dev_set_name(&dfl_dev->dev, "%s.%d", dev_name(&pdev->dev),
> > > > +     feature->index);
> > >
> > > Or it's better to have a generic name for the device on the bus.
> >
> > mm.. It is good suggestion, we should have a unified name for dfl
> > devices.
> >
> > How about ("dfl.%d.%d", pdev->id, feature->index)
> 
> It's quite difficult for people to use related information from these magic
> numbers. They are not ids defined in the spec, so just dfl_dev.x with one
> unique id seems to be better. If you really need to expose some id
> information, maybe you can consider adding some standard sysfs entry
> to all dfl_dev, I think that will be easier for users. How do you think?

I'm fine with the dfl_dev.x solution.

> 
> Thanks
> Hao
