Return-Path: <SRS0=jqPo=SK=denx.de=agust@kernel.org>
Return-Path: <SRS0=jqPo=SK=denx.de=agust@kernel.org>
Date: Mon, 8 Apr 2019 19:25:39 +0200
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v4 3/3] fpga: Add fpga manager driver for ARRI Altera
 FPP
Message-ID: <20190408192539.590410bb@crub>
In-Reply-To: <20190221202506.17744-4-agust@denx.de>
References: <20190221202506.17744-1-agust@denx.de>
	<20190221202506.17744-4-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: atull@kernel.org, mdf@kernel.org
Cc: linux-usb@vger.kernel.org, linux-spi@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, broonie@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi,

On Thu, 21 Feb 2019 21:25:06 +0100
Anatolij Gustschin agust@denx.de wrote:
...
> .../ABI/testing/sysfs-driver-ftdi-fifo-fpp    |   7 +
> drivers/fpga/Kconfig                          |   7 +
> drivers/fpga/Makefile                         |   1 +
> drivers/fpga/ftdi-fifo-fpp.c                  | 594 ++++++++++++++++++
> 4 files changed, 609 insertions(+)
> create mode 100644 Documentation/ABI/testing/sysfs-driver-ftdi-fifo-fpp
> create mode 100644 drivers/fpga/ftdi-fifo-fpp.c

Ping. Any comments to this driver?

Thanks,
Anatolij
