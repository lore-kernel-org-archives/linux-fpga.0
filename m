Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1365D37206E
	for <linux-fpga@vger.kernel.org>; Tue, 12 May 2026 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591251; cv=none; b=iS8mm723j9/3JjHgTX/FlNDWphPBF7fh9oj/kGo8TpkrVm13tBFcIKUW1zMfHhu2+a9jeE/d029eg5ilgMDDBT/HdPh6AtqkAJrVmv1GZqFlfzY7KR/++gcXpm8klvVnKboOz75OzD7+k5Gg8navYNB9mGACuBM15nn4o/KgvwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591251; c=relaxed/simple;
	bh=O58YtyLftv/aSr8x9baMQzWxATwo2ioj8rHnKr5cmYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVvWLYU8VSMs2pzArTiB6InoiKxLOiaEmuecR11+Njeuq5HnvBCcS612CjopvfPD5G/nt96MC7ws6wfXYokvT/Q8DKb4DJ6y/9uzSUu6ME0P7JWAooXinPuQftygZqQ5JA+7BiRNB13XxO6hfAq+nxAY+R+8JJIJ8xzPYCECBTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwuFgspb; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwuFgspb"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bd9f61458eso41279587b3.0
        for <linux-fpga@vger.kernel.org>; Tue, 12 May 2026 06:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591248; x=1779196048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6OJAQsGwoFPD7r4LZcpMPocelNw4jhWQiyjjqAx5Pk=;
        b=NwuFgspbYjjUKTWzbFiLyatbSUVTs/IOpFn5NBzG/cUwQBk/0H1pWciYNYM/AbzK2l
         UhcMXqkPYWj0Mtk2M6//aD8DqVQNh0cpPt4yzBio8IW96GVk8Wr08QsywXmCFDLF/zGN
         hLx6bPIfhQ7QveXF2Rf0IUqzysyHSLwq9jS8DHZSZ5S5i2+U1L5vcyfeZAroRUO9RGBn
         QqLsLP+5sHt8toYMXej3tJdDRXJmTuuzfgBljLfI3wcQr0ustLzftHI3pQRD8jd5z6o0
         kgteVPzYFPWWjX3LlPdPPbMSrc28L+la6K8/X2W8yTFDpYe3lPrLE2uFPbHgJFC48JYz
         DClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591248; x=1779196048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6OJAQsGwoFPD7r4LZcpMPocelNw4jhWQiyjjqAx5Pk=;
        b=JY5r8Jo/cNsjlzK2poSxZRw7VDNqMD0UPY8SEbyMMc1NGPRJCij0UC/BSWNnMEPrgU
         u4jJNMUxGFr+n17R3d0hefHrxNH82AdMuusHTnreNbs/iHBgk+MNj4K8VxUtNv/nRe3S
         saOAD74q/jf1urFOEy7rSb9iU2EWSzgyGrhtPOWa+jbjC8zzqymqAFHKoIypGZLHL+Qc
         YJi3I0DqlxJnUnpIkyAAZKhTlvIvnGY4YjS0w5OAYqb4GREKj1nqP5On001H9EEnTIgV
         BATTzAjjUnC+H4ADMOFB/XNj79Kl6aPZlt4eD8B1xBxeJ/G1lc7IIM7eIqEEzynkHFsw
         cjtg==
X-Gm-Message-State: AOJu0YxQpwPbAu2pgdTfdZZBulFI/wvdy5uzuWr6U7m2bfdr5lbe1kyM
	AbnaB2peoK1vj+PihPeSm9dIRCrIVTZb1TBm6LHiuX3uhT7rHEiciRe4
X-Gm-Gg: Acq92OFkbc5y3HE48pH3wFCx03GQ2eveHR8GHrOcVFBr9XFNuSXFugXbbgXPrdMJ48Z
	Pr8x57uutjAOH/l1Sn8SuoKH644GrUR0WVYQAcNiQqJJz4WWoFJm0dBJiYWkpnU6W/il8xZB9JV
	G69XAepJ4b10biu7vdyovle2243+WNMY+jxjtHtfZ8EUZBdeN+RHUL9orYgFFEJoHeBC0iYWXFY
	7OMIMAhspeydqbIAz0m7DmkIkYk/8/3cisa7qfXYpl5ZjyrkBMi8hj6cfQIjynrGIrc6PBr99iH
	TzX9WX9dDUY5agrs3GKs4uG8Ha3SLUP8a1mc+X6niDVjJlu0WxogLxCgn2SMoHyVSlkg4pJ1bht
	jaGNXu3IK+KYzPTrC1yqtwcmEInKIjo7xLyaMZcSOxK8axfpqGFakti+rzutZRocrmeXBWdZnja
	I3s8dSi2IA4tI3vxzoIqstfwlNOEtYyBX1WthecnfVE6zzOHXs960KOIOq
X-Received: by 2002:a05:690c:885:b0:79a:3e8d:9bd8 with SMTP id 00721157ae682-7c1025640dbmr134369777b3.2.1778591247954;
        Tue, 12 May 2026 06:07:27 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6686ead7sm167459037b3.39.2026.05.12.06.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:07:27 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v6 0/3] fpga: bounds checks and input validation fixes
Date: Tue, 12 May 2026 07:07:07 -0600
Message-ID: <20260512130710.933089-1-sebasjosue84@gmail.com>
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

