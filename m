Return-Path: <SRS0=Tyjd=FP=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Tyjd=FP=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:41434 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUFgh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 21 Feb 2018 00:36:37 -0500
Received: by mail-qk0-f169.google.com with SMTP id h129so579947qke.8
        for <linux-fpga@vger.kernel.org>; Tue, 20 Feb 2018 21:36:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CANk1AXRm9ME1Yu3y2WRMxG1o9BZq+6pg9T8CWaqKy2v+LwK9RA@mail.gmail.com>
References: <CAKfKVtH-HRa2Z5Ff_wss9oK2tN2taSLU6gAfgus=Z1KkhZwMBg@mail.gmail.com>
 <CANk1AXRm9ME1Yu3y2WRMxG1o9BZq+6pg9T8CWaqKy2v+LwK9RA@mail.gmail.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Wed, 21 Feb 2018 11:06:36 +0530
Message-ID: <CAKfKVtFkYjwe0JH+f1Bdt7p+o2b_TsKYE0fD6HNs_syXn8D82Q@mail.gmail.com>
Subject: Re: Fpga manager help
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: linux-fpga@vger.kernel.org

Hi Alan,
Thanks for the help.


On Tue, Feb 20, 2018 at 9:54 PM, Alan Tull <atull@kernel.org> wrote:
> On Mon, Feb 19, 2018 at 1:09 AM, Shubhrajyoti Datta
> <shubhrajyoti.datta@gmail.com> wrote:
>
> Hi Shubhrajyoti,
>
>> Hi ,
>>
>> Some of the FPGA has a  clock  rate that it needs to operate.
>> Wanted some help in having suggestions as to  how should this be done.
>>
>>
>> I tried the bridge approach.
>> It worked however since having the possible rate have precompiled is difficult
>> because of the wide range of possible frequency.
>>
>> So i have a first overlay that updates the rate and second overlay
>> actually apply.
>
> IIUC, that sounds right to me.  The base overlay sets up bridges and
> fpga regions.  The overlay after that does the programming.  That's
> consistent with the fpga-region device tree binding documentation.

My options were
1) a first overlay that updates the rate and second overlay
 actually apply.
2) overlay has a pseudo clock driver that sets the rate and acts
as a provider of clocks so that other drivers are EPROBE_DEFERED.

Do you think I should prefer option 1)
>
> Alan
>
