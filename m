Return-Path: <SRS0=Tyjd=FP=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Tyjd=FP=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751805AbeBUT0e (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 21 Feb 2018 14:26:34 -0500
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com [209.85.217.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46BA4217A0
        for <linux-fpga@vger.kernel.org>; Wed, 21 Feb 2018 19:26:33 +0000 (UTC)
Received: by mail-ua0-f173.google.com with SMTP id i15so1768059uak.3
        for <linux-fpga@vger.kernel.org>; Wed, 21 Feb 2018 11:26:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <be42ac6b-0209-6f90-3802-8be6cd9baac9@monstr.eu>
References: <CAKfKVtH-HRa2Z5Ff_wss9oK2tN2taSLU6gAfgus=Z1KkhZwMBg@mail.gmail.com>
 <CANk1AXRm9ME1Yu3y2WRMxG1o9BZq+6pg9T8CWaqKy2v+LwK9RA@mail.gmail.com>
 <CAKfKVtFkYjwe0JH+f1Bdt7p+o2b_TsKYE0fD6HNs_syXn8D82Q@mail.gmail.com> <be42ac6b-0209-6f90-3802-8be6cd9baac9@monstr.eu>
From: Alan Tull <atull@kernel.org>
Date: Wed, 21 Feb 2018 13:25:52 -0600
Message-ID: <CANk1AXSkryS-KxczSfen41VvoTVafZcuSLDUhcq-kuiqhYjknQ@mail.gmail.com>
Subject: Re: Fpga manager help
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>, linux-fpga@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Grant Likely <grant.likely@secretlab.ca>

On Wed, Feb 21, 2018 at 6:33 AM, Michal Simek <monstr@monstr.eu> wrote:
> Hi, +Grant and Pantelis,

Hi Shubhrajyoti,

I want to make sure I understand your situation here.  So I'll ask
some questions, please let me know if I'm misunderstanding.

>
> On 21.2.2018 06:36, Shubhrajyoti Datta wrote:
>> Hi Alan,
>> Thanks for the help.
>>
>>
>> On Tue, Feb 20, 2018 at 9:54 PM, Alan Tull <atull@kernel.org> wrote:
>>> On Mon, Feb 19, 2018 at 1:09 AM, Shubhrajyoti Datta
>>> <shubhrajyoti.datta@gmail.com> wrote:
>>>
>>> Hi Shubhrajyoti,
>>>
>>>> Hi ,
>>>>
>>>> Some of the FPGA has a  clock  rate that it needs to operate.

The FPGA device needs a clock, right?  This isn't dependent on what
FPGA image is loaded; this is the clock that makes the FPGA device
happy, right?

If that is the case, this is platform specific setup, which can be
done by adding an overlay or it could have been in the base device
tree, right?  The second overlay can do the FPGA programming.

>>>> Wanted some help in having suggestions as to  how should this be done.
>>>>
>>>>
>>>> I tried the bridge approach.
>>>> It worked however since having the possible rate have precompiled is difficult
>>>> because of the wide range of possible frequency.
>>>>
>>>> So i have a first overlay that updates the rate and second overlay
>>>> actually apply.
>>>
>>> IIUC, that sounds right to me.  The base overlay sets up bridges and
>>> fpga regions.  The overlay after that does the programming.  That's
>>> consistent with the fpga-region device tree binding documentation.
>>
>> My options were
>> 1) a first overlay that updates the rate and second overlay
>>  actually apply.

So that's what I'm saying above, IIUC

>> 2) overlay has a pseudo clock driver that sets the rate and acts
>> as a provider of clocks so that other drivers are EPROBE_DEFERED.
>>
>> Do you think I should prefer option 1)
> I would prefer option too.

Option two?

What does option 2 give us that option 1 doesn't?  Seems like more
work, unless there's something in this setup I don't know about, which
seems pretty likely right now.

> If you want to use option 1 then still
> devices in second overlay should reference clock setup in the first.

Now that makes it sound like we're talking about clocks for the
hardware that is in FPGA fabric?

>
> Thanks,
> Michal
>
>
> --
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs
>
>
