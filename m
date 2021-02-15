Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E71C433DB
	for <linux-fpga@archiver.kernel.org>; Mon, 15 Feb 2021 14:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5DF64E04
	for <linux-fpga@archiver.kernel.org>; Mon, 15 Feb 2021 14:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhBOOWW (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 15 Feb 2021 09:22:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:20528 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhBOOWV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 15 Feb 2021 09:22:21 -0500
IronPort-SDR: lzTps7Z5axOVXNWefUwjhDbC/z9UIv0h+c9IImMvUgJkuUPN0kkZWdq4Mg6LMQCIealolUF+s3
 7U3ZO7br7YYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9895"; a="181914565"
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; 
   d="scan'208";a="181914565"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 06:20:36 -0800
IronPort-SDR: JP3GDrYHwJVSWw0VW0CVDQX6PFwg51MbXkTFzNTFyAJcEjGfcgei7PyaqumADIaf700t75O7i+
 YJhEFDEoHQQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; 
   d="scan'208";a="383386972"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga008.fm.intel.com with ESMTP; 15 Feb 2021 06:20:35 -0800
Subject: Re: [PATCHv5 1/7] firmware: stratix10-svc: reset
 COMMAND_RECONFIG_FLAG_PARTIAL to 0
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <1612909233-13867-2-git-send-email-richard.gong@linux.intel.com>
 <bc43e8ab-b8df-fd2f-31e4-02cdc48cadff@redhat.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <3ff3e9ca-cdca-796e-0b57-5010963e7ee1@linux.intel.com>
Date:   Mon, 15 Feb 2021 08:41:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bc43e8ab-b8df-fd2f-31e4-02cdc48cadff@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,

On 2/13/21 9:44 AM, Tom Rix wrote:
> 
> On 2/9/21 2:20 PM, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
>> aligns with the firmware settings.
>>
>> Fixes: 36847f9e3e56 ("firmware: stratix10-svc: correct reconfig flag and timeout values")
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>> v5: new add, add the missing standalone patch
>> ---
>>   include/linux/firmware/intel/stratix10-svc-client.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
>> index a93d859..f843c6a 100644
>> --- a/include/linux/firmware/intel/stratix10-svc-client.h
>> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
>> @@ -56,7 +56,7 @@
>>    * COMMAND_RECONFIG_FLAG_PARTIAL:
>>    * Set to FPGA configuration type (full or partial).
>>    */
>> -#define COMMAND_RECONFIG_FLAG_PARTIAL	1
>> +#define COMMAND_RECONFIG_FLAG_PARTIAL	0
> 
> Is this the stand alone fix split from v3's patch 1 ?
> 
> https://lore.kernel.org/linux-fpga/YBFW50LPP%2FyEbvEW@kroah.com/
>Yes, it is a stand-alone patch.

> Tom
> 
>>   
>>   /**
>>    * Timeout settings for service clients:
> 
Regards,
Richard
