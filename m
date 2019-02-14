Return-Path: <SRS0=Lrc3=QV=intel.com=ira.weiny@kernel.org>
Return-Path: <SRS0=Lrc3=QV=intel.com=ira.weiny@kernel.org>
Date: Wed, 13 Feb 2019 17:53:14 -0800
From: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211225447.GN24692@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211225447.GN24692@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Feb 11, 2019 at 03:54:47PM -0700, Jason Gunthorpe wrote:
> On Mon, Feb 11, 2019 at 05:44:32PM -0500, Daniel Jordan wrote:
> 
> > All five of these places, and probably some of Davidlohr's conversions,
> > probably want to be collapsed into a common helper in the core mm for
> > accounting pinned pages.  I tried, and there are several details that
> > likely need discussion, so this can be done as a follow-on.
> 
> I've wondered the same..

I'm really thinking this would be a nice way to ensure it gets cleaned up and
does not happen again.

Also, by moving it to the core we could better manage any user visible changes.

From a high level, pinned is a subset of locked so it seems like we need a 2
sets of helpers.

try_increment_locked_vm(...)
decrement_locked_vm(...)

try_increment_pinned_vm(...)
decrement_pinned_vm(...)

Where try_increment_pinned_vm() also increments locked_vm...  Of course this
may end up reverting the improvement of Davidlohr  Bueso's atomic work...  :-(

Furthermore it would seem better (although I don't know if at all possible) if
this were accounted for in core calls which tracked them based on how the pages
are being used so that drivers can't call try_increment_locked_vm() and then
pin the pages...  Thus getting the account wrong vs what actually happened.

And then in the end we can go back to locked_vm being the value checked against
RLIMIT_MEMLOCK.

Ira
