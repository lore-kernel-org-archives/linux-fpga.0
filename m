Return-Path: <SRS0=Witp=DD=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Witp=DD=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from postout2.mail.lrz.de ([129.187.255.138]:46122 "EHLO
        postout2.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdLGT6V (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Dec 2017 14:58:21 -0500
Subject: Re: [U-Boot] Linux hang
References: <4d6911ffa53349b0881ff4d4845bc101@hm.edu>
 <71bcb4759caa437dba81be27fc611239@hm.edu>
 <FD897F46D140444CAB8DC80B08F0742B0185ACFB62@PFDE-MX11.EU.P-F.BIZ>
From: Jan Siegmund <jan.siegmund0@hm.edu>
Message-ID: <d4b1fd6b-4c10-231c-1246-a1469dabd554@hm.edu>
Date: Thu, 7 Dec 2017 20:58:19 +0100
MIME-Version: 1.0
In-Reply-To: <FD897F46D140444CAB8DC80B08F0742B0185ACFB62@PFDE-MX11.EU.P-F.BIZ>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>

Am 07.12.2017 um 15:01 schrieb Goldschmidt Simon:
> On 2017-12-07 12:01, Siegmund, Jan wrote:
>> Hi all,
>> does anybody have an idea for the following problem?
>>
>> * FPGA is programmed using an overlay
>> * FPGA writes to SDRAM via the FPGA2SDRAM-bridge
>> * Linux hangs and the watchdog resets the board (the FPGA stays programmed)
>> * After the reset and boot, the FPGA is reprogrammed using the same overlay
>> * Now, the FPGA can write to the SDRAM without a problem
>> [..]
> 
> I haven't tried this method of programming the fpga yet (only
> programmed from U-Boot for now). But reading the SPL source code, it
> seems as the bridges are taken out of reset if the fpga is programmed
> when the SPL runs. That's a difference. And it would mean using your
> way of programming the fpga, the bridges might still be in reset.

Usually, the bridges specified in the DT Overlay are automatically 
disabled before programming and re-enabled after it. I can also write
to the lwHPS2FPGA bridge and the FPGA accepts the data, so I don't
consider this to be the problem. Besides, I am using the FPGA-to-SDRAM 
interface directly connected to the SDRAM subsystem of the HPS 
(https://www.altera.com/documentation/sfo1410143707420.html#sfo1410067640997) 
and the resets are only targeting lwHPS2FPGA, HPS2FPGA and FPGA2HPS.
But your idea could go in the right direction, because some registers 
are set differently, when the FPGA is already in user mode.

Thanks,
Jan

> Regards,
> Simon


