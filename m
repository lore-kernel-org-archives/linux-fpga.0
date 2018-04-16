Return-Path: <SRS0=yjjX=HF=denx.de=agust@kernel.org>
Return-Path: <SRS0=yjjX=HF=denx.de=agust@kernel.org>
Date: Mon, 16 Apr 2018 10:34:22 +0200
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] fpga-manager: altera-ps-spi: preserve nCONFIG state
Message-ID: <20180416103422.5229b5fe@crub>
In-Reply-To: <20180416081008.GA31469@kroah.com>
References: <20180415183308.31402-1-mdf@kernel.org>
	<20180416081008.GA31469@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, atull@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, 16 Apr 2018 10:10:08 +0200
Greg KH gregkh@linuxfoundation.org wrote:
...
>> as discussed. Can you please take this bugfix for 4.17?
>> I rebased it against next.  
>
>Is it also needed in any older kernel versions?

It is needed in versions starting from v4.14.

thanks,

Anatolij
