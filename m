Return-Path: <SRS0=oqt6=SF=oracle.com=steven.sistare@kernel.org>
Return-Path: <SRS0=oqt6=SF=oracle.com=steven.sistare@kernel.org>
Subject: Re: [PATCH 0/6] convert locked_vm from unsigned long to atomic64_t
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Message-ID: <abe31bae-1bdf-b763-c4d1-5e4ea2ccda13@oracle.com>
Date: Wed, 3 Apr 2019 08:51:13 -0400
MIME-Version: 1.0
In-Reply-To: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: akpm@linux-foundation.org, linux_lkml_grp@oracle.com, Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Lameter <cl@linux.com>, Davidlohr Bueso <dave@stgolabs.net>, Michael Ellerman <mpe@ellerman.id.au>, Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 4/2/2019 4:41 PM, Daniel Jordan wrote:
> Hi,
> 
> From patch 1:
> 
>   Taking and dropping mmap_sem to modify a single counter, locked_vm, is
>   overkill when the counter could be synchronized separately.
>   
>   Make mmap_sem a little less coarse by changing locked_vm to an atomic,
>   the 64-bit variety to avoid issues with overflow on 32-bit systems.
> 
> This is a more conservative alternative to [1] with no user-visible
> effects.  Thanks to Alexey Kardashevskiy for pointing out the racy
> atomics and to Alex Williamson, Christoph Lameter, Ira Weiny, and Jason
> Gunthorpe for their comments on [1].
> 
> Davidlohr Bueso recently did a similar conversion for pinned_vm[2].
> 
> Testing
>  1. passes LTP mlock[all], munlock[all], fork, mmap, and mremap tests in an
>     x86 kvm guest
>  2. a VFIO-enabled x86 kvm guest shows the same VmLck in
>     /proc/pid/status before and after this change
>  3. cross-compiles on powerpc
> 
> The series is based on v5.1-rc3.  Please consider for 5.2.
> 
> Daniel
> 
> [1] https://lore.kernel.org/linux-mm/20190211224437.25267-1-daniel.m.jordan@oracle.com/
> [2] https://lore.kernel.org/linux-mm/20190206175920.31082-1-dave@stgolabs.net/
> 
> Daniel Jordan (6):
>   mm: change locked_vm's type from unsigned long to atomic64_t
>   vfio/type1: drop mmap_sem now that locked_vm is atomic
>   vfio/spapr_tce: drop mmap_sem now that locked_vm is atomic
>   fpga/dlf/afu: drop mmap_sem now that locked_vm is atomic
>   powerpc/mmu: drop mmap_sem now that locked_vm is atomic
>   kvm/book3s: drop mmap_sem now that locked_vm is atomic
> 
>  arch/powerpc/kvm/book3s_64_vio.c    | 34 ++++++++++--------------
>  arch/powerpc/mm/mmu_context_iommu.c | 28 +++++++++-----------
>  drivers/fpga/dfl-afu-dma-region.c   | 40 ++++++++++++-----------------
>  drivers/vfio/vfio_iommu_spapr_tce.c | 37 ++++++++++++--------------
>  drivers/vfio/vfio_iommu_type1.c     | 31 +++++++++-------------
>  fs/proc/task_mmu.c                  |  2 +-
>  include/linux/mm_types.h            |  2 +-
>  kernel/fork.c                       |  2 +-
>  mm/debug.c                          |  5 ++--
>  mm/mlock.c                          |  4 +--
>  mm/mmap.c                           | 18 ++++++-------
>  mm/mremap.c                         |  6 ++---
>  12 files changed, 89 insertions(+), 120 deletions(-)
> 
> base-commit: 79a3aaa7b82e3106be97842dedfd8429248896e6

Hi Daniel,
  You could clean all 6 patches up nicely with a common subroutine that
increases locked_vm subject to the rlimit.  Pass a bool arg that is true if
the  limit should be enforced, !dma->lock_cap for one call site, and
!capable(CAP_IPC_LOCK) for the rest.  Push the warnings and debug statements
to the subroutine as well.  One patch could refactor, and a second could
change the locking method.

- Steve
