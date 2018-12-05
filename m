Return-Path: <SRS0=OQ25=OO=denx.de=agust@kernel.org>
Return-Path: <SRS0=OQ25=OO=denx.de=agust@kernel.org>
Date: Wed, 5 Dec 2018 11:25:43 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v3 2/3] spi: add FTDI MPSSE SPI controller driver
Message-ID: <20181205112543.33e167e4@crub>
In-Reply-To: <20181127175438.16116-3-agust@denx.de>
References: <20181127175438.16116-1-agust@denx.de>
	<20181127175438.16116-3-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-spi@vger.kernel.org, broonie@kernel.org
Cc: linux-usb@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, atull@kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Mark,

On Tue, 27 Nov 2018 18:54:37 +0100
Anatolij Gustschin agust@denx.de wrote:

>Add SPI bus controller driver for FTDI MPSSE mode. This driver
>is supposed to be used together with the FT232H interface driver
>for FPGA configuration in drivers/usb/misc/ft232h-intf.c which
>adds an mpsse spi platform device describing USB SPI bus with
>attached SPI slave devices.

I suppose this patch should go via Greg's usb tree as part of the
series, once acked. I've addressed comments in v3, is it okay now?

Thanks,
Anatolij
