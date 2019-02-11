Return-Path: <SRS0=t8ba=QS=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=t8ba=QS=oracle.com=daniel.m.jordan@kernel.org>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH 4/5] powerpc/mmu: use pinned_vm instead of locked_vm to account pinned pages
Date: Mon, 11 Feb 2019 17:44:36 -0500
Message-Id: <20190211224437.25267-5-daniel.m.jordan@oracle.com>
In-Reply-To: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: jgg@ziepe.ca
Cc: akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru, daniel.m.jordan@oracle.com
List-ID: <linux-fpga@vger.kernel.org>

Beginning with bc3e53f682d9 ("mm: distinguish between mlocked and pinned
pages"), locked and pinned pages are accounted separately.  The IOMMU
MMU helpers on powerpc account pinned pages to locked_vm; use pinned_vm
instead.

pinned_vm recently became atomic and so no longer relies on mmap_sem
held as writer: delete.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 arch/powerpc/mm/mmu_context_iommu.c | 43 ++++++++++++++---------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index a712a650a8b6..fdf670542847 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -40,36 +40,35 @@ struct mm_iommu_table_group_mem_t {
 	u64 dev_hpa;		/* Device memory base address */
 };
 
-static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
+static long mm_iommu_adjust_pinned_vm(struct mm_struct *mm,
 		unsigned long npages, bool incr)
 {
-	long ret = 0, locked, lock_limit;
+	long ret = 0;
+	unsigned long lock_limit;
+	s64 pinned_vm;
 
 	if (!npages)
 		return 0;
 
-	down_write(&mm->mmap_sem);
-
 	if (incr) {
-		locked = mm->locked_vm + npages;
 		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+		pinned_vm = atomic64_add_return(npages, &mm->pinned_vm);
+		if (pinned_vm > lock_limit && !capable(CAP_IPC_LOCK)) {
 			ret = -ENOMEM;
-		else
-			mm->locked_vm += npages;
+			atomic64_sub(npages, &mm->pinned_vm);
+		}
 	} else {
-		if (WARN_ON_ONCE(npages > mm->locked_vm))
-			npages = mm->locked_vm;
-		mm->locked_vm -= npages;
+		pinned_vm = atomic64_read(&mm->pinned_vm);
+		if (WARN_ON_ONCE(npages > pinned_vm))
+			npages = pinned_vm;
+		atomic64_sub(npages, &mm->pinned_vm);
 	}
 
-	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%ld %ld/%ld\n",
-			current ? current->pid : 0,
-			incr ? '+' : '-',
+	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%lu %ld/%lu\n",
+			current ? current->pid : 0, incr ? '+' : '-',
 			npages << PAGE_SHIFT,
-			mm->locked_vm << PAGE_SHIFT,
+			atomic64_read(&mm->pinned_vm) << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK));
-	up_write(&mm->mmap_sem);
 
 	return ret;
 }
@@ -133,7 +132,7 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 		struct mm_iommu_table_group_mem_t **pmem)
 {
 	struct mm_iommu_table_group_mem_t *mem;
-	long i, j, ret = 0, locked_entries = 0;
+	long i, j, ret = 0, pinned_entries = 0;
 	unsigned int pageshift;
 	unsigned long flags;
 	unsigned long cur_ua;
@@ -154,11 +153,11 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 	}
 
 	if (dev_hpa == MM_IOMMU_TABLE_INVALID_HPA) {
-		ret = mm_iommu_adjust_locked_vm(mm, entries, true);
+		ret = mm_iommu_adjust_pinned_vm(mm, entries, true);
 		if (ret)
 			goto unlock_exit;
 
-		locked_entries = entries;
+		pinned_entries = entries;
 	}
 
 	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
@@ -252,8 +251,8 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 	list_add_rcu(&mem->next, &mm->context.iommu_group_mem_list);
 
 unlock_exit:
-	if (locked_entries && ret)
-		mm_iommu_adjust_locked_vm(mm, locked_entries, false);
+	if (pinned_entries && ret)
+		mm_iommu_adjust_pinned_vm(mm, pinned_entries, false);
 
 	mutex_unlock(&mem_list_mutex);
 
@@ -352,7 +351,7 @@ long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_mem_t *mem)
 	mm_iommu_release(mem);
 
 	if (dev_hpa == MM_IOMMU_TABLE_INVALID_HPA)
-		mm_iommu_adjust_locked_vm(mm, entries, false);
+		mm_iommu_adjust_pinned_vm(mm, entries, false);
 
 unlock_exit:
 	mutex_unlock(&mem_list_mutex);
-- 
2.20.1
