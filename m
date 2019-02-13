Return-Path: <SRS0=3sgU=QU=ozlabs.ru=aik@kernel.org>
Return-Path: <SRS0=3sgU=QU=ozlabs.ru=aik@kernel.org>
Subject: Re: [PATCH 2/5] vfio/spapr_tce: use pinned_vm instead of locked_vm to
 account pinned pages
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-3-daniel.m.jordan@oracle.com>
 <ee4d14db-05c3-6208-503c-16e287fa78eb@ozlabs.ru>
 <01000168e29daf0a-cb3a9394-e3dd-4d88-ad3c-31df1f9ec052-000000@email.amazonses.com>
 <20190212171839.env4rnjwdjyips6z@ca-dmjordan1.us.oracle.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <660515dd-eb8a-36cc-5fac-a7814bb3ef69@ozlabs.ru>
Date: Wed, 13 Feb 2019 11:37:00 +1100
MIME-Version: 1.0
In-Reply-To: <20190212171839.env4rnjwdjyips6z@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Daniel Jordan <daniel.m.jordan@oracle.com>, Christopher Lameter <cl@linux.com>
Cc: jgg@ziepe.ca, akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>



On 13/02/2019 04:18, Daniel Jordan wrote:
> On Tue, Feb 12, 2019 at 04:50:11PM +0000, Christopher Lameter wrote:
>> On Tue, 12 Feb 2019, Alexey Kardashevskiy wrote:
>>
>>> Now it is 3 independent accesses (actually 4 but the last one is
>>> diagnostic) with no locking around them. Why do not we need a lock
>>> anymore precisely? Thanks,
>>
>> Updating a regular counter is racy and requires a lock. It was converted
>> to be an atomic which can be incremented without a race.
> 
> Yes, though Alexey may have meant that the multiple reads of the atomic in
> decrement_pinned_vm are racy.

Yes, I meant this race, thanks for clarifying this.

>  It only matters when there's a bug that would
> make the counter go negative, but it's there.
> 
> And FWIW the debug print in try_increment_pinned_vm is also racy.
> 
> This fixes all that.  It doesn't try to correct the negative pinned_vm as the
> old code did because it's already a bug and adjusting the value by the negative
> amount seems to do nothing but make debugging harder.
> 
> If it's ok, I'll respin the whole series this way (another point for common
> helper)

This looks good, thanks for fixing this.


> 
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index f47e020dc5e4..b79257304de6 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -53,25 +53,24 @@ static long try_increment_pinned_vm(struct mm_struct *mm, long npages)
>  		atomic64_sub(npages, &mm->pinned_vm);
>  	}
>  
> -	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%lu%s\n", current->pid,
> -			npages << PAGE_SHIFT,
> -			atomic64_read(&mm->pinned_vm) << PAGE_SHIFT,
> -			rlimit(RLIMIT_MEMLOCK), ret ? " - exceeded" : "");
> +	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %lld/%lu%s\n", current->pid,
> +			npages << PAGE_SHIFT, pinned << PAGE_SHIFT,
> +			lock_limit, ret ? " - exceeded" : "");
>  
>  	return ret;
>  }
>  
>  static void decrement_pinned_vm(struct mm_struct *mm, long npages)
>  {
> +	s64 pinned;
> +
>  	if (!mm || !npages)
>  		return;
>  
> -	if (WARN_ON_ONCE(npages > atomic64_read(&mm->pinned_vm)))
> -		npages = atomic64_read(&mm->pinned_vm);
> -	atomic64_sub(npages, &mm->pinned_vm);
> -	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%lu\n", current->pid,
> -			npages << PAGE_SHIFT,
> -			atomic64_read(&mm->pinned_vm) << PAGE_SHIFT,
> +	pinned = atomic64_sub_return(npages, &mm->pinned_vm);
> +	WARN_ON_ONCE(pinned < 0);
> +	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %lld/%lu\n", current->pid,
> +			npages << PAGE_SHIFT, pinned << PAGE_SHIFT,
>  			rlimit(RLIMIT_MEMLOCK));
>  }
>  
> 

-- 
Alexey
