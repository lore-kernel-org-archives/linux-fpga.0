Return-Path: <SRS0=Witp=DD=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Witp=DD=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from postout1.mail.lrz.de ([129.187.255.137]:47277 "EHLO
        postout1.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbdLGLAr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Dec 2017 06:00:47 -0500
From: "Siegmund, Jan" <jan.siegmund0@hm.edu>
Subject: WG: Linux hang
Date: Thu, 7 Dec 2017 11:00:45 +0000
Message-ID: <71bcb4759caa437dba81be27fc611239@hm.edu>
References: <4d6911ffa53349b0881ff4d4845bc101@hm.edu>
In-Reply-To: <4d6911ffa53349b0881ff4d4845bc101@hm.edu>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>

Hi all,
does anybody have an idea for the following problem?

* FPGA is programmed using an overlay
* FPGA writes to SDRAM via the FPGA2SDRAM-bridge
* Linux hangs and the watchdog resets the board (the FPGA stays programmed)
* After the reset and boot, the FPGA is reprogrammed using the same overlay
* Now, the FPGA can write to the SDRAM without a problem

The environment:

*Board:�� DE0-NANO-SoC
*U-Boot: 2017.11
*Kernel:� 4.14.0-rc7 (review-v4.14-rc7-non-dt-support-v5.1 branch)

The overlay:

/dts-v1/;
/plugin/;

/ {
������� fragment@0 {
��������������� target-path = "/soc/base_fpga_region";
��������������� #address-cells = <1>;
��������������� #size-cells = <1>;
��������������� __overlay__ {
����������������������� #address-cells = <1>;
����������������������� #size-cells = <1>;
����������������������� fpga-bridges = <&fpga_bridge0 &fpga_bridge1>;
����������������������� firmware-name = "foo_base.rbf";

����������������������� fpga-bridge@ffc25080 {
������������������������������� compatible = "altr,socfpga-fpga2sdram-bridge";
������������������������������� reg = <0xffc25080 0x4>;
������������������������������� bridge-enable = <1>;
����������������������� };

����������������������� foo@ff200000 {
������������������������������� compatible= "altr,bar";
������������������������������� interrupt-parent = <&intc>;
������������������������������� interrupts = <0 40 4>;
����������������������� };

��������������� };
������� };
};

Thanks