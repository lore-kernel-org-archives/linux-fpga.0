Return-Path: <SRS0=8ZAN=7F=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=8ZAN=7F=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18215 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387847AbgEWVdN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 23 May 2020 17:33:13 -0400
Subject: Re: [PATCH v2] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
References: <20200519201449.3136033-1-jhubbard@nvidia.com>
 <64aa1494-7570-5319-b096-ea354ff20431@nvidia.com>
 <20200523205717.GA443638@epycbox.lan>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <ccf86d21-2ecf-7873-1c30-fbea880b9081@nvidia.com>
Date: Sat, 23 May 2020 14:33:12 -0700
MIME-Version: 1.0
In-Reply-To: <20200523205717.GA443638@epycbox.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <mdf@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org

On 2020-05-23 13:57, Moritz Fischer wrote:
> On Fri, May 22, 2020 at 06:52:34PM -0700, John Hubbard wrote:
>> On 2020-05-19 13:14, John Hubbard wrote:
>>> This code was using get_user_pages_fast(), in a "Case 2" scenario
>>> (DMA/RDMA), using the categorization from [1]. That means that it's
>>> time to convert the get_user_pages_fast() + put_page() calls to
>>> pin_user_pages_fast() + unpin_user_pages() calls.
>>>
>>> There is some helpful background in [2]: basically, this is a small
>>> part of fixing a long-standing disconnect between pinning pages, and
>>> file systems' use of those pages.
>>>
>>> [1] Documentation/core-api/pin_user_pages.rst
>>>
>>> [2] "Explicit pinning of user-space pages":
>>>       https://lwn.net/Articles/807108/
>>>
>>> Cc: Xu Yilun <yilun.xu@intel.com>
>>> Cc: Wu Hao <hao.wu@intel.com>
>>> Cc: Moritz Fischer <mdf@kernel.org>
>>> Cc: linux-fpga@vger.kernel.org
>>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>>
>>
>> Hi Moritz and FPGA developers,
>>
>> Is this OK? And if so, is it going into your git tree? Or should I
>> send it up through a different tree? (I'm new to the FPGA development
>> model).
> 
> I can take it, sorry for sluggish response.
> 

That's great news, thanks Moritz! Sorry to be pushy, just didn't want it
to get lost. :)

thanks,
-- 
John Hubbard
NVIDIA
