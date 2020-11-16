Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA55C61DD8
	for <linux-fpga@archiver.kernel.org>; Mon, 16 Nov 2020 14:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCBC322265
	for <linux-fpga@archiver.kernel.org>; Mon, 16 Nov 2020 14:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgKPOSg (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 16 Nov 2020 09:18:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:44670 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgKPOSg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 16 Nov 2020 09:18:36 -0500
IronPort-SDR: ecGEpSvUZTdJbUktNXYpS9f2RSyDdbn6jSX6vy0aQmDf2IpizZ2aH7mjwI3I7+jbnYB+/L9Sau
 ZNBrwwodM7/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="150599749"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="150599749"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 06:18:35 -0800
IronPort-SDR: vS8QKsFuJV5rCELUzotlPEHJ/ufDutgE31elHl43XyOc5rl+Tf3XxSTnN9vGHjo7MOwi1LW6xY
 xB+oUHuc1tcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="531863793"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2020 06:18:34 -0800
Subject: Re: [PATCHv1 4/4] fpga: stratix10-soc: entend driver for bitstream
 authentication
To:     Moritz Fischer <mdf@kernel.org>
Cc:     trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        sridhar.rajagopal@intel.com, Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-5-git-send-email-richard.gong@linux.intel.com>
 <20201115191936.GA283592@epycbox.lan>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <0eb7fa0d-30e6-099f-d104-8a9aea7d8030@linux.intel.com>
Date:   Mon, 16 Nov 2020 08:39:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201115191936.GA283592@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Moritz,

On 11/15/20 1:19 PM, Moritz Fischer wrote:
> On Thu, Nov 12, 2020 at 12:06:43PM -0600, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Exten FPGA manager driver to support FPGA bitstream authentication on
> Nit: Extend

Sorry, I will fix that in version 2.

>> Intel SocFPGA platforms.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>>   drivers/fpga/stratix10-soc.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
>> index 657a70c..8a59365 100644
>> --- a/drivers/fpga/stratix10-soc.c
>> +++ b/drivers/fpga/stratix10-soc.c
>> @@ -185,7 +185,10 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>>   	ctype.flags = 0;
>>   	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>>   		dev_dbg(dev, "Requesting partial reconfiguration.\n");
>> -		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
>> +		ctype.flags |= FPGA_MGR_PARTIAL_RECONFIG;
> I think we had this discussion during the original review of the
> stratix10-soc driver?

Yes, we discussed before.

> 
> Wasn't the point of using the BIT() to not assume alignment of FPGA_MGR
> flags and firmware structure?
> 

Yes, we should use BIT().

> The FPGA_MGR_* bits are kernel internal and can therefore change, it
> would be unfortunate to end up in a situation where this breaks the FW
> interface (assuming firmware uses the value in pass-through which it
> looks like is what is happening).

In that case, I should use the flag defined in stratix10-soc driver driver.

> 
>> +	} else if (info->flags & FPGA_MGR_BITSTREM_AUTHENTICATION) {
>> +		dev_dbg(dev, "Requesting bitstream authentication.\n");
>> +		ctype.flags |= FPGA_MGR_BITSTREM_AUTHENTICATION;
> Do you want to change this to BIT(COMMAND_AUTHENTICATE_BITSTREAM) or
> something like that?

OK, I will change to BIT(COMMAND_AUTHENTICATE_BITSTREAM).

Regards,
Richard

>>   	} else {
>>   		dev_dbg(dev, "Requesting full reconfiguration.\n");
>>   	}
>> -- 
>> 2.7.4
>>
> 
> Thanks,
> Moritz
> 
