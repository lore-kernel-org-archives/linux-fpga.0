Return-Path: <SRS0=I4wK=HG=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=I4wK=HG=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44507 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeDQERK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 Apr 2018 00:17:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id p15so11554197pff.11
        for <linux-fpga@vger.kernel.org>; Mon, 16 Apr 2018 21:17:09 -0700 (PDT)
Received: from localhost (c-107-3-165-230.hsd1.ca.comcast.net. [107.3.165.230])
        by smtp.gmail.com with ESMTPSA id n83sm9540578pfi.183.2018.04.16.21.17.08
        for <linux-fpga@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 21:17:08 -0700 (PDT)
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 0/3] FPGA Manager Patches for 4.18
Date: Mon, 16 Apr 2018 21:17:04 -0700
Message-Id: <20180417041707.11417-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org

Hi Greg,

Please queue the following patches for v4.18.

Alan's Patch clarifies the locking in the fpga-region code.

Paolo's patches add a new driver with corresponding bindings for a
Lattice FPGA part.

Thanks,

Moritz

Alan Tull (1):
  fpga: fpga-region: comment on fpga_region_program_fpga locking

Paolo Pisati (2):
  dt: bindings: fpga: add lattice machxo2 slave spi binding description
  fpga: lattice machxo2: Add Lattice MachXO2 support

 .../bindings/fpga/lattice-machxo2-spi.txt     |  29 ++
 drivers/fpga/Kconfig                          |   7 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/fpga-region.c                    |   5 +
 drivers/fpga/machxo2-spi.c                    | 403 ++++++++++++++++++
 5 files changed, 445 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
 create mode 100644 drivers/fpga/machxo2-spi.c

-- 
2.17.0

