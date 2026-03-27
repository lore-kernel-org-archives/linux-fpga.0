Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9F34F26F
	for <linux-fpga@vger.kernel.org>; Fri, 27 Mar 2026 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612130; cv=none; b=EjfoZMveOEjaOjWsm0ckKTf8hzljlv7eOPAB87MM+Rxt0/bE6cQ4uBcSNyiblJLV5qsXI3KjhC+x/ZCRS57SRbeSQPejcLb3x+o5C6M2cMw9PJgJgHJFmjAl5qYhoIQVqB2HGnuH+sgc68y8LhanFSZ19ahPM4L1sIloTnadaCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612130; c=relaxed/simple;
	bh=KIZXE8Lzk5B85OIlevm3Mr7lGEeLncI0dprVgBSY/y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ih8F+Yu1z7CvwWqYdTsmUhwwKhtC0DTaWM3iRu8qwtNtxHDSgzE66ISOPNz+ynOT2+n2+EmYxFja8gXH6dBlaZ8OccQ9stAbWsJRZUj60itNgYTICN7DJL/P9OjWo9gp72KM52Z6cKbMukne3z4mfDVreYV/dwG7dsr/MRZrQkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG8mhvcg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG8mhvcg"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so24029215e9.3
        for <linux-fpga@vger.kernel.org>; Fri, 27 Mar 2026 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774612127; x=1775216927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=APJRN7UgMra3qjYWWIOAmYwWw8wN71Hu6O8KoomOMSw=;
        b=dG8mhvcgYBlksWUnTFWXzKIgYW43xE0hYlFwwfVA2YjweI/kzYEuz6+ZdQFf8jvAFN
         aYkN420Q0x18MfY2Ukd7t3WG4jG6NXQtDtVVWcyAqHqNhMC/0HOG5dpqzJIMtUNYezHQ
         GxVtbagRfwxROVX/BO+8aNYnGWPJq2wOSh3LZoR+2+f+RunX7LAJJIRcyLrUAbjEZUBa
         +yuVHKxJ0SanaVzAPUdkt3AYa1otQEY16oakE7YnwI7kG+TTp2VAQ7Nc2K5tRyf9gl/N
         Hy806Zv2lWec8QZ4z/cwcpYFgwEI6sz+uvGsRo4HIElBp0xbX6W/hS9Al2FhBrqcv8io
         /l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774612127; x=1775216927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APJRN7UgMra3qjYWWIOAmYwWw8wN71Hu6O8KoomOMSw=;
        b=rcYmXDVMUBAX5ZRudM6W0+As/qep6LHOIxdlc3ErlX+AwZJry/th0ylVYmTK9dAe8R
         2lGDkFJJaIn8qm+zFMOVS22CfPgqolmQuSGRBmYLa9nVq+gFZxUV752ZbYfhKMPew6Zv
         xOsrcMq/KcyjtefNIbRiTiwmC1nniaPVok7DrFPIFa39271tObkT9xQYJ+VALEMFYmc2
         PzGIbM2iK7XGQyyLY49vYVzDdGny5xePge4ZnArEaHpdQuQL1CzYJQcxuGJczLSF11ND
         HJx/gHWBC0rCPdfzwaPQcDkvjnkugd/l0K/pvVU/A4HcyhshIQ7JDa8Xhjv86Nq+Hp+W
         YrUA==
X-Gm-Message-State: AOJu0YwWSjqK1jBm1JKBvSpNP8fPartsOTq5GXeVbDrtOKcQ33NXuRsT
	+BZGgVM7TN1Pe+i+dzrUIqyZvn+YfKBPjcR1ux2FVDu+EAx7b31KpTjpTrAHM+a+
