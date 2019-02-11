Return-Path: <SRS0=t8ba=QS=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=t8ba=QS=oracle.com=daniel.m.jordan@kernel.org>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH 2/5] vfio/spapr_tce: use pinned_vm instead of locked_vm to account pinned pages
Date: Mon, 11 Feb 2019 17:44:34 -0500
Message-Id: <20190211224437.25267-3-daniel.m.jordan@oracle.com>
In-Reply-To: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: jgg@ziepe.ca
Cc: akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru, daniel.m.jordan@oracle.com
List-ID: <linux-fpga@vger.kernel.org>

Beginning with bc3e53f682d9 ("mm: distinguish between mlocked and pinned
pages"), locked and pinned pages are accounted separately.  The SPAPR
TCE VFIO IOMMU driver accounts pinned pages to locked_vm; use pinned_vm
instead.

pinned_vm recently became atomic and so no longer relies on mmap_sem
held as writer: delete.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 Documentation/vfio.txt              |  6 +--
 drivers/vfio/vfio_iommu_spapr_tce.c | 64 ++++++++++++++---------------
 2 files changed, 33 insertions(+), 37 deletions(-)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index f1a4d3c3ba0b..fa37d65363f9 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -308,7 +308,7 @@ This implementation has some specifics:
    currently there is no way to reduce the number of calls. In order to make
    things faster, the map/unmap handling has been implemented in real mode
    which provides an excellent performance which has limitations such as
-   inability to do locked pages accounting in real time.
+   inability to do pinned pages accounting in real time.
 
 4) According to sPAPR specification, A Partitionable Endpoint (PE) is an I/O
    subtree that can be treated as a unit for the purposes of partitioning and
@@ -324,7 +324,7 @@ This implementation has some specifics:
 		returns the size and the start of the DMA window on the PCI bus.
 
 	VFIO_IOMMU_ENABLE
-		enables the container. The locked pages accounting
+		enables the container. The pinned pages accounting
 		is done at this point. This lets user first to know what
 		the DMA window is and adjust rlimit before doing any real job.
 
@@ -454,7 +454,7 @@ This implementation has some specifics:
 
    PPC64 paravirtualized guests generate a lot of map/unmap requests,
    and the handling of those includes pinning/unpinning pages and updating
-   mm::locked_vm counter to make sure we do not exceed the rlimit.
+   mm::pinned_vm counter to make sure we do not exceed the rlimit.
    The v2 IOMMU splits accounting and pinning into separate operations:
 
    - VFIO_IOMMU_SPAPR_REGISTER_MEMORY/VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY ioctls
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index c424913324e3..f47e020dc5e4 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -34,9 +34,11 @@
 static void tce_iommu_detach_group(void *iommu_data,
 		struct iommu_group *iommu_group);
 
-static long try_increment_locked_vm(struct mm_struct *mm, long npages)
+static long try_increment_pinned_vm(struct mm_struct *mm, long npages)
 {
-	long ret = 0, locked, lock_limit;
+	long ret = 0;
+	s64 pinned;
+	unsigned long lock_limit;
 
 	if (WARN_ON_ONCE(!mm))
 		return -EPERM;
@@ -44,39 +46,33 @@ static long try_increment_locked_vm(struct mm_struct *mm, long npages)
 	if (!npages)
 		return 0;
 
-	down_write(&mm->mmap_sem);
-	locked = mm->locked_vm + npages;
+	pinned = atomic64_add_return(npages, &mm->pinned_vm);
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+	if (pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
 		ret = -ENOMEM;
-	else
-		mm->locked_vm += npages;
+		atomic64_sub(npages, &mm->pinned_vm);
+	}
 
-	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%ld%s\n", current->pid,
+	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%lu%s\n", current->pid,
 			npages << PAGE_SHIFT,
-			mm->locked_vm << PAGE_SHIFT,
-			rlimit(RLIMIT_MEMLOCK),
-			ret ? " - exceeded" : "");
-
-	up_write(&mm->mmap_sem);
+			atomic64_read(&mm->pinned_vm) << PAGE_SHIFT,
+			rlimit(RLIMIT_MEMLOCK), ret ? " - exceeded" : "");
 
 	return ret;
 }
 
