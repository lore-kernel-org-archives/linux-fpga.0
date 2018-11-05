Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20181105161913.27538-1-agust@denx.de>
In-Reply-To: <20181105161913.27538-1-agust@denx.de>
From: Alan Tull <atull@kernel.org>
Date: Mon, 5 Nov 2018 12:52:03 -0600
Message-ID: <CANk1AXQCTc39hgn7FszzhqHVFRCeMwqddC1FmHe25i2QYffrcw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add support for ARRI FPGA configuration
Content-Type: text/plain; charset="UTF-8"
To: Anatolij Gustschin <agust@denx.de>
Cc: USB list <linux-usb@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, linux-fpga@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Nov 5, 2018 at 10:19 AM Anatolij Gustschin <agust@denx.de> wrote:

Hi Anatolij,

>
> This series adds drivers and FPGA manager support required
> for FT232H based ARRI FPGA configuration adapters.

Is this a repost or a new version of this patchset?  If it's a repost,
you could note that.  If there are changes since the previous posting,
version info helps reviewers know what's new.

Thanks,
Alan

>
> Patch 1/3 adds FT232H interface driver (for ARRI USB PIDs)
> implementing commonly used FTDI USB transfer operations and
> ACBUS/MPSSE GPIO controllers. Depending on USB PIDs it creates
> platform devices for MPSSE SPI bus with attached SPI slaves
> or platform devices for ARRI FPP FPGA manager.
>
> Patch 2/3 adds MPSSE SPI controller driver which registers
> an FTDI USB-SPI bus with attached SPI slaves from description
> in platform data, so existing SPI protocol drivers can be
> used for these slave devices (in our case altera-ps-spi).
> Via interface driver in patch 1/3 it is easily possible to add
> support for other slave devices using custom USB PIDs (e.g.
> spi-nor flash W25Q32 with m25p80 driver has beed used for
> testing MPSSE SPI controller driver).
>
> Patch 3/3 adds FPGA manager driver for ARRI FPP adapters for
> FPGA configuration via Altera fast passive parallel interface.
>
> Anatolij Gustschin (3):
>   usb: misc: add driver for FT232H based FPGA configuration devices
>   spi: add FTDI MPSSE SPI controller driver
>   fpga: Add fpga manager driver for ARRI Altera FPP
>
>  drivers/fpga/Kconfig            |    7 +
>  drivers/fpga/Makefile           |    1 +
>  drivers/fpga/ftdi-fifo-fpp.c    |  594 +++++++++++++
>  drivers/spi/Kconfig             |    7 +
>  drivers/spi/Makefile            |    1 +
>  drivers/spi/spi-ftdi-mpsse.c    |  671 ++++++++++++++
>  drivers/usb/misc/Kconfig        |    9 +
>  drivers/usb/misc/Makefile       |    1 +
>  drivers/usb/misc/ft232h-intf.c  | 1468 +++++++++++++++++++++++++++++++
>  include/linux/usb/ft232h-intf.h |  198 +++++
>  10 files changed, 2957 insertions(+)
>  create mode 100644 drivers/fpga/ftdi-fifo-fpp.c
>  create mode 100644 drivers/spi/spi-ftdi-mpsse.c
>  create mode 100644 drivers/usb/misc/ft232h-intf.c
>  create mode 100644 include/linux/usb/ft232h-intf.h
>
> --
> 2.17.1
>
