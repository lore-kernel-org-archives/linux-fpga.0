Return-Path: <SRS0=QSn8=6V=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=QSn8=6V=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:57934 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgEGGnC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 7 May 2020 02:43:02 -0400
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [bug report] fpga: dfl: fme: add performance reporting support
Date: Thu, 7 May 2020 06:42:06 +0000
Message-ID: <DM6PR11MB3819C32CF618A08A0901678885A50@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200502132419.GA41486@mwanda>
 <20200506063123.GA22708@yilunxu-OptiPlex-7050>
In-Reply-To: <20200506063123.GA22708@yilunxu-OptiPlex-7050>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: "Xu, Yilun" <yilun.xu@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>

> On Sat, May 02, 2020 at 04:24:19PM +0300, Dan Carpenter wrote:
> > Hello Wu Hao,
> >
> > The patch 724142f8c42a: "fpga: dfl: fme: add performance reporting
> > support" from Apr 27, 2020, leads to the following static checker
> > warning:
> >
> > 	drivers/fpga/dfl-fme-perf.c:948 fme_perf_offline_cpu()
> > 	error: potential NULL dereference 'priv'.
> >
> > drivers/fpga/dfl-fme-perf.c
> >    941  static int fme_perf_offline_cpu(unsigned int cpu, struct hlist_=
node
> *node)
> >    942  {
> >    943          struct fme_perf_priv *priv;
> >    944          int target;
> >    945
> >    946          priv =3D hlist_entry_safe(node, struct fme_perf_priv, n=
ode);
> >                                   ^^^^^
> > It doesn't make sense to use the _safe() version if we're not going to
> > check for NULL.
>=20
> Thanks for catching this. Will fix it.

Yes, it's not necessary to use _safe version here.
Thanks Dan for reporting this, and thanks Yilun for covering this when
I was on leave.

Hao

>=20
> Regards,
> Yilun.
>=20
> >
> >    947
> >    948          if (cpu !=3D priv->cpu)
> >    949                  return 0;
> >    950
> >    951          target =3D cpumask_any_but(cpu_online_mask, cpu);
> >    952          if (target >=3D nr_cpu_ids)
> >    953                  return 0;
> >    954
> >    955          priv->cpu =3D target;
> >    956          return 0;
> >    957  }
> >
> > regards,
> > dan carpenter
