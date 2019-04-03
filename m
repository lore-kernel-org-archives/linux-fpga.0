Return-Path: <SRS0=h039=SF=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=h039=SF=oracle.com=daniel.m.jordan@kernel.org>
Date: Wed, 3 Apr 2019 12:52:57 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 0/6] convert locked_vm from unsigned long to atomic64_t
Message-ID: <20190403165257.prekuppqbcempuxo@ca-dmjordan1.us.oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <abe31bae-1bdf-b763-c4d1-5e4ea2ccda13@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abe31bae-1bdf-b763-c4d1-5e4ea2ccda13@oracle.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, akpm@linux-foundation.org, linux_lkml_grp@oracle.com, Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Lameter <cl@linux.com>, Davidlohr Bueso <dave@stgolabs.net>, Michael Ellerman <mpe@ellerman.id.au>, Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Apr 03, 2019 at 08:51:13AM -0400, Steven Sistare wrote:
> On 4/2/2019 4:41 PM, Daniel Jordan wrote:
> > [1] https://lore.kernel.org/linux-mm/20190211224437.25267-1-daniel.m.jordan@oracle.com/
> 
>   You could clean all 6 patches up nicely with a common subroutine that
> increases locked_vm subject to the rlimit.  Pass a bool arg that is true if
> the  limit should be enforced, !dma->lock_cap for one call site, and
> !capable(CAP_IPC_LOCK) for the rest.  Push the warnings and debug statements
> to the subroutine as well.  One patch could refactor, and a second could
> change the locking method.

Yes, I tried writing, but didn't end up including, such a subroutine for [1].
The devil was in the details, but with the cmpxchg business, it's more
worthwhile to iron all those out.  I'll give it a try.
