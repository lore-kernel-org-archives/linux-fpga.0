Return-Path: <SRS0=RqYW=64=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=RqYW=64=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH] fpga: dfl: afu: Corrected error handling levels
Date: Thu, 14 May 2020 06:06:13 +0000
Message-ID: <DM6PR11MB38193B495FB1DB4697F0094F85BC0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1589397725-29697-1-git-send-email-jrdr.linux@gmail.com>
 <20200514022935.GE29933@yilunxu-OptiPlex-7050>
In-Reply-To: <20200514022935.GE29933@yilunxu-OptiPlex-7050>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Thursday, May 14, 2020 10:30 AM
> To: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Wu, Hao <hao.wu@intel.com>; mdf@kernel.org; linux-
> fpga@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] fpga: dfl: afu: Corrected error handling levels
>=20
> The patch looks good to me.
>=20
> Maybe we could add the Fixes tag:
>   Fixes: fa8dda1edef9 (fpga: dfl: afu: add
> DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support)

Thanks for catching this problem.

With this line,
Acked-by: Wu Hao <hao.wu@intel.com>

Thanks!
Hao

>=20
> Thanks,
> Yilun
>=20
> On Thu, May 14, 2020 at 12:52:05AM +0530, Souptick Joarder wrote:
> > Corrected error handling goto sequnece. Level put_pages should
> > be called when pinned pages >=3D 0 && pinned !=3D npages. Level
> > free_pages should be called when pinned pages < 0.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  drivers/fpga/dfl-afu-dma-region.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-d=
ma-
> region.c
> > index 62f9244..5942343 100644
> > --- a/drivers/fpga/dfl-afu-dma-region.c
> > +++ b/drivers/fpga/dfl-afu-dma-region.c
> > @@ -61,10 +61,10 @@ static int afu_dma_pin_pages(struct
> dfl_feature_platform_data *pdata,
> >  				     region->pages);
> >  	if (pinned < 0) {
> >  		ret =3D pinned;
> > -		goto put_pages;
> > +		goto free_pages;
> >  	} else if (pinned !=3D npages) {
> >  		ret =3D -EFAULT;
> > -		goto free_pages;
> > +		goto put_pages;
> >  	}
> >
> >  	dev_dbg(dev, "%d pages pinned\n", pinned);
> > --
> > 1.9.1
