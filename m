Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F7828F935
	for <linux-fpga@vger.kernel.org>; Wed, 19 Nov 2025 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763578053; cv=none; b=uD2zHCi2q/mAd536U8S1I5cQj6wKYYCOuR5fvJJiOEwh5VZT9wi1lMBRJKMh6Acad27kzeVYYnzkVYWndqe7RHWXf3yUjwpCGKVP9VS7tWdZtKpXjfH11nclivX465cIG6tn38al1U5XOWuLPgrPoxhebcDl7BbY9rJH9nKKNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763578053; c=relaxed/simple;
	bh=+hRqRvA5Ob6QZcAxsY5uZZs5qvLXUDj57wjaBm65mbM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GNx5qbK6gKiLZEKJgAhoIGMkEHqNdo7B7LjEHu/i12Wz9ayRjjiaIfdpZo6dmRDnrh4D4YlAjjmSzJ6tjSXEQETGeiTxFK4q6GfC96V0gz6nLw2JRH54skckt0xnqvHPM4BvPPRMCnAihcK2p8g94w1QXtQJSgu7rxOXsV3peE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTo+lTKo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTo+lTKo"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so953035e9.3
        for <linux-fpga@vger.kernel.org>; Wed, 19 Nov 2025 10:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763578043; x=1764182843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CmYSXdfN2Ja/nm2Msv1+BGjsxCvmxF+b0Biwj6Rcb2Q=;
        b=YTo+lTKoxd3FdmeVqyfLEfzjm81Hg5ZMNaAcj2hAaCFePLaSxMOvTzsFuJSA4Z/cpB
         qPwBDi+Pz8/ToSJzDvH6ErjtmE5pGMaXBqIDDGbBEiElPNcBfqbmReIDHm66rPEdYNHp
         4ToityM/qUBwcqfRg/bd5vNrVEozBOlO02iwnaZ5FGh3W5HZ/50X9CvYDXav8jV6log0
         F7Dcbbk7gqhOksRJ27g8NOAKymQ6OIRntn9B8Px//ymGX+VrM89owZnHpYS4j6mVo25A
         5dq/xRBrZEC1hXQ0UB2ZUAb1Q6KrEhmXQJbhJ5P3R2ydRRbT6ChDKoNGxxBxGysRzdUq
         pEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763578043; x=1764182843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmYSXdfN2Ja/nm2Msv1+BGjsxCvmxF+b0Biwj6Rcb2Q=;
        b=TcLn1FWX2QnG+X2jEnvZs5kOcIbvna1cyFANvGYloiCqZNu4dQTnpGea52rSE6bsBj
         SHI89PMUNsPX9DSWD5T5RqIpsoAJTifVj++vTrXXf1uhuk7gq/EYB7C6gWH9kSI11W0l
         ux1vIbncX6H2Z52WiZUUJJt5DxTxIbJU0xtxILcdU+vJeuO1ZCXy3fkXG3MBj6U3Pj3M
         Nh8Ygw3rhwpELXG/S3RrViLqHo16CFZnA1+5Z+Qe2KbdudA69mhc7ed2Cn57ZgvfiL87
         jN6vKLH5FRXvlnYJBolQbc4PuvMbX6E/0F8k3J684PU1F60raJXr+xqk9ZkTujqdoOXs
         wUXg==
X-Forwarded-Encrypted: i=1; AJvYcCUWXO8H00IcvJvtrFKgyr+X3Gc8cME+LSmhZnoVUWLDX969Co6E5ZfuyiuUYraL9WG5oq6kvbOp/jz1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt9Cb+p2pIaH9CrmDuL9F2IhDnuPXN6OCoYHFaHRBpTEsTRWJR
	0Cm8gRLOQssVLsVE2RhVmi2jdgHESQ2QEb8L48UD90v5yYBquvZxz/AX
