Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171028171422.vkc64q2iun7ptpkc@derp-derp.lan>
References: <20171027201951.GA27077@embeddedor.com> <20171028171422.vkc64q2iun7ptpkc@derp-derp.lan>
From: Alan Tull <atull@kernel.org>
Date: Mon, 30 Oct 2017 15:34:07 -0500
Message-ID: <CANk1AXRRG==m65r=exxT-kqSuo+DJ7f8BTFxHm3A6=EyY0omyw@mail.gmail.com>
Subject: Re: [PATCH] fpga: fpga-bridge: remove unnecessary null check in of_fpga_bridge_get
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Sat, Oct 28, 2017 at 12:15 PM, Moritz Fischer <mdf@kernel.org> wrote:

Hi Gustavo,

Thanks!

Alan

> On Fri, Oct 27, 2017 at 08:19:51PM +0000, Gustavo A. R. Silva wrote:
>> Notice that bridge = to_fpga_bridge(dev); expands to:
>>
>> bridge = container_of(dev, struct fpga_bridge, dev);
>>
>> and container_of is never null, so this null check is
>> unnecessary.
>>
>> Addresses-Coverity-ID: 1397912
>> Reported-by: Alan Tull <atull@kernel.org>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>

Signed-off-by: Alan Tull <atull@kernel.org>

>> ---
>>  drivers/fpga/fpga-bridge.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
>> index 9651aa5..409d1ac 100644
>> --- a/drivers/fpga/fpga-bridge.c
>> +++ b/drivers/fpga/fpga-bridge.c
>> @@ -94,8 +94,6 @@ struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
>>               goto err_dev;
>>
>>       bridge = to_fpga_bridge(dev);
>> -     if (!bridge)
>> -             goto err_dev;
>>
>>       bridge->info = info;
>>
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Thanks for the fix,
>
> Moritz
