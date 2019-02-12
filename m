Return-Path: <SRS0=oQeA=QT=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=oQeA=QT=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from a9-35.smtp-out.amazonses.com ([54.240.9.35]:55606 "EHLO
        a9-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729078AbfBLQuM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 12 Feb 2019 11:50:12 -0500
Date: Tue, 12 Feb 2019 16:50:11 +0000
From: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH 2/5] vfio/spapr_tce: use pinned_vm instead of locked_vm
 to account pinned pages
In-Reply-To: <ee4d14db-05c3-6208-503c-16e287fa78eb@ozlabs.ru>
Message-ID: <01000168e29daf0a-cb3a9394-e3dd-4d88-ad3c-31df1f9ec052-000000@email.amazonses.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com> <20190211224437.25267-3-daniel.m.jordan@oracle.com> <ee4d14db-05c3-6208-503c-16e287fa78eb@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, jgg@ziepe.ca, akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz, linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com, atull@kernel.org, mdf@kernel.org

On Tue, 12 Feb 2019, Alexey Kardashevskiy wrote:

> Now it is 3 independent accesses (actually 4 but the last one is
> diagnostic) with no locking around them. Why do not we need a lock
> anymore precisely? Thanks,

Updating a regular counter is racy and requires a lock. It was converted
to be an atomic which can be incremented without a race.
