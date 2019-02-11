Return-Path: <SRS0=TnkL=QS=ziepe.ca=jgg@kernel.org>
Return-Path: <SRS0=TnkL=QS=ziepe.ca=jgg@kernel.org>
Date: Mon, 11 Feb 2019 15:56:20 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 1/5] vfio/type1: use pinned_vm instead of locked_vm to
 account pinned pages
Message-ID: <20190211225620.GO24692@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-2-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211224437.25267-2-daniel.m.jordan@oracle.com>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Feb 11, 2019 at 05:44:33PM -0500, Daniel Jordan wrote:
> Beginning with bc3e53f682d9 ("mm: distinguish between mlocked and pinned
> pages"), locked and pinned pages are accounted separately.  Type1
> accounts pinned pages to locked_vm; use pinned_vm instead.
> 
> pinned_vm recently became atomic and so no longer relies on mmap_sem
> held as writer: delete.
> 
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>  drivers/vfio/vfio_iommu_type1.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 73652e21efec..a56cc341813f 100644
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -257,7 +257,8 @@ static int vfio_iova_put_vfio_pfn(struct vfio_dma *dma, struct vfio_pfn *vpfn)
>  static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
>  {
>  	struct mm_struct *mm;
> -	int ret;
> +	s64 pinned_vm;
> +	int ret = 0;
>  
>  	if (!npage)
>  		return 0;
> @@ -266,24 +267,15 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
>  	if (!mm)
>  		return -ESRCH; /* process exited */
>  
> -	ret = down_write_killable(&mm->mmap_sem);
> -	if (!ret) {
> -		if (npage > 0) {
> -			if (!dma->lock_cap) {
> -				unsigned long limit;
> -
> -				limit = task_rlimit(dma->task,
> -						RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +	pinned_vm = atomic64_add_return(npage, &mm->pinned_vm);
>  
> -				if (mm->locked_vm + npage > limit)
> -					ret = -ENOMEM;
> -			}
> +	if (npage > 0 && !dma->lock_cap) {
> +		unsigned long limit = task_rlimit(dma->task, RLIMIT_MEMLOCK) >>
> +
> -					PAGE_SHIFT;

I haven't looked at this super closely, but how does this stuff work?

do_mlock doesn't touch pinned_vm, and this doesn't touch locked_vm...

Shouldn't all this be 'if (locked_vm + pinned_vm < RLIMIT_MEMLOCK)' ?

Otherwise MEMLOCK is really doubled..

Jason
