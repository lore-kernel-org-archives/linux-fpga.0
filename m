Return-Path: <SRS0=FAKN=QR=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=FAKN=QR=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-eopbgr730043.outbound.protection.outlook.com ([40.107.73.43]:11296
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbfBJQNd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 10 Feb 2019 11:13:33 -0500
From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3 0/3] Add Bitstream configuration support for ZynqMP  
Date: Mon, 11 Feb 2019 21:43:35 +0530
Message-ID: <20190211161335.23463-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com, jollys@xilinx.com, nava.manne@xilinx.com, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chinnikishore369@gmail.com

Nava kishore Manne (3):
  firmware: xilinx: Add fpga API's
  dt-bindings: fpga: Add bindings for ZynqMP fpga driver
  fpga manager: Adding FPGA Manager support for Xilinx zynqmp

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt        |  13 ++
 drivers/firmware/xilinx/zynqmp.c                   |  46 ++++++
 drivers/fpga/Kconfig                               |   9 ++
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/zynqmp-fpga.c                         | 165 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  12 ++
 6 files changed, 246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
 create mode 100644 drivers/fpga/zynqmp-fpga.c

-- 
2.7.4
