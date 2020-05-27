Return-Path: <SRS0=f32r=7J=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=f32r=7J=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH v3] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
Date: Wed, 27 May 2020 00:10:21 +0000
Message-ID: <DM6PR11MB3819416F353D38A57131F0A385B10@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200525221754.433023-1-jhubbard@nvidia.com>
In-Reply-To: <20200525221754.433023-1-jhubbard@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: John Hubbard <jhubbard@nvidia.com>, LKML <linux-kernel@vger.kernel.org>
Cc: "Xu, Yilun" <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

> -----Original Message-----
> From: John Hubbard <jhubbard@nvidia.com>
> Sent: Tuesday, May 26, 2020 6:18 AM
> To: LKML <linux-kernel@vger.kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>; Xu, Yilun <yilun.xu@intel.com>;
> Wu, Hao <hao.wu@intel.com>; Moritz Fischer <mdf@kernel.org>; linux-
> fpga@vger.kernel.org
> Subject: [PATCH v3] fpga: dfl: afu: convert get_user_pages() -->
> pin_user_pages()
>=20
> This code was using get_user_pages_fast(), in a "Case 2" scenario
> (DMA/RDMA), using the categorization from [1]. That means that it's
> time to convert the get_user_pages_fast() + put_page() calls to
> pin_user_pages_fast() + unpin_user_pages() calls.
>=20
> There is some helpful background in [2]: basically, this is a small
> part of fixing a long-standing disconnect between pinning pages, and
> file systems' use of those pages.
>=20
> [1] Documentation/core-api/pin_user_pages.rst
>=20
> [2] "Explicit pinning of user-space pages":
>     https://lwn.net/Articles/807108/
>=20
> Cc: Xu Yilun <yilun.xu@intel.com>
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: linux-fpga@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>=20
> Hi,
>=20
> This is the same logical change as in v2, but it is applied to
> char-misc-next, in order to avoid a merge problem with Souptick's
> commit c9d7e3da1f3c ("fpga: dfl: afu: Corrected error handling levels
> <Souptick Joarder>")

Thanks a lot!=20

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao

>=20
> thanks,
> John Hubbard
> NVIDIA
>=20
>=20
>  drivers/fpga/dfl-afu-dma-region.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma=
-
> region.c
> index 5942343a5d6e..0b817b722920 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -16,15 +16,6 @@
>=20
>  #include "dfl-afu.h"
>=20
> -static void put_all_pages(struct page **pages, int npages)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < npages; i++)
> -		if (pages[i])
> -			put_page(pages[i]);
> -}
> -
>  void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
>  {
>  	struct dfl_afu *afu =3D dfl_fpga_pdata_get_private(pdata);
> @@ -57,22 +48,22 @@ static int afu_dma_pin_pages(struct
> dfl_feature_platform_data *pdata,
>  		goto unlock_vm;
>  	}
>=20
> -	pinned =3D get_user_pages_fast(region->user_addr, npages,
> FOLL_WRITE,
> +	pinned =3D pin_user_pages_fast(region->user_addr, npages,
> FOLL_WRITE,
>  				     region->pages);
>  	if (pinned < 0) {
>  		ret =3D pinned;
>  		goto free_pages;
>  	} else if (pinned !=3D npages) {
>  		ret =3D -EFAULT;
> -		goto put_pages;
> +		goto unpin_pages;
>  	}
>=20
>  	dev_dbg(dev, "%d pages pinned\n", pinned);
>=20
>  	return 0;
>=20
> -put_pages:
> -	put_all_pages(region->pages, pinned);
> +unpin_pages:
> +	unpin_user_pages(region->pages, pinned);
>  free_pages:
>  	kfree(region->pages);
>  unlock_vm:
> @@ -94,7 +85,7 @@ static void afu_dma_unpin_pages(struct
> dfl_feature_platform_data *pdata,
>  	long npages =3D region->length >> PAGE_SHIFT;
>  	struct device *dev =3D &pdata->dev->dev;
>=20
> -	put_all_pages(region->pages, npages);
> +	unpin_user_pages(region->pages, npages);
>  	kfree(region->pages);
>  	account_locked_vm(current->mm, npages, false);
>=20
> --
> 2.26.2
