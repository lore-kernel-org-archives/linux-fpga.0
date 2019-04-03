Return-Path: <SRS0=h039=SF=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=h039=SF=oracle.com=daniel.m.jordan@kernel.org>
Date: Wed, 3 Apr 2019 12:07:02 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-ID: <20190403160702.uevv74wajpqtggo7@ca-dmjordan1.us.oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-2-daniel.m.jordan@oracle.com>
 <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
 <20190402234357.tn3tik4r7k6nbrau@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402234357.tn3tik4r7k6nbrau@linux-r8p5>
To: Andrew Morton <akpm@linux-foundation.org>, Daniel Jordan <daniel.m.jordan@oracle.com>, Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Lameter <cl@linux.com>, Michael Ellerman <mpe@ellerman.id.au>, Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Apr 02, 2019 at 04:43:57PM -0700, Davidlohr Bueso wrote:
> On Tue, 02 Apr 2019, Andrew Morton wrote:
> 
> > Also, we didn't remove any down_write(mmap_sem)s from core code so I'm
> > thinking that the benefit of removing a few mmap_sem-takings from a few
> > obscure drivers (sorry ;)) is pretty small.
> 
> afaik porting the remaining incorrect users of locked_vm to pinned_vm was
> the next step before this one, which made converting locked_vm to atomic
> hardly worth it. Daniel?
 
Right, as you know I tried those incorrect users first, but there were concerns
about user-visible changes regarding RLIMIT_MEMLOCK and pinned_vm/locked_vm
without the accounting problem between all three being solved.

To my knowledge no one has a solution for that, so in the meantime I'm taking
the incremental step of getting rid of mmap_sem for locked_vm users.  The
locked_vm -> pinned_vm conversion can happen later.
