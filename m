Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175AB361DA8
	for <linux-fpga@vger.kernel.org>; Thu,  2 Apr 2026 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134529; cv=none; b=DmmB9V9Fm+j0ST1yQqsc6B2UqRZv5jxwz5cgELF24NhJ84n5n4xP0RL70/3YpSePNyCzW4QS2ZcV+FdOqtOrjRGNxwzb44pK9JRkfLzEX8Ss3T2Nwm6gPP9x0ms5NClnzePM6eE3J1FB5+/oOG5bWg8y4ZEBPhBEyMgSj9o4gks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134529; c=relaxed/simple;
	bh=9MtKRQ5M+bp1zJOU/8ASwu4KWEN9j9lDStP99duruKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W48iP2u+OkNdS4J7s7QGC0FugJaiPI7R1P3xaTu8RVUqRecbtD0beznYQMsXb3W2ark4G5QfCZVIChKAIx9gJdL4vO5ajBecJHvwtGwgohnr8xM7efqSIL1iJIOCtKKp6mLlriGoRTb9a/okHGWZfPaZ3HqwSdD56U7l7pN4Lco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+Mp+FfI; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+Mp+FfI"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56d93355337so643541e0c.0
        for <linux-fpga@vger.kernel.org>; Thu, 02 Apr 2026 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775134522; x=1775739322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/piubItRaGyzWs9BDYPbrLc9Q9XuMH2IjUibk3CFdsU=;
        b=l+Mp+FfIjAzf9veLnpDZw5pColg24jqp0rApYmmqC3RyH1mkhnYs7YvXFA3Z/RIYIi
         KBFzwT+FjI1JuK+DRG8uh6mCJC8j4i6icFofsOYJbKhc/zITX3Aio9bAcHw3Cvex75gV
         dMHfzSJw+GuuuN51ezGdKK4jLRiVpeaDIiVZV7ZZgE6+kL15jrkNqWmZ7j2SzbIWOCh0
         Mg7qEFemQg7PgvnicFpeb4PpWooc1nKQk9StyvBYG5Z57tHi7LG06Cw2s3CoMX/40I29
         UDAdSfgsaMs4fk1LHIh6KMxulXqsIx7lv1B9ucA2hG3waMnWilHwZh+HNECZfWrbzeLC
         DHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775134522; x=1775739322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/piubItRaGyzWs9BDYPbrLc9Q9XuMH2IjUibk3CFdsU=;
        b=l6TFeCH1UVMhI4Z2+Zpo3UoV90B0ukQBIyBSK9KnoCPhaZ+9TySzvlw/kbiq+XVzcP
         +jFUf89vtInP6TqA+RLDKhrP7qZ9vvIf1OOI75EDYmlf15poKuNH/hqB+lMSXpHVHDq9
         Kz9ztx/C1GGh2PlBHjzHKXyZ2lF8/LGmSOJQ5UTy20IeHnmHpWlFO4MfiL076QD+Zh9F
         89AIPtkhnFpmvhSr7wZ+G/jFsgaVMtI73KkOILdzlL0AkECxlHa3oI449Hwxm/Ne6Lpd
         GLTYh8kLD/LR1f+Ba4c/BXuMXN9ikzcx2/MrENjqtlCfoXGzuvlqLBqoFphFW9KVHdKs
         FSwA==
X-Gm-Message-State: AOJu0Yzfc0tkV9qrWOG+EgOCFa7Ic844ZnjX09L7VVrUonYGmaaYNg23
	uGdTZ0FUjaf1bIKbF2pzxElmP6roxymnoXuTpWZnghRMk68FRLpn81a7WDU/5Lm/6qX80Tza
X-Gm-Gg: ATEYQzxOrf8d4mZNI05OJbtcveMzkYJtRnhSznLLuTKZ0iuVzvJp0bXFNjttYHaqHn9
	v/0oqTwLZwJAsR7chzEdr8mfxdxvItZj/2taPvEqMEqc4ccG0391+DjYrZLcpakC3280UyhI/re
	dfyeqpZC6oQLgqYU8V0IsN9TTl1T5sCq915j5U7p7FQ/S9v9cwmpyriRD0+OL8IY0MM0qsn9qbM
	41heWP+sJmNGz7VKpymPMi5HZVZAywL8CFszqciM3V0ZgP6g/nysESVB2RpuxBKkpbCqelurRLu
	DJHIC5svxL7570Uxci5wH6VodXHKZe4cjhxP4g+pOexk1W5cdvmUlsadoINc3H8fAiMlVZvVzM6
	s/e1LLj5ye/AST6mLgjo4sLqjXruqKV9I/WivTaenxZBAL2dSWNIyfGmlSshUfCrqvzJCJkpOO0
	rMuJ+rcxHyx7jIVrCCqWns2/U=
X-Received: by 2002:a05:6122:e462:b0:566:4689:46eb with SMTP id 71dfb90a1353d-56d8a658429mr3295957e0c.0.1775134521759;
        Thu, 02 Apr 2026 05:55:21 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d73:aa::11:178])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fba6af44sm3080950241.8.2026.04.02.05.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 05:55:21 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH 2/3] fpga: dfl-afu: fix integer truncation of npages in afu_dma_pin_pages()
Date: Thu,  2 Apr 2026 06:54:45 -0600
Message-ID: <20260402125446.3776153-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402125446.3776153-1-sebasjosue84@gmail.com>
References: <20260402125446.3776153-1-sebasjosue84@gmail.com>
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

