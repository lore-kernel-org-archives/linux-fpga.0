Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD43397B06
	for <linux-fpga@vger.kernel.org>; Tue, 12 May 2026 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591254; cv=none; b=W3ypVhCOibSHtyz8nAE1L2VfR9FsCpdReLkG212w/MZAkdubbGp76EvXqIg/0Za1nJrIE8sedS9ck2ljx1T673L0tj1K6bVL3sw+JVpBPOCxIeJBPJhHhLDGwOzYSCsH+24zdJjJ1S1nH8XO/+v+X2Cd2eJF4GOkPdOUzoo0Rk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591254; c=relaxed/simple;
	bh=4olwjdhUJV9yQf5ckjVh6vmaJyDU534e4WimvLGZEd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PC8Rg4OyIPbPgQK/mVFY6n5Eh2JOAMT6+iIGEz/JyLpc3uKzwjhbLOo81obRaiMknJ5ayRcerPq0z6TnoTAUXrbnqQEncUrZy1LYhukv8YqIOgsFS5wuH6ZaDTJBo3FXKp7/oXDo1RcwGGyYnoI4QcYThU7Sd5gaOgzOl8GUD4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4BrFZ6B; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4BrFZ6B"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7bd8cb26219so30070947b3.0
        for <linux-fpga@vger.kernel.org>; Tue, 12 May 2026 06:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591252; x=1779196052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF+t9homXAdxJUbJz+MKrPNemeLBnB/WpmMKz7l6PWU=;
        b=q4BrFZ6Bq/LCPbof2IuGhWOTrhZn9jEIKA6ZldUBuBNtEKnJGhD7UGDjvD6zxxgR2h
         pHP6NhroLwoWFAriD/RFwcvtRBPxIOPUUtVdMnrkyakWVcFY73bONDeO5b8MewusCOK9
         T3aKmuVOzqR6l2FuZw5w+EAzdWDFXKhvvyro0pL040igPaqS9svVY2Y6mHAGz7LOQpgR
         h4mOK/aZqpfxGyiRoxy9LDD5vjBXMO9SY8KQjlv7rfnfrbiIvIChmkKmWfQ90bPusb3g
         iduvcCTdAAGo8UHCCyZqsG5OlyDgj3N4Tf3ZYPe9zfRjqb0HxDiMaUF0fansE4w4BSLr
         QEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591252; x=1779196052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dF+t9homXAdxJUbJz+MKrPNemeLBnB/WpmMKz7l6PWU=;
        b=fB9JMhbthmb1sEcJ4BJ+2c3UQ4Rr1aX/qLxyILvFmzkmhRaFGYjDJx1Rq38R9ITeAA
         +NT8Wx5OOyiM/i2nzOb0FR4QZdfCRy1a8VivyWTIcdLx8zgZKcpjdn9ufIKSaajQ3v5y
         au0eU4JW9LrV4VHTFQw13rOfLOuSCQFTRasQ62f2dHfBRcL+XJDVUAUbu0EnZzRM/E0O
         t4I32rSlzDOvcpLrvDn1IRzsIKdX4QodKQT+6CWpjUMNnSywnA88dx0ZXoPl58/75NI9
         DaJCvlu7sVbVc+YG3ygNs7wTFNxl9N15k7RN8cCS6nAWQeidpW0R1zJKV4FmFcjgNm2q
         rfow==
X-Gm-Message-State: AOJu0Yw2nH+vObsxM5/kUzySr9DQEjc8hA0aTdfu3C2h9ewpPgwmChDs
	P23UIx4sz8r7ZkIeO8s+ElG6anp/aj4agBUJ0gt45gnx8O+z76iLcsAG
X-Gm-Gg: Acq92OGfQUiaolNRp0f1GCBp7jE7GasKP4zZkcFO7ltLrjWT0vyedxYOlS8by9GSysl
	2HDi5Ksbi2QVMfO59mL3FzyfIQNbpDFjgDHByjaCpSFtTJZZUCQUvJuIeCFbb5rPzA2iwFtfg6B
	mvAdF8RHNRENRB76WJNwswwK1onFJqxA0v1bhdTKaAAZKK84bCeN7hVa5P4YwtVzbhIjE51pJt0
	yfmGWw5W+iTekFdx5s1FX448HBZBijwdC3rCCKvxKDypbWtTCGoG11LqKBuCHW1BVk/EmKm4CRF
	8ZDrDX3Yml8eBRBnGhWfCh1trHVctXRzsNWJ03ThvGoj5Vb5miVL3ET7XDldSKVtRU9xXNLI0L8
	r+1ch/Jd8WMRbFW2pFW8SEuRYmrOOGEPzF7iSKS85JnuXzPEiSGyegDcE3ou+x4BwvwE0ovy1PC
	JZI4HsTNVoTe8PWWTrPoe6NuGbH18AN68sSLZ+gKOgI5B9qk5hHA37qez4
X-Received: by 2002:a05:690c:6612:b0:7bd:a4dc:c23b with SMTP id 00721157ae682-7c564141e00mr26031567b3.49.1778591251396;
        Tue, 12 May 2026 06:07:31 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6686ead7sm167459037b3.39.2026.05.12.06.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:07:30 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v6 2/3] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Tue, 12 May 2026 07:07:09 -0600
Message-ID: <20260512130710.933089-3-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512130710.933089-1-sebasjosue84@gmail.com>
References: <20260512130710.933089-1-sebasjosue84@gmail.com>
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
Changes in v6:
  - Rebase onto linux-next. Add cover letter.
    Suggested by Xu Yilun.
Changes in v3:
  - Move validation to afu_ioctl_dma_map() at the ioctl entry point.
    Suggested by Greg Kroah-Hartman.
---
 drivers/fpga/dfl-afu-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 3bf8e7338..097a97eee 100644
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

