Return-Path: <SRS0=Witp=DD=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Witp=DD=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:47557 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbdLGXM0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Dec 2017 18:12:26 -0500
Date: Fri, 8 Dec 2017 00:12:22 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: RFC: FT232H based FPGA configuration adapter drivers
Message-ID: <20171208001222.5ed2bf19@crub>
In-Reply-To: <CANk1AXQtqWBN4Y40vQun6V9Oq+TB5xbXCCT8MDUXCufHtn9ZgQ@mail.gmail.com>
References: <20171207153150.6f33f2e7@crub>
        <CANk1AXQtqWBN4Y40vQun6V9Oq+TB5xbXCCT8MDUXCufHtn9ZgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org, linux-spi@vger.kernel.org

On Thu, 7 Dec 2017 14:24:57 -0600
Alan Tull atull@kernel.org wrote:
...
>> Instead of MFD part as in previous version I intend to add an USB misc
>> driver for our FPGA configuration adapters under drivers/usb/misc.
>> When probing for VID/PID assigned to FIFO-FPP adapter type, this
>> driver will register CBUS GPIO controller, GPIO lookup tables for  
>
> I'm not clear how these lookup tables will be specified.  Is this
>platform using device tree?

No, this is x86 platform, not using device tree. Therefore we have
to specify device GPIOs for each dynamically added platform device,
e.g. like:

    lookup->dev_id = devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
    lookup->table[0].chip_hwnum = N; /* pin offset on this GPIO chip */
    lookup->table[0].chip_label = priv->gpiochip->label;
    lookup->table[0].con_id = "nconfig";
    lookup->table[0].flags = GPIO_ACTIVE_LOW;

    lookup->table[1].chip_hwnum = M;
    lookup->table[1].chip_label = priv->gpiochip->label;
    lookup->table[1].con_id = "conf_done";
    lookup->table[1].flags = GPIO_ACTIVE_HIGH;

Then, gpiod_get(dev, "nconfig", GPIOD_OUT_HIGH) in platform driver will
find the appropriate GPIO descriptor.

...
>> Below simplified diagram shows the intended device and drivers
>> relationship for reworking the adapter drivers.
>>
>>    +-------------+
>>    |             |
>>    |  STRATIX V  |PS-SPI         FT245 FIFO & GPIO
>>    |             +-----+    +-------------------+
>>    |  on Board 1 |     +    +                   |
>>    |             |                         +----+---+
>>    |  PCIe       |   ADBUS&ACBUS           |  CPLD  |
>>    +---+---------+ Connection Options      +----+---+
>>        ^          (MPSSE or FIFO&GPIO)          |
>>        +                  +              +------+-------+
>>   altera-cvp  +-----------+----------+   |     FPP      |
>>               |        FT232H        |   |              |
>>               |     0x0403:0x7148    |   |   ARRIA 10   |
>>               |     0x0403:0x7149    |   |              |
>>               +----------+-----------+   |  on Board 2  |
>>                          |               |              |
>>              +-----------+------------+  |        PCIe  |
>>     USB misc | fpga-cfg-intf USB misc |  +----------+---+
>>   drv creates|     bulk/ctrl xfer     |             ^
>>     platform |ACBUS GPIO Ctrl (0x7148)|             |
>>      devices |MPSSE GPIO Ctrl (0x7149)|             |
>>       below  +-------+-------+--------+             |
>>                      |       |                      |
>>         for     +----+       +------+    for        |
>>      PID 0x7149 |                   | PID 0x7148    |
>>       +---------+--------+  +-------+---------+     |
>>       | ftdi-mpsse-spi + |  |                 |     |
>>       | altera-ps-spi in |  |ftdi-fifo-fpp-mgr|     |
>>       |  spi_board_info  |  | platform device |     |
>>       +---------+--------+  +--------+--------+     |
>>                 ^                    ^              |
>>       drivers:  |                    |              |
>>                 +                    |              |
>>          MPSSE SPI master            |              |
>>                 ^                    |              |
>>                 |                    +              +
>>           altera-ps-spi        ftdi-fifo-fpp    altera-cvp
>>            FPGA Manager         FPGA Manager   FPGA Manager
>>                 ^                    ^              ^
>>                 |                    |              |
>>                 +---------------+    +    +---------+
>>                                   fpga-mgr
>>  
>
>Just to be clear, this is several solutions that are being
>superimposed in one diagram, depending on which platform you are on,
>right?

Correct, we either have USB -> MPSSE -> PS-SPI -> Stratix V path on
one board, or USB -> FIFO-FPP -> CPLD -> Arria 10 path on another
board.

Anatolij
