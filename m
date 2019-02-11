Return-Path: <SRS0=t8ba=QS=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=t8ba=QS=oracle.com=daniel.m.jordan@kernel.org>
Date: Mon, 11 Feb 2019 18:11:53 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/5] vfio/type1: use pinned_vm instead of locked_vm to
 account pinned pages
Message-ID: <20190211231152.qflff6g2asmkb6hr@ca-dmjordan1.us.oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-2-daniel.m.jordan@oracle.com>
 <20190211225620.GO24692@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211225620.GO24692@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Feb 11, 2019 at 03:56:20PM -0700, Jason Gunthorpe wrote:
> On Mon, Feb 11, 2019 at 05:44:33PM -0500, Daniel Jordan wrote:
> > @@ -266,24 +267,15 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
> >  	if (!mm)
> >  		return -ESRCH; /* process exited */
> >  
> > -	ret = down_write_killable(&mm->mmap_sem);
> > -	if (!ret) {
> > -		if (npage > 0) {
> > -			if (!dma->lock_cap) {
> > -				unsigned long limit;
> > -
> > -				limit = task_rlimit(dma->task,
> > -						RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > +	pinned_vm = atomic64_add_return(npage, &mm->pinned_vm);
> >  
> > -				if (mm->locked_vm + npage > limit)
> > -					ret = -ENOMEM;
> > -			}
> > +	if (npage > 0 && !dma->lock_cap) {
> > +		unsigned long limit = task_rlimit(dma->task, RLIMIT_MEMLOCK) >>
> > +
> > -					PAGE_SHIFT;
> 
> I haven't looked at this super closely, but how does this stuff work?
> 
> do_mlock doesn't touch pinned_vm, and this doesn't touch locked_vm...
> 
> Shouldn't all this be 'if (locked_vm + pinned_vm < RLIMIT_MEMLOCK)' ?
>
> Otherwise MEMLOCK is really doubled..

So this has been a problem for some time, but it's not as easy as adding them
together, see [1][2] for a start.

The locked_vm/pinned_vm issue definitely needs fixing, but all this series is
trying to do is account to the right counter.

Daniel

[1] http://lkml.kernel.org/r/20130523104154.GA23650@twins.programming.kicks-ass.net
[2] http://lkml.kernel.org/r/20130524140114.GK23650@twins.programming.kicks-ass.net
