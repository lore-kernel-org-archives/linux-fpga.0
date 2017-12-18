Return-Path: <SRS0=Gzx4=DO=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Gzx4=DO=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from postout1.mail.lrz.de ([129.187.255.137]:55474 "EHLO
        postout1.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758651AbdLRUo1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Dec 2017 15:44:27 -0500
From: Jan Siegmund <jan.siegmund0@hm.edu>
Subject: Socfpga: configure FPGA to SDRAM interface without reprogramming the
 FPGA
Message-ID: <db4aae59-d3fa-4904-c4ac-e96668667f3f@hm.edu>
Date: Mon, 18 Dec 2017 21:44:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, marex@denx.de

Hi all,
Here is another question on the FPGA to SDRAM interface of the Cyclone V SoC.
Is is possible to configure the the interface in U-Boot or SPL,
without reprogramming the FPGA? Maybe through the usage of the generated
header files from the Quartus synthesis?
The SDRAM controller's registers only differ in eight entries in Linux when the
FPGA is programmed or not.

+----------+-------------+------------+----------------+
| address  |    name     | programmed | not programmed |
+----------+-------------+------------+----------------+
| FFC25064 |             | 00044003   | 00044FFF       |
| FFC25068 |             | 2C000000   | 2C03FFFF       |
| FFC2506c |             | 00B00000   | 00B3FFFF       |
| FFC25070 |             | 00760000   | 0076FFFF       |
| FFC25074 |             | 00980000   | 0098FFFF       |
| FFC25078 |             | 0005A003   | 0005AFFF       |
| FFC2507c | portcfg     | 00000000   | 0000003F       |
| FFC25080 | fpgaportrst | 000001FF   | 00000000       |
+----------+-------------+------------+----------------+

The registers 0xFFC25064-0xFFC25078 don't show up on the HPS' memory map
[1], so are they even intended to be configured?

Thanks



[1]
https://www.altera.com/hps/cyclone-v/hps.html#topic/sfo1411577380716.html#sfo1411577380716
