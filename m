Return-Path: <SRS0=Ghnj=LS=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Ghnj=LS=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-dm3nam03on0074.outbound.protection.outlook.com ([104.47.41.74]:46560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbeIDLtU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 4 Sep 2018 07:49:20 -0400
From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [RFC PATCH v2 0/3] Add Bitstream configuration support for ZynqMP
Date: Wed, 5 Sep 2018 12:54:45 +0530
Message-ID: <20180905072448.12488-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, atull@kernel.org, mdf@kernel.org, jollys@xilinx.com, sboyd@kernel.org, rajanv@xilinx.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, chinnikishore369@gmail.com
Cc: Nava kishore Manne <nava.manne@xilinx.com>

This series of patches are created On top of the
below series of patches.
https://lkml.org/lkml/2018/8/3/687 

Nava kishore Manne (3):
  firmware: xilinx: Add fpga API's
  dt-bindings: fpga: Add bindings for ZynqMP fpga driver
  fpga manager: Adding FPGA Manager support for Xilinx zynqmp

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt  |  13 ++
 drivers/firmware/xilinx/zynqmp.c              |  46 +++++
 drivers/fpga/Kconfig                          |   9 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/zynqmp-fpga.c                    | 159 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |   4 +
 6 files changed, 232 insertions(+)
 create mode 100644 drivers/fpga/zynqmp-fpga.c

-- 
2.18.0
