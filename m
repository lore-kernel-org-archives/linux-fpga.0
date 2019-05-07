Return-Path: <SRS0=MpdK=TH=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=MpdK=TH=oracle.com=daniel.m.jordan@kernel.org>
Date: Mon, 6 May 2019 23:09:57 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH] mm: add account_locked_vm utility function
Message-ID: <20190507030957.3qp7yflco6ckcj5q@ca-dmjordan1.us.oracle.com>
References: <20190503201629.20512-1-daniel.m.jordan@oracle.com>
 <20190503232818.GA5182@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503232818.GA5182@mellanox.com>
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Lameter <cl@linux.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Davidlohr Bueso <dave@stgolabs.net>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Steve Sistare <steven.sistare@oracle.com>, Wu Hao <hao.wu@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, May 03, 2019 at 11:28:22PM +0000, Jason Gunthorpe wrote:
> On Fri, May 03, 2019 at 01:16:30PM -0700, Daniel Jordan wrote:
> > Andrew, this one patch replaces these six from [1]:
> > 
> >     mm-change-locked_vms-type-from-unsigned-long-to-atomic64_t.patch
> >     vfio-type1-drop-mmap_sem-now-that-locked_vm-is-atomic.patch
> >     vfio-spapr_tce-drop-mmap_sem-now-that-locked_vm-is-atomic.patch
> >     fpga-dlf-afu-drop-mmap_sem-now-that-locked_vm-is-atomic.patch
> >     kvm-book3s-drop-mmap_sem-now-that-locked_vm-is-atomic.patch
> >     powerpc-mmu-drop-mmap_sem-now-that-locked_vm-is-atomic.patch
> > 
> > That series converts locked_vm to an atomic, but on closer inspection causes at
> > least one accounting race in mremap, and fixing it just for this type
> > conversion came with too much ugly in the core mm to justify, especially when
> > the right long-term fix is making these drivers use pinned_vm instead.
> 
> Did we ever decide what to do here? Should all these drivers be
> switched to pinned_vm anyhow?

Well, there were the concerns about switching in [1].  Alex, is there an
example of an application or library that would break or be exploitable?  If
there were particular worries (qemu for vfio type1, for example), perhaps some
coordinated changes across the kernel and userspace would be possible,
especially given the amount of effort it's likely going to take to get the
locked_vm/pinned_vm accounting sorted out.

[1] https://lore.kernel.org/linux-mm/20190213130330.76ef1987@w520.home/
