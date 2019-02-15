Return-Path: <SRS0=am2V=QW=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=am2V=QW=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:59600 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726773AbfBOP0v (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 15 Feb 2019 10:26:51 -0500
Date: Fri, 15 Feb 2019 15:26:49 +0000
From: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
In-Reply-To: <20190214221629.GD1739@ziepe.ca>
Message-ID: <01000168f1c4718d-91714478-72d3-47cd-ae36-2d781947ebde-000000@email.amazonses.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com> <20190211225447.GN24692@ziepe.ca> <20190214015314.GB1151@iweiny-DESK2.sc.intel.com> <20190214060006.GE24692@ziepe.ca> <20190214193352.GA7512@iweiny-DESK2.sc.intel.com> <20190214201231.GC1739@ziepe.ca>
 <20190214214650.GB7512@iweiny-DESK2.sc.intel.com> <20190214221629.GD1739@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ira Weiny <ira.weiny@intel.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru

On Thu, 14 Feb 2019, Jason Gunthorpe wrote:

> On Thu, Feb 14, 2019 at 01:46:51PM -0800, Ira Weiny wrote:
>
> > > > > Really unclear how to fix this. The pinned/locked split with two
> > > > > buckets may be the right way.
> > > >
> > > > Are you suggesting that we have 2 user limits?
> > >
> > > This is what RDMA has done since CL's patch.
> >
> > I don't understand?  What is the other _user_ limit (other than
> > RLIMIT_MEMLOCK)?
>
> With todays implementation RLIMIT_MEMLOCK covers two user limits,
> total number of pinned pages and total number of mlocked pages. The
> two are different buckets and not summed.

Applications were failing at some point because they were effectively
summed up. If you mlocked/pinned a dataset of more than half the memory of
a system then things would get really weird.

Also there is the possibility of even more duplication because pages can
be pinned by multiple kernel subsystems. So you could get more than
doubling of the number.

The sane thing was to account them separately so that mlocking and
pinning worked without apps failing and then wait for another genius
to find out how to improve the situation by getting the pinned page mess
under control.

It is not even advisable to check pinned pages against any limit because
pages can be pinned by multiple subsystems.

The main problem here is that we only have a refcount to indicate pinning
and no way to clearly distinguish long term from short pins. In order to
really fix this issue we would need to have a list of subsystems that have
taken long term pins on a page. But doing so would waste a lot of memory
and cause a significant performance regression.

And the discussions here seem to be meandering around these issues.
Nothing really that convinces me that we have a clean solution at hand.
