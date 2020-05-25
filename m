Return-Path: <SRS0=jakO=7H=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=jakO=7H=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7188 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388054AbgEYWR4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 May 2020 18:17:56 -0400
From: John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3] fpga: dfl: afu: convert get_user_pages() --> pin_user_pages()
Date: Mon, 25 May 2020 15:17:54 -0700
Message-ID: <20200525221754.433023-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org

This code was using get_user_pages_fast(), in a "Case 2" scenario
(DMA/RDMA), using the categorization from [1]. That means that it's
time to convert the get_user_pages_fast() + put_page() calls to
pin_user_pages_fast() + unpin_user_pages() calls.

There is some helpful background in [2]: basically, this is a small
part of fixing a long-standing disconnect between pinning pages, and
file systems' use of those pages.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

Cc: Xu Yilun <yilun.xu@intel.com>
Cc: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

This is the same logical change as in v2, but it is applied to
char-misc-next, in order to avoid a merge problem with Souptick's
commit c9d7e3da1f3c ("fpga: dfl: afu: Corrected error handling levels <Soup=
tick Joarder>")

thanks,
John Hubbard
NVIDIA


 drivers/fpga/dfl-afu-dma-region.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-r=
egion.c
index 5942343a5d6e..0b817b722920 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -16,15 +16,6 @@
=20
 #include "dfl-afu.h"
=20
-static void put_all_pages(struct page **pages, int npages)
-{
-	int i;
-
-	for (i =3D 0; i < npages; i++)
-		if (pages[i])
-			put_page(pages[i]);
-}
-
 void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
 {
 	struct dfl_afu *afu =3D dfl_fpga_pdata_get_private(pdata);
@@ -57,22 +48,22 @@ static int afu_dma_pin_pages(struct dfl_feature_platfor=
m_data *pdata,
 		goto unlock_vm;
 	}
=20
-	pinned =3D get_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
+	pinned =3D pin_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
 				     region->pages);
 	if (pinned < 0) {
 		ret =3D pinned;
 		goto free_pages;
 	} else if (pinned !=3D npages) {
 		ret =3D -EFAULT;
-		goto put_pages;
+		goto unpin_pages;
 	}
=20
 	dev_dbg(dev, "%d pages pinned\n", pinned);
=20
 	return 0;
=20
-put_pages:
-	put_all_pages(region->pages, pinned);
+unpin_pages:
+	unpin_user_pages(region->pages, pinned);
 free_pages:
 	kfree(region->pages);
 unlock_vm:
@@ -94,7 +85,7 @@ static void afu_dma_unpin_pages(struct dfl_feature_platfo=
rm_data *pdata,
 	long npages =3D region->length >> PAGE_SHIFT;
 	struct device *dev =3D &pdata->dev->dev;
=20
-	put_all_pages(region->pages, npages);
+	unpin_user_pages(region->pages, npages);
 	kfree(region->pages);
 	account_locked_vm(current->mm, npages, false);
=20
--=20
2.26.2
