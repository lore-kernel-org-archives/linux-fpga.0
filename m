Return-Path: <SRS0=F9uP=B4=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=F9uP=B4=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from gateway31.websitewelcome.com ([192.185.143.52]:32643 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751209AbdJ2AsZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 28 Oct 2017 20:48:25 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 1C09469DF1E
        for <linux-fpga@vger.kernel.org>; Sat, 28 Oct 2017 19:25:36 -0500 (CDT)
Date: Sat, 28 Oct 2017 19:25:35 -0500
Message-ID: <20171028192535.Horde.T7HEP1UuJs43TNa6pQe6Ziy@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] fpga: fpga-bridge: remove unnecessary null check in
 of_fpga_bridge_get
References: <20171027201951.GA27077@embeddedor.com>
 <20171028171422.vkc64q2iun7ptpkc@derp-derp.lan>
In-Reply-To: <20171028171422.vkc64q2iun7ptpkc@derp-derp.lan>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Moritz,

Quoting Moritz Fischer <mdf@kernel.org>:

> On Fri, Oct 27, 2017 at 08:19:51PM +0000, Gustavo A. R. Silva wrote:
>> Notice that bridge = to_fpga_bridge(dev); expands to:
>>
>> bridge = container_of(dev, struct fpga_bridge, dev);
>>
>> and container_of is never null, so this null check is
>> unnecessary.
>>
>> Addresses-Coverity-ID: 1397912
>> Reported-by: Alan Tull <atull@kernel.org>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
>> ---
>>  drivers/fpga/fpga-bridge.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
>> index 9651aa5..409d1ac 100644
>> --- a/drivers/fpga/fpga-bridge.c
>> +++ b/drivers/fpga/fpga-bridge.c
>> @@ -94,8 +94,6 @@ struct fpga_bridge *of_fpga_bridge_get(struct  
>> device_node *np,
>>  		goto err_dev;
>>
>>  	bridge = to_fpga_bridge(dev);
>> -	if (!bridge)
>> -		goto err_dev;
>>
>>  	bridge->info = info;
>>
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Thanks for the fix,
>

Glad to help.

Thanks
--
Gustavo A. R. Silva






