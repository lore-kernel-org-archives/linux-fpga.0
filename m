Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170918164225.GA31137@tyrael.ni.corp.natinst.com>
References: <20170918101736.GA30415@kroah.com> <20170918164225.GA31137@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 18 Sep 2017 15:40:13 -0500
Message-ID: <CANk1AXTRoOiqswPi-SzNG01vPRQuAKxsBt3hszyWw7BvPx-YdQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fpga: altera-cvp: remove DRIVER_ATTR() usage
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Sep 18, 2017 at 11:42 AM, Moritz Fischer <mdf@kernel.org> wrote:
> On Mon, Sep 18, 2017 at 12:17:36PM +0200, Greg Kroah-Hartman wrote:
>> It's better to be explicit and use the DRIVER_ATTR_RW() macro when
>> defining a driver's sysfs file.
>>
>> This is part of a series to drop DRIVER_ATTR() from the tree entirely.
>>
>> Cc: Alan Tull <atull@kernel.org>
>> Cc: Moritz Fischer <mdf@kernel.org>
>> Cc: linux-fpga@vger.kernel.org
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
>> ---
>>  drivers/fpga/altera-cvp.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>> index 08629ee69d11..00e73d28077c 100644
>> --- a/drivers/fpga/altera-cvp.c
>> +++ b/drivers/fpga/altera-cvp.c
>> @@ -361,12 +361,12 @@ static const struct fpga_manager_ops altera_cvp_ops = {
>>       .write_complete = altera_cvp_write_complete,
>>  };
>>
>> -static ssize_t show_chkcfg(struct device_driver *dev, char *buf)
>> +static ssize_t chkcfg_show(struct device_driver *dev, char *buf)
>>  {
>>       return snprintf(buf, 3, "%d\n", altera_cvp_chkcfg);
>>  }
>>
>> -static ssize_t store_chkcfg(struct device_driver *drv, const char *buf,
>> +static ssize_t chkcfg_store(struct device_driver *drv, const char *buf,
>>                           size_t count)
>>  {
>>       int ret;
>> @@ -378,7 +378,7 @@ static ssize_t store_chkcfg(struct device_driver *drv, const char *buf,
>>       return count;
>>  }
>>
>> -static DRIVER_ATTR(chkcfg, 0600, show_chkcfg, store_chkcfg);
>> +static DRIVER_ATTR_RW(chkcfg);
>>
>>  static int altera_cvp_probe(struct pci_dev *pdev,
>>                           const struct pci_device_id *dev_id);
>> --
>> 2.14.1
>>
