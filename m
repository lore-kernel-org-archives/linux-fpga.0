Return-Path: <SRS0=u/s3=TU=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=u/s3=TU=oracle.com=daniel.m.jordan@kernel.org>
Date: Mon, 20 May 2019 11:30:20 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH] mm: add account_locked_vm utility function
Message-ID: <20190520153020.mzvjsjwefwxz6cau@ca-dmjordan1.us.oracle.com>
References: <20190503201629.20512-1-daniel.m.jordan@oracle.com>
 <4b42057f-b998-f87c-4e0f-a91abcb366f9@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b42057f-b998-f87c-4e0f-a91abcb366f9@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, akpm@linux-foundation.org, Alan Tull <atull@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Lameter <cl@linux.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Davidlohr Bueso <dave@stgolabs.net>, Jason Gunthorpe <jgg@mellanox.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Steve Sistare <steven.sistare@oracle.com>, Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, May 20, 2019 at 04:19:34PM +1000, Alexey Kardashevskiy wrote:
> On 04/05/2019 06:16, Daniel Jordan wrote:
> > locked_vm accounting is done roughly the same way in five places, so
> > unify them in a helper.  Standardize the debug prints, which vary
> > slightly.
> 
> And I rather liked that prints were different and tell precisely which
> one of three each printk is.

I'm not following.  One of three...callsites?  But there were five callsites.

Anyway, I added a _RET_IP_ to the debug print so you can differentiate.

> I commented below but in general this seems working.
> 
> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thanks!  And for the review as well.

> > diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> > index 6b64e45a5269..d39a1b830d82 100644
> > --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> > +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> > @@ -34,49 +35,13 @@
> >  static void tce_iommu_detach_group(void *iommu_data,
> >  		struct iommu_group *iommu_group);
> >  
> > -static long try_increment_locked_vm(struct mm_struct *mm, long npages)
> > +static int tce_account_locked_vm(struct mm_struct *mm, unsigned long npages,
> > +				 bool inc)
> >  {
> > -	long ret = 0, locked, lock_limit;
> > -
> >  	if (WARN_ON_ONCE(!mm))
> >  		return -EPERM;
> 
> 
> If this WARN_ON is the only reason for having tce_account_locked_vm()
> instead of calling account_locked_vm() directly, you can then ditch the
> check as I have never ever seen this triggered.

Great, will do.

> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index d0f731c9920a..15ac76171ccd 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -273,25 +273,14 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
> >  		return -ESRCH; /* process exited */
> >  
> >  	ret = down_write_killable(&mm->mmap_sem);
> > -	if (!ret) {
> > -		if (npage > 0) {
> > -			if (!dma->lock_cap) {
> > -				unsigned long limit;
> > -
> > -				limit = task_rlimit(dma->task,
> > -						RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > -
> > -				if (mm->locked_vm + npage > limit)
> > -					ret = -ENOMEM;
> > -			}
> > -		}
> > +	if (ret)
> > +		goto out;
> 
> 
> A single "goto" to jump just 3 lines below seems unnecessary.

No strong preference here, I'll take out the goto.

> > +int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
> > +			struct task_struct *task, bool bypass_rlim)
> > +{
> > +	unsigned long locked_vm, limit;
> > +	int ret = 0;
> > +
> > +	locked_vm = mm->locked_vm;
> > +	if (inc) {
> > +		if (!bypass_rlim) {
> > +			limit = task_rlimit(task, RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > +			if (locked_vm + pages > limit) {
> > +				ret = -ENOMEM;
> > +				goto out;
> > +			}
> > +		}
> 
> Nit:
> 
> if (!ret)
> 
> and then you don't need "goto out".

Ok, sure.

> > +		mm->locked_vm = locked_vm + pages;
> > +	} else {
> > +		WARN_ON_ONCE(pages > locked_vm);
> > +		mm->locked_vm = locked_vm - pages;
> 
> 
> Can go negative here. Not a huge deal but inaccurate imo.

I hear you, but setting a negative value to zero, as we had done previously,
doesn't make much sense to me.
