Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAtXAHej5XsMUD7peenuPcG2fZcR8PHiyX3fjo7UVq0JkZgNjw@mail.gmail.com>
References: <1492697401-11211-1-git-send-email-atull@kernel.org>
 <1492697401-11211-16-git-send-email-atull@kernel.org> <CAAtXAHej5XsMUD7peenuPcG2fZcR8PHiyX3fjo7UVq0JkZgNjw@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 3 May 2017 15:08:25 -0500
Message-ID: <CANk1AXQSg7qTxfnqx+VA2Le7PU3qZMygq0qsKhmJzP0L4NSnPg@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] fpga: region: add fpga_region_class_find
Content-Type: text/plain; charset=UTF-8
To: Moritz Fischer <mdf@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, May 3, 2017 at 10:44 AM, Moritz Fischer <mdf@kernel.org> wrote:
> On Thu, Apr 20, 2017 at 7:10 AM, Alan Tull <atull@kernel.org> wrote:
>> Add a function for searching the fpga-region class.  This
>> will be useful when device tree code is no longer in the
>> same file that declares the fpga-region class.  Another
>> step in separating common FPGA region code from device
>> tree support.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Hi Moritz,

Thanks!

Alan

>> ---
>> v2: split out from another patch
>> ---
>>  drivers/fpga/fpga-region.c       | 23 +++++++++++++++--------
>>  include/linux/fpga/fpga-region.h |  4 ++++
>>  2 files changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index e2a3fe6..7ffb8c1 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -30,6 +30,20 @@
>>  static DEFINE_IDA(fpga_region_ida);
>>  static struct class *fpga_region_class;
>>
>> +struct fpga_region *fpga_region_class_find(
>> +       struct device *start, const void *data,
>> +       int (*match)(struct device *, const void *))
>> +{
>> +       struct device *dev;
>> +
>> +       dev = class_find_device(fpga_region_class, start, data, match);
>> +       if (!dev)
>> +               return NULL;
>> +
>> +       return to_fpga_region(dev);
>> +}
>> +EXPORT_SYMBOL_GPL(fpga_region_class_find);
>> +
>>  static const struct of_device_id fpga_region_of_match[] = {
>>         { .compatible = "fpga-region", },
>>         {},
>> @@ -51,14 +65,7 @@ static int fpga_region_of_node_match(struct device *dev, const void *data)
>>   */
>>  static struct fpga_region *of_fpga_region_find(struct device_node *np)
>>  {
>> -       struct device *dev;
>> -
>> -       dev = class_find_device(fpga_region_class, NULL, np,
>> -                               fpga_region_of_node_match);
>> -       if (!dev)
>> -               return NULL;
>> -
>> -       return to_fpga_region(dev);
>> +       return fpga_region_class_find(NULL, np, fpga_region_of_node_match);
>>  }
>>
>>  /**
>> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
>> index 35e7e09..4966bb2 100644
>> --- a/include/linux/fpga/fpga-region.h
>> +++ b/include/linux/fpga/fpga-region.h
>> @@ -28,6 +28,10 @@ struct fpga_region {
>>
>>  #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
>>
>> +struct fpga_region *fpga_region_class_find(
>> +       struct device *start, const void *data,
>> +       int (*match)(struct device *, const void *));
>> +
>>  int fpga_region_program_fpga(struct fpga_region *region,
>>                              struct fpga_image_info *image_info);
>>
>> --
>> 2.7.4
>>
