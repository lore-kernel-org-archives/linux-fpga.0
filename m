Return-Path: <SRS0=B1nR=NV=denx.de=agust@kernel.org>
Return-Path: <SRS0=B1nR=NV=denx.de=agust@kernel.org>
Date: Sat, 10 Nov 2018 11:39:58 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 2/3] spi: add FTDI MPSSE SPI controller driver
Message-ID: <20181110113958.021c4f46@crub>
In-Reply-To: <20181109153026.GA7734@sirena.org.uk>
References: <20181105161913.27538-3-agust@denx.de>
	<20181109075356.19229-1-agust@denx.de>
	<20181109153026.GA7734@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org, atull@kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, 9 Nov 2018 15:30:26 +0000
Mark Brown broonie@kernel.org wrote:

>On Fri, Nov 09, 2018 at 08:53:56AM +0100, Anatolij Gustschin wrote:
>> Add SPI bus controller driver for FTDI MPSSE mode. This driver
>> is supposed to be used together with the FT232H interface driver
>> for FPGA configuration in drivers/usb/misc/ft232h-intf.c which
>> adds an mpsse spi platform device describing USB SPI bus with
>> attached SPI slave devices.  
>
>I don't have the rest of this series or a cover letter - what's the
>story with dependencies?

This v2 patch is the only patch of the original series that was
changed, I didn't resend whole series to avoid spamming the lists.

The original cover letter is here [1], this v2 patch depends on
patch [2].

[1] https://marc.info/?l=linux-spi&m=154143476109363&w=2
[2] https://marc.info/?l=linux-spi&m=154143479113473&w=2

Thanks,

Anatolij
