Return-Path: <SRS0=/QMV=QG=gmail.com=simon.k.r.goldschmidt@kernel.org>
Return-Path: <SRS0=/QMV=QG=gmail.com=simon.k.r.goldschmidt@kernel.org>
Subject: Re: [PATCH] ARM: socfpga: fix base address of SDR controller
References: <20190129200858.19773-1-goldsimon@gmx.de>
 <0711a2e0-b4fb-fa12-7c5c-0b5da73c8b02@kernel.org>
 <CAAh8qszCQROUZVOyX9GCNF_09DebDDUWf_2cfW3M13yG1aJ_Xg@mail.gmail.com>
 <961ac9bf-d111-2e42-a39b-b26c499afcc0@kernel.org>
From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Message-ID: <ad197fef-e946-1861-5ace-f4e8e4f1c044@gmail.com>
Date: Wed, 30 Jan 2019 17:28:04 +0100
MIME-Version: 1.0
In-Reply-To: <961ac9bf-d111-2e42-a39b-b26c499afcc0@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alan Tull <atull@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-fpga@vger.kernel.org>

Am 30.01.2019 um 16:50 schrieb Dinh Nguyen:
> 
> 
> On 1/30/19 12:00 AM, Simon Goldschmidt wrote:
>> + Marek (as I really want to keep the dts in Linux and U-Boot in sync)
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
> 
> That's great! Can you elaborate on what is the impetus for converting
> the SDR driver to use the dts?

The initial reason to do so was to move its reset handling from U-Boot 
SPL to the driver itself. Moving from ad-hoc code to using the reset driver.

And when it's being converted to using the reset handle from dts, I 
think it should also use the base address from dts.

Regards,
Simon