X-Gm-Gg: ATEYQzwRPJE9a43WQNZ0ycyqU8st8P1c1l5kaNGwY5qr63Y0occLHfP7kGyEUxEmKa5
	PmCTpsrZzdVRQeUrHijwWblozU3RcMYT5xjEyeS6xia/DhV51IsiQaAIc/Sga2j2Kqw9KywVeIC
	hiYrq2Rf38hLEBursS46rnuCNdU1AKyvpfJ0/bdkZGOZPsugVVPFpVPGOnizn0TdP3oD2E+XFDT
	dxI25gVzpvQXiOKYyycEp8T/r+F8auJFHIDuh4GO/21VCNMtxJilTc1lmD3eTZkloQA9mNLhuh8
	27fj//WKTWkoMs/hxsDdB+YXFwcZCPgdA+AEzfOGSkeDpXkXlInIc+dGGrvzS83tsyYZMZCxFCd
	khiCNnW98BPpXlDQz1Wp6YefTXhPpV6Bv4MlzBGOVX1sxAM4KVw70KzyhetuuqmGuCIHCa3fDGp
	JHUbuAO3pW32EVrobebI/lfMu9QxbUgsxemKDtejmVqz+6/Xa644jLbQzqYj15Btb6gkl052y3Z
	XLE8vcq2VznuUEDzeG2406xjQ==
X-Received: by 2002:a05:600c:a10a:b0:485:3f72:324d with SMTP id 5b1f17b1804b1-48727e9ea73mr32263505e9.14.1774612126754;
        Fri, 27 Mar 2026 04:48:46 -0700 (PDT)
Received: from iris-Ian.fritz.box (p200300eb5f28a7005a7787565d4257d0.dip0.t-ipconnect.de. [2003:eb:5f28:a700:5a77:8756:5d42:57d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d49c18sm90506115e9.14.2026.03.27.04.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 04:48:46 -0700 (PDT)
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
Subject: [PATCH v6 0/3] Add Efinix FPGA configuration support
Date: Fri, 27 Mar 2026 12:48:38 +0100
Message-ID: <20260327114842.1300284-1-iansdannapel@gmail.com>
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

This is v6 of the series adding support for programming Efinix FPGAs
over SPI using the fpga-mgr subsystem.

The series adds DT bindings for the Efinix SPI configuration interface
and a new FPGA manager driver implementing passive SPI configuration.

Testing:
- Verified on a custom board with an Efinix Trion T13 FPGA
- Tested full bitstream configuration over SPI at 25 MHz

Changes since v5:

dt-bindings: vendor-prefix: Add prefix for Efinix, Inc.
- fixed trailer formatting

dt-bindings: fpga: Add Efinix SPI programming bindings
- renamed the binding from efinix,trion-spi.yaml to
  efinix,trion-config.yaml
- replaced the generic fallback approach with a family fallback scheme
- made efinix,trion-config the required fallback for Titanium and Topaz
- updated the example to use the new compatible naming
- added an example showing the fallback-compatible form
- removed driver-limitation wording from the binding description

fpga-mgr: Add Efinix SPI programming driver
- renamed compatibles from *-spi to *-config
- aligned the driver with the fallback-compatible scheme
- removed direct OF matching for Titanium and Topaz so binding happens
  via the Trion fallback compatible
- moved Kconfig and Makefile entries to the end of the FPGA manager
  sections
- fixed kernel-doc style multi-line comments
- documented why chip select must stay asserted across reset and
  bitstream transfer
- removed the redundant bus_locked state
- reordered probe initialization

Ian Dannapel (3):
  dt-bindings: vendor-prefix: Add prefix for Efinix, Inc.
  dt-bindings: fpga: Add Efinix SPI programming bindings
  fpga-mgr: Add Efinix SPI programming driver

 .../bindings/fpga/efinix,trion-config.yaml    |  96 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/fpga/Kconfig                          |   7 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/efinix-spi.c                     | 263 ++++++++++++++++++
 5 files changed, 369 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/efinix,trion-config.yaml
 create mode 100644 drivers/fpga/efinix-spi.c

-- 
2.43.0

