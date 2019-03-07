Return-Path: <SRS0=2IxU=RK=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=2IxU=RK=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-eopbgr730048.outbound.protection.outlook.com ([40.107.73.48]:41344
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726159AbfCGLGX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 7 Mar 2019 06:06:23 -0500
Subject: Re: FPGA Manager - Partial Reconfiguration support for Xilinx
 Zynq-7000
References: <5bdf4d79-c0d6-30c1-1eb0-360b7dce615b@gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <70789e51-cb23-9776-dafe-fb34a0736bad@xilinx.com>
Date: Thu, 7 Mar 2019 12:06:00 +0100
MIME-Version: 1.0
In-Reply-To: <5bdf4d79-c0d6-30c1-1eb0-360b7dce615b@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alper Yazar <alperyazar2@gmail.com>, linux-fpga@vger.kernel.org, Nava kishore Manne <navam@xilinx.com>
Cc: Ronan Keryell <rkeryell@xilinx.com>

Hi,

On 03. 03. 19 12:32, Alper Yazar wrote:
> Hi,
> 
> I asked the question on Xilinx forums about 1 months ago but didn't get any response [1]. I hope that someone on this list may guide me.
> 
> I am creating Linux based images for Zynq-7000 devices by using Petalinux 2018.3 which is a set of build tools provided by Xilinx. For FPGA management, FPGA Manager is included by default. However it doesn't support partial reconfiguration for Zynq-7000 devices as stated [2]. I tested and verified that it doesn't work. I assumed that /drivers/fpga/zynq-fpga.c is the source code, checked it and noticed some comments about partial reconfig. AFAIK previous driver used by Xilinx before FPGA Manager whose source code file is xilinx_devcfg.c supported partial reconfig. So I don't think that there is a hardware limitation since the previous solution was working on the same device. So I wonder why the newest method is less capable than the older one. I need partial reconfig support for the newest petalinux version. What should I do?
> 
> a) Compile old xilinx_devcfg.c driver for Petalinux 2018.3 and disable FPGA Manager. 
> 
> b) Somehow patch FPGA Manager
> 
> c) Wait (how long?) Xilinx to solve this issue
> 
> Two names are listed as MODULE_AUTHOR of zynq-fpga.c: Moritz Fischer and Michal Simek. I don't know whether they are subscribed to this list or not.
> 
> 
> [1]: https://forums.xilinx.com/t5/Embedded-Linux/Partial-Reconfiguration-support-in-Petalinux-2018-3-for-Zynq/td-p/934057
> [2]: https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841645/Solution+Zynq+PL+Programming+With+FPGA+Manager

Nava: Can you please check if partial reconfiguration is still working?
I see code in the driver.

Alper: Can you please use u-boot and check that your bitstreams are
correct?
Also will be good to have some logs to see what it is happening.

Thanks,
Michal
