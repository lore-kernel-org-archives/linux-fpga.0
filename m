Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE2F2989BC
	for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123213; cv=none; b=YAdSk0/6bJW+2nnNcyDIZ+iPLjD7CIdLKb2pEZoXgq7JS0VOt9IHjhZO87okfulcpNF+UMdDD8ZdpALvj1uxtSpZy0HiHtplu/DaU8UFnH+YvO1FI3EUwlf8F1KnAejiP9CIoi5u6C4+ZMtz+GztC7c6EkcGkKifQ2i2DyE8dmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123213; c=relaxed/simple;
	bh=O58YtyLftv/aSr8x9baMQzWxATwo2ioj8rHnKr5cmYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWllpdmWUiQqzGWliO1t+2y6/Sc0n7CZjz/CdQG39j3+Oq4O7xz5f9I5B6k5lsDj8MW73+2rKsenCWJPtQNri0N0DSNvzgBcTF+cUUOQpa19l+ZYeTzN0IPIrTmd8WLLJYbG37vAYU47vgpx2Rm2Dkikd4PoFsQOggDG7qn8L+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3QAkuKr; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3QAkuKr"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7bd5e373d07so20707997b3.2
        for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779123211; x=1779728011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6OJAQsGwoFPD7r4LZcpMPocelNw4jhWQiyjjqAx5Pk=;
        b=L3QAkuKrkQ0UziMDwTYwuZW6ExFK9XePVRNR6f7NZFO4FvsWxgc0g40/eAE4YdYDu4
         FoOAe48oRZLErxQt5/6u8THA/MU5G2O7rRo+UpD/vy2lPKI8mkLiSa500bFn+UcYd/bm
         TG2O6JFipMb3MS0StKeIaV3UlAPY+uB5Px5ts00s1y1qRU+oFv9ycLvHX7oT7rKMIJOK
         IQIWP2yIr0oaRDhtQaT1UXT4q2JYWn7q5sSaV63VUtxc2+SId3fj2cRGaKuhsNXlTmpb
         0yuJbq7Eo/UglSlirFgpqz2TpHPL0GqeccFE3wcLFNJsXifVWYWCxkp9CIwJOtYb3rGb
         bSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123211; x=1779728011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6OJAQsGwoFPD7r4LZcpMPocelNw4jhWQiyjjqAx5Pk=;
        b=fkssfiXbOeQVto4Io52Cdnlis6N4oXPCHpfLRmqiMs7nIBLG5gmUNpJvecXJXZeWdA
         OprUfxlpQJDAXsKVMOB019LtG0xFgSOTiZiah3/hFVXDFuDTlN7R4py+kmcgqie4miWy
         5CwAWlTSplTppJbZCTyzBkWa+KliEFPYSN1x2pKR5prYR8TEaoH2wBDyqCBG4EZjUZpJ
         5zsJHxTykJ6qez0pfwVDKpG+DBITb/+CIDKdtNKo7ssQnxnA6up50f+xkqhFCVnbLprA
         v7hRVjuM2umtkgPAqNq7NyLHdEf3Vvgma2VmLt+IxbBEjcBSkM0r8l7miAcj3tAZbh9G
         zBBw==
X-Gm-Message-State: AOJu0YzQoXqCXBXQSGg+9nKhKCvFB7RUHGhmxrxXlP3EvvDi4jICyUTp
	LK9OrN8paO84xMDfacb7RGInRJLWPkPh00hhc0aiK2SQP6k03Wzkxba/
X-Gm-Gg: Acq92OEqjS8fFipEPPF/ka4c53kIJuTr8ya4p3YEmAkqFp24sXF4+L1SVnFAjR79exW
	li39Z2sXWM93CyqPceoylmgOfxyohflh5v36Em5ge0VQDcfm6U9GBWJK91coGWBqA0lyDQz/1Q3
	pP/tjqiuJyLSZVzkNp+Q2RPpXjWL0cn5mqe+vZrmffiURpIPfYaXTcHek/UtT4Mt+n6RNWeN5Nx
	ZQm+KdLToUvjsgSTnHlYUgu8MfQS1S6tGG09Z1p+zXpJ3EZAGnV2U9ehFa0e71iiuHcFbNgctPr
	xem4+EY5Kss+ztcrJ2Lcr37UF1Z/TREogt4D3LunjKT1tfD9Mou74izY3Rq2iU7qc0JooPz5hP4
	4jd3WDSP/56uCb3oeZD449rZ9hjxTQzJUTLijnsXSgdv/lQnWta0Ww3/7PYy2CIwu8D9jyFzeh+
	n6/buVdMBxb6lj0MPRyRrFq/zSDH6VYOPB4zpmsrtLTOb6TNd1aMEcAVaDkq4sNojOVjpvO4cPp
	EQmRrh6dYzhahjU
X-Received: by 2002:a05:690c:19:b0:7bb:eaf:5101 with SMTP id 00721157ae682-7c9599a2f1emr185013507b3.16.1779123211650;
        Mon, 18 May 2026 09:53:31 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc965ab98dsm24232957b3.0.2026.05.18.09.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:53:30 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v7 0/3] fpga: bounds checks and input validation fixes
Date: Mon, 18 May 2026 10:52:15 -0600
Message-ID: <20260518165218.35388-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds three defensive fixes to FPGA drivers:

Patch 1/3 fixes dfh_get_param_size() in the DFL driver where the loop
bounds check is evaluated before incrementing size, potentially returning
an inflated size that exceeds the feature region boundary.

Patch 2/3 validates the DMA mapping length in afu_ioctl_dma_map() at the
ioctl entry point before passing it down the call chain, preventing
implicit integer truncation in pin_user_pages_fast().

Patch 3/3 fixes mpf_ops_parse_header() in the Microchip SPI FPGA manager
where a zero header_size from the bitstream causes a one-byte read before
the buffer start.

Sebastian Alba Vives (3):
  fpga: dfl: add bounds check in dfh_get_param_size()
  fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
  fpga: microchip-spi: fix zero header_size OOB read in
    mpf_ops_parse_header()

 drivers/fpga/dfl-afu-main.c  | 3 +++
 drivers/fpga/dfl.c           | 2 ++
 drivers/fpga/microchip-spi.c | 3 +++
 3 files changed, 8 insertions(+)

-- 
2.43.0

