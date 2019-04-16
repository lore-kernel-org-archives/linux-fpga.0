Return-Path: <SRS0=rg85=SS=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=rg85=SS=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from ch3vs01.rockwellcollins.com ([205.175.226.27]:33793 "EHLO
        ch3vs01.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbfDPQSK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 16 Apr 2019 12:18:10 -0400
Received: by mail-oi1-f198.google.com with SMTP id d198so10172757oih.6
        for <linux-fpga@vger.kernel.org>; Tue, 16 Apr 2019 09:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190411221109.173242-1-brandon.maier@rockwellcollins.com> <a3513e84-0328-b2ef-1ca2-1c563caf0e6d@monstr.eu>
In-Reply-To: <a3513e84-0328-b2ef-1ca2-1c563caf0e6d@monstr.eu>
From: Brandon Maier <brandon.maier@rockwellcollins.com>
Date: Tue, 16 Apr 2019 11:08:24 -0500
Message-ID: <CA+fik501cfCznG951=9oooTpN3T3Y+iSM8EW9DchCY6fFf7SAQ@mail.gmail.com>
Subject: Re: [PATCH] fpga: mgr: Use devicetree /alias to assign FPGA IDs
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: monstr@monstr.eu
Cc: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org, Clayton Shotwell <clayton.shotwell@rockwellcollins.com>

On Tue, Apr 16, 2019 at 7:06 AM Michal Simek <monstr@monstr.eu> wrote:
>
> From the first look this is not proper implementation. It is not
> handling cases where you have mix of devices with and without aliases.
> If first mgr has no alias it gets 0, then second devices with fpga0
> alias can't take it even it is assign to it.

From what I can tell, most of the drivers that use of_alias_get_id()
work this way. They assume the devicetree will either contain aliases
for all devices, or none at all; and prints a dev_warn() if there's a
mismatch. Not to say this is the best solution, but it's the
precedent.

>
> For exactly this reason I have introduced of_alias_get_alias_list()
> and take a look at cdns_get_id() in serial driver how I am using it.

It looks like cdns_get_id() uses bitmaps instead of IDA to handle
this, which complicates this. I'd prefer to not pull in those changes
for now if that's ok with the maintainers.

I could see value in adding an of.h helper like of_alias_ida_get()
that handles the boiler plate stuff of requesting the alias ID and
searching for a valid ID, though.

>
> Thanks,
> Michal
>
> --
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
>
>

Thanks,
Brandon
