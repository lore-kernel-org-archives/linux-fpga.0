Return-Path: <SRS0=W+aB=B2=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=W+aB=B2=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from gateway32.websitewelcome.com ([192.185.145.107]:29925 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752696AbdJ0TaN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 27 Oct 2017 15:30:13 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id B968F152EEC
        for <linux-fpga@vger.kernel.org>; Fri, 27 Oct 2017 14:09:04 -0500 (CDT)
Date: Fri, 27 Oct 2017 14:09:04 -0500
Message-ID: <20171027140904.Horde.m5O1mdmtNKyY-jthC9ZZmz8@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] fpga: fpga-mgr: remove unnecessary code in
 __fpga_mgr_get
References: <20171026230230.GA4904@embeddedor.com>
 <CANk1AXQX24U06SBuoBmw=UWeCdnu3OV4BW2ZRBW4t1KirZZ5DA@mail.gmail.com>
In-Reply-To: <CANk1AXQX24U06SBuoBmw=UWeCdnu3OV4BW2ZRBW4t1KirZZ5DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Hi Alan,

Quoting Alan Tull <atull@kernel.org>:

> On Thu, Oct 26, 2017 at 6:02 PM, Gustavo A. R. Silva
> <garsilva@embeddedor.com> wrote:
>
> Hi Gustavo,
>
> Thanks for pointing that out.  There's also a similar thing in
> fpga-bridge.c that I need to fix.
>

Can you share with me what exactly are you trying to fix?

If the issue is similar I might be able to help.

Thanks
--
Gustavo A. R. Silva

> Alan
>
>> Notice that mgr = to_fpga_manager(dev); expands to:
>>
>> mgr = container_of(dev, struct fpga_manager, dev);
>>
>> and container_of is never null, so this null check is
>> unnecessary.
>>
>> Addresses-Coverity-ID: 1397916
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>>  drivers/fpga/fpga-mgr.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index 188ffef..33063ca 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -367,8 +367,6 @@ static struct fpga_manager  
>> *__fpga_mgr_get(struct device *dev)
>>         int ret = -ENODEV;
>>
>>         mgr = to_fpga_manager(dev);
>> -       if (!mgr)
>> -               goto err_dev;
>>
>>         /* Get exclusive use of fpga manager */
>>         if (!mutex_trylock(&mgr->ref_mutex)) {
>> --
>> 2.7.4
>>






