Return-Path: <SRS0=XueN=SE=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=XueN=SE=oracle.com=daniel.m.jordan@kernel.org>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH 4/6] fpga/dlf/afu: drop mmap_sem now that locked_vm is atomic
Date: Tue,  2 Apr 2019 16:41:56 -0400
Message-Id: <20190402204158.27582-5-daniel.m.jordan@oracle.com>
In-Reply-To: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: akpm@linux-foundation.org
Cc: daniel.m.jordan@oracle.com, Alan Tull <atull@kernel.org>, Christoph Lameter <cl@linux.com>, Davidlohr Bueso <dave@stgolabs.net>, Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

With locked_vm now an atomic, there is no need to take mmap_sem as
writer.  Delete and refactor accordingly.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Alan Tull <atull@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: Wu Hao <hao.wu@intel.com>
Cc: <linux-mm@kvack.org>
Cc: <linux-fpga@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
 drivers/fpga/dfl-afu-dma-region.c | 40 ++++++++++++-------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 08132fd9b6b7..81e3e3a71758 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -35,46 +35,36 @@ void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
  * afu_dma_adjust_locked_vm - adjust locked memory
  * @dev: port device
  * @npages: number of pages
- * @incr: increase or decrease locked memory
  *
  * Increase or decrease the locked memory size with npages input.
  *
  * Return 0 on success.
  * Return -ENOMEM if locked memory size is over the limit and no CAP_IPC_LOCK.
  */
-static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
+static int afu_dma_adjust_locked_vm(struct device *dev, long pages)
 {
-	unsigned long locked, lock_limit;
+	unsigned long lock_limit;
 	s64 locked_vm;
 	int ret = 0;
 
 	/* the task is exiting. */
-	if (!current->mm)
+	if (!current->mm || !pages)
 		return 0;
 
-	down_write(&current->mm->mmap_sem);
-
-	locked_vm = atomic64_read(&current->mm->locked_vm);
-	if (incr) {
-		locked = locked_vm + npages;
+	locked_vm = atomic64_add_return(pages, &current->mm->locked_vm);
+	WARN_ON_ONCE(locked_vm < 0);
+	if (pages > 0 && !capable(CAP_IPC_LOCK)) {
 		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-
-		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+		if (locked_vm > lock_limit) {
 			ret = -ENOMEM;
-		else
-			atomic64_add(npages, &current->mm->locked_vm);
-	} else {
-		if (WARN_ON_ONCE(npages > locked_vm))
-			npages = locked_vm;
-		atomic64_sub(npages, &current->mm->locked_vm);
+			atomic64_sub(pages, &current->mm->locked_vm);
+		}
 	}
 
 	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %lld/%lu%s\n", current->pid,
-		incr ? '+' : '-', npages << PAGE_SHIFT,
-		(s64)atomic64_read(&current->mm->locked_vm) << PAGE_SHIFT,
-		rlimit(RLIMIT_MEMLOCK), ret ? "- exceeded" : "");
-
-	up_write(&current->mm->mmap_sem);
+		(pages > 0) ? '+' : '-', pages << PAGE_SHIFT,
+		locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
+		ret ? "- exceeded" : "");
 
 	return ret;
 }
@@ -94,7 +84,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
 	struct device *dev = &pdata->dev->dev;
 	int ret, pinned;
 
-	ret = afu_dma_adjust_locked_vm(dev, npages, true);
+	ret = afu_dma_adjust_locked_vm(dev, npages);
 	if (ret)
 		return ret;
 
@@ -123,7 +113,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
 free_pages:
 	kfree(region->pages);
 unlock_vm:
-	afu_dma_adjust_locked_vm(dev, npages, false);
+	afu_dma_adjust_locked_vm(dev, -npages);
 	return ret;
 }
 
@@ -143,7 +133,7 @@ static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
 
 	put_all_pages(region->pages, npages);
 	kfree(region->pages);
-	afu_dma_adjust_locked_vm(dev, npages, false);
+	afu_dma_adjust_locked_vm(dev, -npages);
 
 	dev_dbg(dev, "%ld pages unpinned\n", npages);
 }
-- 
2.21.0
