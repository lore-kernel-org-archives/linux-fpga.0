Return-Path: <SRS0=t8ba=QS=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=t8ba=QS=oracle.com=daniel.m.jordan@kernel.org>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH 1/5] vfio/type1: use pinned_vm instead of locked_vm to account pinned pages
Date: Mon, 11 Feb 2019 17:44:33 -0500
Message-Id: <20190211224437.25267-2-daniel.m.jordan@oracle.com>
In-Reply-To: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: jgg@ziepe.ca
Cc: akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru, daniel.m.jordan@oracle.com
List-ID: <linux-fpga@vger.kernel.org>

Beginning with bc3e53f682d9 ("mm: distinguish between mlocked and pinned
pages"), locked and pinned pages are accounted separately.  Type1
accounts pinned pages to locked_vm; use pinned_vm instead.

pinned_vm recently became atomic and so no longer relies on mmap_sem
held as writer: delete.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 drivers/vfio/vfio_iommu_type1.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 73652e21efec..a56cc341813f 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -257,7 +257,8 @@ static int vfio_iova_put_vfio_pfn(struct vfio_dma *dma, struct vfio_pfn *vpfn)
 static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
 {
 	struct mm_struct *mm;
-	int ret;
+	s64 pinned_vm;
+	int ret = 0;
 
 	if (!npage)
 		return 0;
@@ -266,24 +267,15 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
 	if (!mm)
 		return -ESRCH; /* process exited */
 
-	ret = down_write_killable(&mm->mmap_sem);
-	if (!ret) {
-		if (npage > 0) {
-			if (!dma->lock_cap) {
-				unsigned long limit;
-
-				limit = task_rlimit(dma->task,
-						RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	pinned_vm = atomic64_add_return(npage, &mm->pinned_vm);
 
-				if (mm->locked_vm + npage > limit)
-					ret = -ENOMEM;
-			}
+	if (npage > 0 && !dma->lock_cap) {
+		unsigned long limit = task_rlimit(dma->task, RLIMIT_MEMLOCK) >>
+								   PAGE_SHIFT;
+		if (pinned_vm > limit) {
+			atomic64_sub(npage, &mm->pinned_vm);
+			ret = -ENOMEM;
 		}
-
-		if (!ret)
-			mm->locked_vm += npage;
-
-		up_write(&mm->mmap_sem);
 	}
 
 	if (async)
@@ -401,6 +393,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 	long ret, pinned = 0, lock_acct = 0;
 	bool rsvd;
 	dma_addr_t iova = vaddr - dma->vaddr + dma->iova;
+	atomic64_t *pinned_vm = &current->mm->pinned_vm;
 
 	/* This code path is only user initiated */
 	if (!current->mm)
@@ -418,7 +411,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 	 * pages are already counted against the user.
 	 */
 	if (!rsvd && !vfio_find_vpfn(dma, iova)) {
-		if (!dma->lock_cap && current->mm->locked_vm + 1 > limit) {
+		if (!dma->lock_cap && atomic64_read(pinned_vm) + 1 > limit) {
 			put_pfn(*pfn_base, dma->prot);
 			pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n", __func__,
 					limit << PAGE_SHIFT);
@@ -445,7 +438,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 
 		if (!rsvd && !vfio_find_vpfn(dma, iova)) {
 			if (!dma->lock_cap &&
-			    current->mm->locked_vm + lock_acct + 1 > limit) {
+			    atomic64_read(pinned_vm) + lock_acct + 1 > limit) {
 				put_pfn(pfn, dma->prot);
 				pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
 					__func__, limit << PAGE_SHIFT);
-- 
2.20.1
