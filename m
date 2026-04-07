Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619B3B8BDC
	for <linux-fpga@vger.kernel.org>; Tue,  7 Apr 2026 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571484; cv=none; b=lME9WN1iM6X0JdMF+hm1Rnae2rsjLkCafn9wCUtWlDmkOdO9mJZNWaqnI3DwDlEG7Zq9I6RYw1y7zhIWEn1nHwxEdHvEKLCurfSEXGrnt0G2GQVeeW0YdAZxcFbMIA86J/unbbQcYtUzL6pu8Y1jQJfN1s2vfmVRHqiKlRXDuSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571484; c=relaxed/simple;
	bh=W/Y2moVCx0pFV/yNmF0z4KZzsa7aIha3IhcxjDNS368=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emF0KCoZZFbjmuBJLpg8VgcrgSMkl6Ta3ABCBTVC4YgP19HGLR+BoCbe2J65FKYuRgOUim//7x8zTV7GIZOek6MX1eZZ/uso4zrO8rsl8MliZsxEJR66C75O+FaYbqCBNbGc+0+iUfzOMLGhNAuiz44FnZI2NXwbd006mN1xMFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHeivRhH; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHeivRhH"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56ee0e0305cso937773e0c.2
        for <linux-fpga@vger.kernel.org>; Tue, 07 Apr 2026 07:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775571482; x=1776176282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0LRSDzC6gu/OoHknNvEWw02qs0lg4F1CkzYCQMjH1Q=;
        b=RHeivRhH45Nl1xLuTMBJ/UeyXZrz+y/PvHjO4U00dQhNswmSdS7crnas1B/TWa7zng
         a96uCJhPCO87SfCiD0MhPnv1haGVXeSMOtjBtFqYbg7EEiDB4P2wdfYdINuT2DVn4h7k
         KNWcC1fUX7M4CIed3vbZuZIYZ+LnIEV4V6DfAA86L++lwTtWb/uSVgHR8ukMXENf0q5e
         XWw44ZW5A7iJOrg7geECVnSznB82lt/7MMpfXoQZw0IYHfRRLMHSTh6/ohdIA2v073nY
         qDaUn6OFeaibx8VUOmWewtdQKbhRq5+z5HtxWr+HiFoSa49oiuuxO/V4y0JOAyoVDez0
         gFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775571482; x=1776176282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0LRSDzC6gu/OoHknNvEWw02qs0lg4F1CkzYCQMjH1Q=;
        b=AuaH4KKO/McsvlSEXUBto8wv4mvGe5ZDv9xgZbKg38sXlJQWXcCYWzA8C3HHZ/NczU
         fXt2ru/1D/xMOPQepkftagW1h2vU4NA3SPf32SzheT+Jfw8u26e14vry1E62Hz+VAxoj
         mmjyfKqhvixMgU2SZe5x6utB7Sc1MXxeIHI3yeeiVNL9lf6w6DzwPpz6NhiFujWIntEO
         nSqXvHh27pJkkETyRVF6CxzeJN3tX3EHgg0yIxYT/UYUc3iYFBVcfs5tUDaUdA2eTmc2
         wvhg0ZdYkd5+e7YJ1+8CJ0Y7M6k4yGyZL/C9Bm9P2j9gAURk0tneyb0QdqpyMjwuOS2l
         v50w==
X-Gm-Message-State: AOJu0Yy6qUQx8ZIoyez+j+HWC3Bq6aWPqv4UM8mlbSbqpubAj59qNuZC
	aZg/84d01FhilYchBYA9EGT9Jbx/FcSnMf0SwEBlvTuPdgL3bi0gGouAfGEhkyomAxLJag==
X-Gm-Gg: AeBDieuq41E6ytkfiDti2XnqU39XqOg8qrBbmtkTW8+8pPNqt7t27sOG+1PFbVNLRMJ
	Ch2vebSPs31OUtDfh0d1XUusyuKKdFUBtRluIxigKHm92eOkAMmuNnwk5qjNZk6mxHG6OulnwYm
	eq1r5fx9fapmH6riYt1KUkeh1e5AOhkU5CgESzkV5LRXDgZysZAWlpjKmzHexVU4B3sHkFKz8qn
	fxE2N0IViAm64QOi1zPOlpE0jmc2MR+6KG/wdVNodaqO2ul6sJ3yqw6H9dvjkzb6YWY4GJjxppl
	UcDE27xt0Ib1+GrwZcT67tOhg5vuYK5Wv0k6qO1Le4U5VznLrU3r6kNRVNXuwbolYIxMufX+UNy
	YZ/eGeaM4zFZceetmbsur6pcfaJGD1tg6F9zEHXhMmt/OCrbVaw211sCkmOPFLHpZ576Nz7+8Pv
	XRLIBqxy9HsA0oENIWWZ0BdFiE
X-Received: by 2002:a05:6122:4893:b0:56d:7b2e:89a1 with SMTP id 71dfb90a1353d-56dab86455amr5676845e0c.4.1775571478262;
        Tue, 07 Apr 2026 07:17:58 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6d8:aa::11:1b5])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bd0a8a3sm19673793e0c.17.2026.04.07.07.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:17:57 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: gregkh@linuxfoundation.org,
	yilun.xu@linux.intel.com
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v3 2/3] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Tue,  7 Apr 2026 08:17:35 -0600
Message-ID: <20260407141735.17394-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402125446.3776153-2-sebasjosue84@gmail.com>
References: <20260402125446.3776153-2-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

afu_ioctl_dma_map() accepts a 64-bit length from userspace via
DFL_FPGA_PORT_DMA_MAP ioctl without an upper bound check. The value
is passed to afu_dma_pin_pages() where npages is derived as
length >> PAGE_SHIFT and passed to pin_user_pages_fast() which takes
int nr_pages, causing implicit truncation if length is very large.

Validate map.length at the ioctl entry point before calling
afu_dma_map_region(), rejecting values whose page count exceeds
INT_MAX.

Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v3:
  - Move the upper-bound check on map.length to afu_ioctl_dma_map()
    at the ioctl entry point, before crossing the userspace/kernel
    boundary, instead of deep in afu_dma_pin_pages(). Revert changes
    to dfl-afu-dma-region.c from v1/v2.
    Suggested by Greg Kroah-Hartman.
Changes in v2:
  - Added cap at INT_MAX in afu_dma_pin_pages() (superseded by v3).
---
 drivers/fpga/dfl-afu-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 3bf8e73..097a97e 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -723,6 +723,9 @@ afu_ioctl_dma_map(struct dfl_feature_dev_data *fdata, void __user *arg)
 	if (map.argsz < minsz || map.flags)
 		return -EINVAL;
 
+	if (map.length >> PAGE_SHIFT > (u64)INT_MAX)
+		return -EINVAL;
+
 	ret = afu_dma_map_region(fdata, map.user_addr, map.length, &map.iova);
 	if (ret)
 		return ret;
-- 
2.43.0

