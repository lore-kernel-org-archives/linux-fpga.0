Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEBF3CEBB1
	for <linux-fpga@vger.kernel.org>; Mon,  4 May 2026 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896822; cv=none; b=O6eZSHwwNQSqjDEJtRlizitlmdhTSfAB8a0zJ8oKQDChQeMCuTTUMVqcSpBujxgTVTolKkr39JajhplEIa3Pf/LfVyrmyVWn7g7EKXiu7jQMFunKWS7E61y0RsyqbWaiZ/ydrhKloDWnLY78ZeNRB4F53QkJw5nv1QsHydw6Ksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896822; c=relaxed/simple;
	bh=Egdo5vrSXhRUuwvCP13xWBmy+e12kq8TwbonylRp/1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Obu3sCI0mKcGo5EdHZmLuqrQGh7UKCPIIIy+Oy6qnqlwXo/UMi6M3obF+tl6bc+rY7cs+BSE5pCLUMS7L7w4mI3MtvwbsyKpO3ouVIpC7qzNssVMKKtOD1yRLclk88cd6ZqznxV3NUs7tErfaGCuHwc9s4cbPSUu9bjWiVvHdw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZ8N5eNT; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ8N5eNT"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7b23713eac9so41920037b3.2
        for <linux-fpga@vger.kernel.org>; Mon, 04 May 2026 05:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777896820; x=1778501620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/70r6IqZMUzMPLl+F4JoQGxVMmdN9u1Qh2Ykml3WfQY=;
        b=ZZ8N5eNTxmG2M6cMkJCHmZjJxcbyazwHJ2F9x7BD4h6bBXjSwvzVOCbpdG8Kv35uhF
         U4Ci5jjKTwgozMmkZEPA+mBmaTvCXzqrMjIRi4fTjsSSizkcM8ys9D3afpkV1t0L+WbV
         a9yJXmbkHAMJScUtamenb6tH3rW7UzKrTno6zB7Ya50zTEtF/HTpUoZ2nXlOzt6NKzFG
         45wpnJH5mVgGyT0+G+94bpjXk6YRudke0RnnZKNheiE1+nTP+tVDPqI+0ni/+gGA3KfM
         sL7GKxArHVVfsuPWKEnOJrt1wdT5xgIyIFrdOEjK+rbDO51DTY9t1tC/3YNx9Ipv7ewq
         z16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777896820; x=1778501620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/70r6IqZMUzMPLl+F4JoQGxVMmdN9u1Qh2Ykml3WfQY=;
        b=gL7aYqZW1V519VocMXtX9YsuKzgcWuhfo88/Y78gw+Lk9hd4DKcv0TETm1tPd+qwxX
         pGwZiiLmR1jORzuxer4VGAWOdgdQry4eQa0Bc58XevOsmY/jaaK3Qm9BQxRv1X4Zd1fG
         ZEEIDaitZrZyrKMozX1yemyxd7Px0sH9uPDoHdPmbu4QZEIDXAEpxM8AFyh3u1dIQL53
         ejuoMdEEhs96HqYCFm78DWDgcB/ktNV3MaeCPCfWYokJ78XoszmDWq9ThiaqhXPa3+Pe
         y/7xoSpuniNeqg2E5HnbwgvvV1NaZH6eKUj+vt9c5xmTFlYHtTf/JXXaY4hanM6wrFSD
         DA/w==
X-Gm-Message-State: AOJu0Yy4Ei6cmicBdJufhNFXn4SYrJ1/tLKhqtXeRRLndPKkd1odgiUB
	g4uG1tGNYkzmN1KnlweI2wcEmb5Y2LlS7GqIjJUoYGwDRZrwag0Efbkg445Od1zf
X-Gm-Gg: AeBDies/iaaavNABlSb69EH4/yehSOhqCSH07MeAWSX8joLSsTxY8US4Zu/pNO7j0/f
	PmAcsOzrCYoNpzNQdKX2xoSa8xp8eiJ39qKlLLYMc11c7M8MbHSgiVKjZF61bUYfqFXPLR4Rqhv
	5UOPbBs5tqtvF/EGtnx2keP10wEzSW+Ic8HUOBsXjIrn+I1cQb24y0JjAYoqtp8wMhsaeuO+Lry
	iURnsJqhWF9Xi/wqGVTAtQQufSyX/B4qg5jVqDV+YhDveVA79t6e5OW4SzgpAEL6qXWsVfBB4Aq
	dXb19B6Py1tLOIbPzTvQgyoUgDMqqjIuLJa5bVTISprdAQth8mda48YZ6JW/deKRXZzBpgojrPn
	l95DOFMN4Ztzd3EwTOYWkZzXAnpa8dJwfM/Po6RJR/4lwkBROTKlzLzwwzBkU8ODfNz32hqBY1E
	jVJmQbSKgh+RBw8u4QaHFxphnwMHe/KVYWUPZUR/VS7n23IycEe1fbdfIy0WLbuKPpiw==
X-Received: by 2002:a05:690c:e3c5:b0:7ba:154:87d1 with SMTP id 00721157ae682-7bd770dbe69mr97087697b3.33.1777896819793;
        Mon, 04 May 2026 05:13:39 -0700 (PDT)
Received: from ubuntu-linux-2404.ts.net ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665464ccsm48417937b3.11.2026.05.04.05.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:13:39 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v5 2/3] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Mon,  4 May 2026 06:13:31 -0600
Message-ID: <20260504121332.1053563-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504121332.1053563-1-sebasjosue84@gmail.com>
References: <20260504121332.1053563-1-sebasjosue84@gmail.com>
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
Changes in v5:
  - Resubmit as full series with v5 corrections to patches 1/3 and 3/3.
    No changes to this patch.
Changes in v4:
  - Resubmit as full series per maintainer request.
Changes in v3:
  - Move validation to afu_ioctl_dma_map() at the ioctl entry point,
    before crossing the userspace/kernel boundary, instead of deep in
    afu_dma_pin_pages(). Suggested by Greg Kroah-Hartman.
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

