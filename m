Return-Path: <SRS0=HHoX=DH=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=HHoX=DH=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from postout1.mail.lrz.de ([129.187.255.137]:41143 "EHLO
        postout1.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752598AbdLKQXL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 11 Dec 2017 11:23:11 -0500
Subject: Re: Linux hang
References: <4d6911ffa53349b0881ff4d4845bc101@hm.edu>
 <20171208145230.36cce190@crub>
From: Jan Siegmund <jan.siegmund0@hm.edu>
Message-ID: <759ae2df-e12f-859a-2a5d-dff32489ace8@hm.edu>
Date: Mon, 11 Dec 2017 17:23:08 +0100
MIME-Version: 1.0
In-Reply-To: <20171208145230.36cce190@crub>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>

Am 08.12.2017 um 14:52 schrieb Anatolij Gustschin:
> Hi,
> 
> On Wed, 6 Dec 2017 17:02:07 +0000
> Siegmund, Jan jan.siegmund0@hm.edu wrote:
> 
>> Hi all,
>> does anybody have an idea for the following problem.
>>
>> * FPGA is programmed using an overlay
>> * FPGA writes to SDRAM via the FPGA2SDRAM-bridge
>> * Linux hangs and the watchdog resets the board (the FPGA stays programmed)
>> * After the reset and boot the FPGA is reprogrammed using the same overlay
>> * Now, the FPGA can write to the SDRAM without a problem
> 
> Probably because configuration of the FPGA2SDRAM-bridge is different than
> other bridges. There is an important step needed, setting APPLYCFG bit in
> the STATICCFG register [1]. But this must be done when the DDR interface
> is idle (no DRAM transfer from ARM-core or DMA) which is not the case when
> Linux is running. Therefore, if you have designs that use fpga2sdram, you
> have to program the FPGA under U-Boot. U-Boot fpga command runs APPLYCFG
> setting code from OCRAM.

Thanks, this has helped me a lot. But there was still something
missing. First, the FPGA needs to be programmed in U-Boot using the 
'fpga' command. Then 'bridge enable' has to be called. This command
does not only get the lwHPS2FPGA, HPS2FPGA and FPGA2HPS bridges out of 
reset, but also applies the SDRAM config, like you described.
Now, my SDRAM-to-FPGA interface works fine.

Regards,
Jan

> 
> Anatolij
> 
> [1] https://support.criticallink.com/redmine/projects/mityarm-5cs/wiki/Important_Note_about_FPGAHPS_SDRAM_Bridge
> 
