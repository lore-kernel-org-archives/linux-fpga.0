Return-Path: <SRS0=KFgc=NM=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=KFgc=NM=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40790 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeKBEsh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 2 Nov 2018 00:48:37 -0400
Received: by mail-yw1-f66.google.com with SMTP id f192-v6so715878ywh.7
        for <linux-fpga@vger.kernel.org>; Thu, 01 Nov 2018 12:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181029144222.26927-1-agust@denx.de> <20181029164857.GA2453@archbook>
 <20181030121913.3f5f8458@crub> <CANk1AXR470s6XyfjR8=1SdiNAFsVj0oNA1-STVCu6_zY-kLf3A@mail.gmail.com>
 <20181101193336.766566fc@crub> <CANk1AXR+Kv9-vEmMS3ybMoPOUdbNZXSK1341BD1jsEWUaZRXUg@mail.gmail.com>
 <20181101202325.3bf87ea3@crub>
In-Reply-To: <20181101202325.3bf87ea3@crub>
From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Thu, 1 Nov 2018 12:44:03 -0700
Message-ID: <CAAtXAHcv_=CEKdDsQH59-OrPaHO2CUPAYF89ce=kP6WX_UUCeg@mail.gmail.com>
Subject: Re: [PATCH] fpga: xilinx-spi: Use unique FPGA manager names
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org

Hi Anatolij,

On Thu, Nov 1, 2018 at 12:23 PM Anatolij Gustschin <agust@denx.de> wrote:
>
> On Thu, 1 Nov 2018 13:46:27 -0500
> Alan Tull atull@kernel.org wrote:
> ...
> >> # ls -l /sys/class/fpga_manager/fpga0/device
> >> lrwxrwxrwx 1 root root 0 Nov  1 19:26 /sys/class/fpga_manager/fpga0/device -> ../../../spi1.0
> >
> >Is 'device' giving the info this patch is adding to 'name'?
>
> One can extract this info from 'device' somehow, but it is much more
> easier to get it from the name
>
> # cat /sys/class/fpga_manager/fpga0/name
> xlnx-slave-spi spi1.0

I see your use case, but I don't think the FPGA Manager framework is
the right place to fix this,
especially not encoding bus information in the FPGA Manager name. The
info is already available
to userland (not conveniently I agree, but nevertheless).

From my end NAK.

Thanks,

Moritz
