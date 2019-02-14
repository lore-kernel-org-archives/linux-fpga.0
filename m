Return-Path: <SRS0=/3vN=QV=ziepe.ca=jgg@kernel.org>
Return-Path: <SRS0=/3vN=QV=ziepe.ca=jgg@kernel.org>
Date: Wed, 13 Feb 2019 23:00:06 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190214060006.GE24692@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211225447.GN24692@ziepe.ca>
 <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Feb 13, 2019 at 05:53:14PM -0800, Ira Weiny wrote:
> On Mon, Feb 11, 2019 at 03:54:47PM -0700, Jason Gunthorpe wrote:
> > On Mon, Feb 11, 2019 at 05:44:32PM -0500, Daniel Jordan wrote:
> > 
> > > All five of these places, and probably some of Davidlohr's conversions,
> > > probably want to be collapsed into a common helper in the core mm for
> > > accounting pinned pages.  I tried, and there are several details that
> > > likely need discussion, so this can be done as a follow-on.
> > 
> > I've wondered the same..
> 
> I'm really thinking this would be a nice way to ensure it gets cleaned up and
> does not happen again.
> 
> Also, by moving it to the core we could better manage any user visible changes.
> 
> From a high level, pinned is a subset of locked so it seems like we need a 2
> sets of helpers.
> 
> try_increment_locked_vm(...)
> decrement_locked_vm(...)
> 
> try_increment_pinned_vm(...)
> decrement_pinned_vm(...)
> 
> Where try_increment_pinned_vm() also increments locked_vm...  Of course this
> may end up reverting the improvement of Davidlohr  Bueso's atomic work...  :-(
> 
> Furthermore it would seem better (although I don't know if at all possible) if
> this were accounted for in core calls which tracked them based on how the pages
> are being used so that drivers can't call try_increment_locked_vm() and then
> pin the pages...  Thus getting the account wrong vs what actually happened.
> 
> And then in the end we can go back to locked_vm being the value checked against
> RLIMIT_MEMLOCK.

Someone would need to understand the bug that was fixed by splitting
them. 

I think it had to do with double accounting pinned and mlocked pages
and thus delivering a lower than expected limit to userspace.

vfio has this bug, RDMA does not. RDMA has a bug where it can
overallocate locked memory, vfio doesn't.

Really unclear how to fix this. The pinned/locked split with two
buckets may be the right way.

Jason
