Return-Path: <SRS0=OzvY=SN=ozlabs.ru=aik@kernel.org>
Return-Path: <SRS0=OzvY=SN=ozlabs.ru=aik@kernel.org>
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-2-daniel.m.jordan@oracle.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <614ea07a-dd1e-2561-b6f4-2d698bf55f5b@ozlabs.ru>
Date: Thu, 11 Apr 2019 14:22:23 +1000
MIME-Version: 1.0
In-Reply-To: <20190402204158.27582-2-daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Daniel Jordan <daniel.m.jordan@oracle.com>, akpm@linux-foundation.org
Cc: Alan Tull <atull@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Lameter <cl@linux.com>, Davidlohr Bueso <dave@stgolabs.net>, Michael Ellerman <mpe@ellerman.id.au>, Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>



On 03/04/2019 07:41, Daniel Jordan wrote:
> Taking and dropping mmap_sem to modify a single counter, locked_vm, is
> overkill when the counter could be synchronized separately.
> 
> Make mmap_sem a little less coarse by changing locked_vm to an atomic,
> the 64-bit variety to avoid issues with overflow on 32-bit systems.
> 
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: <linux-mm@kvack.org>
> Cc: <kvm@vger.kernel.org>
> Cc: <kvm-ppc@vger.kernel.org>
> Cc: <linuxppc-dev@lists.ozlabs.org>
> Cc: <linux-fpga@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> ---
>  arch/powerpc/kvm/book3s_64_vio.c    | 14 ++++++++------
>  arch/powerpc/mm/mmu_context_iommu.c | 15 ++++++++-------
>  drivers/fpga/dfl-afu-dma-region.c   | 18 ++++++++++--------
>  drivers/vfio/vfio_iommu_spapr_tce.c | 17 +++++++++--------
>  drivers/vfio/vfio_iommu_type1.c     | 10 ++++++----
>  fs/proc/task_mmu.c                  |  2 +-
>  include/linux/mm_types.h            |  2 +-
>  kernel/fork.c                       |  2 +-
>  mm/debug.c                          |  5 +++--
>  mm/mlock.c                          |  4 ++--
>  mm/mmap.c                           | 18 +++++++++---------
>  mm/mremap.c                         |  6 +++---
>  12 files changed, 61 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> index f02b04973710..e7fdb6d10eeb 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -59,32 +59,34 @@ static unsigned long kvmppc_stt_pages(unsigned long tce_pages)
>  static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
>  {
>  	long ret = 0;
> +	s64 locked_vm;
>  
>  	if (!current || !current->mm)
>  		return ret; /* process exited */
>  
>  	down_write(&current->mm->mmap_sem);
>  
> +	locked_vm = atomic64_read(&current->mm->locked_vm);
>  	if (inc) {
>  		unsigned long locked, lock_limit;
>  
> -		locked = current->mm->locked_vm + stt_pages;
> +		locked = locked_vm + stt_pages;
>  		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
>  			ret = -ENOMEM;
>  		else
> -			current->mm->locked_vm += stt_pages;
> +			atomic64_add(stt_pages, &current->mm->locked_vm);
>  	} else {
> -		if (WARN_ON_ONCE(stt_pages > current->mm->locked_vm))
> -			stt_pages = current->mm->locked_vm;
> +		if (WARN_ON_ONCE(stt_pages > locked_vm))
> +			stt_pages = locked_vm;
>  
> -		current->mm->locked_vm -= stt_pages;
> +		atomic64_sub(stt_pages, &current->mm->locked_vm);
>  	}
>  
>  	pr_debug("[%d] RLIMIT_MEMLOCK KVM %c%ld %ld/%ld%s\n", current->pid,
>  			inc ? '+' : '-',
>  			stt_pages << PAGE_SHIFT,
> -			current->mm->locked_vm << PAGE_SHIFT,
> +			atomic64_read(&current->mm->locked_vm) << PAGE_SHIFT,
>  			rlimit(RLIMIT_MEMLOCK),
>  			ret ? " - exceeded" : "");
>  
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
> index e7a9c4f6bfca..8038ac24a312 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -55,30 +55,31 @@ static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
>  		unsigned long npages, bool incr)
>  {
>  	long ret = 0, locked, lock_limit;
> +	s64 locked_vm;
>  
>  	if (!npages)
>  		return 0;
>  
>  	down_write(&mm->mmap_sem);
> -
> +	locked_vm = atomic64_read(&mm->locked_vm);
>  	if (incr) {
> -		locked = mm->locked_vm + npages;
> +		locked = locked_vm + npages;
>  		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
>  			ret = -ENOMEM;
>  		else
> -			mm->locked_vm += npages;
> +			atomic64_add(npages, &mm->locked_vm);
>  	} else {
> -		if (WARN_ON_ONCE(npages > mm->locked_vm))
> -			npages = mm->locked_vm;
> -		mm->locked_vm -= npages;
> +		if (WARN_ON_ONCE(npages > locked_vm))
> +			npages = locked_vm;
> +		atomic64_sub(npages, &mm->locked_vm);
>  	}
>  
>  	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%ld %ld/%ld\n",
>  			current ? current->pid : 0,
>  			incr ? '+' : '-',
>  			npages << PAGE_SHIFT,
> -			mm->locked_vm << PAGE_SHIFT,
> +			atomic64_read(&mm->locked_vm) << PAGE_SHIFT,
>  			rlimit(RLIMIT_MEMLOCK));
>  	up_write(&mm->mmap_sem);
>  
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> index e18a786fc943..08132fd9b6b7 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -45,6 +45,7 @@ void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
>  static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
>  {
>  	unsigned long locked, lock_limit;
> +	s64 locked_vm;
>  	int ret = 0;
>  
>  	/* the task is exiting. */
> @@ -53,24 +54,25 @@ static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
>  
>  	down_write(&current->mm->mmap_sem);
>  
> +	locked_vm = atomic64_read(&current->mm->locked_vm);
>  	if (incr) {
> -		locked = current->mm->locked_vm + npages;
> +		locked = locked_vm + npages;
>  		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  
>  		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
>  			ret = -ENOMEM;
>  		else
> -			current->mm->locked_vm += npages;
> +			atomic64_add(npages, &current->mm->locked_vm);
>  	} else {
> -		if (WARN_ON_ONCE(npages > current->mm->locked_vm))
> -			npages = current->mm->locked_vm;
> -		current->mm->locked_vm -= npages;
> +		if (WARN_ON_ONCE(npages > locked_vm))
> +			npages = locked_vm;
> +		atomic64_sub(npages, &current->mm->locked_vm);
>  	}
>  
> -	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
> +	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %lld/%lu%s\n", current->pid,
>  		incr ? '+' : '-', npages << PAGE_SHIFT,
> -		current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
> -		ret ? "- exceeded" : "");
> +		(s64)atomic64_read(&current->mm->locked_vm) << PAGE_SHIFT,
> +		rlimit(RLIMIT_MEMLOCK), ret ? "- exceeded" : "");



atomic64_read() returns "long" which matches "%ld", why this change (and
similar below)? You did not do this in the two pr_debug()s above anyway.


-- 
Alexey
