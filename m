Return-Path: <SRS0=XtSj=SE=stgolabs.net=dave@kernel.org>
Return-Path: <SRS0=XtSj=SE=stgolabs.net=dave@kernel.org>
Date: Tue, 2 Apr 2019 16:43:57 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-ID: <20190402234357.tn3tik4r7k6nbrau@linux-r8p5>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-2-daniel.m.jordan@oracle.com>
 <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Lameter <cl@linux.com>, Michael Ellerman <mpe@ellerman.id.au>, Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, 02 Apr 2019, Andrew Morton wrote:

>Also, we didn't remove any down_write(mmap_sem)s from core code so I'm
>thinking that the benefit of removing a few mmap_sem-takings from a few
>obscure drivers (sorry ;)) is pretty small.

afaik porting the remaining incorrect users of locked_vm to pinned_vm was
the next step before this one, which made converting locked_vm to atomic
hardly worth it. Daniel?

Thanks,
Davidlohr
