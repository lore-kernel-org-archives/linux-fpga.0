Return-Path: <akpm@linux-foundation.org>
Return-Path: <akpm@linux-foundation.org>
Date: Tue, 2 Apr 2019 15:04:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-Id: <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
In-Reply-To: <20190402204158.27582-2-daniel.m.jordan@oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
	<20190402204158.27582-2-daniel.m.jordan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Lameter <cl@linux.com>, Davidlohr Bueso <dave@stgolabs.net>, Michael Ellerman <mpe@ellerman.id.au>, Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue,  2 Apr 2019 16:41:53 -0400 Daniel Jordan <daniel.m.jordan@oracle.com> wrote:

> Taking and dropping mmap_sem to modify a single counter, locked_vm, is
> overkill when the counter could be synchronized separately.
> 
> Make mmap_sem a little less coarse by changing locked_vm to an atomic,
> the 64-bit variety to avoid issues with overflow on 32-bit systems.
> 
> ...
>
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -59,32 +59,34 @@ static unsigned long kvmppc_stt_pages(unsigned long tce_pages)
>  static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
>  {
>  	long ret = 0;
> +	s64 locked_vm;
>  
>  	if (!current || !current->mm)
>  		return ret; /* process exited */
>  
>  	down_write(&current->mm->mmap_sem);
>  
> +	locked_vm = atomic64_read(&current->mm->locked_vm);
>  	if (inc) {
>  		unsigned long locked, lock_limit;
>  
> -		locked = current->mm->locked_vm + stt_pages;
> +		locked = locked_vm + stt_pages;
>  		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
>  			ret = -ENOMEM;
>  		else
> -			current->mm->locked_vm += stt_pages;
> +			atomic64_add(stt_pages, &current->mm->locked_vm);
>  	} else {
> -		if (WARN_ON_ONCE(stt_pages > current->mm->locked_vm))
> -			stt_pages = current->mm->locked_vm;
> +		if (WARN_ON_ONCE(stt_pages > locked_vm))
> +			stt_pages = locked_vm;
>  
> -		current->mm->locked_vm -= stt_pages;
> +		atomic64_sub(stt_pages, &current->mm->locked_vm);
>  	}

With the current code, current->mm->locked_vm cannot go negative. 
After the patch, it can go negative.  If someone else decreased
current->mm->locked_vm between this function's atomic64_read() and
atomic64_sub().

I guess this is a can't-happen in this case because the racing code
which performed the modification would have taken it negative anyway.

But this all makes me rather queazy.


Also, we didn't remove any down_write(mmap_sem)s from core code so I'm
thinking that the benefit of removing a few mmap_sem-takings from a few
obscure drivers (sorry ;)) is pretty small.


Also, the argument for switching 32-bit arches to a 64-bit counter was
suspiciously vague.  What overflow issues?  Or are we just being lazy?
