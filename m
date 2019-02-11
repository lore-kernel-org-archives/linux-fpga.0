Return-Path: <SRS0=TnkL=QS=ziepe.ca=jgg@kernel.org>
Return-Path: <SRS0=TnkL=QS=ziepe.ca=jgg@kernel.org>
Date: Mon, 11 Feb 2019 15:54:47 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190211225447.GN24692@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Feb 11, 2019 at 05:44:32PM -0500, Daniel Jordan wrote:
> Hi,
> 
> This series converts users that account pinned pages with locked_vm to
> account with pinned_vm instead, pinned_vm being the correct counter to
> use.  It's based on a similar patch I posted recently[0].
> 
> The patches are based on rdma/for-next to build on Davidlohr Bueso's
> recent conversion of pinned_vm to an atomic64_t[1].  Seems to make some
> sense for these to be routed the same way, despite lack of rdma content?

Oy.. I'd be willing to accumulate a branch with acks to send to Linus
*separately* from RDMA to Linus, but this is very abnormal.

Better to wait a few weeks for -rc1 and send patches through the
subsystem trees.

> All five of these places, and probably some of Davidlohr's conversions,
> probably want to be collapsed into a common helper in the core mm for
> accounting pinned pages.  I tried, and there are several details that
> likely need discussion, so this can be done as a follow-on.

I've wondered the same..

Jason
