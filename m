Return-Path: <SRS0=6hXC=QU=ziepe.ca=jgg@kernel.org>
Return-Path: <SRS0=6hXC=QU=ziepe.ca=jgg@kernel.org>
Date: Wed, 13 Feb 2019 16:07:27 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 1/5] vfio/type1: use pinned_vm instead of locked_vm to
 account pinned pages
Message-ID: <20190213230727.GC24692@ziepe.ca>
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
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru, peterz@infradead.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Feb 13, 2019 at 01:03:30PM -0700, Alex Williamson wrote:
> > PeterZ posted an RFC that addresses this point[1].  It kept pinned_vm and
> > locked_vm accounting separate, but allowed the two to be added safely to be
> > compared against RLIMIT_MEMLOCK.
> 
> Unless I'm incorrect in the concerns above, I don't see how we can
> convert vfio before this occurs.

RDMA was converted to this pinned_vm scheme a long time ago, arguably
it is a mistake that VFIO did something different... This was to fix
some other bug where reporting of pages was wrong.

You are not wrong that this approach doesn't entirely make sense
though. :)

Jason
