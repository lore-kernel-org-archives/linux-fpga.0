Return-Path: <SRS0=OQ25=OO=denx.de=agust@kernel.org>
Return-Path: <SRS0=OQ25=OO=denx.de=agust@kernel.org>
Date: Wed, 5 Dec 2018 10:50:08 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v3 3/3] fpga: Add fpga manager driver for ARRI Altera
 FPP
Message-ID: <20181205105008.4a32956c@crub>
In-Reply-To: <20181127175438.16116-4-agust@denx.de>
References: <20181127175438.16116-1-agust@denx.de>
	<20181127175438.16116-4-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: atull@kernel.org
Cc: linux-usb@vger.kernel.org, linux-spi@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, broonie@kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan,

On Tue, 27 Nov 2018 18:54:38 +0100
Anatolij Gustschin agust@denx.de wrote:

>Add FPGA manager driver for loading ARRI Altera FPGAs via fast
>passive parallel (FPP) interface using FTDI FT232H chip.

Ping. Is this patch okay? I suppose that it will go via usb tree
as part of the whole series (you send fpga driver patches to Greg
anyway). Can you ack this patch or is there something that should
be changed? I'd like to see it merged in v4.21, so if there are
issues with this patch, I'll try to address it before it is to late.

Thanks,
Anatolij
