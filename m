Return-Path: <SRS0=3sgU=QU=ozlabs.ru=aik@kernel.org>
Return-Path: <SRS0=3sgU=QU=ozlabs.ru=aik@kernel.org>
Subject: Re: [PATCH 2/5] vfio/spapr_tce: use pinned_vm instead of locked_vm to
 account pinned pages
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-3-daniel.m.jordan@oracle.com>
 <ee4d14db-05c3-6208-503c-16e287fa78eb@ozlabs.ru>
 <20190212115652.6cf9a20b@w520.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5e478ac6-814d-d599-e44f-5e90232d30b3@ozlabs.ru>
Date: Wed, 13 Feb 2019 11:34:28 +1100
MIME-Version: 1.0
In-Reply-To: <20190212115652.6cf9a20b@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, jgg@ziepe.ca, akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>



On 13/02/2019 05:56, Alex Williamson wrote:
> On Tue, 12 Feb 2019 17:56:18 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 12/02/2019 09:44, Daniel Jordan wrote:
>>> Beginning with bc3e53f682d9 ("mm: distinguish between mlocked and pinned
>>> pages"), locked and pinned pages are accounted separately.  The SPAPR
>>> TCE VFIO IOMMU driver accounts pinned pages to locked_vm; use pinned_vm
>>> instead.
>>>
>>> pinned_vm recently became atomic and so no longer relies on mmap_sem
>>> held as writer: delete.
>>>
>>> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>>> ---
>>>  Documentation/vfio.txt              |  6 +--
>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 64 ++++++++++++++---------------
>>>  2 files changed, 33 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
>>> index f1a4d3c3ba0b..fa37d65363f9 100644
>>> --- a/Documentation/vfio.txt
>>> +++ b/Documentation/vfio.txt
>>> @@ -308,7 +308,7 @@ This implementation has some specifics:
>>>     currently there is no way to reduce the number of calls. In order to make
>>>     things faster, the map/unmap handling has been implemented in real mode
>>>     which provides an excellent performance which has limitations such as
>>> -   inability to do locked pages accounting in real time.
>>> +   inability to do pinned pages accounting in real time.
>>>  
>>>  4) According to sPAPR specification, A Partitionable Endpoint (PE) is an I/O
>>>     subtree that can be treated as a unit for the purposes of partitioning and
>>> @@ -324,7 +324,7 @@ This implementation has some specifics:
>>>  		returns the size and the start of the DMA window on the PCI bus.
>>>  
>>>  	VFIO_IOMMU_ENABLE
>>> -		enables the container. The locked pages accounting
>>> +		enables the container. The pinned pages accounting
>>>  		is done at this point. This lets user first to know what
>>>  		the DMA window is and adjust rlimit before doing any real job.
> 
> I don't know of a ulimit only covering pinned pages, so for
> documentation it seems more correct to continue referring to this as
> locked page accounting.
> 
>>> @@ -454,7 +454,7 @@ This implementation has some specifics:
>>>  
>>>     PPC64 paravirtualized guests generate a lot of map/unmap requests,
>>>     and the handling of those includes pinning/unpinning pages and updating
>>> -   mm::locked_vm counter to make sure we do not exceed the rlimit.
>>> +   mm::pinned_vm counter to make sure we do not exceed the rlimit.
>>>     The v2 IOMMU splits accounting and pinning into separate operations:
>>>  
>>>     - VFIO_IOMMU_SPAPR_REGISTER_MEMORY/VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY ioctls
>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>>> index c424913324e3..f47e020dc5e4 100644
>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>>> @@ -34,9 +34,11 @@
>>>  static void tce_iommu_detach_group(void *iommu_data,
>>>  		struct iommu_group *iommu_group);
>>>  
>>> -static long try_increment_locked_vm(struct mm_struct *mm, long npages)
>>> +static long try_increment_pinned_vm(struct mm_struct *mm, long npages)
>>>  {
>>> -	long ret = 0, locked, lock_limit;
>>> +	long ret = 0;
>>> +	s64 pinned;
>>> +	unsigned long lock_limit;
>>>  
>>>  	if (WARN_ON_ONCE(!mm))
>>>  		return -EPERM;
>>> @@ -44,39 +46,33 @@ static long try_increment_locked_vm(struct mm_struct *mm, long npages)
>>>  	if (!npages)
>>>  		return 0;
>>>  
>>> -	down_write(&mm->mmap_sem);
>>> -	locked = mm->locked_vm + npages;
>>> +	pinned = atomic64_add_return(npages, &mm->pinned_vm);
>>>  	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>>> -	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
>>> +	if (pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
>>>  		ret = -ENOMEM;
>>> -	else
>>> -		mm->locked_vm += npages;
>>> +		atomic64_sub(npages, &mm->pinned_vm);
>>> +	}
>>>  
>>> -	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%ld%s\n", current->pid,
>>> +	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%lu%s\n", current->pid,
>>>  			npages << PAGE_SHIFT,
>>> -			mm->locked_vm << PAGE_SHIFT,
>>> -			rlimit(RLIMIT_MEMLOCK),
>>> -			ret ? " - exceeded" : "");
>>> -
>>> -	up_write(&mm->mmap_sem);
>>> +			atomic64_read(&mm->pinned_vm) << PAGE_SHIFT,
>>> +			rlimit(RLIMIT_MEMLOCK), ret ? " - exceeded" : "");
>>>  
>>>  	return ret;
>>>  }
>>>  
>>> -static void decrement_locked_vm(struct mm_struct *mm, long npages)
>>> +static void decrement_pinned_vm(struct mm_struct *mm, long npages)
>>>  {
>>>  	if (!mm || !npages)
>>>  		return;
>>>  
>>> -	down_write(&mm->mmap_sem);
>>> -	if (WARN_ON_ONCE(npages > mm->locked_vm))
>>> -		npages = mm->locked_vm;
>>> -	mm->locked_vm -= npages;
>>> -	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%ld\n", current->pid,
>>> +	if (WARN_ON_ONCE(npages > atomic64_read(&mm->pinned_vm)))
>>> +		npages = atomic64_read(&mm->pinned_vm);
>>> +	atomic64_sub(npages, &mm->pinned_vm);
>>> +	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%lu\n", current->pid,
>>>  			npages << PAGE_SHIFT,
>>> -			mm->locked_vm << PAGE_SHIFT,
>>> +			atomic64_read(&mm->pinned_vm) << PAGE_SHIFT,
>>>  			rlimit(RLIMIT_MEMLOCK));
>>> -	up_write(&mm->mmap_sem);  
>>
>>
>> So it used to be down_write+up_write and stuff in between.
>>
>> Now it is 3 independent accesses (actually 4 but the last one is
>> diagnostic) with no locking around them. Why do not we need a lock
>> anymore precisely? Thanks,
> 
> The first 2 look pretty sketchy to me, is there a case where you don't
> know how many pages you've pinned to unpin them?

No case like this, this is why WARN_ON_ONCE(). At the time I could have
been under impression that pinned_vm is system-global, hence that
adjustment but we do not really need it there.

>  And can it ever
> really be correct to just unpin whatever remains?  The last access is
> diagnostic, which leaves 1.  Daniel's rework to warn on a negative
> result looks more sane. Thanks,

Yes it does look sane.


-- 
Alexey
