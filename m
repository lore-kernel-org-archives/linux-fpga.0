Date: Sun, 31 May 2020 14:27:51 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v3] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
Message-ID: <20200531212749.GA7770@epycbox.lan>
References: <20200525221754.433023-1-jhubbard@nvidia.com>
 <DM6PR11MB3819416F353D38A57131F0A385B10@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819416F353D38A57131F0A385B10@DM6PR11MB3819.namprd11.prod.outlook.com>
To: "Wu, Hao" <hao.wu@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>, LKML <linux-kernel@vger.kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, May 27, 2020 at 12:10:21AM +0000, Wu, Hao wrote:
> > -----Original Message-----
> > From: John Hubbard <jhubbard@nvidia.com>
> > Sent: Tuesday, May 26, 2020 6:18 AM
> > To: LKML <linux-kernel@vger.kernel.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>; Xu, Yilun <yilun.xu@intel.com>;
> > Wu, Hao <hao.wu@intel.com>; Moritz Fischer <mdf@kernel.org>; linux-
> > fpga@vger.kernel.org
> > Subject: [PATCH v3] fpga: dfl: afu: convert get_user_pages() -->
> > pin_user_pages()
> > 
> > This code was using get_user_pages_fast(), in a "Case 2" scenario
> > (DMA/RDMA), using the categorization from [1]. That means that it's
> > time to convert the get_user_pages_fast() + put_page() calls to
> > pin_user_pages_fast() + unpin_user_pages() calls.
> > 
> > There is some helpful background in [2]: basically, this is a small
> > part of fixing a long-standing disconnect between pinning pages, and
> > file systems' use of those pages.
> > 
> > [1] Documentation/core-api/pin_user_pages.rst
> > 
> > [2] "Explicit pinning of user-space pages":
> >     https://lwn.net/Articles/807108/
> > 
> > Cc: Xu Yilun <yilun.xu@intel.com>
> > Cc: Wu Hao <hao.wu@intel.com>
> > Cc: Moritz Fischer <mdf@kernel.org>
> > Cc: linux-fpga@vger.kernel.org
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > ---
> > 
> > Hi,
> > 
> > This is the same logical change as in v2, but it is applied to
> > char-misc-next, in order to avoid a merge problem with Souptick's
> > commit c9d7e3da1f3c ("fpga: dfl: afu: Corrected error handling levels
> > <Souptick Joarder>")
> 
> Thanks a lot! 
> 
> Acked-by: Wu Hao <hao.wu@intel.com>
> 
> Thanks
> Hao
> 
> > 
> > thanks,
> > John Hubbard
> > NVIDIA
> > 
> > 
> >  drivers/fpga/dfl-afu-dma-region.c | 19 +++++--------------
> >  1 file changed, 5 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-
> > region.c
> > index 5942343a5d6e..0b817b722920 100644
> > --- a/drivers/fpga/dfl-afu-dma-region.c
> > +++ b/drivers/fpga/dfl-afu-dma-region.c
> > @@ -16,15 +16,6 @@
> > 
> >  #include "dfl-afu.h"
> > 
> > -static void put_all_pages(struct page **pages, int npages)
> > -{
> > -	int i;
> > -
> > -	for (i = 0; i < npages; i++)
> > -		if (pages[i])
> > -			put_page(pages[i]);
> > -}
> > -
> >  void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
> >  {
> >  	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
> > @@ -57,22 +48,22 @@ static int afu_dma_pin_pages(struct
> > dfl_feature_platform_data *pdata,
> >  		goto unlock_vm;
> >  	}
> > 
> > -	pinned = get_user_pages_fast(region->user_addr, npages,
> > FOLL_WRITE,
> > +	pinned = pin_user_pages_fast(region->user_addr, npages,
> > FOLL_WRITE,
> >  				     region->pages);
> >  	if (pinned < 0) {
> >  		ret = pinned;
> >  		goto free_pages;
> >  	} else if (pinned != npages) {
> >  		ret = -EFAULT;
> > -		goto put_pages;
> > +		goto unpin_pages;
> >  	}
> > 
> >  	dev_dbg(dev, "%d pages pinned\n", pinned);
> > 
> >  	return 0;
> > 
> > -put_pages:
> > -	put_all_pages(region->pages, pinned);
> > +unpin_pages:
> > +	unpin_user_pages(region->pages, pinned);
> >  free_pages:
> >  	kfree(region->pages);
> >  unlock_vm:
> > @@ -94,7 +85,7 @@ static void afu_dma_unpin_pages(struct
> > dfl_feature_platform_data *pdata,
> >  	long npages = region->length >> PAGE_SHIFT;
> >  	struct device *dev = &pdata->dev->dev;
> > 
> > -	put_all_pages(region->pages, npages);
> > +	unpin_user_pages(region->pages, npages);
> >  	kfree(region->pages);
> >  	account_locked_vm(current->mm, npages, false);
> > 
> > --
> > 2.26.2
> 
Applied to for-next.

Thanks,
Moritz
