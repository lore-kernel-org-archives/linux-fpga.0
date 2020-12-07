Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A43C4361B
	for <linux-fpga@archiver.kernel.org>; Mon,  7 Dec 2020 18:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC7923877
	for <linux-fpga@archiver.kernel.org>; Mon,  7 Dec 2020 18:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgLGSKk (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 7 Dec 2020 13:10:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:33967 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgLGSKk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 7 Dec 2020 13:10:40 -0500
IronPort-SDR: +tToWHGkpcoipGfsSWS3D+Mj0moaya31FPEmknxd7pp8txotKVbwuAeau4fLLdHzuLezLyDO2m
 zDDljjmg7iPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="161512255"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="161512255"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 10:09:56 -0800
IronPort-SDR: 4bx4yQedlpWhygQsuy4TjrqAY0RCAmkpmkwPQZWLvOP9KF1JbXWpRdOJ1j3yJoVXvLCBCc2al+
 xH9ffOvxR9sQ==
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="317312314"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.209.98.39])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 10:09:55 -0800
Subject: Re: [PATCH v7 1/7] fpga: sec-mgr: fpga security manager class driver
To:     Randy Dunlap <rdunlap@infradead.org>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20201203210958.241329-1-russell.h.weight@intel.com>
 <20201203210958.241329-2-russell.h.weight@intel.com>
 <711e290a-d8de-b31a-d640-df6785a3eba3@infradead.org>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <210d0b92-85c9-16b4-e7ac-ee045530deb4@intel.com>
Date:   Mon, 7 Dec 2020 10:09:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <711e290a-d8de-b31a-d640-df6785a3eba3@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 12/4/20 11:45 AM, Randy Dunlap wrote:
> Hi--
>
> On 12/3/20 1:09 PM, Russ Weight wrote:
>
>> ---
>> diff --git a/Documentation/fpga/fpga-sec-mgr.rst b/Documentation/fpga/fpga-sec-mgr.rst
>> new file mode 100644
>> index 000000000000..26dac599ead7
>> --- /dev/null
>> +++ b/Documentation/fpga/fpga-sec-mgr.rst
>> @@ -0,0 +1,44 @@
>
>> +In addition to managing secure updates of the FPGA and BMC images,
>> +the FPGA Security Manager update process may also used to
>                                             may also be used to

Thanks - I'll fix this for the next submission.

- Russ
>
>> +program root entry hashes and cancellation keys for the FPGA static
>> +region, the FPGA partial reconfiguration region, and the BMC.
>
> thanks.

