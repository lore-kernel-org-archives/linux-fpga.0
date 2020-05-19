Return-Path: <SRS0=mLS4=7B=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=mLS4=7B=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16978 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESRjD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 19 May 2020 13:39:03 -0400
Subject: Re: [PATCH] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
References: <20200517011837.382189-1-jhubbard@nvidia.com>
 <20200519151037.GA20726@yilunxu-OptiPlex-7050>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <2e9e6c4e-296d-b0cd-88ce-1b300b9e2e0f@nvidia.com>
Date: Tue, 19 May 2020 10:39:02 -0700
MIME-Version: 1.0
In-Reply-To: <20200519151037.GA20726@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Xu Yilun <yilun.xu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org

On 2020-05-19 08:10, Xu Yilun wrote:
...
>> @@ -72,7 +63,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
>>   	return 0;
>>   
>>   put_pages:
> 
> How about we also change the tag to "unpin_pages"?
> 
> Others look good to me.
> 

Sure, I'll send a v2 with that.


thanks,
-- 
John Hubbard
NVIDIA
