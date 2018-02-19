Return-Path: <SRS0=VGfm=FN=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=VGfm=FN=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:44395 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeBSHJE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 19 Feb 2018 02:09:04 -0500
Received: by mail-qt0-f173.google.com with SMTP id g60so2911580qtd.11
        for <linux-fpga@vger.kernel.org>; Sun, 18 Feb 2018 23:09:04 -0800 (PST)
MIME-Version: 1.0
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Mon, 19 Feb 2018 12:39:03 +0530
Message-ID: <CAKfKVtH-HRa2Z5Ff_wss9oK2tN2taSLU6gAfgus=Z1KkhZwMBg@mail.gmail.com>
Subject: Fpga manager help
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org

Hi ,

Some of the FPGA has a  clock  rate that it needs to operate.
Wanted some help in having suggestions as to  how should this be done.


I tried the bridge approach.
It worked however since having the possible rate have precompiled is difficult
because of the wide range of possible frequency.

So i have a first overlay that updates the rate and second overlay
actually apply.
However this makes the apply look odd.

Also if this is solved in some platform or if there are guidelines
that will be helpful.

Thanks and Regards,
Shubhrajyoti
