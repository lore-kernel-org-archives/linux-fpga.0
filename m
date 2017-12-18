Return-Path: <SRS0=Gzx4=DO=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Gzx4=DO=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:39840 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758790AbdLRVFb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Dec 2017 16:05:31 -0500
Subject: Re: Socfpga: configure FPGA to SDRAM interface without reprogramming
 the FPGA
References: <db4aae59-d3fa-4904-c4ac-e96668667f3f@hm.edu>
From: Marek Vasut <marex@denx.de>
Message-ID: <cff49ca7-ce8b-d7f9-e2a8-b2149bfea756@denx.de>
Date: Mon, 18 Dec 2017 22:05:28 +0100
MIME-Version: 1.0
In-Reply-To: <db4aae59-d3fa-4904-c4ac-e96668667f3f@hm.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Jan Siegmund <jan.siegmund0@hm.edu>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>

On 12/18/2017 09:44 PM, Jan Siegmund wrote:
> Hi all,

Hi,

> Here is another question on the FPGA to SDRAM interface of the Cyclone V SoC.
> Is is possible to configure the the interface in U-Boot or SPL,

What is "the interface" ?

If you mean DRAM, then yes, the CV/AV do _not_ configure the FPGA in SPL
at all. They just configure the IOMUX/clock rings, but that's all.

> without reprogramming the FPGA? Maybe through the usage of the generated
> header files from the Quartus synthesis?
> The SDRAM controller's registers only differ in eight entries in Linux when the
> FPGA is programmed or not.
> 
> +----------+-------------+------------+----------------+
> | address  |    name     | programmed | not programmed |
> +----------+-------------+------------+----------------+
> | FFC25064 |             | 00044003   | 00044FFF       |
> | FFC25068 |             | 2C000000   | 2C03FFFF       |
> | FFC2506c |             | 00B00000   | 00B3FFFF       |
> | FFC25070 |             | 00760000   | 0076FFFF       |
> | FFC25074 |             | 00980000   | 0098FFFF       |
> | FFC25078 |             | 0005A003   | 0005AFFF       |
> | FFC2507c | portcfg     | 00000000   | 0000003F       |
> | FFC25080 | fpgaportrst | 000001FF   | 00000000       |
> +----------+-------------+------------+----------------+
> 
> The registers 0xFFC25064-0xFFC25078 don't show up on the HPS' memory map
> [1], so are they even intended to be configured?
> 
> Thanks
> 
> 
> 
> [1]
> https://www.altera.com/hps/cyclone-v/hps.html#topic/sfo1411577380716.html#sfo1411577380716
> 


-- 
Best regards,
Marek Vasut
