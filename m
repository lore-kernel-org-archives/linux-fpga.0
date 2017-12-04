Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171202012108.x5js74t73f3wkpem@derp-derp.lan>
References: <1512159984-23948-1-git-send-email-khoroshilov@ispras.ru> <20171202012108.x5js74t73f3wkpem@derp-derp.lan>
From: Alan Tull <atull@kernel.org>
Date: Mon, 4 Dec 2017 09:44:50 -0600
Message-ID: <CANk1AXRZV3cRYHoFONUdMj6mbM+6aV3h5JvbMhZR7WhSLXTWFw@mail.gmail.com>
Subject: Re: [PATCH] fpga: socfpga-a10: disable clk on error in socfpga_a10_fpga_probe()
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, ldv-project@linuxtesting.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Dec 1, 2017 at 7:21 PM, Moritz Fischer <mdf@kernel.org> wrote:

Hi Alexey,

Thanks for the fix!

Alan

> Hi Alexey,
>
> On Fri, Dec 01, 2017 at 11:26:24PM +0300, Alexey Khoroshilov wrote:
>> If fpga_mgr_register() fails, a clock is left undisabled.
>>
>> Found by Linux Driver Verification project (linuxtesting.org).
>>
>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>

Acked-by: Alan Tull <atull@kernel.org>

>> ---
>>  drivers/fpga/socfpga-a10.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
>> index f8770af0f6b5..a46e343a5b72 100644
>> --- a/drivers/fpga/socfpga-a10.c
>> +++ b/drivers/fpga/socfpga-a10.c
>> @@ -519,8 +519,14 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>>               return -EBUSY;
>>       }
>>
>> -     return fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
>> +     ret = fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
>>                                &socfpga_a10_fpga_mgr_ops, priv);
>> +     if (ret) {
>> +             clk_disable_unprepare(priv->clk);
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>>  }
>>
>>  static int socfpga_a10_fpga_remove(struct platform_device *pdev)
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Thanks for your patch,
>
> Moritz
