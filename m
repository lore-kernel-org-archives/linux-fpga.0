Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B885175A9F
	for <linux-fpga@vger.kernel.org>; Tue,  7 Apr 2026 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570791; cv=none; b=eLj9SgwZo8KtjnnxSnwxcxoDMSkYWL2AWE89Ms7e3iY7vjKAm0ZehBmGCvU+oMRZ5Y56GM+N+Hjc19LT81HMQClkVUIxP7VaNaVGGxCJu/EF8hhZ3GW6CqU5weLBOkTChfbFu5kMkhV8nrq5esnRy/bZbzLY2dBMOjBByfcAt6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570791; c=relaxed/simple;
	bh=9MtKRQ5M+bp1zJOU/8ASwu4KWEN9j9lDStP99duruKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyR7wHVc/P6+Tb0yNFHnBc77w+v10rarPRU69br0QIFdSp6giyGESWNfJcBigyYHSSv8sJL3tzlA/zS/x0wvYWMp8kbc2V4B5y8X74ppzQyCoiBE03pOSNxs1CZEIOTftT43rznNwjgFpttyDK9IyIji+SILXKZnkI2qAiwRIdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR0T4QXA; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR0T4QXA"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-948029fb1f2so1528329241.0
        for <linux-fpga@vger.kernel.org>; Tue, 07 Apr 2026 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775570788; x=1776175588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/piubItRaGyzWs9BDYPbrLc9Q9XuMH2IjUibk3CFdsU=;
        b=NR0T4QXAiKDHaEhukAr0rZYCLB+AqDc2c+A+kM1r7noVTiQ1ICEFZ/Q0U8jZXLjSWN
         iOQSG1x37b5ojKa27OGXgYFaDU0yki68uj3OdO7trEKDkLFQdY0KBl7GOsguu/JSkkRK
         pQHeccGCWeHybrVO3vYJIWowlbfLgQLQ9bg2hdu1jYfH9PJ5Pyh0TGgGu+OGgUU9xp6P
         X9sAqXFKLB/OZ1eeES2g0540WOTWDYfroIJdKf5RKnXeKDCscLTmzI6JriSOR5VVdIxF
         C3ykkipjkqzR1VsCwUho7RpWX0bcjdR6ErPTB3VFz9fsXyjI20oaaVBpQKmtzx6MZ9/6
         xetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775570788; x=1776175588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/piubItRaGyzWs9BDYPbrLc9Q9XuMH2IjUibk3CFdsU=;
        b=dNVGoxhNQA/bkYFeKWxI+gA6OfEq+T6ZRlmKUYvgHTV++/atyWZMM2EGCAkskKxZ93
         CB7eQXEpNkz/ivvFQlmb4c9SOqFntI99e8DXAoM1b8vh+J7gIHUM2wcvOEn+QNBEHUqK
         dQ3nWELAK3NJMgExiBEU3hQCXT4F/+E90RtNBXPkFb7oIoI1my6Ty0sFRzW67MvWRPlN
         ro+NkoF9+wVaD1M1obdYcfxXu3Xz1WqxpXqtjdO1k93EuKL1f+M97OYHvXZ018mDwN8i
         Tz/tRjvnSY+BAcuxuZdFHMttJZtqo856Lg29ydDlQjH9LNtBPu41fAU65OvRCvpjMfRz
         Paog==
X-Gm-Message-State: AOJu0Yy13vYJEBpsvxX96XC0QvxbGLbKIlJkk1aqavjIKt8ZPEzxyMx7
	rEFJyynM9dcXFd/0z+ypSdIInbPTp3jR4SCkyLc6mbsqvkRTyaXiZBso
X-Gm-Gg: AeBDies8G74RFvRd0n0UOqZt1J11JgJdQaVCOnv6qrfgB9Me/oLXkziVegcGo9fwkVZ
	k1BW2HAUasDYV8vgXOoykYSGZQUpe1+MD+3tJ/IBukhqT0L9F9mfdLSWD8hLtB7o6yQ4eMdj3K5
	7TUSvC+CuFU3o8zCZ20dO0skFgEH4wGeWOM/W9faztbV+bHAOtLOhyTweOPU9pI6zhBntymtNgJ
	LU70BwS2t4pTwrNxvzrxHWHeosTQPCh8E5tOGeX0k607cI+VSbYqlanjRsMID01M6qklbdiIuQ7
	Fmm4iLYNyPqmFEcjeHisqWQ8W8Ec4AbV7nanshGeQ6ecXxVwjb44b2LKYN8sYuBVo1TFFOI1osE
	8J4FDX046kYenq3/h1RAfeRDYEQ1NosGN/OzjJ4bybBFdlyITUSl1Qv4gE83K3uiU7+tXB26bFx
	kZpTfedsE+elGnaWSZcdAzkEc=
X-Received: by 2002:a05:6102:548f:b0:604:f155:9371 with SMTP id ada2fe7eead31-605a4e7abcbmr5938439137.12.1775570788285;
        Tue, 07 Apr 2026 07:06:28 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d73:aa::11:1b5])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6058304a726sm19814641137.9.2026.04.07.07.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:06:27 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2 2/3] fpga: dfl-afu: fix integer truncation of npages in afu_dma_pin_pages()
Date: Tue,  7 Apr 2026 08:06:00 -0600
Message-ID: <20260407140601.15006-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407140601.15006-1-sebasjosue84@gmail.com>
References: <20260402125446.3776153-1-sebasjosue84@gmail.com>
 <20260407140601.15006-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>

In afu_dma_pin_pages(), npages is declared as int but is assigned from
region->length >> PAGE_SHIFT where region->length is u64. This causes
implicit truncation on 64-bit systems when length is large.

The truncated value is then passed to account_locked_vm() (which takes
unsigned long) with implicit sign extension, and to pin_user_pages_fast()
which takes int nr_pages, potentially causing incorrect VM accounting.

Change npages to unsigned long and add a cap to prevent values exceeding
INT_MAX from reaching pin_user_pages_fast().

Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
 drivers/fpga/dfl-afu-dma-region.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 87652d5..0d1f973 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -34,10 +34,13 @@ void afu_dma_region_init(struct dfl_feature_dev_data *fdata)
 static int afu_dma_pin_pages(struct dfl_feature_dev_data *fdata,
 			     struct dfl_afu_dma_region *region)
 {
-	int npages = region->length >> PAGE_SHIFT;
+	unsigned long npages = region->length >> PAGE_SHIFT;
 	struct device *dev = &fdata->dev->dev;
 	int ret, pinned;
 
+	if (npages > INT_MAX)
+		return -EINVAL;
+
 	ret = account_locked_vm(current->mm, npages, true);
 	if (ret)
 		return ret;
-- 
2.43.0

