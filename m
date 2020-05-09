Return-Path: <SRS0=vYR5=6X=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=vYR5=6X=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH] fpga: dfl: Replace zero-length array with flexible-array
Date: Sat, 9 May 2020 03:57:01 +0000
Message-ID: <DM6PR11MB3819D8BD585D5A568F62D2A485A30@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200507185256.GA14313@embeddedor>
 <alpine.DEB.2.21.2005081119420.7209@rhweight-WRK1>
In-Reply-To: <alpine.DEB.2.21.2005081119420.7209@rhweight-WRK1>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

I think Moritz had already applied it to his tree per last submission.
https://lkml.org/lkml/2020/3/21/373

Thanks
Hao

> -----Original Message-----
> From: matthew.gerlach@linux.intel.com <matthew.gerlach@linux.intel.com>
> Sent: Saturday, May 9, 2020 2:21 AM
> To: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Wu, Hao <hao.wu@intel.com>; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] fpga: dfl: Replace zero-length array with flexible-a=
rray
>=20
>=20
>=20
> This looks like a a good change to me.
>=20
> Tested-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> On Thu, 7 May 2020, Gustavo A. R. Silva wrote:
>=20
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][=
2],
> > introduced in C99:
> >
> > struct foo {
> >        int stuff;
> >        struct boo array[];
> > };
> >
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > inadvertently introduced[3] to the codebase from now on.
> >
> > Also, notice that, dynamic memory allocations won't be affected by
> > this change:
> >
> > "Flexible array members have incomplete type, and so the sizeof operato=
r
> > may not be applied. As a quirk of the original implementation of
> > zero-length arrays, sizeof evaluates to zero."[1]
> >
> > sizeof(flexible-array-member) triggers a warning because flexible array
> > members have incomplete type[1]. There are some instances of code in
> > which the sizeof operator is being incorrectly/erroneously applied to
> > zero-length arrays and the result is zero. Such instances may be hiding
> > some bugs. So, this work (flexible-array member conversions) will also
> > help to get completely rid of those sorts of issues.
> >
> > This issue was found with the help of Coccinelle.
> >
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://github.com/KSPP/linux/issues/21
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > drivers/fpga/dfl.h |    2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index 9f0e656de720..1cd51ea52ce1 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -235,7 +235,7 @@ struct dfl_feature_platform_data {
> > 	unsigned long dev_status;
> > 	void *private;
> > 	int num;
> > -	struct dfl_feature features[0];
> > +	struct dfl_feature features[];
> > };
> >
> > static inline
> >
> >
