Return-Path: <SRS0=h039=SF=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=h039=SF=oracle.com=daniel.m.jordan@kernel.org>
Date: Wed, 3 Apr 2019 11:58:39 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-ID: <20190403155839.m447czluxd74n5ad@ca-dmjordan1.us.oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-2-daniel.m.jordan@oracle.com>
 <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Lameter <cl@linux.com>, Davidlohr Bueso <dave@stgolabs.net>, Michael Ellerman <mpe@ellerman.id.au>, Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Apr 02, 2019 at 03:04:24PM -0700, Andrew Morton wrote:
> On Tue,  2 Apr 2019 16:41:53 -0400 Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> >  static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
> >  {
> >  	long ret = 0;
> > +	s64 locked_vm;
> >  
> >  	if (!current || !current->mm)
> >  		return ret; /* process exited */
> >  
> >  	down_write(&current->mm->mmap_sem);
> >  
> > +	locked_vm = atomic64_read(&current->mm->locked_vm);
> >  	if (inc) {
> >  		unsigned long locked, lock_limit;
> >  
> > -		locked = current->mm->locked_vm + stt_pages;
> > +		locked = locked_vm + stt_pages;
> >  		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> >  		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
> >  			ret = -ENOMEM;
> >  		else
> > -			current->mm->locked_vm += stt_pages;
> > +			atomic64_add(stt_pages, &current->mm->locked_vm);
> >  	} else {
> > -		if (WARN_ON_ONCE(stt_pages > current->mm->locked_vm))
> > -			stt_pages = current->mm->locked_vm;
> > +		if (WARN_ON_ONCE(stt_pages > locked_vm))
> > +			stt_pages = locked_vm;
> >  
> > -		current->mm->locked_vm -= stt_pages;
> > +		atomic64_sub(stt_pages, &current->mm->locked_vm);
> >  	}
> 
> With the current code, current->mm->locked_vm cannot go negative. 
> After the patch, it can go negative.  If someone else decreased
> current->mm->locked_vm between this function's atomic64_read() and
> atomic64_sub().
> 
> I guess this is a can't-happen in this case because the racing code
> which performed the modification would have taken it negative anyway.
> 
> But this all makes me rather queazy.

mmap_sem is still held in this patch, so updates to locked_vm are still
serialized and I don't think what you describe can happen.  A later patch
removes mmap_sem, of course, but it also rewrites the code to do something
different.  This first patch is just a mechanical type change from unsigned
long to atomic64_t.

So...does this alleviate your symptoms?

> Also, we didn't remove any down_write(mmap_sem)s from core code so I'm
> thinking that the benefit of removing a few mmap_sem-takings from a few
> obscure drivers (sorry ;)) is pretty small.

Not sure about the other drivers, but vfio type1 isn't obscure.  We use it
extensively in our cloud, and from Andrea's __GFP_THISNODE thread a few months
back it seems Red Hat also uses it:

  https://lore.kernel.org/linux-mm/20180820032204.9591-3-aarcange@redhat.com/

> Also, the argument for switching 32-bit arches to a 64-bit counter was
> suspiciously vague.  What overflow issues?  Or are we just being lazy?

If user-controlled values are used to increase locked_vm, multiple threads
doing it at once on a 32-bit system could theoretically cause overflow, so in
the absence of atomic overflow checking, the 64-bit counter on 32b is defensive
programming.

I wouldn't have thought to do it, but Jason Gunthorpe raised the same issue in
the pinned_vm series:

  https://lore.kernel.org/linux-mm/20190115205311.GD22031@mellanox.com/

I'm fine with changing it to atomic_long_t if the scenario is too theoretical
for people.


Anyway, thanks for looking at this.
