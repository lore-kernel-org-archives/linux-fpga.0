Return-Path: <SRS0=WpWf=QV=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=WpWf=QV=oracle.com=daniel.m.jordan@kernel.org>
Date: Wed, 13 Feb 2019 20:46:34 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/5] vfio/type1: use pinned_vm instead of locked_vm to
 account pinned pages
Message-ID: <20190214014634.kxjiwzelczlskeo6@ca-dmjordan1.us.oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-2-daniel.m.jordan@oracle.com>
 <20190211225620.GO24692@ziepe.ca>
 <20190211231152.qflff6g2asmkb6hr@ca-dmjordan1.us.oracle.com>
 <20190212114110.17bc8a14@w520.home>
 <20190213002650.kav7xc4r2xs5f3ef@ca-dmjordan1.us.oracle.com>
 <20190213130330.76ef1987@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213130330.76ef1987@w520.home>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>, akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru, peterz@infradead.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Feb 13, 2019 at 01:03:30PM -0700, Alex Williamson wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> > On Tue, Feb 12, 2019 at 11:41:10AM -0700, Alex Williamson wrote:
> > > This still makes me nervous because we have userspace dependencies on
> > > setting process locked memory.  
> > 
> > Could you please expand on this?  Trying to get more context.
> 
> VFIO is a userspace driver interface and the pinned/locked page
> accounting we're doing here is trying to prevent a user from exceeding
> their locked memory limits.  Thus a VM management tool or unprivileged
> userspace driver needs to have appropriate locked memory limits
> configured for their use case.  Currently we do not have a unified
> accounting scheme, so if a page is mlock'd by the user and also mapped
> through VFIO for DMA, it's accounted twice, these both increment
> locked_vm and userspace needs to manage that.  If pinned memory
> and locked memory are now two separate buckets and we're only comparing
> one of them against the locked memory limit, then it seems we have
> effectively doubled the user's locked memory for this use case, as
> Jason questioned.  The user could mlock one page and DMA map another,
> they're both "locked", but now they only take one slot in each bucket.

Right, yes.  Should have been more specific.  I was after a concrete use case
where this would happen (sounded like you may have had a specific tool in
mind).

But it doesn't matter.  I understand your concern and agree that, given the
possibility that accounting in _some_ tool can be affected, we should fix
accounting before changing user visible behavior.  I can start a separate
discussion, having opened the can of worms again :)

> If we continue forward with using a separate bucket here, userspace
> could infer that accounting is unified and lower the user's locked
> memory limit, or exploit the gap that their effective limit might
> actually exceed system memory.  In the former case, if we do eventually
> correct to compare the total of the combined buckets against the user's
> locked memory limits, we'll break users that have adapted their locked
> memory limits to meet the apparent needs.  In the latter case, the
> inconsistent accounting is potentially an attack vector.

Makes sense.

> > > There's a user visible difference if we
> > > account for them in the same bucket vs separate.  Perhaps we're
> > > counting in the wrong bucket now, but if we "fix" that and userspace
> > > adapts, how do we ever go back to accounting both mlocked and pinned
> > > memory combined against rlimit?  Thanks,  
> > 
> > PeterZ posted an RFC that addresses this point[1].  It kept pinned_vm and
> > locked_vm accounting separate, but allowed the two to be added safely to be
> > compared against RLIMIT_MEMLOCK.
> 
> Unless I'm incorrect in the concerns above, I don't see how we can
> convert vfio before this occurs.
>  
> > Anyway, until some solution is agreed on, are there objections to converting
> > locked_vm to an atomic, to avoid user-visible changes, instead of switching
> > locked_vm users to pinned_vm?
> 
> Seems that as long as we have separate buckets that are compared
> individually to rlimit that we've got problems, it's just a matter of
> where they're exposed based on which bucket is used for which
> interface.  Thanks,

Indeed.  But for now, any concern with simply changing the type of the
currently used counter to an atomic, to reduce mmap_sem usage?  This is just an
implementation detail, invisible to userspace.