-static void decrement_locked_vm(struct mm_struct *mm, long npages)
+static void decrement_pinned_vm(struct mm_struct *mm, long npages)
 {
 	if (!mm || !npages)
 		return;
 
-	down_write(&mm->mmap_sem);
-	if (WARN_ON_ONCE(npages > mm->locked_vm))
-		npages = mm->locked_vm;
-	mm->locked_vm -= npages;
-	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%ld\n", current->pid,
+	if (WARN_ON_ONCE(npages > atomic64_read(&mm->pinned_vm)))
+		npages = atomic64_read(&mm->pinned_vm);
+	atomic64_sub(npages, &mm->pinned_vm);
+	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%lu\n", current->pid,
 			npages << PAGE_SHIFT,
-			mm->locked_vm << PAGE_SHIFT,
+			atomic64_read(&mm->pinned_vm) << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK));
-	up_write(&mm->mmap_sem);
 }
 
 /*
@@ -110,7 +106,7 @@ struct tce_container {
 	bool enabled;
 	bool v2;
 	bool def_window_pending;
-	unsigned long locked_pages;
+	unsigned long pinned_pages;
 	struct mm_struct *mm;
 	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
 	struct list_head group_list;
@@ -283,7 +279,7 @@ static int tce_iommu_find_free_table(struct tce_container *container)
 static int tce_iommu_enable(struct tce_container *container)
 {
 	int ret = 0;
-	unsigned long locked;
+	unsigned long pinned;
 	struct iommu_table_group *table_group;
 	struct tce_iommu_group *tcegrp;
 
@@ -292,15 +288,15 @@ static int tce_iommu_enable(struct tce_container *container)
 
 	/*
 	 * When userspace pages are mapped into the IOMMU, they are effectively
-	 * locked memory, so, theoretically, we need to update the accounting
-	 * of locked pages on each map and unmap.  For powerpc, the map unmap
+	 * pinned memory, so, theoretically, we need to update the accounting
+	 * of pinned pages on each map and unmap.  For powerpc, the map unmap
 	 * paths can be very hot, though, and the accounting would kill
 	 * performance, especially since it would be difficult to impossible
 	 * to handle the accounting in real mode only.
 	 *
 	 * To address that, rather than precisely accounting every page, we
-	 * instead account for a worst case on locked memory when the iommu is
-	 * enabled and disabled.  The worst case upper bound on locked memory
+	 * instead account for a worst case on pinned memory when the iommu is
+	 * enabled and disabled.  The worst case upper bound on pinned memory
 	 * is the size of the whole iommu window, which is usually relatively
 	 * small (compared to total memory sizes) on POWER hardware.
 	 *
@@ -317,7 +313,7 @@ static int tce_iommu_enable(struct tce_container *container)
 	 *
 	 * So we do not allow enabling a container without a group attached
 	 * as there is no way to know how much we should increment
-	 * the locked_vm counter.
+	 * the pinned_vm counter.
 	 */
 	if (!tce_groups_attached(container))
 		return -ENODEV;
@@ -335,12 +331,12 @@ static int tce_iommu_enable(struct tce_container *container)
 	if (ret)
 		return ret;
 
-	locked = table_group->tce32_size >> PAGE_SHIFT;
-	ret = try_increment_locked_vm(container->mm, locked);
+	pinned = table_group->tce32_size >> PAGE_SHIFT;
+	ret = try_increment_pinned_vm(container->mm, pinned);
 	if (ret)
 		return ret;
 
-	container->locked_pages = locked;
+	container->pinned_pages = pinned;
 
 	container->enabled = true;
 
@@ -355,7 +351,7 @@ static void tce_iommu_disable(struct tce_container *container)
 	container->enabled = false;
 
 	BUG_ON(!container->mm);
-	decrement_locked_vm(container->mm, container->locked_pages);
+	decrement_pinned_vm(container->mm, container->pinned_pages);
 }
 
 static void *tce_iommu_open(unsigned long arg)
@@ -658,7 +654,7 @@ static long tce_iommu_create_table(struct tce_container *container,
 	if (!table_size)
 		return -EINVAL;
 
-	ret = try_increment_locked_vm(container->mm, table_size >> PAGE_SHIFT);
+	ret = try_increment_pinned_vm(container->mm, table_size >> PAGE_SHIFT);
 	if (ret)
 		return ret;
 
@@ -677,7 +673,7 @@ static void tce_iommu_free_table(struct tce_container *container,
 	unsigned long pages = tbl->it_allocated_size >> PAGE_SHIFT;
 
 	iommu_tce_table_put(tbl);
-	decrement_locked_vm(container->mm, pages);
+	decrement_pinned_vm(container->mm, pages);
 }
 
 static long tce_iommu_create_window(struct tce_container *container,
-- 
2.20.1
