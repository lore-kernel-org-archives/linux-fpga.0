Return-Path: <SRS0=Witp=DD=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Witp=DD=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from postout1.mail.lrz.de ([129.187.255.137]:44123 "EHLO
        postout1.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdLGUO5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Dec 2017 15:14:57 -0500
Subject: Re: Linux hang
References: <4d6911ffa53349b0881ff4d4845bc101@hm.edu>
 <71bcb4759caa437dba81be27fc611239@hm.edu>
 <CANk1AXSJc88PcVpDsipDr+1PMjJkCxdnyPfsOGqfuzz2zEWb5Q@mail.gmail.com>
From: Jan Siegmund <jan.siegmund0@hm.edu>
Message-ID: <889a3fd6-5935-899c-a1da-ee974aa6e30e@hm.edu>
Date: Thu, 7 Dec 2017 21:14:54 +0100
MIME-Version: 1.0
In-Reply-To: <CANk1AXSJc88PcVpDsipDr+1PMjJkCxdnyPfsOGqfuzz2zEWb5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, matthew.gerlach@linux.intel.com

Am 07.12.2017 um 20:19 schrieb Alan Tull:
> On Thu, Dec 7, 2017 at 5:00 AM, Siegmund, Jan <jan.siegmund0@hm.edu> wrote:
> 
> Hi SIegmund,
> 
>> Hi all,
>> does anybody have an idea for the following problem?
>>
>> * FPGA is programmed using an overlay
>> * FPGA writes to SDRAM via the FPGA2SDRAM-bridge
>> * Linux hangs and the watchdog resets the board (the FPGA stays programmed)
>> * After the reset and boot, the FPGA is reprogrammed using the same overlay
>> * Now, the FPGA can write to the SDRAM without a problem
>>
>> The environment:
>>
>> *Board:   DE0-NANO-SoC
>> *U-Boot: 2017.11
>> *Kernel:  4.14.0-rc7 (review-v4.14-rc7-non-dt-support-v5.1 branch)
>>
>> The overlay:
>>
>> /dts-v1/;
>> /plugin/;
>>
>> / {
>>          fragment@0 {
>>                  target-path = "/soc/base_fpga_region";
>>                  #address-cells = <1>;
>>                  #size-cells = <1>;
>>                  __overlay__ {
>>                          #address-cells = <1>;
>>                          #size-cells = <1>;
>>                          fpga-bridges = <&fpga_bridge0 &fpga_bridge1>;
>>                          firmware-name = "foo_base.rbf";
>>
>>                          fpga-bridge@ffc25080 {
>>                                  compatible = "altr,socfpga-fpga2sdram-bridge";
>>                                  reg = <0xffc25080 0x4>;
>>                                  bridge-enable = <1>;
>>                          };
> 
> It's been a while since I've touched that bridge, but here's what I
> can think of, hope it helps.
> 
> This overlay will add the bridge after programming.  It looks like it
> should enable it since you have bridge-enable = <1>, so I'm not sure
> why that's not working.
> 
> Would it make sense to add the f2s bridge before doing the fpga
> programming?  You could add the f2s bridge in the base device tree and
> add it to your fpga-bridges list so that that bridge is enabled after
> the fpga is programmed.

Hi Alan,
this might be worth a try.

Thanks,
Jan

> 
> Alan
> 
>>
>>                          foo@ff200000 {
>>                                  compatible= "altr,bar";
>>                                  interrupt-parent = <&intc>;
>>                                  interrupts = <0 40 4>;
>>                          };
>>
>>                  };
>>          };
>> };
>>
>> Thanks
> 
