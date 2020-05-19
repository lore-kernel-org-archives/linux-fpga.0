Return-Path: <SRS0=mLS4=7B=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=mLS4=7B=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2923 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESUOv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 19 May 2020 16:14:51 -0400
From: John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2] fpga: dfl: afu: convert get_user_pages() --> pin_user_pages()
Date: Tue, 19 May 2020 13:14:49 -0700
Message-ID: <20200519201449.3136033-1-jhubbard@nvidia.com>
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

Changes since v1:

Changed the label from "put_pages", to "unpin_pages".

thanks,
John Hubbard
NVIDIA
=20
 drivers/fpga/dfl-afu-dma-region.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-r=
egion.c
index 62f924489db5..a31dd3a7e581 100644
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
@@ -57,11 +48,11 @@ static int afu_dma_pin_pages(struct dfl_feature_platfor=
m_data *pdata,
 		goto unlock_vm;
 	}
=20
-	pinned =3D get_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
+	pinned =3D pin_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
 				     region->pages);
 	if (pinned < 0) {
 		ret =3D pinned;
-		goto put_pages;
+		goto unpin_pages;
 	} else if (pinned !=3D npages) {
 		ret =3D -EFAULT;
 		goto free_pages;
@@ -71,8 +62,8 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_=
data *pdata,
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
