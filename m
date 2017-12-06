Return-Path: <SRS0=iDbC=DC=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=iDbC=DC=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from postout2.mail.lrz.de ([129.187.255.138]:35807 "EHLO
        postout2.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbdLFRHs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 6 Dec 2017 12:07:48 -0500
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
        by postout2.mail.lrz.de (Postfix) with ESMTP id 3ysPzh4K87zyTD
        for <linux-fpga@vger.kernel.org>; Wed,  6 Dec 2017 18:02:08 +0100 (CET)
Received: from postout2.mail.lrz.de ([127.0.0.1])
        by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id sAL29OHFxlBM for <linux-fpga@vger.kernel.org>;
        Wed,  6 Dec 2017 18:02:08 +0100 (CET)
Received: from BADWLRZ-SWMBX10.ads.mwn.de (BADWLRZ-SWMBX10.ads.mwn.de [IPv6:2001:4ca0:0:108::166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "BADWLRZ-SWMBX10", Issuer "BADWLRZ-SWMBX10" (not verified))
        by postout2.mail.lrz.de (Postfix) with ESMTPS id 3ysPzh1cQ1zyTj
        for <linux-fpga@vger.kernel.org>; Wed,  6 Dec 2017 18:02:08 +0100 (CET)
From: "Siegmund, Jan" <jan.siegmund0@hm.edu>
Subject: Linux hang
Date: Wed, 6 Dec 2017 17:02:07 +0000
Message-ID: <4d6911ffa53349b0881ff4d4845bc101@hm.edu>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>


Hi all,
does anybody have an idea for the following problem.

* FPGA is programmed using an overlay
* FPGA writes to SDRAM via the FPGA2SDRAM-bridge
* Linux hangs and the watchdog resets the board (the FPGA stays programmed)
* After the reset and boot the FPGA is reprogrammed using the same overlay
* Now, the FPGA can write to the SDRAM without a problem

The environment:

*Board:   DE0-NANO-SoC
*U-Boot: 2017.11
*Kernel:  4.14.0-rc7 (review-v4.14-rc7-non-dt-support-v5.1 branch)

The overlay:

/dts-v1/;
/plugin/;

/ {
	fragment@0 {
		target-path = "/soc/base_fpga_region";
		#address-cells = <1>;
		#size-cells = <1>;
		__overlay__ {
			#address-cells = <1>;
			#size-cells = <1>;
			fpga-bridges = <&fpga_bridge0 &fpga_bridge1>;
			firmware-name = "foo_base.rbf";

			fpga-bridge@ffc25080 {
				compatible = "altr,socfpga-fpga2sdram-bridge";
				reg = <0xffc25080 0x4>;
				bridge-enable = <1>;
			};

			foo@ff200000 {
				compatible= "altr,bar";
				interrupt-parent = <&intc>;
				interrupts = <0 40 4>;
			};

		};
	};
};

Thanks