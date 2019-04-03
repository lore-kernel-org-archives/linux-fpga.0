Return-Path: <SRS0=h039=SF=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=h039=SF=oracle.com=daniel.m.jordan@kernel.org>
Date: Wed, 3 Apr 2019 12:09:03 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-ID: <20190403160903.5so4okn3ha2tvob3@ca-dmjordan1.us.oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-2-daniel.m.jordan@oracle.com>
 <4140911c-8193-010b-e8fc-c8b24ffdf423@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4140911c-8193-010b-e8fc-c8b24ffdf423@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, akpm@linux-foundation.org, Davidlohr Bueso <dave@stgolabs.net>, kvm@vger.kernel.org, Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-mm@kvack.org, Alex Williamson <alex.williamson@redhat.com>, Moritz Fischer <mdf@kernel.org>, Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org, Wu Hao <hao.wu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Apr 03, 2019 at 06:46:07AM +0200, Christophe Leroy wrote:
> 
> 
> Le 02/04/2019 � 22:41, Daniel Jordan a �crit�:
> > Taking and dropping mmap_sem to modify a single counter, locked_vm, is
> > overkill when the counter could be synchronized separately.
> > 
> > Make mmap_sem a little less coarse by changing locked_vm to an atomic,
> > the 64-bit variety to avoid issues with overflow on 32-bit systems.
> 
> Can you elaborate on the above ? Previously it was 'unsigned long', what
> were the issues ?

Sure, I responded to this in another thread from this series.

> If there was such issues, shouldn't there be a first patch
> moving it from unsigned long to u64 before this atomic64_t change ? Or at
> least it should be clearly explain here what the issues are and how
> switching to a 64 bit counter fixes them.

Yes, I can explain the motivation in the next version.
