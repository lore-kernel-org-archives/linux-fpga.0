Return-Path: <SRS0=jakO=7H=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=jakO=7H=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14502 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388110AbgEYCeg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 24 May 2020 22:34:36 -0400
Subject: Re: [PATCH v2] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
References: <20200519201449.3136033-1-jhubbard@nvidia.com>
 <64aa1494-7570-5319-b096-ea354ff20431@nvidia.com>
 <20200523205717.GA443638@epycbox.lan>
 <ccf86d21-2ecf-7873-1c30-fbea880b9081@nvidia.com>
 <DM6PR11MB38194610D744865657EEB08385B30@DM6PR11MB3819.namprd11.prod.outlook.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <4f326d89-d034-72ea-06d0-a2f9ba62bcc9@nvidia.com>
Date: Sun, 24 May 2020 19:34:35 -0700
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB38194610D744865657EEB08385B30@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: "Wu, Hao" <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>

On 2020-05-24 19:25, Wu, Hao wrote:
>>>> Hi Moritz and FPGA developers,
>>>>
>>>> Is this OK? And if so, is it going into your git tree? Or should I
>>>> send it up through a different tree? (I'm new to the FPGA development
>>>> model).
>>>
>>> I can take it, sorry for sluggish response.
>>>
>>
>> That's great news, thanks Moritz! Sorry to be pushy, just didn't want it
>> to get lost. :)
> 
> Thanks John for this patch, and thanks Moritz for taking care of this.
> Sorry for late response, one thing here we may need to be careful is
> a recent bug fixing patch, that fixing patch has been merged by Greg
> in char-misc-next tree, and may have some conflict with this one.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?h=char-misc-next&id=c9d7e3da1f3c4cf5dddfc5d7ce4d76d013aba1cc
> fpga: dfl: afu: Corrected error handling levels
> 
> I guess we need to rebase this patch on top of it?
> Moritz, do you have any suggestion?
> 

I'll send you a v2, rebased on top of the latest char-misc.git, no problem.

thanks,
-- 
John Hubbard
NVIDIA
