Return-Path: <SRS0=XueN=SE=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=XueN=SE=oracle.com=daniel.m.jordan@kernel.org>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH 1/6] mm: change locked_vm's type from unsigned long to atomic64_t
Date: Tue,  2 Apr 2019 16:41:53 -0400
Message-Id: <20190402204158.27582-2-daniel.m.jordan@oracle.com>
In-Reply-To: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: akpm@linux-foundation.org
Cc: daniel.m.jordan@oracle.com, Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Lameter <cl@linux.com>, Davidlohr Bueso <dave@stgolabs.net>, Michael Ellerman <mpe@ellerman.id.au>, Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Taking and dropping mmap_sem to modify a single counter, locked_vm, is
overkill when the counter could be synchronized separately.

Make mmap_sem a little less coarse by changing locked_vm to an atomic,
the 64-bit variety to avoid issues with overflow on 32-bit systems.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Alan Tull <atull@kernel.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Wu Hao <hao.wu@intel.com>
Cc: <linux-mm@kvack.org>
Cc: <kvm@vger.kernel.org>
Cc: <kvm-ppc@vger.kernel.org>
Cc: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-fpga@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
 arch/powerpc/kvm/book3s_64_vio.c    | 14 ++++++++------
 arch/powerpc/mm/mmu_context_iommu.c | 15 ++++++++-------
 drivers/fpga/dfl-afu-dma-region.c   | 18 ++++++++++--------
 drivers/vfio/vfio_iommu_spapr_tce.c | 17 +++++++++--------
 drivers/vfio/vfio_iommu_type1.c     | 10 ++++++----
 fs/proc/task_mmu.c                  |  2 +-
 include/linux/mm_types.h            |  2 +-
 kernel/fork.c                       |  2 +-
 mm/debug.c                          |  5 +++--
 mm/mlock.c                          |  4 ++--
 mm/mmap.c                           | 18 +++++++++---------
 mm/mremap.c                         |  6 +++---
 12 files changed, 61 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index f02b04973710..e7fdb6d10eeb 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -59,32 +59,34 @@ static unsigned long kvmppc_stt_pages(unsigned long tce_pages)
 static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
 {
 	long ret = 0;
+	s64 locked_vm;
 
 	if (!current || !current->mm)
 		return ret; /* process exited */
 
 	down_write(&current->mm->mmap_sem);
 
+	locked_vm = atomic64_read(&current->mm->locked_vm);
 	if (inc) {
 		unsigned long locked, lock_limit;
 
-		locked = current->mm->locked_vm + stt_pages;
+		locked = locked_vm + stt_pages;
 		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			ret = -ENOMEM;
 		else
-			current->mm->locked_vm += stt_pages;
+			atomic64_add(stt_pages, &current->mm->locked_vm);
 	} else {
-		if (WARN_ON_ONCE(stt_pages > current->mm->locked_vm))
-			stt_pages = current->mm->locked_vm;
+		if (WARN_ON_ONCE(stt_pages > locked_vm))
+			stt_pages = locked_vm;
 
-		current->mm->locked_vm -= stt_pages;
+		atomic64_sub(stt_pages, &current->mm->locked_vm);
 	}
 
 	pr_debug("[%d] RLIMIT_MEMLOCK KVM %c%ld %ld/%ld%s\n", current->pid,
 			inc ? '+' : '-',
 			stt_pages << PAGE_SHIFT,
-			current->mm->locked_vm << PAGE_SHIFT,
+			atomic64_read(&current->mm->locked_vm) << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK),
 			ret ? " - exceeded" : "");
 
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index e7a9c4f6bfca..8038ac24a312 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -55,30 +55,31 @@ static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
 		unsigned long npages, bool incr)
 {
 	long ret = 0, locked, lock_limit;
+	s64 locked_vm;
 
 	if (!npages)
 		return 0;
 
 	down_write(&mm->mmap_sem);
-
+	locked_vm = atomic64_read(&mm->locked_vm);
 	if (incr) {
-		locked = mm->locked_vm + npages;
+		locked = locked_vm + npages;
 		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			ret = -ENOMEM;
 		else
-			mm->locked_vm += npages;
+			atomic64_add(npages, &mm->locked_vm);
 	} else {
-		if (WARN_ON_ONCE(npages > mm->locked_vm))
-			npages = mm->locked_vm;
-		mm->locked_vm -= npages;
+		if (WARN_ON_ONCE(npages > locked_vm))
+			npages = locked_vm;
+		atomic64_sub(npages, &mm->locked_vm);
 	}
 
 	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%ld %ld/%ld\n",
 			current ? current->pid : 0,
 			incr ? '+' : '-',
 			npages << PAGE_SHIFT,
-			mm->locked_vm << PAGE_SHIFT,
+			atomic64_read(&mm->locked_vm) << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK));
 	up_write(&mm->mmap_sem);
 
diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index e18a786fc943..08132fd9b6b7 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -45,6 +45,7 @@ void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
 static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
 {
 	unsigned long locked, lock_limit;
+	s64 locked_vm;
 	int ret = 0;
 
 	/* the task is exiting. */
@@ -53,24 +54,25 @@ static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
 
 	down_write(&current->mm->mmap_sem);
 
+	locked_vm = atomic64_read(&current->mm->locked_vm);
 	if (incr) {
-		locked = current->mm->locked_vm + npages;
+		locked = locked_vm + npages;
 		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			ret = -ENOMEM;
 		else
-			current->mm->locked_vm += npages;
+			atomic64_add(npages, &current->mm->locked_vm);
 	} else {
-		if (WARN_ON_ONCE(npages > current->mm->locked_vm))
-			npages = current->mm->locked_vm;
-		current->mm->locked_vm -= npages;
+		if (WARN_ON_ONCE(npages > locked_vm))
+			npages = locked_vm;
+		atomic64_sub(npages, &current->mm->locked_vm);
 	}
 
-	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
+	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %lld/%lu%s\n", current->pid,
 		incr ? '+' : '-', npages << PAGE_SHIFT,
-		current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
-		ret ? "- exceeded" : "");
+		(s64)atomic64_read(&current->mm->locked_vm) << PAGE_SHIFT,
+		rlimit(RLIMIT_MEMLOCK), ret ? "- exceeded" : "");
 
 	up_write(&current->mm->mmap_sem);
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 8dbb270998f4..e7d787e5d839 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -36,7 +36,8 @@ static void tce_iommu_detach_group(void *iommu_data,
 
 static long try_increment_locked_vm(struct mm_struct *mm, long npages)
 {
-	long ret = 0, locked, lock_limit;
+	long ret = 0, lock_limit;
+	s64 locked;
 
 	if (WARN_ON_ONCE(!mm))
 		return -EPERM;
@@ -45,16 +46,16 @@ static long try_increment_locked_vm(struct mm_struct *mm, long npages)
 		return 0;
 
 	down_write(&mm->mmap_sem);
-	locked = mm->locked_vm + npages;
+	locked = atomic64_read(&mm->locked_vm) + npages;
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 		ret = -ENOMEM;
 	else
-		mm->locked_vm += npages;
+		atomic64_add(npages, &mm->locked_vm);
 
 	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%ld%s\n", current->pid,
 			npages << PAGE_SHIFT,
-			mm->locked_vm << PAGE_SHIFT,
+			atomic64_read(&mm->locked_vm) << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK),
 			ret ? " - exceeded" : "");
 
@@ -69,12 +70,12 @@ static void decrement_locked_vm(struct mm_struct *mm, long npages)
 		return;
 
 	down_write(&mm->mmap_sem);
-	if (WARN_ON_ONCE(npages > mm->locked_vm))
-		npages = mm->locked_vm;
-	mm->locked_vm -= npages;
+	if (WARN_ON_ONCE(npages > atomic64_read(&mm->locked_vm)))
+		npages = atomic64_read(&mm->locked_vm);
+	atomic64_sub(npages, &mm->locked_vm);
 	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%ld\n", current->pid,
 			npages << PAGE_SHIFT,
