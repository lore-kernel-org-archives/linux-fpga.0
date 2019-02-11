Return-Path: <SRS0=t8ba=QS=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=t8ba=QS=oracle.com=daniel.m.jordan@kernel.org>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH 5/5] kvm/book3s: use pinned_vm instead of locked_vm to account pinned pages
Date: Mon, 11 Feb 2019 17:44:37 -0500
Message-Id: <20190211224437.25267-6-daniel.m.jordan@oracle.com>
In-Reply-To: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: jgg@ziepe.ca
Cc: akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru, daniel.m.jordan@oracle.com
List-ID: <linux-fpga@vger.kernel.org>

Memory used for TCE tables in kvm_vm_ioctl_create_spapr_tce is currently
accounted to locked_vm because it stays resident and its allocation is
directly triggered from userspace as explained in f8626985c7c2 ("KVM:
PPC: Account TCE-containing pages in locked_vm").

However, since the memory comes straight from the page allocator (and to
a lesser extent unreclaimable slab) and is effectively pinned, it should
be accounted with pinned_vm (see bc3e53f682d9 ("mm: distinguish between
mlocked and pinned pages")).

pinned_vm recently became atomic and so no longer relies on mmap_sem
held as writer: delete.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 arch/powerpc/kvm/book3s_64_vio.c | 35 ++++++++++++++------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 532ab79734c7..2f8d7c051e4e 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -56,39 +56,34 @@ static unsigned long kvmppc_stt_pages(unsigned long tce_pages)
 	return tce_pages + ALIGN(stt_bytes, PAGE_SIZE) / PAGE_SIZE;
 }
 
-static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
+static long kvmppc_account_memlimit(unsigned long pages, bool inc)
 {
 	long ret = 0;
+	s64 pinned_vm;
 
 	if (!current || !current->mm)
 		return ret; /* process exited */
 
-	down_write(&current->mm->mmap_sem);
-
 	if (inc) {
-		unsigned long locked, lock_limit;
+		unsigned long lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
-		locked = current->mm->locked_vm + stt_pages;
-		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+		pinned_vm = atomic64_add_return(pages, &current->mm->pinned_vm);
+		if (pinned_vm > lock_limit && !capable(CAP_IPC_LOCK)) {
 			ret = -ENOMEM;
-		else
-			current->mm->locked_vm += stt_pages;
+			atomic64_sub(pages, &current->mm->pinned_vm);
+		}
 	} else {
-		if (WARN_ON_ONCE(stt_pages > current->mm->locked_vm))
-			stt_pages = current->mm->locked_vm;
+		pinned_vm = atomic64_read(&current->mm->pinned_vm);
+		if (WARN_ON_ONCE(pages > pinned_vm))
+			pages = pinned_vm;
 
-		current->mm->locked_vm -= stt_pages;
+		atomic64_sub(pages, &current->mm->pinned_vm);
 	}
 
-	pr_debug("[%d] RLIMIT_MEMLOCK KVM %c%ld %ld/%ld%s\n", current->pid,
-			inc ? '+' : '-',
-			stt_pages << PAGE_SHIFT,
-			current->mm->locked_vm << PAGE_SHIFT,
-			rlimit(RLIMIT_MEMLOCK),
-			ret ? " - exceeded" : "");
-
-	up_write(&current->mm->mmap_sem);
+	pr_debug("[%d] RLIMIT_MEMLOCK KVM %c%lu %ld/%lu%s\n", current->pid,
+			inc ? '+' : '-', pages << PAGE_SHIFT,
+			atomic64_read(&current->mm->pinned_vm) << PAGE_SHIFT,
+			rlimit(RLIMIT_MEMLOCK), ret ? " - exceeded" : "");
 
 	return ret;
 }
-- 
2.20.1
