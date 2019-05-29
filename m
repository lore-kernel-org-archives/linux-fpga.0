Return-Path: <SRS0=UGkj=T5=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=UGkj=T5=oracle.com=daniel.m.jordan@kernel.org>
Date: Wed, 29 May 2019 14:35:59 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v2] mm: add account_locked_vm utility function
Message-ID: <20190529183559.jzkpvbdiimnp3n2m@ca-dmjordan1.us.oracle.com>
References: <de375582-2c35-8e8a-4737-c816052a8e58@ozlabs.ru>
 <20190524175045.26897-1-daniel.m.jordan@oracle.com>
 <20190529180547.GA16182@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529180547.GA16182@iweiny-DESK2.sc.intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Alan Tull <atull@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Lameter <cl@linux.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Davidlohr Bueso <dave@stgolabs.net>, Jason Gunthorpe <jgg@mellanox.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Steve Sistare <steven.sistare@oracle.com>, Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, May 29, 2019 at 11:05:48AM -0700, Ira Weiny wrote:
> On Fri, May 24, 2019 at 01:50:45PM -0400, Daniel Jordan wrote:
> > +static inline int account_locked_vm(struct mm_struct *mm, unsigned long pages,
> > +				    bool inc)
> > +{
> > +	int ret;
> > +
> > +	if (pages == 0 || !mm)
> > +		return 0;
> > +
> > +	down_write(&mm->mmap_sem);
> > +	ret = __account_locked_vm(mm, pages, inc, current,
> > +				  capable(CAP_IPC_LOCK));
> > +	up_write(&mm->mmap_sem);
> > +
> > +	return ret;
> > +}
> > +
...snip...
> > +/**
> > + * __account_locked_vm - account locked pages to an mm's locked_vm
> > + * @mm:          mm to account against, may be NULL
> 
> This kernel doc is wrong.  You dereference mm straight away...
...snip...
> > +
> > +	locked_vm = mm->locked_vm;
> 
> here...
> 
> Perhaps the comment was meant to document account_locked_vm()?

Yes, the comment got out of sync when I moved the !mm check outside
__account_locked_vm.  Thanks for catching, will fix.