X-Gm-Gg: ASbGncv50o/ptJyBpySctduKW+i1LOYLeX/bPXwwgTQ7RhghpFYZxC5NrFl/BEh9Wjb
	PTG8TMtUmzNLPI7BR0amtxDF3+48GtgLYXBOuh1wGaJxs+aJ3vxW1IRXHDqlOF0kGBuY/lymMoI
	149I6YpUt+yRMt19YjDEocIhM3AiM1aoRUN2wru480FNcy152XXDSaXuH3/LdSiYBbS0ZwZT4Aa
	64UYIm0s/t8Yr1UdvOKqj3BLAiA6sQ6qu2LJJmx/UCS06/1yLqViUGrpJdGsm3O/OqOSh7yhRWY
	ibnk47VBBy2hYXozMdO9zCGiMeirayyzfgrGLQpeLWBsHvMAlDhUs8ewzRqciIMDsPA+423WNJS
	yUFF2q6CpCCnc8W1o3cbqXJQ9i+e0blAkUw2nxW4w7zqf88lYopaZ7MhkU7OPqDcSMJI2S6IW/k
	Q6AfFVSIRkcLqenUx9Gavb3s4ZhDAODwPy8mRJbnK/XSykl39y48hum/z5yU7aSCJy734a9Jcuv
	OWTry0vEMOSUitSLWvUTqhu/ZsOaYtMpYo=
X-Google-Smtp-Source: AGHT+IFnLZhy+yX/aZGJYa09bejnAMrPid7rEcBMkFMdth51macEXUw6ZxkmvFTNhRjmgTb5LJTjzw==
X-Received: by 2002:a05:600c:1d05:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-477b8a5189cmr3256465e9.2.1763578042850;
        Wed, 19 Nov 2025 10:47:22 -0800 (PST)
Received: from iris-Ian.fritz.box (p200300eb5f27c400b58af32dfc3cbd97.dip0.t-ipconnect.de. [2003:eb:5f27:c400:b58a:f32d:fc3c:bd97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82e8ea6sm4909795e9.8.2025.11.19.10.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 10:47:22 -0800 (PST)
From: iansdannapel@gmail.com
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	mdf@kernel.org,
	yilun.xu@intel.com,
	trix@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	mani@kernel.org,
	kever.yang@rock-chips.com,
	dev@kael-k.io,
	iansdannapel@gmail.com
Subject: [PATCH v5 0/3] Add Efinix FPGA SPI programming support
Date: Wed, 19 Nov 2025 19:47:03 +0100
Message-ID: <20251119184708.566461-1-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Dannapel <iansdannapel@gmail.com>

Hi all,

This is the v5 version of the series that adds support for programming
Efinix FPGAs over SPI using the fpga-mgr subsystem.

The driver implements the passive-serial configuration
protocol and allows loading full bitstreams via an SPI controller. The
binding describes the Efinix Trion SPI interface and documents the DT
requirements for enabling the driver.

All v4 remarks should now be adressed.
Please let me know if further adjustments are needed.

Testing:
- Verified on an Efinix Trion T13 custom board
- Tested full bitstream configuration over SPI at 25 MHz

Changelog since v4:

dt-bindings: fpga: Add Efinix SPI programming bindings:
- efinix,spi.yaml: remove unused binding efinix,fpga-spi
- Rename efinix,spi.yaml to match a compatible (efinix,trion-spi.yaml)
- efinix,trion-spi.yaml: remove notes not relevant to hardware description

fpga-mgr: Add Efinix SPI programming driver
- efinix-spi.c: improve driver description header
- efinix-spi.c: replace hardcoded numbers with macros
- efinix-spi.c: use spi_message_init_with_transfers instead of spi message init + tail
- efinix-spi.c: rework write logic to avoid deasserting the cs or resetting the hardware in between write chunks

Ian Dannapel (3):
  dt-bindings: vendor-prefix: Add prefix for Efinix, Inc.
  dt-bindings: fpga: Add Efinix SPI programming bindings
  fpga-mgr: Add Efinix SPI programming driver

 .../bindings/fpga/efinix,trion-spi.yaml       |  77 ++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/fpga/Kconfig                          |   7 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/efinix-spi.c                     | 256 ++++++++++++++++++
 5 files changed, 343 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/efinix,trion-spi.yaml
 create mode 100644 drivers/fpga/efinix-spi.c

-- 
2.43.0

