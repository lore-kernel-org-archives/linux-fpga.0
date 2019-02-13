Return-Path: <SRS0=i9uM=QU=intel.com=ira.weiny@kernel.org>
Return-Path: <SRS0=i9uM=QU=intel.com=ira.weiny@kernel.org>
Date: Wed, 13 Feb 2019 15:52:01 -0800
From: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH V2 3/7] mm/gup: Change GUP fast to use flags rather than
 a write 'bool'
Message-ID: <20190213235200.GA1151@iweiny-DESK2.sc.intel.com>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190213230455.5605-1-ira.weiny@intel.com>
 <20190213230455.5605-4-ira.weiny@intel.com>
 <20190213231110.GD24692@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213231110.GD24692@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, kvm@vger.kernel.org, linux-fpga@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, linux-scsi@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-fbdev@vger.kernel.org, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-mm@kvack.org, ceph-devel@vger.kernel.org, rds-devel@oss.oracle.com, John Hubbard <jhubbard@nvidia.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>, Wu Hao <hao.wu@intel.com>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Christian Benvenuti <benve@cisco.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Rob Springer <rspringer@google.com>, Todd Poynor <toddpoynor@google.com>, Ben Chan <benchan@chromium.org>, Jens Wiklander <jens.wiklander@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stefano Stabellini <sstabellini@kernel.org>, Martin Brandenburg <martin@omnibond.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Feb 13, 2019 at 04:11:10PM -0700, Jason Gunthorpe wrote:
> On Wed, Feb 13, 2019 at 03:04:51PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > To facilitate additional options to get_user_pages_fast() change the
> > singular write parameter to be gup_flags.
> 
> So now we have:
> 
> long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> 		    struct page **pages, unsigned int gup_flags);
> 
> and 
> 
> int get_user_pages_fast(unsigned long start, int nr_pages,
> 			unsigned int gup_flags, struct page **pages)
> 
> Does this make any sense? At least the arguments should be in the same
> order, I think.

Yes...  and no.  see below.

> 
> Also this comment:
> /*
>  * get_user_pages_unlocked() is suitable to replace the form:
>  *
>  *      down_read(&mm->mmap_sem);
>  *      get_user_pages(tsk, mm, ..., pages, NULL);
>  *      up_read(&mm->mmap_sem);
>  *
>  *  with:
>  *
>  *      get_user_pages_unlocked(tsk, mm, ..., pages);
>  *
>  * It is functionally equivalent to get_user_pages_fast so
>  * get_user_pages_fast should be used instead if specific gup_flags
>  * (e.g. FOLL_FORCE) are not required.
>  */
> 
> Needs some attention as the recommendation is now nonsense.

IMO they are not functionally equivalent.

We can't remove *_unlocked() as it is used as both a helper for the arch
specific *_fast() calls, _and_ in drivers.  Again I don't know the history here
but it could be that the drivers should never have used the call in the first
place???  Or been converted at some point?

I could change the comment to be something like

/*
 * get_user_pages_unlocked() is only to be used by arch specific
 * get_user_pages_fast() calls.  Drivers should be calling
 * get_user_pages_fast()
 */

Instead of the current comment.

And change the drivers to get_user_pages_fast().

However, I'm not sure if these drivers need the FOLL_TOUCH flag which
*_unlocked() adds for them.  And adding FOLL_TOUCH to *_fast() is not going to
give the same functionality.

It _looks_ like we can add FOLL_TOUCH functionality to the fast path in the
generic code.  I'm not sure about the arch's.

If we did that then we can have those drivers use FOLL_TOUCH or not in *_fast()
if they want/need.

> 
> Honestly a proper explanation of why two functions exist would be
> great at this point :)

I've not researched it.  I do agree that there seems to be a lot of calls in
this file and the differences are subtle.

Ira

> 
> Jason
