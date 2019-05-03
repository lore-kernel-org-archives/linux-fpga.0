Return-Path: <SRS0=Y2C3=TD=mellanox.com=jgg@kernel.org>
Return-Path: <SRS0=Y2C3=TD=mellanox.com=jgg@kernel.org>
From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH] mm: add account_locked_vm utility function
Date: Fri, 3 May 2019 23:28:22 +0000
Message-ID: <20190503232818.GA5182@mellanox.com>
References: <20190503201629.20512-1-daniel.m.jordan@oracle.com>
In-Reply-To: <20190503201629.20512-1-daniel.m.jordan@oracle.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6BC684B50DAD6D4A8D031B0B8F7E32C4@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Lameter <cl@linux.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Davidlohr Bueso <dave@stgolabs.net>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Steve Sistare <steven.sistare@oracle.com>, Wu Hao <hao.wu@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, May 03, 2019 at 01:16:30PM -0700, Daniel Jordan wrote:
> locked_vm accounting is done roughly the same way in five places, so
> unify them in a helper.  Standardize the debug prints, which vary
> slightly.  Error codes stay the same, so user-visible behavior does too.
>=20
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Steve Sistare <steven.sistare@oracle.com>
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: linux-mm@kvack.org
> Cc: kvm@vger.kernel.org
> Cc: kvm-ppc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-fpga@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>=20
> Based on v5.1-rc7.  Tested with the vfio type1 driver.  Any feedback
> welcome.
>=20
> Andrew, this one patch replaces these six from [1]:
>=20
>     mm-change-locked_vms-type-from-unsigned-long-to-atomic64_t.patch
>     vfio-type1-drop-mmap_sem-now-that-locked_vm-is-atomic.patch
>     vfio-spapr_tce-drop-mmap_sem-now-that-locked_vm-is-atomic.patch
>     fpga-dlf-afu-drop-mmap_sem-now-that-locked_vm-is-atomic.patch
>     kvm-book3s-drop-mmap_sem-now-that-locked_vm-is-atomic.patch
>     powerpc-mmu-drop-mmap_sem-now-that-locked_vm-is-atomic.patch
>=20
> That series converts locked_vm to an atomic, but on closer inspection cau=
ses at
> least one accounting race in mremap, and fixing it just for this type
> conversion came with too much ugly in the core mm to justify, especially =
when
> the right long-term fix is making these drivers use pinned_vm instead.

Did we ever decide what to do here? Should all these drivers be
switched to pinned_vm anyhow?

Jason
