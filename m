Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180214210319.GC25618@tyrael.ni.corp.natinst.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-8-git-send-email-hao.wu@intel.com> <20180214210319.GC25618@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 14 Feb 2018 15:13:54 -0600
Message-ID: <CANk1AXRksJum6s5yB5727136DBLHs4UPW7xaLn_dT5qMEfqm9A@mail.gmail.com>
Subject: Re: [PATCH v4 07/24] fpga: dfl: add feature device infrastructure
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Tim Whisonant <tim.whisonant@intel.com>, Enno Luebbers <enno.luebbers@intel.com>, Shiva Rao <shiva.rao@intel.com>, Christopher Rauer <christopher.rauer@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Feb 14, 2018 at 3:03 PM, Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

> HI Hao,
>
> On Tue, Feb 13, 2018 at 05:24:36PM +0800, Wu Hao wrote:
>> From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
>>
>> This patch abstracts the common operations of the sub features, and defines
>> the feature_ops data structure, including init, uinit and ioctl function
>> pointers. And this patch adds some common helper functions for FME and AFU
>> drivers, e.g feature_dev_use_begin/end which are used to ensure exclusive
>> usage of the feature device file.
>>
>> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
>> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
>> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
>> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
>> Signed-off-by: Kang Luwei <luwei.kang@intel.com>
>> Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
>> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
>> Signed-off-by: Wu Hao <hao.wu@intel.com>
>> ---
>> v2: rebased
>> v3: use const for feature_ops.
>>     replace pci related function.
>> v4: rebase and add more comments in code.
>> ---
>>  drivers/fpga/dfl.c | 59 +++++++++++++++++++++++++++++++++++++
>>  drivers/fpga/dfl.h | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 143 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
>> index 38dc819..c0aad87 100644
>> --- a/drivers/fpga/dfl.c
>> +++ b/drivers/fpga/dfl.c
>> @@ -74,6 +74,65 @@ static enum fpga_id_type feature_dev_id_type(struct platform_device *pdev)
>>       return FPGA_ID_MAX;
>>  }
>>
>> +void fpga_dev_feature_uinit(struct platform_device *pdev)
>> +{
>> +     struct feature *feature;
>> +     struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> See comment below w.r.t ordering declarations. Not a must for sure.
>> +
>> +     fpga_dev_for_each_feature(pdata, feature)
>> +             if (feature->ops) {
>> +                     feature->ops->uinit(pdev, feature);
>> +                     feature->ops = NULL;
>> +             }
>> +}
>> +EXPORT_SYMBOL_GPL(fpga_dev_feature_uinit);
>> +
>> +static int
>> +feature_instance_init(struct platform_device *pdev,
>> +                   struct feature_platform_data *pdata,
>> +                   struct feature *feature, struct feature_driver *drv)
>> +{
>> +     int ret;
>> +
>> +     WARN_ON(!feature->ioaddr);
>
> Not sure I understand correctly, is the !feature->ioaddr a use-case that
> happens? If not just return early.
>> +
>> +     ret = drv->ops->init(pdev, feature);
>> +     if (ret)
>> +             return ret;
>> +
>> +     feature->ops = drv->ops;
>> +
>> +     return ret;
>> +}
>> +
>> +int fpga_dev_feature_init(struct platform_device *pdev,
>> +                       struct feature_driver *feature_drvs)
>> +{
>> +     struct feature *feature;
>> +     struct feature_driver *drv = feature_drvs;
>> +     struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>> +     int ret;
> We don't have clear guidelines here, but some subsystems want reverse
> X-Mas tree declarations.

Sounds good!  I agree.

Alan
