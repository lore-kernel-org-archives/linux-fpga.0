Return-Path: <SRS0=OUfI=SN=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=OUfI=SN=oracle.com=daniel.m.jordan@kernel.org>
Date: Thu, 11 Apr 2019 16:28:07 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-ID: <20190411202807.q2fge33uoduhtehq@ca-dmjordan1.us.oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-2-daniel.m.jordan@oracle.com>
 <614ea07a-dd1e-2561-b6f4-2d698bf55f5b@ozlabs.ru>
 <20190411095543.GA55197@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411095543.GA55197@lakrids.cambridge.arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Daniel Jordan <daniel.m.jordan@oracle.com>, akpm@linux-foundation.org, Alan Tull <atull@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Lameter <cl@linux.com>, Davidlohr Bueso <dave@stgolabs.net>, Michael Ellerman <mpe@ellerman.id.au>, Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Apr 11, 2019 at 10:55:43AM +0100, Mark Rutland wrote:
> On Thu, Apr 11, 2019 at 02:22:23PM +1000, Alexey Kardashevskiy wrote:
> > On 03/04/2019 07:41, Daniel Jordan wrote:
> 
> > > -	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
> > > +	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %lld/%lu%s\n", current->pid,
> > >  		incr ? '+' : '-', npages << PAGE_SHIFT,
> > > -		current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
> > > -		ret ? "- exceeded" : "");
> > > +		(s64)atomic64_read(&current->mm->locked_vm) << PAGE_SHIFT,
> > > +		rlimit(RLIMIT_MEMLOCK), ret ? "- exceeded" : "");
> > 
> > 
> > 
> > atomic64_read() returns "long" which matches "%ld", why this change (and
> > similar below)? You did not do this in the two pr_debug()s above anyway.
> 
> Unfortunately, architectures return inconsistent types for atomic64 ops.
> 
> Some return long (e..g. powerpc), some return long long (e.g. arc), and
> some return s64 (e.g. x86).

Yes, Mark said it all, I'm just chiming in to confirm that's why I added the
cast.

Btw, thanks for doing this, Mark.
