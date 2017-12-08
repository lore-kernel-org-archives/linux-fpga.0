Return-Path: <SRS0=YrFZ=DE=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=YrFZ=DE=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42439 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbdLHJ1r (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 8 Dec 2017 04:27:47 -0500
MIME-Version: 1.0
In-Reply-To: <20171207153150.6f33f2e7@crub>
References: <20171207153150.6f33f2e7@crub>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 Dec 2017 10:27:46 +0100
Message-ID: <CAMuHMdUAXv_s8Lw1qwORew8RydKRKhFq7tMccU7jCa63_Otp0w@mail.gmail.com>
Subject: Re: RFC: FT232H based FPGA configuration adapter drivers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-fpga@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>

Hi Anatolij,

On Thu, Dec 7, 2017 at 3:31 PM, Anatolij Gustschin <agust@denx.de> wrote:
> I have to rework drivers for custom FT232H based FPGA configuration
> adapters to make them suitable for including in mainline kernel. These
> adapters should be usable via low-level drivers for FPGA Manager
> framework. Two required low-level FPGA Manager drivers (for PS-SPI and
> CvP configurations) are already in mainline. The missing parts are the
> MPSSE SPI master driver (for attaching altera-ps-spi SPI devices) and
> the FTDI FIFO FPP interface driver for FPGA Manager. I'm CCing the
> relevant subsystem mailing lists and would like to get feedback to the
> draft below before rewriting the missing driver parts.
>
> A few words about our FPGA and FPGA configuration adapter hardware. We
> have FPGA PCIe boards with two different FT232H based configuration
> adapters. The first adapter type utilizes FT232H chip in MPSSE mode to
> connect ADBUS SPI/GPIO pins to Stratix-V PS-SPI interface. Another
> adapter type connects FT232H ADBUS (in FT245 FIFO mode) and two ACBUS
> GPIOs to a CPLD, the CPLD is connected to the Arria-10 FPP interface.
> Both FPGA boards are connected to the host via PCIe and USB (FT232H).

[...]

> Instead of MFD part as in previous version I intend to add an USB misc
> driver for our FPGA configuration adapters under drivers/usb/misc.
> When probing for VID/PID assigned to FIFO-FPP adapter type, this
> driver will register CBUS GPIO controller, GPIO lookup tables for
> FIFO FPP device and will create a platform device for attaching the
> low-level FPGA manager driver for FIFO FPP interface. The attached
> FPGA manager driver will be similar to the ftdi-fifo-fpp driver and
> will reside in drivers/fpga. When probing for VID/PID assigned to
> MPSSE SPI adapter type, the USB misc driver will register MPSSE GPIO
> controller, GPIO lookup tables for altera-ps-spi control/status GPIOs
> and will create platform device for attaching MPSSE SPI master
> controller driver. The SPI master controller platform driver will
> register MPSSE SPI bus with SPI slave device from spi_board_info
> struct in its platform data (in our case altera-ps-spi SPI slave
> device for attaching altera-ps-spi driver). The intended location
> of this custom SPI master controller driver is drivers/spi.

A quick Google shows the FT232H chip in MPSSE mode can also support i2c.
I guess your design can be extended for that, too, using another VID/PID pair?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
