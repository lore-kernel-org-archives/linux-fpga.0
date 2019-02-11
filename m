Return-Path: <SRS0=t8ba=QS=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=t8ba=QS=oracle.com=daniel.m.jordan@kernel.org>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH 3/5] fpga/dlf/afu: use pinned_vm instead of locked_vm to account pinned pages
Date: Mon, 11 Feb 2019 17:44:35 -0500
Message-Id: <20190211224437.25267-4-daniel.m.jordan@oracle.com>
In-Reply-To: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: jgg@ziepe.ca
Cc: akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru, daniel.m.jordan@oracle.com
List-ID: <linux-fpga@vger.kernel.org>

Beginning with bc3e53f682d9 ("mm: distinguish between mlocked and pinned
pages"), locked and pinned pages are accounted separately.  The FPGA AFU
driver accounts pinned pages to locked_vm; use pinned_vm instead.

pinned_vm recently became atomic and so no longer relies on mmap_sem
held as writer: delete.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 drivers/fpga/dfl-afu-dma-region.c | 50 ++++++++++++++-----------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index e18a786fc943..a9a6b317fe2e 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -32,47 +32,43 @@ void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
 }
 
 /**
- * afu_dma_adjust_locked_vm - adjust locked memory
+ * afu_dma_adjust_pinned_vm - adjust pinned memory
  * @dev: port device
  * @npages: number of pages
- * @incr: increase or decrease locked memory
  *
- * Increase or decrease the locked memory size with npages input.
+ * Increase or decrease the pinned memory size with npages input.
  *
  * Return 0 on success.
- * Return -ENOMEM if locked memory size is over the limit and no CAP_IPC_LOCK.
+ * Return -ENOMEM if pinned memory size is over the limit and no CAP_IPC_LOCK.
  */
-static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
+static int afu_dma_adjust_pinned_vm(struct device *dev, long pages)
 {
-	unsigned long locked, lock_limit;
+	unsigned long lock_limit;
+	s64 pinned_vm;
 	int ret = 0;
 
 	/* the task is exiting. */
-	if (!current->mm)
+	if (!current->mm || !pages)
 		return 0;
 
-	down_write(&current->mm->mmap_sem);
-
-	if (incr) {
-		locked = current->mm->locked_vm + npages;
+	if (pages > 0) {
 		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-
-		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+		pinned_vm = atomic64_add_return(pages, &current->mm->pinned_vm);
+		if (pinned_vm > lock_limit && !capable(CAP_IPC_LOCK)) {
 			ret = -ENOMEM;
-		else
-			current->mm->locked_vm += npages;
+			atomic64_sub(pages, &current->mm->pinned_vm);
+		}
 	} else {
-		if (WARN_ON_ONCE(npages > current->mm->locked_vm))
-			npages = current->mm->locked_vm;
-		current->mm->locked_vm -= npages;
+		pinned_vm = atomic64_read(&current->mm->pinned_vm);
+		if (WARN_ON_ONCE(pages > pinned_vm))
+			pages = pinned_vm;
+		atomic64_sub(pages, &current->mm->pinned_vm);
 	}
 
-	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
-		incr ? '+' : '-', npages << PAGE_SHIFT,
-		current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
-		ret ? "- exceeded" : "");
-
-	up_write(&current->mm->mmap_sem);
+	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %lld/%lu%s\n", current->pid,
+		(pages > 0) ? '+' : '-', pages << PAGE_SHIFT,
+		(s64)atomic64_read(&current->mm->pinned_vm) << PAGE_SHIFT,
+		rlimit(RLIMIT_MEMLOCK), ret ? "- exceeded" : "");
 
 	return ret;
 }
@@ -92,7 +88,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
 	struct device *dev = &pdata->dev->dev;
 	int ret, pinned;
 
-	ret = afu_dma_adjust_locked_vm(dev, npages, true);
+	ret = afu_dma_adjust_pinned_vm(dev, npages);
 	if (ret)
 		return ret;
 
@@ -121,7 +117,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
 free_pages:
 	kfree(region->pages);
 unlock_vm:
-	afu_dma_adjust_locked_vm(dev, npages, false);
+	afu_dma_adjust_pinned_vm(dev, -npages);
 	return ret;
 }
 
@@ -141,7 +137,7 @@ static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
 
 	put_all_pages(region->pages, npages);
 	kfree(region->pages);
-	afu_dma_adjust_locked_vm(dev, npages, false);
+	afu_dma_adjust_pinned_vm(dev, -npages);
 
 	dev_dbg(dev, "%ld pages unpinned\n", npages);
 }
-- 
2.20.1
