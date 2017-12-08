Return-Path: <SRS0=YrFZ=DE=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=YrFZ=DE=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:46619 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbdLHNwh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 8 Dec 2017 08:52:37 -0500
Date: Fri, 8 Dec 2017 14:52:30 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: Linux hang
Message-ID: <20171208145230.36cce190@crub>
In-Reply-To: <4d6911ffa53349b0881ff4d4845bc101@hm.edu>
References: <4d6911ffa53349b0881ff4d4845bc101@hm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: "Siegmund, Jan" <jan.siegmund0@hm.edu>
Cc: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>

Hi,

On Wed, 6 Dec 2017 17:02:07 +0000
Siegmund, Jan jan.siegmund0@hm.edu wrote:

>Hi all,
>does anybody have an idea for the following problem.
>
>* FPGA is programmed using an overlay
>* FPGA writes to SDRAM via the FPGA2SDRAM-bridge
>* Linux hangs and the watchdog resets the board (the FPGA stays programmed)
>* After the reset and boot the FPGA is reprogrammed using the same overlay
>* Now, the FPGA can write to the SDRAM without a problem

Probably because configuration of the FPGA2SDRAM-bridge is different than
other bridges. There is an important step needed, setting APPLYCFG bit in
the STATICCFG register [1]. But this must be done when the DDR interface
is idle (no DRAM transfer from ARM-core or DMA) which is not the case when
Linux is running. Therefore, if you have designs that use fpga2sdram, you
have to program the FPGA under U-Boot. U-Boot fpga command runs APPLYCFG
setting code from OCRAM.

Anatolij

[1] https://support.criticallink.com/redmine/projects/mityarm-5cs/wiki/Important_Note_about_FPGAHPS_SDRAM_Bridge
