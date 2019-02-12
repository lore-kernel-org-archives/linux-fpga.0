Return-Path: <SRS0=uuah=QT=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=uuah=QT=oracle.com=daniel.m.jordan@kernel.org>
Date: Tue, 12 Feb 2019 12:18:40 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 2/5] vfio/spapr_tce: use pinned_vm instead of locked_vm
 to account pinned pages
Message-ID: <20190212171839.env4rnjwdjyips6z@ca-dmjordan1.us.oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-3-daniel.m.jordan@oracle.com>
 <ee4d14db-05c3-6208-503c-16e287fa78eb@ozlabs.ru>
 <01000168e29daf0a-cb3a9394-e3dd-4d88-ad3c-31df1f9ec052-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000168e29daf0a-cb3a9394-e3dd-4d88-ad3c-31df1f9ec052-000000@email.amazonses.com>
To: Christopher Lameter <cl@linux.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Daniel Jordan <daniel.m.jordan@oracle.com>, jgg@ziepe.ca, akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Feb 12, 2019 at 04:50:11PM +0000, Christopher Lameter wrote:
> On Tue, 12 Feb 2019, Alexey Kardashevskiy wrote:
> 
> > Now it is 3 independent accesses (actually 4 but the last one is
> > diagnostic) with no locking around them. Why do not we need a lock
> > anymore precisely? Thanks,
> 
> Updating a regular counter is racy and requires a lock. It was converted
> to be an atomic which can be incremented without a race.

Yes, though Alexey may have meant that the multiple reads of the atomic in
decrement_pinned_vm are racy.  It only matters when there's a bug that would
make the counter go negative, but it's there.

And FWIW the debug print in try_increment_pinned_vm is also racy.

This fixes all that.  It doesn't try to correct the negative pinned_vm as the
old code did because it's already a bug and adjusting the value by the negative
amount seems to do nothing but make debugging harder.

If it's ok, I'll respin the whole series this way (another point for common
helper)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index f47e020dc5e4..b79257304de6 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -53,25 +53,24 @@ static long try_increment_pinned_vm(struct mm_struct *mm, long npages)
 		atomic64_sub(npages, &mm->pinned_vm);
 	}
 
-	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%lu%s\n", current->pid,
-			npages << PAGE_SHIFT,
-			atomic64_read(&mm->pinned_vm) << PAGE_SHIFT,
-			rlimit(RLIMIT_MEMLOCK), ret ? " - exceeded" : "");
+	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %lld/%lu%s\n", current->pid,
+			npages << PAGE_SHIFT, pinned << PAGE_SHIFT,
+			lock_limit, ret ? " - exceeded" : "");
 
 	return ret;
 }
 
 static void decrement_pinned_vm(struct mm_struct *mm, long npages)
 {
+	s64 pinned;
+
 	if (!mm || !npages)
 		return;
 
-	if (WARN_ON_ONCE(npages > atomic64_read(&mm->pinned_vm)))
-		npages = atomic64_read(&mm->pinned_vm);
-	atomic64_sub(npages, &mm->pinned_vm);
-	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%lu\n", current->pid,
-			npages << PAGE_SHIFT,
-			atomic64_read(&mm->pinned_vm) << PAGE_SHIFT,
+	pinned = atomic64_sub_return(npages, &mm->pinned_vm);
+	WARN_ON_ONCE(pinned < 0);
+	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %lld/%lu\n", current->pid,
+			npages << PAGE_SHIFT, pinned << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK));
 }
 
