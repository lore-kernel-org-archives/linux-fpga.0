Return-Path: <SRS0=8dAr=NQ=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=8dAr=NQ=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:43554 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKFFvP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Nov 2018 00:51:15 -0500
Date: Mon, 5 Nov 2018 21:29:45 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 0/3] Add support for ARRI FPGA configuration
Message-ID: <20181105212945.7625cfd3@crub>
In-Reply-To: <CANk1AXQCTc39hgn7FszzhqHVFRCeMwqddC1FmHe25i2QYffrcw@mail.gmail.com>
References: <20181105161913.27538-1-agust@denx.de>
        <CANk1AXQCTc39hgn7FszzhqHVFRCeMwqddC1FmHe25i2QYffrcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: USB list <linux-usb@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, linux-fpga@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Moritz Fischer <mdf@kernel.org>

Hi Alan,

On Mon, 5 Nov 2018 12:52:03 -0600
Alan Tull atull@kernel.org wrote:

>On Mon, Nov 5, 2018 at 10:19 AM Anatolij Gustschin <agust@denx.de> wrote:
>
>Hi Anatolij,
>
>>
>> This series adds drivers and FPGA manager support required
>> for FT232H based ARRI FPGA configuration adapters.  
>
>Is this a repost or a new version of this patchset?  If it's a repost,
>you could note that.  If there are changes since the previous posting,
>version info helps reviewers know what's new.

This is a new version. Or it is very different compared to my first
attempt to add driver support for this adapter hardware. The initial
series ([1],[2],[3]) didn't include MPSSE SPI driver, it didn't use
vendor specific USB PIDs for FTDI device and had fundamental design
issues. This new version implements the new driver design as summarized
here [4].

Changes in this new version:
 - don't use MFD framework
 - don't use original FT232H USB PID (it is too generic and collides
   with existing ftdi_sio driver)
 - don't add separate CBUS GPIO driver based on FT232H MFD device
 - redesign/rework the drivers as described under [4]
 - add basic FT232H interface driver under drivers/usb/misc/
 - use custom reserved USB PIDs in the USB driver for adapter devices
 - add notes about borrowed protocol code from libftdi to commit log
   and header file
 - add MPSSE SPI controller driver supporting USB-SPI bus with
   dynamically added SPI slaves from description in platform data
   (the initial attempt didn't include USB SPI bus support for PS-
    SPI FPGA configuration via USB)
 - rework FPP fpga manager driver based on new FT232H interface
   driver and extend it according to CPLD changes for additional
   support of new hardware revision B.

[1] https://patchwork.kernel.org/patch/9828985/
[2] https://patchwork.kernel.org/patch/9828981/
[3] https://patchwork.kernel.org/patch/9828983/
[4] https://www.spinics.net/lists/linux-usb/msg163441.html

Thanks,

Anatolij
