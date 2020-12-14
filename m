Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85D9C2BBCA
	for <linux-fpga@archiver.kernel.org>; Mon, 14 Dec 2020 14:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA16A22CF7
	for <linux-fpga@archiver.kernel.org>; Mon, 14 Dec 2020 14:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgLNOXg (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 14 Dec 2020 09:23:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:31126 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440165AbgLNOX2 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 09:23:28 -0500
IronPort-SDR: kS+eYmU7/zCHhRjwjJXcJENWlU1JwIfWV4ioY+2Z2VpLhkEvhbo/CXMh6BmcgPACj2+Ftx5+0s
 ch1aCzFG2cBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="171202280"
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="171202280"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 06:21:42 -0800
IronPort-SDR: BjdsnLP1VrbQFSqujFVrzFi5vyVdX5LWRlDQV7fFkFeEjlrEuI7KIsaxneanNXMg3AjXsWxIyd
 7/7dy4wdDAIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="381836283"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga004.fm.intel.com with ESMTP; 14 Dec 2020 06:21:42 -0800
Subject: Re: [PATCHv2 0/5] Extend Intel service layer, FPGA manager and region
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        sridhar.rajagopal@intel.com, richard.gong@intel.com
References: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
 <8640e59d-5e38-a32a-2ac6-a178180e816d@linux.intel.com>
 <X9dxE/jQ33mfWBz/@kroah.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <f5227d19-895a-e43f-a5eb-4fb86ddcc52f@linux.intel.com>
Date:   Mon, 14 Dec 2020 08:43:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X9dxE/jQ33mfWBz/@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

On 12/14/20 8:05 AM, Greg KH wrote:
> On Mon, Dec 14, 2020 at 08:03:07AM -0600, Richard Gong wrote:
>>
>> Hi Moritz, Greg,
>>
>> Sorry for asking.
>>
>> Any comment on Intel service layer and FPGA patches submitted on 11/18/20?
> 
> I don't see them in my review queue, sorry.
> 

I just re-submitted the patches.

> greg k-h >
Regards,
Richard
