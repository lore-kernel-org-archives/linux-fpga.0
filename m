Return-Path: <SRS0=Dhza=SY=oracle.com=daniel.m.jordan@kernel.org>
Return-Path: <SRS0=Dhza=SY=oracle.com=daniel.m.jordan@kernel.org>
Date: Mon, 22 Apr 2019 11:54:37 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-ID: <20190422155437.qppyxcbfql34ginr@ca-dmjordan1.us.oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-2-daniel.m.jordan@oracle.com>
 <614ea07a-dd1e-2561-b6f4-2d698bf55f5b@ozlabs.ru>
 <20190411095543.GA55197@lakrids.cambridge.arm.com>
 <20190411202807.q2fge33uoduhtehq@ca-dmjordan1.us.oracle.com>
 <20190416163351.5e4e075ddfad0677239fc23a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416163351.5e4e075ddfad0677239fc23a@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Mark Rutland <mark.rutland@arm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alan Tull <atull@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Lameter <cl@linux.com>, Davidlohr Bueso <dave@stgolabs.net>, Michael Ellerman <mpe@ellerman.id.au>, Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Apr 16, 2019 at 04:33:51PM -0700, Andrew Morton wrote:

Sorry for the delay, I was on vacation all last week.

> What's the status of this patchset, btw?
> 
> I have a note here that
> powerpc-mmu-drop-mmap_sem-now-that-locked_vm-is-atomic.patch is to be
> updated.

Yes, the series needs a few updates.  v2 should appear in the next day or two.
