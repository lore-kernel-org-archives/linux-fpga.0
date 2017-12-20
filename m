Return-Path: <SRS0=bpQk=DQ=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=bpQk=DQ=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:38683 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754380AbdLTQhA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 20 Dec 2017 11:37:00 -0500
Subject: Re: Socfpga: configure FPGA to SDRAM interface without reprogramming
 the FPGA
References: <db4aae59-d3fa-4904-c4ac-e96668667f3f@hm.edu>
 <cff49ca7-ce8b-d7f9-e2a8-b2149bfea756@denx.de>
 <05469a8c-cd1b-184a-024e-b6d0dc4e17f8@hm.edu>
 <7082fb57-aaae-c2f7-10d3-a7863929578c@denx.de>
 <231101b7-30ee-6d13-0fec-6485e84e8d77@hm.edu>
From: Marek Vasut <marex@denx.de>
Message-ID: <9ac9473f-f561-7737-afff-d6cadeba8dfc@denx.de>
Date: Wed, 20 Dec 2017 16:06:21 +0100
MIME-Version: 1.0
In-Reply-To: <231101b7-30ee-6d13-0fec-6485e84e8d77@hm.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Jan Siegmund <jan.siegmund0@hm.edu>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, "See, Chin Liang" <chin.liang.see@intel.com>

On 12/20/2017 12:51 PM, Jan Siegmund wrote:
[...]
>>> My preferred usecase would be configuring the registers in the table below in
>>> SPL and configuring the FPGA in Linux, with a design using the FPGA-to-HPS SDRAM
>>> interface.
>>>
>>> For example, the last bits in the portcfg register define whether the
>>> FPGA-to-HPS SDRAM interface's protocol is AXI or Avalon MM. The problem is, that
>>> this register can't be written to in U-Boot, even though it is specified as rw
>>> [3]. Can this register just be set by programming the FPGA?
>>
>> You might need to regenerate the SPL if you changed those kinds of
>> settings. The SPL programs these based on the handoff files IIRC.
> 
> I generated the headers using the bsp-editor from Quartus 17 and converted them
> using the qts-filter.sh script in U-Boot. Since then, I did not change any settings.
> 
> sdram.h in board/.../qts and mach-socfpga/
> 
> 	#define CONFIG_HPS_SDR_CTRLCFG_PORTCFG_AUTOPCHEN	0
> 
> 	#define SDR_CTRLGRP_PORTCFG_AUTOPCHEN_LSB		10
> 
> wrap_sdram_config.c
> 	.port_cfg =
> 		(CONFIG_HPS_SDR_CTRLCFG_PORTCFG_AUTOPCHEN <<
> 			SDR_CTRLGRP_PORTCFG_AUTOPCHEN_LSB),
> 
> sdram.c
> 	debug("Configuring PORTCFG\n");
> 	writel(cfg->port_cfg, &sdr_ctrl->port_cfg);
> 
> When I add some debug printing around the code shown above, SPL console shows this:
> 
> U-Boot SPL 2018.01-rc1-00129-ga8548b9-dirty (Dec 18 2017 - 14:13:21)
> Content of ffc2507c is 3f
> Wrote 0 to ffc2507c
> Content of ffc2507c is 3f
> drivers/ddr/altera/sequencer.c: Preparing to start memory calibration
> drivers/ddr/altera/sequencer.c: CALIBRATION PASSED
> drivers/ddr/altera/sequencer.c: Calibration complete
> Trying to boot from MMC1
> 
> Maybe the portprotocol part of portcfg is just a status register. But then
> again, why would it be specified as rw?

It should be RW actually.

> Do you have any idea what I might be missing, to get the f2s running without
> programming the FPGA?
CCing Dinh and Chin.

-- 
Best regards,
Marek Vasut
