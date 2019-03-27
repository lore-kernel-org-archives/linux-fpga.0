Return-Path: <SRS0=0fI7=R6=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=0fI7=R6=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-eopbgr90053.outbound.protection.outlook.com ([40.107.9.53]:61520
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727454AbfC0RRn (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 27 Mar 2019 13:17:43 -0400
From: Federico Vaga <federico.vaga@cern.ch>
Reply-To: <federico.vaga@cern.ch>
Subject: Device Description for FPGA Components on x86 system
Date: Wed, 27 Mar 2019 18:17:18 +0100
Message-ID: <1629227.alSmCsHHUc@pcbe13614>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-x86_64@vger.kernel.org

Hello,

I'm looking for guidance

What I have:
* Intel x86_64 computer
* PCIe card with FPGA on it

What I want to achieve:
* load an FPGA bitstream on the card
* load a device-tree like description for the FPGA devices contained in the 
bitstream

This is achievable on ARM with DeviceTree, overlay-dt, fpga-mgr; but I'm 
puzzled about the x86_64 use-case. I'm not able to find recent and clear 
information.

Does anyone know if this is doable? Perhaps with ACPI SSDTs overlay? Or with 
the DT?

thanks 
