Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v11 0/2] fpga: Lattice MachXO2 Slave SPI FPGA Manager support
Date: Thu, 12 Apr 2018 10:13:46 -0500
Message-Id: <20180412151348.4584-1-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

This is Paolo's v10 with a minor fixup.  I had asked him to rebase his
patch on a branch with a new FPGA manager API.  That API change ended
up not going upstream, so I've fixed it for the current API.  This patch
applies cleanly on the current linux-next.

Paolo Pisati (2):
  dt: bindings: fpga: add lattice machxo2 slave spi binding description
  fpga: lattice machxo2: Add Lattice MachXO2 support

 .../bindings/fpga/lattice-machxo2-spi.txt          |  29 ++
 drivers/fpga/Kconfig                               |   7 +
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/machxo2-spi.c                         | 403 +++++++++++++++++++++
 4 files changed, 440 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
 create mode 100644 drivers/fpga/machxo2-spi.c

-- 
2.16.2
