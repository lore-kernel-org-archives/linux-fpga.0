Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170627163600.GA9914@tyrael.amer.corp.natinst.com>
References: <20170627151842.15955-1-abbotti@mev.co.uk> <20170627163600.GA9914@tyrael.amer.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 5 Jul 2017 13:51:42 -0500
Message-ID: <CANk1AXSYt2nR-8_+qyKbxHRtsSQAGcRQO9Sq+kic-=AtYHMkhA@mail.gmail.com>
Subject: Re: [PATCH] fpga: altera-hps2fpga: fix multiple init of l3_remap_lock
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Ian Abbott <abbotti@mev.co.uk>, linux-fpga@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>, "# 4 . 10+" <stable@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Jun 27, 2017 at 11:36 AM, Moritz Fischer <mdf@kernel.org> wrote:

Hi Ian,

Thanks for the fix!

Alan

> On Tue, Jun 27, 2017 at 04:18:42PM +0100, Ian Abbott wrote:
>> The global spinlock `l3_remap_lock` is reinitialized every time the
>> "probe" function `alt_fpga_bridge_probe()` is called.  It should only be
>> initialized once.  Use `DEFINE_SPINLOCK()` to initialize it statically.
>>
>> Fixes: e5f8efa5c8bf ("ARM: socfpga: fpga bridge driver support")
>> Cc: <stable@vger.kernel.org> # 4.10+
>> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> Reviewed-By: Moritz Fischer <mdf@kernel.org>

Signed-off-by: Alan Tull <atull@kernel.org>

>
> Thanks for catching that,
>
> Moritz
>> ---
>>  drivers/fpga/altera-hps2fpga.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
>> index 3066b805f2d0..08c0ecb7d109 100644
>> --- a/drivers/fpga/altera-hps2fpga.c
>> +++ b/drivers/fpga/altera-hps2fpga.c
>> @@ -66,7 +66,7 @@ static int alt_hps2fpga_enable_show(struct fpga_bridge *bridge)
>>
>>  /* The L3 REMAP register is write only, so keep a cached value. */
>>  static unsigned int l3_remap_shadow;
>> -static spinlock_t l3_remap_lock;
>> +static DEFINE_SPINLOCK(l3_remap_lock);
>>
>>  static int _alt_hps2fpga_enable_set(struct altera_hps2fpga_data *priv,
>>                                   bool enable)
>> @@ -171,8 +171,6 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>>               return -EBUSY;
>>       }
>>
>> -     spin_lock_init(&l3_remap_lock);
>> -
>>       if (!of_property_read_u32(dev->of_node, "bridge-enable", &enable)) {
>>               if (enable > 1) {
>>                       dev_warn(dev, "invalid bridge-enable %u > 1\n", enable);
>> --
>> 2.11.0
>>
