Return-Path: <SRS0=W+aB=B2=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=W+aB=B2=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from gateway31.websitewelcome.com ([192.185.143.4]:40048 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750998AbdJ0TzF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 27 Oct 2017 15:55:05 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id F0F3C324221
        for <linux-fpga@vger.kernel.org>; Fri, 27 Oct 2017 14:55:04 -0500 (CDT)
Date: Fri, 27 Oct 2017 14:55:04 -0500
Message-ID: <20171027145504.Horde.VcX25ngHHNNLQOuEV8-B27E@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] fpga: fpga-mgr: remove unnecessary code in
 __fpga_mgr_get
References: <20171026230230.GA4904@embeddedor.com>
 <CANk1AXQX24U06SBuoBmw=UWeCdnu3OV4BW2ZRBW4t1KirZZ5DA@mail.gmail.com>
 <20171027140904.Horde.m5O1mdmtNKyY-jthC9ZZmz8@gator4166.hostgator.com>
 <CANk1AXRzoh8ZsJmzoGJuOJZ=ioTyaMBtaT5y+63Ho26HUzJchA@mail.gmail.com>
In-Reply-To: <CANk1AXRzoh8ZsJmzoGJuOJZ=ioTyaMBtaT5y+63Ho26HUzJchA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>


Quoting Alan Tull <atull@kernel.org>:

> On Fri, Oct 27, 2017 at 2:09 PM, Gustavo A. R. Silva
> <garsilva@embeddedor.com> wrote:
>> Hi Alan,
>>
>> Quoting Alan Tull <atull@kernel.org>:
>>
>>> On Thu, Oct 26, 2017 at 6:02 PM, Gustavo A. R. Silva
>>> <garsilva@embeddedor.com> wrote:
>>>
>>> Hi Gustavo,
>>>
>>> Thanks for pointing that out.  There's also a similar thing in
>>> fpga-bridge.c that I need to fix.
>>>
>>
>> Can you share with me what exactly are you trying to fix?
>>
>> If the issue is similar I might be able to help.
>
> Same fix, but in of_fpga_bridge_get.  Checks the output of
> to_fpga_bridge for NULL.
>

Oh I see now. I'll send a patch for this shortly.

Thanks!
--
Gustavo A. R. Silva





