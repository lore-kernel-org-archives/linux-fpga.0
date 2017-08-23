Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANk1AXRm9ACzFSgszTWOcgSciWs1vqre8+QBrudf57ocfCdd_g@mail.gmail.com>
References: <20170822155355.3896-1-atull@kernel.org> <20170822155355.3896-3-atull@kernel.org>
 <CANk1AXRm9ACzFSgszTWOcgSciWs1vqre8+QBrudf57ocfCdd_g@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 23 Aug 2017 12:54:48 -0500
Message-ID: <CANk1AXTuRE_Q=1J-5JpMN_7T1ga35ZAWdB5dP3VwbX9sunfoOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpga: altera-cvp: register attribute groups using ops
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>, Anatolij Gustschin <agust@denx.de>
Cc: Alan Tull <atull@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Aug 22, 2017 at 3:23 PM, Alan Tull <atull@kernel.org> wrote:
> On Tue, Aug 22, 2017 at 10:53 AM, Alan Tull <atull@kernel.org> wrote:

On second thought, this patch is probably not really helpful as it
changes the path of the existing sysfs file from

/sys/bus/pci/drivers/altera-cvp/chkcfg

to

/sys/class/fpga_manager/fpga*/chkcfg

which there is no need to do.  Patch 1/2 is still fine for manager
drivers in the future that are adding device attributes.

Alan

>
> OK so obviously, this patch doesn't have the necessary header or
> signoff.  Will fix that.
>
> Alan
>
>> ---
>>  drivers/fpga/altera-cvp.c | 39 +++++++++++++++++++--------------------
>>  1 file changed, 19 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>> index 08629ee..a498022 100644
>> --- a/drivers/fpga/altera-cvp.c
>> +++ b/drivers/fpga/altera-cvp.c
>> @@ -354,20 +354,14 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
>>         return ret;
>>  }
>>
>> -static const struct fpga_manager_ops altera_cvp_ops = {
>> -       .state          = altera_cvp_state,
>> -       .write_init     = altera_cvp_write_init,
>> -       .write          = altera_cvp_write,
>> -       .write_complete = altera_cvp_write_complete,
>> -};
>> -
>> -static ssize_t show_chkcfg(struct device_driver *dev, char *buf)
>> +static ssize_t show_chkcfg(struct device *dev,
>> +                          struct device_attribute *attr, char *buf)
>>  {
>>         return snprintf(buf, 3, "%d\n", altera_cvp_chkcfg);
>>  }
>>
>> -static ssize_t store_chkcfg(struct device_driver *drv, const char *buf,
>> -                           size_t count)
>> +static ssize_t store_chkcfg(struct device *dev, struct device_attribute *attr,
>> +                           const char *buf, size_t count)
>>  {
>>         int ret;
>>
>> @@ -378,7 +372,21 @@ static ssize_t store_chkcfg(struct device_driver *drv, const char *buf,
>>         return count;
>>  }
>>
>> -static DRIVER_ATTR(chkcfg, 0600, show_chkcfg, store_chkcfg);
>> +static DEVICE_ATTR(chkcfg, 0600, show_chkcfg, store_chkcfg);
>> +
>> +static struct attribute *altera_cvp_attrs[] = {
>> +       &dev_attr_chkcfg.attr,
>> +       NULL,
>> +};
>> +ATTRIBUTE_GROUPS(altera_cvp);
>> +
>> +static const struct fpga_manager_ops altera_cvp_ops = {
>> +       .state          = altera_cvp_state,
>> +       .write_init     = altera_cvp_write_init,
>> +       .write          = altera_cvp_write,
>> +       .write_complete = altera_cvp_write_complete,
>> +       .groups         = altera_cvp_groups,
>> +};
>>
>>  static int altera_cvp_probe(struct pci_dev *pdev,
>>                             const struct pci_device_id *dev_id);
>> @@ -459,14 +467,6 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>>         if (ret)
>>                 goto err_unmap;
>>
>> -       ret = driver_create_file(&altera_cvp_driver.driver,
>> -                                &driver_attr_chkcfg);
>> -       if (ret) {
>> -               dev_err(&pdev->dev, "Can't create sysfs chkcfg file\n");
>> -               fpga_mgr_unregister(&pdev->dev);
>> -               goto err_unmap;
>> -       }
>> -
>>         return 0;
>>
>>  err_unmap:
>> @@ -484,7 +484,6 @@ static void altera_cvp_remove(struct pci_dev *pdev)
>>         struct altera_cvp_conf *conf = mgr->priv;
>>         u16 cmd;
>>
>> -       driver_remove_file(&altera_cvp_driver.driver, &driver_attr_chkcfg);
>>         fpga_mgr_unregister(&pdev->dev);
>>         pci_iounmap(pdev, conf->map);
>>         pci_release_region(pdev, CVP_BAR);
>> --
>> 2.7.4
>>
