Return-Path: <SRS0=mQXS=DP=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=mQXS=DP=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from postout1.mail.lrz.de ([129.187.255.137]:46034 "EHLO
        postout1.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753727AbdLSX3Z (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 19 Dec 2017 18:29:25 -0500
Subject: Re: Socfpga: configure FPGA to SDRAM interface without reprogramming
 the FPGA
References: <db4aae59-d3fa-4904-c4ac-e96668667f3f@hm.edu>
 <cff49ca7-ce8b-d7f9-e2a8-b2149bfea756@denx.de>
From: Jan Siegmund <jan.siegmund0@hm.edu>
Message-ID: <05469a8c-cd1b-184a-024e-b6d0dc4e17f8@hm.edu>
Date: Wed, 20 Dec 2017 00:29:21 +0100
MIME-Version: 1.0
In-Reply-To: <cff49ca7-ce8b-d7f9-e2a8-b2149bfea756@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>

Am 18.12.2017 um 22:05 schrieb Marek Vasut:
> On 12/18/2017 09:44 PM, Jan Siegmund wrote:

Hi Marek,

>> Hi all,
> 
> Hi,
> 
>> Here is another question on the FPGA to SDRAM interface of the Cyclone V SoC.
>> Is is possible to configure the the interface in U-Boot or SPL,
> 
> What is "the interface" ?

I am sorry I did not specify it further. I meant the FPGA-to-HPS SDRAM interface
[2], sometimes called FPGA2SDRAM bridge.

> 
> If you mean DRAM, then yes, the CV/AV do _not_ configure the FPGA in SPL
> at all. They just configure the IOMUX/clock rings, but that's all.
> 

I know the FPGA is not configured in SPL, but does the FPGA need to be
configured in SPL or U-Boot, to use the FPGA-to-HPS SDRAM interface? Would it be
possible to just preset the registers for later configuration?
My preferred usecase would be configuring the registers in the table below in
SPL and configuring the FPGA in Linux, with a design using the FPGA-to-HPS SDRAM
interface.

For example, the last bits in the portcfg register define whether the
FPGA-to-HPS SDRAM interface's protocol is AXI or Avalon MM. The problem is, that
this register can't be written to in U-Boot, even though it is specified as rw
[3]. Can this register just be set by programming the FPGA?

>> without reprogramming the FPGA? Maybe through the usage of the generated
>> header files from the Quartus synthesis?
>> The SDRAM controller's registers only differ in eight entries in Linux when the
>> FPGA is programmed or not.
>>
>> +----------+-------------+------------+----------------+
>> | address  |    name     | programmed | not programmed |
>> +----------+-------------+------------+----------------+
>> | FFC25064 |             | 00044003   | 00044FFF       |
>> | FFC25068 |             | 2C000000   | 2C03FFFF       |
>> | FFC2506c |             | 00B00000   | 00B3FFFF       |
>> | FFC25070 |             | 00760000   | 0076FFFF       |
>> | FFC25074 |             | 00980000   | 0098FFFF       |
>> | FFC25078 |             | 0005A003   | 0005AFFF       |
>> | FFC2507c | portcfg     | 00000000   | 0000003F       |
>> | FFC25080 | fpgaportrst | 000001FF   | 00000000       |
>> +----------+-------------+------------+----------------+
>>
>> The registers 0xFFC25064-0xFFC25078 don't show up on the HPS' memory map
>> [1], so are they even intended to be configured?
>>
>> Thanks
>>
>>
>>
>> [1]
>> https://www.altera.com/hps/cyclone-v/hps.html#topic/sfo1411577380716.html#sfo1411577380716
>>
> 
> 

Best regards,
Jan

[2]
https://www.altera.com/documentation/sfo1410143707420.html#sfo1411577336440__section_N10012_N1000F_N10001


[3] https://www.altera.com/hps/cyclone-v/hps.html#topic/sfo1411577375739.html
