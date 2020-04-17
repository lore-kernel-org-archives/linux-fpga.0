Return-Path: <SRS0=U5LB=6B=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=U5LB=6B=intel.com=yilun.xu@kernel.org>
Date: Fri, 17 Apr 2020 11:21:32 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Message-ID: <20200417032132.GA25293@yilunxu-OptiPlex-7050>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
 <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
 <9b1d85e0-4f44-179b-c847-af858fcc212a@redhat.com>
 <20200417015605.GA30618@yilunxu-OptiPlex-7050>
 <DM6PR11MB381919B83DB49F937E3EDEEA85D90@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB381919B83DB49F937E3EDEEA85D90@DM6PR11MB3819.namprd11.prod.outlook.com>
To: "Wu, Hao" <hao.wu@intel.com>
Cc: Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bhu@redhat.com" <bhu@redhat.com>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Apr 17, 2020 at 11:05:16AM +0800, Wu, Hao wrote:
> > -----Original Message-----
> > From: Xu, Yilun <yilun.xu@intel.com>
> > Sent: Friday, April 17, 2020 9:56 AM
> > To: Tom Rix <trix@redhat.com>
> > Cc: Wu, Hao <hao.wu@intel.com>; mdf@kernel.org; linux-
> > fpga@vger.kernel.org; linux-kernel@vger.kernel.org; bhu@redhat.com
> > Subject: Re: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
> >
> > Hi Rix:
> >
> > This patch is based on linux-next. There is an preceding patch
> > (3c2760b78f90 "fpga: dfl: pci: fix return value of cci_pci_sriov_configure",
> > Also see Fixes:) in linux-next but not merged in 5.7-rc1 yet.
> > This patch is to fix the lkp warning brought by the previous one.
> 
> Yilun
> 
> Is it possible that commit id may be different for master then?

It is possible if the previous patch need a little change when merging
to master.

I'm not sure how to handle this then. But the previous patch is simple
and is unlikely to change.

> 
> Thanks
> Hao
> 
> >
> > Thanks.
> >
> > On Thu, Apr 16, 2020 at 09:56:47AM -0700, Tom Rix wrote:
> > > Please check the scope.
> > >
> > > On linus/master, the result of this change looks like
> > >
> > > static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
> > > {
> > >     struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> > >     struct dfl_fpga_cdev *cdev = drvdata->cdev;
> > >
> > >     if (!num_vfs) {
> > >         /*
> > >          * disable SRIOV and then put released ports back to default
> > >          * PF access mode.
> > >          */
> > >         pci_disable_sriov(pcidev);
> > >
> > >         dfl_fpga_cdev_config_ports_pf(cdev);
> > >
> > >     } else {
> > >         int ret; <--- defined here
> > >
> > >         /*
> > >          * before enable SRIOV, put released ports into VF access mode
> > >          * first of all.
> > >          */
> > >         ret = dfl_fpga_cdev_config_ports_vf(cdev, num_vfs);
> > >         if (ret)
> > >             return ret;
> > >
> > >         ret = pci_enable_sriov(pcidev, num_vfs);
> > >         if (ret)
> > >             dfl_fpga_cdev_config_ports_pf(cdev);
> > >     }
> > >
> > >     return ret;  <---- not in scope, not defined here
> > > }
> > >
> > > Tom
