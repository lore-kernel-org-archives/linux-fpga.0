Return-Path: <SRS0=t8ba=QS=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=t8ba=QS=oracle.com=daniel.m.jordan@kernel.org>
Date: Mon, 11 Feb 2019 18:15:57 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190211231557.zrcq3tv7qi6lqtvo@ca-dmjordan1.us.oracle.com>
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
> > Hi,
> > 
> > This series converts users that account pinned pages with locked_vm to
> > account with pinned_vm instead, pinned_vm being the correct counter to
> > use.  It's based on a similar patch I posted recently[0].
> > 
> > The patches are based on rdma/for-next to build on Davidlohr Bueso's
> > recent conversion of pinned_vm to an atomic64_t[1].  Seems to make some
> > sense for these to be routed the same way, despite lack of rdma content?
> 
> Oy.. I'd be willing to accumulate a branch with acks to send to Linus
> *separately* from RDMA to Linus, but this is very abnormal.
> 
> Better to wait a few weeks for -rc1 and send patches through the
> subsystem trees.

Ok, I can do that.  It did seem strange, so I made it a question...
