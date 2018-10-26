Return-Path: <SRS0=Bgun=NG=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Bgun=NG=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-by2nam03on0079.outbound.protection.outlook.com ([104.47.42.79]:6379
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbeJZQay (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 26 Oct 2018 12:30:54 -0400
Subject: Re: [PATCH] zynq-fpga: Only route PR via PCAP when required
References: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
 <20181023090119.GA2205@archbook>
 <1781ed23-e03c-f70a-ea8c-3e9fa6eec9d4@topic.nl>
 <20181023110445.GA1371@archbook>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <468b9b34-aa87-9abb-a913-0512a01e9a51@xilinx.com>
Date: Fri, 26 Oct 2018 09:54:42 +0200
MIME-Version: 1.0
In-Reply-To: <20181023110445.GA1371@archbook>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <mdf@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>
Cc: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "atull@kernel.org" <atull@kernel.org>

On 23. 10. 18 13:04, Moritz Fischer wrote:
> Hi Mike,
> 
> On Tue, Oct 23, 2018 at 10:53:50AM +0000, Mike Looijmans wrote:
>> On 23-10-18 11:01, Moritz Fischer wrote:
>>> Hi Mike,
>>>
>>> seems like a good usecase (though uncommon), question below
>>
>> Usecases for ICAP:
>> - It's considerably faster than PCAP
>> - Self-repairing logic (e.g. single-event upsets)
>> - Being programmed from a remote FPGA
>> - Programming through another bus (e.g. PCIe)
> 
> Yeah, I wasn't saying it's a bad usecase, just not super common :)
> 
>>
>>
>>>
>>> On Tue, Oct 23, 2018 at 08:31:19AM +0200, Mike Looijmans wrote:
>>>> The Xilinx Zynq FPGA driver takes ownership of the PR interface, making
>>>> it impossible to use the ICAP interface for partial reconfiguration.
>>>>
>>>> This patch changes the driver to only activate PR over PCAP while the
>>>> device is actively being accessed by the driver for programming.
>>>>
>>>> This allows both PCAP and ICAP interfaces to be used for PR.
>>>>
>>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>>> ---
>>>>   drivers/fpga/zynq-fpga.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
>>>> index 3110e00..f6c205a 100644
>>>> --- a/drivers/fpga/zynq-fpga.c
>>>> +++ b/drivers/fpga/zynq-fpga.c
>>>> @@ -497,6 +497,10 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
>>>>   	int err;
>>>>   	u32 intr_status;
>>>>   
>>>> +	/* Release 'PR' control back to the ICAP */
>>>> +	zynq_fpga_write(priv, CTRL_OFFSET,
>>>> +		zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);
>>>> +
>>>
>>> Shouldn't that be after the below stanza that enables the clock?
>>
>> I'm actually not sure, and I did not encounter any problems while testing 
>> this, but it's easier to just move it than to find out, so I'll go for "yes, 
>> let's enable the clock first".
>> I'll await a bit more feedback and post a v2 for that.
> 
> Ok, I had suspected you tested it and probably didn't run into issues,
> but just wanted to make sure we think about it. If you don't mind, swap
> it around as I suggested just to be safe.
> 
> With that change feel free to add my Reviewed-by: Moritz Fischer
> <mdf@kernel.org> in your v2.

That clock can be used by something else that's why you didn't observe
any issue. Anyway I have no problem with reverting that setting back
that icap can be used.
In general there should be synchronization mechanism for this. And also
driver "feature" not to enable access from icap for security reason. But
that's something what should be done in other patch.

Thanks,
Michal
