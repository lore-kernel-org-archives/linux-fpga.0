Return-Path: <SRS0=Lrc3=QV=intel.com=ira.weiny@kernel.org>
Return-Path: <SRS0=Lrc3=QV=intel.com=ira.weiny@kernel.org>
Date: Thu, 14 Feb 2019 13:46:51 -0800
From: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190214214650.GB7512@iweiny-DESK2.sc.intel.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211225447.GN24692@ziepe.ca>
 <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
 <20190214060006.GE24692@ziepe.ca>
 <20190214193352.GA7512@iweiny-DESK2.sc.intel.com>
 <20190214201231.GC1739@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214201231.GC1739@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Feb 14, 2019 at 01:12:31PM -0700, Jason Gunthorpe wrote:
> On Thu, Feb 14, 2019 at 11:33:53AM -0800, Ira Weiny wrote:
> 
> > > I think it had to do with double accounting pinned and mlocked pages
> > > and thus delivering a lower than expected limit to userspace.
> > > 
> > > vfio has this bug, RDMA does not. RDMA has a bug where it can
> > > overallocate locked memory, vfio doesn't.
> > 
> > Wouldn't vfio also be able to overallocate if the user had RDMA pinned pages?
> 
> Yes
>  
> > I think the problem is that if the user calls mlock on a large range then both
> > vfio and RDMA could potentially overallocate even with this fix.  This was your
> > initial email to Daniel, I think...  And Alex's concern.
> 
> Here are the possibilities
> - mlock and pin on the same pages - RDMA respects the limit, VFIO halfs it.
> - mlock and pin on different pages - RDMA doubles the limit, VFIO
>   respects it
> - VFIO and RDMA in the same process, the limit is halfed or doubled, depending.
> 
> IHMO we should make VFIO & RDMA the same, and then decide what to do
> about case #2.

I'm not against that.  Sorry if I came across that way.  For this series I
agree we should make it consistent.

> 
> > > Really unclear how to fix this. The pinned/locked split with two
> > > buckets may be the right way.
> > 
> > Are you suggesting that we have 2 user limits?
> 
> This is what RDMA has done since CL's patch.

I don't understand?  What is the other _user_ limit (other than
RLIMIT_MEMLOCK)?

> 
> It is very hard to fix as you need to track how many pages are mlocked
> *AND* pinned.

Understood. :-/

Ira

> 
> Jason
