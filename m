Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A8D39B94A
	for <linux-fpga@vger.kernel.org>; Thu, 16 Apr 2026 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350563; cv=none; b=RdStshrhKsp0EAIEiDgCDaLIXAL8gGWmHB+tw8Tzxr/xSij5n6Vwf8g9T0XKucJYLhyn8fCckcy+kGHlZXJ3DDPaFzopKapUWHLKukBl1/4ixQw25LHepV3zKYobezL2O8fwqblKxMstEFAiCuRxDlM70vakXnDb98mqspDv+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350563; c=relaxed/simple;
	bh=o7RjQadYHL/375cjm6XwoIOguUQh3DPk4SGVbAOcCPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iCGh/hQ+CwjdwLp7emo0uT0hxb5T4SkriJSrfSAh3ZEMN/2Iyh5+h7Az+5ECgExtK2/hZx+DuEGbXkVUTWX1zBsT2qsfaRrgeomjSXi9reCo739BpAFiGAujwzt/+1DFgN5sBwLPxwhgds38eTSxVMT+2weuem/cX+X7FA9C378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHdggSbA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHdggSbA"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b980785a0bfso1092525566b.3
        for <linux-fpga@vger.kernel.org>; Thu, 16 Apr 2026 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776350560; x=1776955360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kV10FdcC3w13UCLKuFTzhb2hnSCEpOxDvfqK3oc2E8s=;
        b=JHdggSbA57Iie/Fxx3IzNvDlAMC/JIZ8T4unXqLV4Nl+uJ7MWwV9PrErGXsUkavglV
         YIBmcFapRtot16rfq0ZQfr2KFibEYEOcJa9rx1eNveKNSO3656s7uyoIKSZV3DQ5UvON
         iyoJIkYd06Z+HoIHmHrYENWx0XdoPG1m8N3XMAFqpptzqKIVp9S3kh6vGfpdkBCzI4MU
         BI+aKgwRq+EkS3Gqh6yB9Zpdq+YUYf1HGCzdtHdaKyjyviFHSLke2XG2CTJBttQxdlID
         TvWQChDq4mM5PiLFzlLMt4zD8BvUAkJyTJR2J0T+hh3fElzAKqlnSuirwE16IYfVaaZ0
         Al+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776350560; x=1776955360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV10FdcC3w13UCLKuFTzhb2hnSCEpOxDvfqK3oc2E8s=;
        b=BpaNHO/bZqX+PIyVt0yx9UA88C4nyVQ1/w4NXbQmsNnKTs9dV8OyGMkMELVNanyrP9
         FP25yaf+g4eVzW+bGTZ7FJARW/PmhX6BAMu7QM5YwikckZjubNz6ct6BI5FuWlofoBJ9
         DJ/M5CYezboQo6eR4LqkOQyTAxV/+umo+16+ypZrcLe1A4ye6QFGdnXdKFHdFNGHXtMx
         lupyRvIRgYm0O8gWkv3Neg6hboajmm3eovXCAT+0+LgqY7cdSH+vb6zE/2QYnBn9WCnQ
         8x+9tJb0DbL3QlPlKCPnqWNYGznUuGldL5etVnN4icCd1b+kNSFksyAXJaoTT1gFyr+O
         bCyA==
X-Gm-Message-State: AOJu0YzFO45VLjnUdntAdR3xwTs7eom0wNMc2K5WqtfJplY56tFCrQJq
	6NH5cZvY5dzPMCncVSG+faP1X1mJ+qTE8hhmp7PpzwEKBXuyGD6gFTRjZIVpIsVfYLw=
X-Gm-Gg: AeBDies3qT+JbKm142QVnUKiA5yD5bhV8flyDj3/2cN/KcOHsrgDDp/HCratuXe84ey
	Yhz1LfV3djs5afnMq/6b+V0HlNP0KNHW0dvKvHrFhOmDvUPKPR91yxBWnz3fuqQp1jxwrJ4AEa8
	oclnFrFyCpo7x6OL4mHGIZO//dBOJ1hde9Psw6N3pH7QUSYq8IlFDA7iD319gD0T1OsQn1tmCfP
	JdAfOymwqW4G56WACN7HDpFxntX8p7JHI76DqTgZFLhLXZmriTNFmzLJPZJDWs3QRR6nI1SZKdJ
	Bq3LREVxoXhZYedQsocDvtx+rmrBXenA0ES3nGb+BW4FCm1Sa7wO5aDIxuMDPf+I+ilVolo4MHR
	WzCiK+JuCwWCGeGJNWr0/Tg/oubCH9g47ZbAl0eVHcGFsokhC6JHkT0tCxhFbki6YFA8iPCJeYK
	F6jzbAfAkaSDp99g5uKpLDW2/ypx46Misdxrlx
X-Received: by 2002:a17:907:782:b0:b9b:1cad:fe93 with SMTP id a640c23a62f3a-b9d7266157amr1436656866b.24.1776350560042;
        Thu, 16 Apr 2026 07:42:40 -0700 (PDT)
Received: from iris-Ian.. ([2a00:20:636a:3838:3bf9:3a9b:8000:4975])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba2a112cc9csm90502766b.40.2026.04.16.07.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 07:42:39 -0700 (PDT)
From: iansdannapel@gmail.com
To: linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mdf@kernel.org,
	yilun.xu@intel.com,
	trix@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	heiko@sntech.de,
	marex@nabladev.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	dev@kael-k.io,
	Ian Dannapel <iansdannapel@gmail.com>
Subject: [PATCH v7 0/3] Add Efinix FPGA configuration support
Date: Thu, 16 Apr 2026 16:42:33 +0200
Message-ID: <20260416144237.373852-1-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ian Dannapel <iansdannapel@gmail.com>

Hi all,

This is v7 of the series adding support for programming Efinix FPGAs
over SPI using the fpga-mgr subsystem.

The series adds DT bindings for the Efinix SPI configuration interface
and a new FPGA manager driver implementing passive SPI configuration.

Testing:
- Verified on a custom board with an Efinix Trion T13 FPGA
- Tested full bitstream configuration over SPI at 25 MHz

Changes since v6:

dt-bindings: fpga: Add Efinix SPI programming bindings
- Require spi-cpha and spi-cpol in the binding to match the driver’s probe-time requirement
- Dropped review tag

fpga-mgr: Add Efinix SPI programming driver
- moved Makefile entry to the end of the FPGA manager section
- moved "keep asserted CS" comment to first appeareance
- removed unnecessary variable struct device *dev = &mgr->dev; in fpga mgr callbacks
- trimmed unused spi_device_id's

Ian Dannapel (3):
  dt-bindings: vendor-prefix: Add prefix for Efinix, Inc.
  dt-bindings: fpga: Add Efinix SPI programming bindings
  fpga-mgr: Add Efinix SPI programming driver

 .../bindings/fpga/efinix,trion-config.yaml    |  98 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/fpga/Kconfig                          |   7 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/efinix-spi.c                     | 260 ++++++++++++++++++
 5 files changed, 368 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/efinix,trion-config.yaml
 create mode 100644 drivers/fpga/efinix-spi.c

-- 
2.43.0

