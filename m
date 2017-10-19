Return-Path: <SRS0=xl3R=BS=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=xl3R=BS=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:53122 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbdJSWPD (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 19 Oct 2017 18:15:03 -0400
From: matthew.gerlach@linux.intel.com
Subject: [PATCH v3 0/2] Altera ASMI Parallel II IP Core
Date: Thu, 19 Oct 2017 15:14:48 -0700
Message-Id: <1508451290-26426-1-git-send-email-matthew.gerlach@linux.intel.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: vndao@altera.com, dwmw2@infradead.org, computersforpeace@gmail.com, boris.brezillon@free-electrons.com, marek.vasut@gmail.com, richard@nod.at, cyrille.pitchen@wedev4u.fr, robh+dt@kernel.org, mark.rutland@arm.com, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, davem@davemloft.net, mchehab@kernel.org, linux-fpga@vger.kernel.org, tien.hock.loh@intel.com, hean.loong.ong@intel.com
Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patch set adds a spi-nor flash driver for the Altera ASMI Parallel II 
IP Core.  This driver was created based on feedback from Marek Vasut,
Cyrill Pitchen, and Michal Suchanek regarding Version 2 of the Altera
Quadspi Controller: https://lkml.org/lkml/2017/6/26/518

The overall problem with Version 2 of the Altera Quadspi Controller and 
its driver was the fact that there was much duplication of code and logic
with the spi-nor framework.  This new combination of fpga hardware and 
software "gets out of the way" of the spi-nor framework.  The result is a
much simpler driver with the spi-nor framework performing the bulk of the work.

Patch 1 contains the device tree bindings for the driver for
the Altera ASMI-Parallel II IP Core.

Patch 2 contains the driver code for the Altera ASMI-Parallel II IP Core.
This driver supports being configured via a device tree or with platform
data.  In the later case, the memory for the registers has been remapped.

Matthew Gerlach (2):
  dt-bindings: mtd: Altera ASMI Parallel II IP Core
  mtd: spi-nor: Altera ASMI Parallel II IP Core

 .../devicetree/bindings/mtd/altera-asmip2.txt      |  15 +
 MAINTAINERS                                        |   7 +
 drivers/mtd/spi-nor/Kconfig                        |   6 +
 drivers/mtd/spi-nor/Makefile                       |   1 +
 drivers/mtd/spi-nor/altera-asmip2.c                | 494 +++++++++++++++++++++
 include/linux/mtd/altera-asmip2.h                  |  25 ++
 6 files changed, 548 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/altera-asmip2.txt
 create mode 100644 drivers/mtd/spi-nor/altera-asmip2.c
 create mode 100644 include/linux/mtd/altera-asmip2.h

-- 
2.7.4

