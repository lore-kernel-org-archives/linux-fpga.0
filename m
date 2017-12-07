Return-Path: <SRS0=Witp=DD=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Witp=DD=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbdLGTUe (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 7 Dec 2017 14:20:34 -0500
Received: from mail-ua0-f172.google.com (mail-ua0-f172.google.com [209.85.217.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA830219AD
        for <linux-fpga@vger.kernel.org>; Thu,  7 Dec 2017 19:20:33 +0000 (UTC)
Received: by mail-ua0-f172.google.com with SMTP id p33so6016619uag.9
        for <linux-fpga@vger.kernel.org>; Thu, 07 Dec 2017 11:20:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <71bcb4759caa437dba81be27fc611239@hm.edu>
References: <4d6911ffa53349b0881ff4d4845bc101@hm.edu> <71bcb4759caa437dba81be27fc611239@hm.edu>
From: Alan Tull <atull@kernel.org>
Date: Thu, 7 Dec 2017 13:19:52 -0600
Message-ID: <CANk1AXSJc88PcVpDsipDr+1PMjJkCxdnyPfsOGqfuzz2zEWb5Q@mail.gmail.com>
Subject: Re: Linux hang
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: "Siegmund, Jan" <jan.siegmund0@hm.edu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, matthew.gerlach@linux.intel.com

On Thu, Dec 7, 2017 at 5:00 AM, Siegmund, Jan <jan.siegmund0@hm.edu> wrote:

Hi SIegmund,

> Hi all,
> does anybody have an idea for the following problem?
>
> * FPGA is programmed using an overlay
> * FPGA writes to SDRAM via the FPGA2SDRAM-bridge
> * Linux hangs and the watchdog resets the board (the FPGA stays programmed)
> * After the reset and boot, the FPGA is reprogrammed using the same overlay
> * Now, the FPGA can write to the SDRAM without a problem
>
> The environment:
>
> *Board:   DE0-NANO-SoC
> *U-Boot: 2017.11
> *Kernel:  4.14.0-rc7 (review-v4.14-rc7-non-dt-support-v5.1 branch)
>
> The overlay:
>
> /dts-v1/;
> /plugin/;
>
> / {
>         fragment@0 {
>                 target-path = "/soc/base_fpga_region";
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 __overlay__ {
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         fpga-bridges = <&fpga_bridge0 &fpga_bridge1>;
>                         firmware-name = "foo_base.rbf";
>
>                         fpga-bridge@ffc25080 {
>                                 compatible = "altr,socfpga-fpga2sdram-bridge";
>                                 reg = <0xffc25080 0x4>;
>                                 bridge-enable = <1>;
>                         };

It's been a while since I've touched that bridge, but here's what I
can think of, hope it helps.

This overlay will add the bridge after programming.  It looks like it
should enable it since you have bridge-enable = <1>, so I'm not sure
why that's not working.

Would it make sense to add the f2s bridge before doing the fpga
programming?  You could add the f2s bridge in the base device tree and
add it to your fpga-bridges list so that that bridge is enabled after
the fpga is programmed.

Alan

>
>                         foo@ff200000 {
>                                 compatible= "altr,bar";
>                                 interrupt-parent = <&intc>;
>                                 interrupts = <0 40 4>;
>                         };
>
>                 };
>         };
> };
>
> Thanks--
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
