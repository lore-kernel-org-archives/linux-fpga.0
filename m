Return-Path: <SRS0=DPgN=QU=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=DPgN=QU=oracle.com=daniel.m.jordan@kernel.org>
Date: Tue, 12 Feb 2019 19:26:50 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/5] vfio/type1: use pinned_vm instead of locked_vm to
 account pinned pages
Message-ID: <20190213002650.kav7xc4r2xs5f3ef@ca-dmjordan1.us.oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-2-daniel.m.jordan@oracle.com>
 <20190211225620.GO24692@ziepe.ca>
 <20190211231152.qflff6g2asmkb6hr@ca-dmjordan1.us.oracle.com>
 <20190212114110.17bc8a14@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212114110.17bc8a14@w520.home>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>, akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru, peterz@infradead.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Feb 12, 2019 at 11:41:10AM -0700, Alex Williamson wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> > On Mon, Feb 11, 2019 at 03:56:20PM -0700, Jason Gunthorpe wrote:
> > > I haven't looked at this super closely, but how does this stuff work?
> > > 
> > > do_mlock doesn't touch pinned_vm, and this doesn't touch locked_vm...
> > > 
> > > Shouldn't all this be 'if (locked_vm + pinned_vm < RLIMIT_MEMLOCK)' ?
> > >
> > > Otherwise MEMLOCK is really doubled..  
> > 
> > So this has been a problem for some time, but it's not as easy as adding them
> > together, see [1][2] for a start.
> > 
> > The locked_vm/pinned_vm issue definitely needs fixing, but all this series is
> > trying to do is account to the right counter.

Thanks for taking a look, Alex.

> This still makes me nervous because we have userspace dependencies on
> setting process locked memory.

Could you please expand on this?  Trying to get more context.

> There's a user visible difference if we
> account for them in the same bucket vs separate.  Perhaps we're
> counting in the wrong bucket now, but if we "fix" that and userspace
> adapts, how do we ever go back to accounting both mlocked and pinned
> memory combined against rlimit?  Thanks,

PeterZ posted an RFC that addresses this point[1].  It kept pinned_vm and
locked_vm accounting separate, but allowed the two to be added safely to be
compared against RLIMIT_MEMLOCK.

Anyway, until some solution is agreed on, are there objections to converting
locked_vm to an atomic, to avoid user-visible changes, instead of switching
locked_vm users to pinned_vm?

Daniel

[1] http://lkml.kernel.org/r/20130524140114.GK23650@twins.programming.kicks-ass.net
