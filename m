Return-Path: <SRS0=PsNa=T5=redhat.com=alex.williamson@kernel.org>
Return-Path: <SRS0=PsNa=T5=redhat.com=alex.williamson@kernel.org>
Date: Wed, 29 May 2019 12:56:27 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2] mm: add account_locked_vm utility function
Message-ID: <20190529125627.0cb5b704@x1.home>
In-Reply-To: <20190528150424.tjbaiptpjhzg7y75@ca-dmjordan1.us.oracle.com>
References: <de375582-2c35-8e8a-4737-c816052a8e58@ozlabs.ru>
	<20190524175045.26897-1-daniel.m.jordan@oracle.com>
	<20190525145118.bfda2d75a14db05a001e49ad@linux-foundation.org>
	<20190528150424.tjbaiptpjhzg7y75@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alan Tull <atull@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Lameter <cl@linux.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Davidlohr Bueso <dave@stgolabs.net>, Jason Gunthorpe <jgg@mellanox.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Steve Sistare <steven.sistare@oracle.com>, Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, 28 May 2019 11:04:24 -0400
Daniel Jordan <daniel.m.jordan@oracle.com> wrote:

> On Sat, May 25, 2019 at 02:51:18PM -0700, Andrew Morton wrote:
> > On Fri, 24 May 2019 13:50:45 -0400 Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> >   
> > > locked_vm accounting is done roughly the same way in five places, so
> > > unify them in a helper.  Standardize the debug prints, which vary
> > > slightly, but include the helper's caller to disambiguate between
> > > callsites.
> > > 
> > > Error codes stay the same, so user-visible behavior does too.  The one
> > > exception is that the -EPERM case in tce_account_locked_vm is removed
> > > because Alexey has never seen it triggered.
> > > 
> > > ...
> > >
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -1564,6 +1564,25 @@ long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> > >  int get_user_pages_fast(unsigned long start, int nr_pages,
> > >  			unsigned int gup_flags, struct page **pages);
> > >  
> > > +int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
> > > +			struct task_struct *task, bool bypass_rlim);
> > > +
> > > +static inline int account_locked_vm(struct mm_struct *mm, unsigned long pages,
> > > +				    bool inc)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (pages == 0 || !mm)
> > > +		return 0;
> > > +
> > > +	down_write(&mm->mmap_sem);
> > > +	ret = __account_locked_vm(mm, pages, inc, current,
> > > +				  capable(CAP_IPC_LOCK));
> > > +	up_write(&mm->mmap_sem);
> > > +
> > > +	return ret;
> > > +}  
> > 
> > That's quite a mouthful for an inlined function.  How about uninlining
> > the whole thing and fiddling drivers/vfio/vfio_iommu_type1.c to suit. 
> > I wonder why it does down_write_killable and whether it really needs
> > to...  
> 
> Sure, I can uninline it.  vfio changelogs don't show a particular reason for
> _killable[1].  Maybe Alex has something to add.  Otherwise I'll respin without
> it since the simplification seems worth removing _killable.
> 
> [1] 0cfef2b7410b ("vfio/type1: Remove locked page accounting workqueue")

A userspace vfio driver maps DMA via an ioctl through this path, so I
believe I used killable here just to be friendly that it could be
interrupted and we could fall out with an errno if it were stuck here.
No harm, no foul, the user's mapping is aborted and unwound.  If we're
deadlocked or seriously contended on mmap_sem, maybe we're already in
trouble, but it seemed like a valid and low hanging use case for
killable.  Thanks,

Alex
