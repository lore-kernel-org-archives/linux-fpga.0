Return-Path: <SRS0=ps2+=FO=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=ps2+=FO=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751827AbeBTQZ1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Feb 2018 11:25:27 -0500
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com [209.85.213.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 016AD21785
        for <linux-fpga@vger.kernel.org>; Tue, 20 Feb 2018 16:25:27 +0000 (UTC)
Received: by mail-vk0-f52.google.com with SMTP id z190so5955579vkg.1
        for <linux-fpga@vger.kernel.org>; Tue, 20 Feb 2018 08:25:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKfKVtH-HRa2Z5Ff_wss9oK2tN2taSLU6gAfgus=Z1KkhZwMBg@mail.gmail.com>
References: <CAKfKVtH-HRa2Z5Ff_wss9oK2tN2taSLU6gAfgus=Z1KkhZwMBg@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 20 Feb 2018 10:24:45 -0600
Message-ID: <CANk1AXRm9ME1Yu3y2WRMxG1o9BZq+6pg9T8CWaqKy2v+LwK9RA@mail.gmail.com>
Subject: Re: Fpga manager help
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: linux-fpga@vger.kernel.org

On Mon, Feb 19, 2018 at 1:09 AM, Shubhrajyoti Datta
<shubhrajyoti.datta@gmail.com> wrote:

Hi Shubhrajyoti,

> Hi ,
>
> Some of the FPGA has a  clock  rate that it needs to operate.
> Wanted some help in having suggestions as to  how should this be done.
>
>
> I tried the bridge approach.
> It worked however since having the possible rate have precompiled is difficult
> because of the wide range of possible frequency.
>
> So i have a first overlay that updates the rate and second overlay
> actually apply.

IIUC, that sounds right to me.  The base overlay sets up bridges and
fpga regions.  The overlay after that does the programming.  That's
consistent with the fpga-region device tree binding documentation.

Alan

> However this makes the apply look odd.
>
> Also if this is solved in some platform or if there are guidelines
> that will be helpful.
>
> Thanks and Regards,
> Shubhrajyoti
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
