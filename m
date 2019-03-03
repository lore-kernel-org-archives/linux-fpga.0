Return-Path: <SRS0=9FGq=RG=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=9FGq=RG=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-wm1-f52.google.com ([209.85.128.52]:56002 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfCCLc0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 3 Mar 2019 06:32:26 -0500
Received: by mail-wm1-f52.google.com with SMTP id q187so1999883wme.5
        for <linux-fpga@vger.kernel.org>; Sun, 03 Mar 2019 03:32:24 -0800 (PST)
Received: from [192.168.0.18] ([94.54.58.88])
        by smtp.gmail.com with ESMTPSA id b197sm3350214wmd.23.2019.03.03.03.32.22
        for <linux-fpga@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 03:32:23 -0800 (PST)
From: Alper Yazar <alperyazar2@gmail.com>
Subject: FPGA Manager - Partial Reconfiguration support for Xilinx Zynq-7000
Message-ID: <5bdf4d79-c0d6-30c1-1eb0-360b7dce615b@gmail.com>
Date: Sun, 3 Mar 2019 14:32:21 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org

Hi,

I asked the question on Xilinx forums about 1 months ago but didn't get any response [1]. I hope that someone on this list may guide me.

I am creating Linux based images for Zynq-7000 devices by using Petalinux 2018.3 which is a set of build tools provided by Xilinx. For FPGA management, FPGA Manager is included by default. However it doesn't support partial reconfiguration for Zynq-7000 devices as stated [2]. I tested and verified that it doesn't work. I assumed that /drivers/fpga/zynq-fpga.c is the source code, checked it and noticed some comments about partial reconfig. AFAIK previous driver used by Xilinx before FPGA Manager whose source code file is xilinx_devcfg.c supported partial reconfig. So I don't think that there is a hardware limitation since the previous solution was working on the same device. So I wonder why the newest method is less capable than the older one. I need partial reconfig support for the newest petalinux version. What should I do?

a) Compile old xilinx_devcfg.c driver for Petalinux 2018.3 and disable FPGA Manager. 

b) Somehow patch FPGA Manager

c) Wait (how long?) Xilinx to solve this issue

Two names are listed as MODULE_AUTHOR of zynq-fpga.c: Moritz Fischer and Michal Simek. I don't know whether they are subscribed to this list or not.


[1]: https://forums.xilinx.com/t5/Embedded-Linux/Partial-Reconfiguration-support-in-Petalinux-2018-3-for-Zynq/td-p/934057
[2]: https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841645/Solution+Zynq+PL+Programming+With+FPGA+Manager

Best,
Alper
