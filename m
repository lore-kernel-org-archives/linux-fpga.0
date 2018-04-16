Return-Path: <SRS0=3ZTQ=HF=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=3ZTQ=HF=linuxfoundation.org=gregkh@kernel.org>
Date: Mon, 16 Apr 2018 10:10:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] fpga-manager: altera-ps-spi: preserve nCONFIG state
Message-ID: <20180416081008.GA31469@kroah.com>
References: <20180415183308.31402-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180415183308.31402-1-mdf@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: atull@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
List-ID: <linux-fpga@vger.kernel.org>

On Sun, Apr 15, 2018 at 11:33:08AM -0700, Moritz Fischer wrote:
> From: Anatolij Gustschin <agust@denx.de>
> 
> If the driver module is loaded when FPGA is configured, the FPGA
> is reset because nconfig is pulled low (low-active gpio inited
> with GPIOD_OUT_HIGH activates the signal which means setting its
> value to low). Init nconfig with GPIOD_OUT_LOW to prevent this.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Acked-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> Hi Greg,
> 
> as discussed. Can you please take this bugfix for 4.17?
> I rebased it against next.

Is it also needed in any older kernel versions?

thanks,

greg k-h
