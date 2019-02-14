Return-Path: <SRS0=/3vN=QV=ziepe.ca=jgg@kernel.org>
Return-Path: <SRS0=/3vN=QV=ziepe.ca=jgg@kernel.org>
Date: Thu, 14 Feb 2019 15:16:29 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190214221629.GD1739@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211225447.GN24692@ziepe.ca>
 <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
 <20190214060006.GE24692@ziepe.ca>
 <20190214193352.GA7512@iweiny-DESK2.sc.intel.com>
 <20190214201231.GC1739@ziepe.ca>
 <20190214214650.GB7512@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214214650.GB7512@iweiny-DESK2.sc.intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Feb 14, 2019 at 01:46:51PM -0800, Ira Weiny wrote:

> > > > Really unclear how to fix this. The pinned/locked split with two
> > > > buckets may be the right way.
> > > 
> > > Are you suggesting that we have 2 user limits?
> > 
> > This is what RDMA has done since CL's patch.
> 
> I don't understand?  What is the other _user_ limit (other than
> RLIMIT_MEMLOCK)?

With todays implementation RLIMIT_MEMLOCK covers two user limits,
total number of pinned pages and total number of mlocked pages. The
two are different buckets and not summed.

Jason
