Return-Path: <SRS0=4xvK=QI=gmail.com=simon.k.r.goldschmidt@kernel.org>
Return-Path: <SRS0=4xvK=QI=gmail.com=simon.k.r.goldschmidt@kernel.org>
Subject: Re: [PATCH] ARM: socfpga: fix base address of SDR controller
References: <20190129200858.19773-1-goldsimon@gmx.de>
 <0711a2e0-b4fb-fa12-7c5c-0b5da73c8b02@kernel.org>
 <CAAh8qszCQROUZVOyX9GCNF_09DebDDUWf_2cfW3M13yG1aJ_Xg@mail.gmail.com>
 <080c0900-4c34-e097-3e0e-4508951b0ddd@kernel.org>
From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Message-ID: <e7c314cf-294d-e80a-c9f2-b5e183af6af5@gmail.com>
Date: Fri, 1 Feb 2019 16:50:21 +0100
MIME-Version: 1.0
In-Reply-To: <080c0900-4c34-e097-3e0e-4508951b0ddd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alan Tull <atull@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-fpga@vger.kernel.org>

Am 01.02.2019 um 16:13 schrieb Dinh Nguyen:
> 
> 
> On 1/30/19 12:00 AM, Simon Goldschmidt wrote:
>> + Marek (as I really want to keep the dts in Linux and U-Boot in sync)
> 
> So can you wait until your patch in U-Boot is in?

Well, yes, this could wait. The problem is we wanted to keep Linux and 
U-Boot dts in sync.

I guess I'll just finish preparing my patch for U-Boot changing the dts 
there and then we'll see which part gets pushed first...

> 
>> On Wed, Jan 30, 2019 at 1:16 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>>>
>>>
>>>
>>> On 1/29/19 2:08 PM, Simon Goldschmidt wrote:
>>>> From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>>>>
>>>> The documentation for socfpga gen5 says the base address of the sdram
>>>> controller is 0xffc20000, while the current devicetree says it is at
>>>> 0xffc25000.
>>>>
>>>> While this is not a problem for Linux, as it only accesses the registers
>>>> above 0xffc25000, it *is* a problem for U-Boot because the lower registers
>>>> are used during DDR calibration (up to now, the U-Boot driver does not use
>>>> the dts address, but that should change).
>>>>
>>>> To keep Linux and U-Boot devicetrees in sync, this patch changes the base
>>>> address to 0xffc20000 and adapts the 2 files where it is currently used.
>>>>
>>>> This patch changes the dts and 2 drivers with one commit to prevent
>>>> breaking the code if dts change and driver change would be split.
>>>>
>>>> Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>>>> ---
>>>>
>>>>   arch/arm/boot/dts/socfpga.dtsi       | 4 ++--
>>>>   arch/arm/mach-socfpga/self-refresh.S | 4 ++--
>>>>   drivers/fpga/altera-fpga2sdram.c     | 2 +-
>>>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>>>> index f365003f0..8f6c1a5d6 100644
>>>> --- a/arch/arm/boot/dts/socfpga.dtsi
>>>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>>>> @@ -788,9 +788,9 @@
>>>>                        reg = <0xfffec000 0x100>;
>>>>                };
>>>>
>>>> -             sdr: sdr@ffc25000 {
>>>> +             sdr: sdr@ffc20000 {
>>>>                        compatible = "altr,sdr-ctl", "syscon";
>>>> -                     reg = <0xffc25000 0x1000>;
>>>> +                     reg = <0xffc20000 0x6000>;
>>>
>>> I don't see the U-Boot device tree having this change. Yes, the
>>> documentation does state that the SDR address starts at 0xffc20000, but
>>> all of the pertinent registers start at 0x5000 offset. Thus, the
>>> starting address should be 0xffc25000.[1]
>>
>> You don't see it in U-Boot as I'm working on a patch for that.
>> As I wrote in the commit message, U-Boot currently does not use the
>> devicetree for the SDR driver, but I want to convert it to do that.
>>
>> But before converting, I need to find a clean way to provide the
>> register addresses to the driver. That doesn't work with the current dts.
>>
>>>
>>> [1]
>>> https://www.intel.com/content/www/us/en/programmable/documentation/sfo1410143707420.html#sfo1411577366917
>>
>> Well, in [2], you see that the peripheral's address range actually starts
>> at 0xffc20000. It's only the public documented registers that start at
>> 0xffc25000. I don't know why the lower address range is undocumented.
>> Maybe you can help me here?
>>
> 
> Yes, the reason these register are not documented is that the ddr
> engineers didn't really want anyone outside of their team messing around
> with the calibration. These registers, from the limited documentation I
> have, are related to the PHY settings. I've been told the calibration
> sequence is something of a "black" magic.

That's exactly how I thought it would be. However, that's not the best 
attitued for getting code into an open source project like U-Boot. For 
example, I wanted to take a look at the code to see if it can be made 
smaller, but that's unnecessary hard if the registers are not documented...

Regards,
Simon
