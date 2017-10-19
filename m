Return-Path: <SRS0=xl3R=BS=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=xl3R=BS=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753365AbdJSOaG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 19 Oct 2017 10:30:06 -0400
MIME-Version: 1.0
In-Reply-To: <59E7D6E0.5030109@gmail.com>
References: <CANk1AXQaXKud2Mic_879JiS39hJB4y0uTS2w1uxXje-0mO68Vw@mail.gmail.com>
 <59E7ACA0.7030809@gmail.com> <CAL_Jsq+f4Y1DDB4ZkXAEKUZ_P9YdMUKMhr2E=VKtbHWMZFaO0w@mail.gmail.com>
 <59E7D6E0.5030109@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 19 Oct 2017 09:29:24 -0500
Message-ID: <CANk1AXQ4bkL+FWEqf7X9fNgrdTJoPWoMr+CMFxo6Dk1m_CmR1g@mail.gmail.com>
Subject: Re: dtc issue with overlays starting in next-20171009
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Devicetree Compiler <devicetree-compiler@vger.kernel.org>

On Wed, Oct 18, 2017 at 5:34 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> On 10/18/17 13:16, Rob Herring wrote:
>> Use devicetree-compiler list for dtc issues please.
>>
>> On Wed, Oct 18, 2017 at 2:33 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>>> Hi Rob, Alan,
>>>
>>> On 10/18/17 08:58, Alan Tull wrote:
>>>> Hi Rob,
>>>>
>>>> I've noticed a problem compiling DT overlays and traced it back to
>>>> beginning in next-20171009
>>>>
>>>> That tag adds the following in scripts/dtc
>>>>
>>>> e9480c1 2017-10-09 16:17:32 +0100 : Mark Brown : Merge remote-tracking
>>>> branch 'devicetree/for-next'
>>>> 4201d05 2017-10-03 15:03:47 -0500 : Rob Herring : scripts/dtc: Update
>>>> to upstream version v1.4.5-3-gb1a60033c110
>>>> 4322323 2017-10-03 15:03:46 -0500 : Rob Herring : scripts/dtc: add
>>>> fdt_overlay.c and fdt_addresses.c to sync script
>>>>
>>>> The error is:
>>>>
>>>> dtc: /home/atull/repos/linux-socfpga/scripts/dtc/livetree.c:543:
>>>> get_node_by_phandle: Assertion `(phandle != 0) && (phandle != -1)'
>>>> failed.
>>>> arch/arm/boot/dts/socfpga_overlay.dtb: Warning (clocks_property):
>>>> Could not get phandle node for
>>>> /fragment@0/__overlay__/gpio@10040:clocks(cell 0)
>>>> Aborted (core dumped)
>>>> scripts/Makefile.lib:316: recipe for target
>>>> 'arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dtb'
>>>> failed
>>>> make[2]: *** [arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dtb]
>>>> Error 134
>>>> arch/arm/Makefile:346: recipe for target 'dtbs' failed
>>>>
>>>> Here's a simplified overlay that gets this error.  Taking out the line
>>>> "interrupt-parent = <&intc>;" fixes the build.
>>>>
>>>> /dts-v1/;
>>>> /plugin/;
>>>> / {
>>>>         fragment@0 {
>>>>                 target-path = "/soc/base_fpga_region";
>>>>                 #address-cells = <1>;
>>>>                 #size-cells = <1>;
>>>>
>>>>                 __overlay__ {
>>>>                         ranges = <0x00000000 0x00000000 0xc0000000 0x00040000>,
>>>>                                  <0x00000001 0x00000000 0xff200000 0x00001000>;
>>>>
>>>>                         external-fpga-config;
>>>>
>>>>                         #address-cells = <2>;
>>>>                         #size-cells = <1>;
>>>>
>>>>                         fpga_pr_region0 {
>>>>                                 compatible = "fpga-region";
>>>>                                 fpga-bridges = <&freeze_controller_0>;
>>>>                                 ranges;
>>>>                         };
>>>>
>>>>                         freeze_controller_0: freeze_controller@0x100000450 {
>>>>                                 compatible = "altr,freeze-bridge-controller";
>>>>                                 reg = <0x00000001 0x00000450 0x00000010>;
>>>>                                 interrupt-parent = <&intc>;  /* <--
>>>> remove to fix build */
>>>>                                 interrupts = <0 21 4>;
>>>>                         };
>>>>                 };
>>>>         };
>>>> };
>>>>
>>>> Alan
>>>
>>> Phandle references in overlays are assigned the value of -1 (0xffffffff) in
>>> the dtb, to be fixed up when loaded.  A new check sees this value and
>>> triggers the assert.
>>>
>>> It is this commit in the upstream dtc tools tree:
>>>
>>>    commit ee3d26f6960bb5922d9a35fe266d9eac74a78ec0
>>>    checks: add interrupts property check
>>>
>>> There are a bunch of other new checks that call get_node_by_phandle(),
>>> and thus could trigger the assertion.
>>>
>>> I'm guessing that those checks would also trigger the assert if an
>>> overlay contained something that would lead to one of the other checks
>>> being processed.
>>
>> You won't get an assert because I check for 0 or -1 and skip the check
>> in those cases. The interrupts check missed that condition.
>
> Awesome, thank for confirming that.  That means the temporary work around
> is quite easy.
>
>>
>> However, as shown above, you will get an erroneous warning because it
>> just skips 1 cell and goes to the next to handle the case where the
>> phandle is optional and you want a fixed number of elements.
>
> Just for those reading along at home, with the one warning disabled, the
> messages become:
>
>    $  dtc -Wno-interrupts_property socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dts >junk.dtb
>    <stdout>: Warning (unit_address_vs_reg): Node /fragment@0 has a unit name, but no reg property
>    <stdout>: Warning (unit_address_vs_reg): Node /fragment@0/__overlay__ has a reg or ranges property, but no unit name
>
>
>> I guess we can't validate overlays which is unfortunate. I don't think
>> that's a solvable problem unless you have the base DT.
>
> Yes, maybe.  But there are still some useful warnings for overlays, maybe.  I'm
> not sure what the implications of the "range_format" warning that I will show
> below are (I'd actually have to spend a few minutes thinking about ranges, and
> I don't have the cycles right now).
>
>
>>
>>> You can avoid the problem in your example dts with "-Wno-interrupts_property"
>>>
>>>   dtc -Wno-interrupts_property fpga_01_a.dts
>>>
>>> The larger set of other checks that might trigger the assert is too large
>>> for me to want to add "-Wno-" flags for all of them to the command line
>>> (as temporary workarounds).
>>
>> David thought more switches were better.
>
> Yep.  Not a complaint, just an observation about a _temporary_ workaround.
>
>
>>
>> Rob
>>
>
>
> Here is the "range_format" warning I mentioned above.  The dts file that
> started this thread hand crafts what is internal overlay data, which
> should be generated by the dtc compiler instead of being hand coded in
> the dts.  If I remove the hand coded stuff and let dtc generate the
> internal overlay data, the dtc messages become (use a wide window to
> avoid line wrapping):
>
> $ dtc -Wno-interrupts_property fpga_01_a.dts >junk.dtb
> <stdout>: Warning (ranges_format): "ranges" property in /fragment@0/__overlay__ has invalid length (32 bytes) (parent #address-cells == 2, child #address-cells == 2, #size-cells == 1)
> <stdout>: Warning (unit_address_vs_reg): Node /fragment@0 has a unit name, but no reg property
> <stdout>: Warning (unit_address_vs_reg): Node /fragment@0/__overlay__ has a reg or ranges property, but no unit name
> <stdout>: Warning (avoid_default_addr_size): Relying on default #address-cells value for /fragment@0/__overlay__
> <stdout>: Warning (avoid_default_addr_size): Relying on default #size-cells value for /fragment@0/__overlay__
>
>
> The second through last warning are about the format of the internal
> data structure, and hopefully could just be suppressed.  I don't
> know how easy or hard that would be to implement - I am very much
> not a dtc internals expert.
>
> The first warning says something about what the overlay source dts
> contains.  Here is what the original dts source looks like when
> transformed to not contain the hand crafted internal overlay data:
>
> $ cat fpga_01_a.dts
> /dts-v1/;
> /plugin/;
>
> // This assumes an existing label in the base dts
> // whose location is "/soc/base_fpga_region"
> &fpga_region {
>
>                         ranges = <0x00000000 0x00000000 0xc0000000 0x00040000>,
>                                  <0x00000001 0x00000000 0xff200000 0x00001000>;
>
>                         external-fpga-config;
>
>                         #address-cells = <2>;
>                         #size-cells = <1>;
>
>                         fpga_pr_region0 {
>                                 compatible = "fpga-region";
>                                 fpga-bridges = <&freeze_controller_0>;
>                                 ranges;
>                         };
>
>                         freeze_controller_0: freeze_controller@100000450 {
>                                 compatible = "altr,freeze-bridge-controller";
>                                 reg = <0x00000001 0x00000450 0x00000010>;
>                                 interrupt-parent = <&intc>;  /* <-- remove to fix build */
>                                 interrupts = <0 21 4>;
>                         };
> };
>
> Of course, if this was a real transformation, I would remove all the
> extra tabbing.  But the current form makes it easier to see that all
> of the stuff that is highly indented is unchanged from the original
> dts file.
>
> $ diff -u socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dts fpga_01_a.dts
> --- socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dts    2017-10-18 15:18:43.123137508 -0700
> +++ fpga_01_a.dts       2017-10-18 15:18:11.587136897 -0700
> @@ -1,12 +1,10 @@
>  /dts-v1/;
>  /plugin/;
> -/ {
> -       fragment@0 {
> -               target-path = "/soc/base_fpga_region";
> -               #address-cells = <1>;
> -               #size-cells = <1>;
>
> -               __overlay__ {
> +// This assumes an existing label in the base dts
> +// whose location is "/soc/base_fpga_region"
> +&fpga_region {
> +

Frank,

Thanks for correcting me on this.  I have this documented wrong in
Documentation/devicetree/bindings/fpga/fpga-region.txt
so I'll need to fix that to not steer people wrong.

Alan


>                         ranges = <0x00000000 0x00000000 0xc0000000 0x00040000>,
>                                  <0x00000001 0x00000000 0xff200000 0x00001000>;
>
> @@ -27,6 +25,4 @@
>                                 interrupt-parent = <&intc>;  /* <-- remove to fix build */
>                                 interrupts = <0 21 4>;
>                         };
> -               };
> -       };
>  };
>
>
> -Frank
