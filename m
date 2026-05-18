Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC89038F255
	for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131282; cv=none; b=npNi40u5EANnVmSuUSmEeW2Cg5Ao4yHHNlGbm9FrAT70W598nOKKYuDi5BuenLlI3K3MFNv4xozdEe8KS5OJYwH8n+EiJf83PLnYik7TOD8+PsgndSC0TlUL4+0y1NSY4Kd623Y0DrU5X/RuNnSoxPG/HopnbinC9NUW2uUoT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131282; c=relaxed/simple;
	bh=O58YtyLftv/aSr8x9baMQzWxATwo2ioj8rHnKr5cmYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ah8Fi7CIzOOBqsImlCOaE0k6N+C+sN2wEw4Qslr3rqKbL2NTDXX5e3H35f/YrWqG4s4EIch2nxQ1UUOf/5tl4vixuZyJa3PppSCYo/JBiPTbpCfDFbVMKs1IFlu+Tv5OZCm+nc2zB+WVRNh5lb6R7ROr55vY3fijwhumEsl/XlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cH1paVhG; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH1paVhG"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7c7fc722b50so17859887b3.2
        for <linux-fpga@vger.kernel.org>; Mon, 18 May 2026 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131280; x=1779736080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6OJAQsGwoFPD7r4LZcpMPocelNw4jhWQiyjjqAx5Pk=;
        b=cH1paVhGmz0GxWCAmIOMsuxpBG0wRPkxxuY84eDhul0lgXgrj7nVGH7W/cT2+Rob+w
         vaswy6lDAye+1ZpzRjwCR1k0/U4MHFhAy3IKQPHXBK0C7+5PxDnsrfhQ+9D+6SqZeIA5
         dEMkQZFg1HSdNrUkHTCtgMQPQUAjRL0wEIyVsMj/lnOggXDuuCh8UFcFPeJgRc0fJsU/
         7v8UpjY3RGJ6ldYGLC0BWMqhyw5A0v5xfVj1BdjSu9jMiplie+cfJ3mOBWsrnAedVbYY
         WE679QfLk0xqGXmEsfPoEeVkEX+G4UimkeI+Py+5x9FvHgr64aljsjILYFKKOOs4PVlF
         BCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131280; x=1779736080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6OJAQsGwoFPD7r4LZcpMPocelNw4jhWQiyjjqAx5Pk=;
        b=Uoiz+r6lao2ZaxnqYGfZZg9sKQ8vJQufF0TKW0TVicDtSWfnb4ByaqU0l+oIMXLDJ+
         OfPfSLN1fguOqbYihN/MODNi/GzBEfo25KqLLjm63XTp6+l2V6duZRmHkfWrTKoOwd08
         DjakmJhXzbkx2E7VlTlCFL6SLMDRMI9UFCQNeLXKgwjEiAlwlmBf/hMY+JiXgzh87yHz
         2H/u0BRb6BvWu0j6tVgJ8qJcqM0xVyjkd0tkYvajLJfUnKYcGoyy64IYNv7qWY2M+D5L
         29a2sEy/3cSKdZnTcPKxDCdo1pChbMDP+XFUaMyJKjv64B93KURfggrE/bYwPaRu95Vj
         9UzA==
X-Gm-Message-State: AOJu0YwPXiXyvZll3F60gz39OmdqjSCGYRXrkOXaX86Zm1Tl3LLG1D9T
	Ar67M5n4vN5Z/UwPLR/YIqLGgx4cwQg6WI5dIohZvLAt2zyxQ1jr6sS6fAFCo7J7
X-Gm-Gg: Acq92OFU8oQ2QW87jakLA8KE1x+QxP8SPhKpMSuE7fOZI6uITjJBDVr66zpJay5su7Z
	nhdrQDvva+Kyhq2fI0kAaRV+cwcWITO3Yu7Er88bkZB32y6KCDuwvAN9yvt/Fi1H20387REK9B7
	Y05K4VNC2/RQpA1myPS6NnkWj4/VoFcazqmMzSlTveVZbecuvROB6gVsakIfMSNx4KUF54fJqZQ
	ITM9u0XC5/3ljOfl1ThvrTRSjW1/1x3qlmpfFBxcrvOM85Y7bAX3yA74LhPudwCyyJ9lslDPhYe
	2+0OI/LuFsw+m/ncc15CVswwwaiHt7tYtwgLT1jPeSRxMm7S/zsybQNvdLpsqNYnP0ko1TK0NtK
	mOhC2Mzvzyr5Vmz/YG/sZsdLBZ0PZqeTdbGYFQ15Urt9ic06qlGnLCNWIpuXLj3XPTmpXrC+iL8
	qCKcBTzFAVHkKUwf5qvDzO6XuDf7mnEaM7U2kwnTPwPH/VpXicSZjHbVKC1fSTdSdTPx2XodKAY
	XENM2bcw2yeUUxVpSe3V4CYv84=
X-Received: by 2002:a05:690e:4086:b0:65e:5955:2e44 with SMTP id 956f58d0204a3-65e59554694mr5535194d50.47.1779131279841;
        Mon, 18 May 2026 12:07:59 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0b11esm6766160d50.11.2026.05.18.12.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:07:59 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v8 0/3] fpga: bounds checks and input validation fixes
Date: Mon, 18 May 2026 13:07:39 -0600
Message-ID: <20260518190742.61426-1-sebasjosue84@gmail.com>
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

