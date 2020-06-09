Return-Path: <SRS0=JyFA=7W=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=JyFA=7W=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730639AbgFIPBl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 9 Jun 2020 11:01:41 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F905C05BD1E
        for <linux-fpga@vger.kernel.org>; Tue,  9 Jun 2020 08:01:38 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 69so16849637otv.2
        for <linux-fpga@vger.kernel.org>; Tue, 09 Jun 2020 08:01:38 -0700 (PDT)
Subject: Re: [PATCH 1/1] selftests: fpga: dfl: A test for afu interrupt
 support
References: <20200609130208.27390-1-trix@redhat.com>
 <20200609130208.27390-2-trix@redhat.com> <20200609142007.GA831428@kroah.com>
 <d3d8e518-0760-8cbe-cf74-191f70329a46@redhat.com>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <340c25e4-579b-a06b-49ae-63937dc0fbf0@linuxfoundation.org>
Date: Tue, 9 Jun 2020 09:01:35 -0600
MIME-Version: 1.0
In-Reply-To: <d3d8e518-0760-8cbe-cf74-191f70329a46@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Tom Rix <trix@redhat.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, linux-fpga@vger.kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>

On 6/9/20 8:45 AM, Tom Rix wrote:
> 
>> Why not use the ksft_* functions and frameworks to properly print out
>> the test status and results so that tools can correctly parse it?
>>
>> It's generally bad-form to make up your own format.
> 
> I used the the drivers/dma-buf test a basis example.  Can you point me at a better example ?
> 

A few examples to choose from as a reference:

tools/testing/selftests/breakpoints
tools/testing/selftests/timens

Please reach out to me if you have any questions.

thanks,
-- Shuah