-			mm->locked_vm << PAGE_SHIFT,
+			atomic64_read(&mm->locked_vm) << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK));
 	up_write(&mm->mmap_sem);
 }
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 73652e21efec..5b2878697286 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -270,18 +270,19 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
 	if (!ret) {
 		if (npage > 0) {
 			if (!dma->lock_cap) {
+				s64 locked_vm = atomic64_read(&mm->locked_vm);
 				unsigned long limit;
 
 				limit = task_rlimit(dma->task,
 						RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
-				if (mm->locked_vm + npage > limit)
+				if (locked_vm + npage > limit)
 					ret = -ENOMEM;
 			}
 		}
 
 		if (!ret)
-			mm->locked_vm += npage;
+			atomic64_add(npage, &mm->locked_vm);
 
 		up_write(&mm->mmap_sem);
 	}
@@ -401,6 +402,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 	long ret, pinned = 0, lock_acct = 0;
 	bool rsvd;
 	dma_addr_t iova = vaddr - dma->vaddr + dma->iova;
+	atomic64_t *locked_vm = &current->mm->locked_vm;
 
 	/* This code path is only user initiated */
 	if (!current->mm)
@@ -418,7 +420,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 	 * pages are already counted against the user.
 	 */
 	if (!rsvd && !vfio_find_vpfn(dma, iova)) {
-		if (!dma->lock_cap && current->mm->locked_vm + 1 > limit) {
+		if (!dma->lock_cap && atomic64_read(locked_vm) + 1 > limit) {
 			put_pfn(*pfn_base, dma->prot);
 			pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n", __func__,
 					limit << PAGE_SHIFT);
@@ -445,7 +447,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 
 		if (!rsvd && !vfio_find_vpfn(dma, iova)) {
 			if (!dma->lock_cap &&
-			    current->mm->locked_vm + lock_acct + 1 > limit) {
+			    atomic64_read(locked_vm) + lock_acct + 1 > limit) {
 				put_pfn(pfn, dma->prot);
 				pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
 					__func__, limit << PAGE_SHIFT);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 92a91e7816d8..61da4b24d0e0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -58,7 +58,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 	swap = get_mm_counter(mm, MM_SWAPENTS);
 	SEQ_PUT_DEC("VmPeak:\t", hiwater_vm);
 	SEQ_PUT_DEC(" kB\nVmSize:\t", total_vm);
-	SEQ_PUT_DEC(" kB\nVmLck:\t", mm->locked_vm);
+	SEQ_PUT_DEC(" kB\nVmLck:\t", atomic64_read(&mm->locked_vm));
 	SEQ_PUT_DEC(" kB\nVmPin:\t", atomic64_read(&mm->pinned_vm));
 	SEQ_PUT_DEC(" kB\nVmHWM:\t", hiwater_rss);
 	SEQ_PUT_DEC(" kB\nVmRSS:\t", total_rss);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7eade9132f02..5059b99a0827 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -410,7 +410,7 @@ struct mm_struct {
 		unsigned long hiwater_vm;  /* High-water virtual memory usage */
 
 		unsigned long total_vm;	   /* Total pages mapped */
-		unsigned long locked_vm;   /* Pages that have PG_mlocked set */
+		atomic64_t    locked_vm;   /* Pages that have PG_mlocked set */
 		atomic64_t    pinned_vm;   /* Refcount permanently increased */
 		unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
 		unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
diff --git a/kernel/fork.c b/kernel/fork.c
index 9dcd18aa210b..56be8cdc7b4a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -979,7 +979,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm->core_state = NULL;
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
-	mm->locked_vm = 0;
+	atomic64_set(&mm->locked_vm, 0);
 	atomic64_set(&mm->pinned_vm, 0);
 	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
 	spin_lock_init(&mm->page_table_lock);
diff --git a/mm/debug.c b/mm/debug.c
index eee9c221280c..b9cd71927d3c 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -136,7 +136,7 @@ void dump_mm(const struct mm_struct *mm)
 #endif
 		"mmap_base %lu mmap_legacy_base %lu highest_vm_end %lu\n"
 		"pgd %px mm_users %d mm_count %d pgtables_bytes %lu map_count %d\n"
-		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %lx\n"
+		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %llx\n"
 		"pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
 		"start_code %lx end_code %lx start_data %lx end_data %lx\n"
 		"start_brk %lx brk %lx start_stack %lx\n"
@@ -167,7 +167,8 @@ void dump_mm(const struct mm_struct *mm)
 		atomic_read(&mm->mm_count),
 		mm_pgtables_bytes(mm),
 		mm->map_count,
-		mm->hiwater_rss, mm->hiwater_vm, mm->total_vm, mm->locked_vm,
+		mm->hiwater_rss, mm->hiwater_vm, mm->total_vm,
+		(u64)atomic64_read(&mm->locked_vm),
 		(u64)atomic64_read(&mm->pinned_vm),
 		mm->data_vm, mm->exec_vm, mm->stack_vm,
 		mm->start_code, mm->end_code, mm->start_data, mm->end_data,
diff --git a/mm/mlock.c b/mm/mlock.c
index 080f3b36415b..e492a155c51a 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -562,7 +562,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		nr_pages = -nr_pages;
 	else if (old_flags & VM_LOCKED)
 		nr_pages = 0;
-	mm->locked_vm += nr_pages;
+	atomic64_add(nr_pages, &mm->locked_vm);
 
 	/*
 	 * vm_flags is protected by the mmap_sem held in write mode.
@@ -687,7 +687,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 	if (down_write_killable(&current->mm->mmap_sem))
 		return -EINTR;
 
-	locked += current->mm->locked_vm;
+	locked += atomic64_read(&current->mm->locked_vm);
 	if ((locked > lock_limit) && (!capable(CAP_IPC_LOCK))) {
 		/*
 		 * It is possible that the regions requested intersect with
diff --git a/mm/mmap.c b/mm/mmap.c
index 41eb48d9b527..03576c1d530c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1339,7 +1339,7 @@ static inline int mlock_future_check(struct mm_struct *mm,
 	/*  mlock MCL_FUTURE? */
 	if (flags & VM_LOCKED) {
 		locked = len >> PAGE_SHIFT;
-		locked += mm->locked_vm;
+		locked += atomic64_read(&mm->locked_vm);
 		lock_limit = rlimit(RLIMIT_MEMLOCK);
 		lock_limit >>= PAGE_SHIFT;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
@@ -1825,7 +1825,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 					vma == get_gate_vma(current->mm))
 			vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
 		else
-			mm->locked_vm += (len >> PAGE_SHIFT);
+			atomic64_add(len >> PAGE_SHIFT, &mm->locked_vm);
 	}
 
 	if (file)
@@ -2301,7 +2301,7 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 	if (vma->vm_flags & VM_LOCKED) {
 		unsigned long locked;
 		unsigned long limit;
-		locked = mm->locked_vm + grow;
+		locked = atomic64_read(&mm->locked_vm) + grow;
 		limit = rlimit(RLIMIT_MEMLOCK);
 		limit >>= PAGE_SHIFT;
 		if (locked > limit && !capable(CAP_IPC_LOCK))
@@ -2395,7 +2395,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 				 */
 				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
-					mm->locked_vm += grow;
+					atomic64_add(grow, &mm->locked_vm);
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end = address;
@@ -2475,7 +2475,7 @@ int expand_downwards(struct vm_area_struct *vma,
 				 */
 				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
-					mm->locked_vm += grow;
+					atomic64_add(grow, &mm->locked_vm);
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_start = address;
@@ -2796,11 +2796,11 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	/*
 	 * unlock any mlock()ed ranges before detaching vmas
 	 */
-	if (mm->locked_vm) {
+	if (atomic64_read(&mm->locked_vm)) {
 		struct vm_area_struct *tmp = vma;
 		while (tmp && tmp->vm_start < end) {
 			if (tmp->vm_flags & VM_LOCKED) {
-				mm->locked_vm -= vma_pages(tmp);
+				atomic64_sub(vma_pages(tmp), &mm->locked_vm);
 				munlock_vma_pages_all(tmp);
 			}
 
@@ -3043,7 +3043,7 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
 	mm->total_vm += len >> PAGE_SHIFT;
 	mm->data_vm += len >> PAGE_SHIFT;
 	if (flags & VM_LOCKED)
-		mm->locked_vm += (len >> PAGE_SHIFT);
+		atomic64_add(len >> PAGE_SHIFT, &mm->locked_vm);
 	vma->vm_flags |= VM_SOFTDIRTY;
 	return 0;
 }
@@ -3115,7 +3115,7 @@ void exit_mmap(struct mm_struct *mm)
 		up_write(&mm->mmap_sem);
 	}
 
-	if (mm->locked_vm) {
+	if (atomic64_read(&mm->locked_vm)) {
 		vma = mm->mmap;
 		while (vma) {
 			if (vma->vm_flags & VM_LOCKED)
diff --git a/mm/mremap.c b/mm/mremap.c
index e3edef6b7a12..9a4046bb2875 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -422,7 +422,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	if (vm_flags & VM_LOCKED) {
-		mm->locked_vm += new_len >> PAGE_SHIFT;
+		atomic64_add(new_len >> PAGE_SHIFT, &mm->locked_vm);
 		*locked = true;
 	}
 
@@ -473,7 +473,7 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 
 	if (vma->vm_flags & VM_LOCKED) {
 		unsigned long locked, lock_limit;
-		locked = mm->locked_vm << PAGE_SHIFT;
+		locked = atomic64_read(&mm->locked_vm) << PAGE_SHIFT;
 		lock_limit = rlimit(RLIMIT_MEMLOCK);
 		locked += new_len - old_len;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
@@ -679,7 +679,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 
 			vm_stat_account(mm, vma->vm_flags, pages);
 			if (vma->vm_flags & VM_LOCKED) {
-				mm->locked_vm += pages;
+				atomic64_add(pages, &mm->locked_vm);
 				locked = true;
 				new_addr = addr;
 			}
-- 
2.21.0
