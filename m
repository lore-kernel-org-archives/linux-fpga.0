Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0BEC61DD8
	for <linux-fpga@archiver.kernel.org>; Mon, 16 Nov 2020 13:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4B222245
	for <linux-fpga@archiver.kernel.org>; Mon, 16 Nov 2020 13:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgKPNiW (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 16 Nov 2020 08:38:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:20910 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgKPNiV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 16 Nov 2020 08:38:21 -0500
IronPort-SDR: AikqHJ4gHng/+fdMxr+inA8gMbtsFFjTnXuKMyeZz4ebpvo5QLY6ZtGFtX3bK+LYyQVFBfovJP
 EUqnsS3DyWAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="157769651"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="157769651"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 05:38:12 -0800
IronPort-SDR: S2+KsB20Cjkshn4UCKQQQApZ/NP0Z5e0DKikePgE5ip3p959q8kMVw9322tVRbGjEb8WTmz9Z4
 gPA8bu8ZA2bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="531848711"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2020 05:38:12 -0800
Subject: Re: [PATCHv1 3/4] dt-bindings: fpga: add authenticate-fpga-config
 property
To:     Moritz Fischer <mdf@kernel.org>
Cc:     trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        sridhar.rajagopal@intel.com, Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-4-git-send-email-richard.gong@linux.intel.com>
 <20201115192106.GB283592@epycbox.lan>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <083f5b49-5519-e15a-a16f-c0fc38aba15b@linux.intel.com>
Date:   Mon, 16 Nov 2020 07:59:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201115192106.GB283592@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Moritz,


On 11/15/20 1:21 PM, Moritz Fischer wrote:
> Hi Richard,
> 
> On Thu, Nov 12, 2020 at 12:06:42PM -0600, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Add authenticate-fpga-config property for FPGA bitstream authentication.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>>   Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
>> index e811cf8..7a512bc 100644
>> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
>> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
>> @@ -187,6 +187,7 @@ Optional properties:
>>   - external-fpga-config : boolean, set if the FPGA has already been configured
>>   	prior to OS boot up.
>>   - encrypted-fpga-config : boolean, set if the bitstream is encrypted
>> +- authenticate-fpga-config : boolean, set if do bitstream authentication
> It is unclear to me from the description whether this entails
> authentication + reconfiguration or just authentication.
> 
> If the latter is the case this should probably be described as such.

It is for authentication only, just make the signed bitstream has the 
valid signatures.

Regards,
Richard

> 
>>   - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
>>   	bridges to successfully become enabled after the region has been
>>   	programmed.
>> -- 
>> 2.7.4
>>
> 
> Thanks
> 
