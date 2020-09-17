Return-Path: <SRS0=AleB=C2=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B95C43461
	for <linux-fpga@archiver.kernel.org>; Thu, 17 Sep 2020 01:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F7C2076D
	for <linux-fpga@archiver.kernel.org>; Thu, 17 Sep 2020 01:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgIQBtI (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Wed, 16 Sep 2020 21:49:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbgIQBtI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 16 Sep 2020 21:49:08 -0400
X-Greylist: delayed 953 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 21:49:07 EDT
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EE9CB5F6BE8476A4EB48;
        Thu, 17 Sep 2020 09:33:13 +0800 (CST)
Received: from [10.174.179.108] (10.174.179.108) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 09:33:10 +0800
Subject: Re: [PATCH -next] fpga: dfl: Make m10_n3000_info static
To:     Moritz Fischer <mdf@kernel.org>
References: <20200916142536.28748-1-yuehaibing@huawei.com>
 <20200916161040.GA1066896@epycbox.lan>
CC:     <hao.wu@intel.com>, <trix@redhat.com>, <yilun.xu@intel.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <52d8411e-13d8-1e91-756d-131802f5f445@huawei.com>
Date:   Thu, 17 Sep 2020 09:33:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200916161040.GA1066896@epycbox.lan>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2020/9/17 0:10, Moritz Fischer wrote:
> Hi Yue,
> 
> On Wed, Sep 16, 2020 at 10:25:36PM +0800, YueHaibing wrote:
>> Fix sparse warning:
>>
>> drivers/fpga/dfl-n3000-nios.c:392:23: warning:
>>  symbol 'm10_n3000_info' was not declared. Should it be static?
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/fpga/dfl-n3000-nios.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
>> index 5088f8f0e0cd..686813b59d33 100644
>> --- a/drivers/fpga/dfl-n3000-nios.c
>> +++ b/drivers/fpga/dfl-n3000-nios.c
>> @@ -389,7 +389,7 @@ static int n3000_nios_init_done_check(struct n3000_nios *ns)
>>  	return ret;
>>  }
>>  
>> -struct spi_board_info m10_n3000_info = {
>> +static struct spi_board_info m10_n3000_info = {
>>  	.modalias = "m10-n3000",
>>  	.max_speed_hz = 12500000,
>>  	.bus_num = 0,
>> -- 
>> 2.17.1
>>
> Can you resend this with a [PATCH v2] or [PATCH v2 next], neither
> lore nor patchwork picks it up in its current form.
> 
> This'll make sure it doesn't get lost.
> 
> While at it could you change the first line to:
> 
> "fpga: dfl: n3000-nios: Make m10_n3000_info static"

Sure, will resend.
> 
> Thanks for the patch,
> Moritz
> .
> 
