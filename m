Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170410175620.GA22815@tyrael.amer.corp.natinst.com>
References: <20170410135103.18612-1-tklauser@distanz.ch> <20170410175620.GA22815@tyrael.amer.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 10 Apr 2017 13:50:24 -0500
Message-ID: <CANk1AXSSF1DtRj28yEE90g9cE6wgBFELM1R5ZMMLFM0Bv0fDoA@mail.gmail.com>
Subject: Re: [PATCH] fpga: region: release FPGA region reference in error path
Content-Type: text/plain; charset=UTF-8
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tobias Klauser <tklauser@distanz.ch>, Moritz Fischer <moritz.fischer@ettus.com>, linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Apr 10, 2017 at 12:56 PM, Moritz Fischer <mdf@kernel.org> wrote:
> On Mon, Apr 10, 2017 at 03:51:03PM +0200, Tobias Klauser wrote:
>> If fpga_region_get_manager() fails in fpga_region_program_fpga(), a
>> reference to the fpga_manager instance previously acquired through
>> fpga_region_get() is retained. Make sure to properly release it in the
>> error case by using a separate jump label which will call
>> fpga_region_put() in before returning.
>>
>> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Signed-off-by: Alan Tull <atull@kernel.org>

>> ---
>>  drivers/fpga/fpga-region.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index ae4c61aada99..3b6b2f4182a1 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -245,7 +245,8 @@ static int fpga_region_program_fpga(struct fpga_region *region,
>>       mgr = fpga_region_get_manager(region);
>>       if (IS_ERR(mgr)) {
>>               pr_err("failed to get fpga region manager\n");
>> -             return PTR_ERR(mgr);
>> +             ret = PTR_ERR(mgr);
>> +             goto err_put_region;
>>       }
>>
>>       ret = fpga_region_get_bridges(region, overlay);
>> @@ -281,6 +282,7 @@ static int fpga_region_program_fpga(struct fpga_region *region,
>>       fpga_bridges_put(&region->bridge_list);
>>  err_put_mgr:
>>       fpga_mgr_put(mgr);
>> +err_put_region:
>>       fpga_region_put(region);
>>
>>       return ret;
>> --
>> 2.12.2
>>
>>
>
> Thanks,
> Moritz
