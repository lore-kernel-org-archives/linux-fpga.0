Return-Path: <SRS0=+hJe=L4=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=+hJe=L4=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38228 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeINVdY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 14 Sep 2018 17:33:24 -0400
Received: by mail-yw1-f68.google.com with SMTP id n21-v6so2852303ywh.5
        for <linux-fpga@vger.kernel.org>; Fri, 14 Sep 2018 09:18:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180914102321.GA21810@hao-dev>
References: <1536888816-51700-1-git-send-email-yuehaibing@huawei.com> <20180914102321.GA21810@hao-dev>
From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Fri, 14 Sep 2018 09:18:12 -0700
Message-ID: <CAAtXAHeWQ-QsD833ugV6Uqk=FOn8mxvg25FY4tyBJVe0bAf38g@mail.gmail.com>
Subject: Re: [PATCH -next] fpga: dfl: fme: remove set but not used variable 'priv'
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Wu Hao <hao.wu@intel.com>
Cc: YueHaibing <yuehaibing@huawei.com>, Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi,

On Fri, Sep 14, 2018 at 3:23 AM, Wu Hao <hao.wu@intel.com> wrote:
> On Fri, Sep 14, 2018 at 01:33:36AM +0000, YueHaibing wrote:
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/fpga/dfl-fme-pr.c: In function 'pr_mgmt_uinit':
>> drivers/fpga/dfl-fme-pr.c:447:18: warning:
>>  variable 'priv' set but not used [-Wunused-but-set-variable]
>
> Looks good to me, thanks for this fixing.

Hao, is this an Acked-by? :)
>
> Thanks
> Hao
>
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
>> ---
>>  drivers/fpga/dfl-fme-pr.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
>> index 0b84053..fe5a557 100644
>> --- a/drivers/fpga/dfl-fme-pr.c
>> +++ b/drivers/fpga/dfl-fme-pr.c
>> @@ -444,10 +444,8 @@ static void pr_mgmt_uinit(struct platform_device *pdev,
>>                         struct dfl_feature *feature)
>>  {
>>       struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>> -     struct dfl_fme *priv;
>>
>>       mutex_lock(&pdata->lock);
>> -     priv = dfl_fpga_pdata_get_private(pdata);
>>
>>       dfl_fme_destroy_regions(pdata);
>>       dfl_fme_destroy_bridges(pdata);

Thanks for the patch,

Moritz
