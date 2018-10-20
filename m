Return-Path: <SRS0=lgA+=M7=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=lgA+=M7=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:58048
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726698AbeJSQys (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 19 Oct 2018 12:54:48 -0400
From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 0/3] Add Bitstream configuration support for ZynqMP
Date: Sat, 20 Oct 2018 14:18:02 +0530
Message-ID: <20181020084805.29103-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com, jollys@xilinx.com, nava.manne@xilinx.com, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chinnikishore369@gmail.com

This series of patches are created On top of the
below repo.
//git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
BRANCH: next/drivers.  

Nava kishore Manne (3):
  firmware: xilinx: Add fpga API's
  dt-bindings: fpga: Add bindings for ZynqMP fpga driver
  fpga manager: Adding FPGA Manager support for Xilinx zynqmp

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   |  17 ++
 drivers/firmware/xilinx/zynqmp.c              |  46 +++++
 drivers/fpga/Kconfig                          |   9 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/zynqmp-fpga.c                    | 159 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |   4 +
 6 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
 create mode 100644 drivers/fpga/zynqmp-fpga.c

-- 
2.18.0
