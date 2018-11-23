Return-Path: <SRS0=fKEv=OC=denx.de=agust@kernel.org>
Return-Path: <SRS0=fKEv=OC=denx.de=agust@kernel.org>
Date: Fri, 23 Nov 2018 16:29:49 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] usb: misc: fix boolconv.cocci warnings
Message-ID: <20181123162949.0ca117d0@crub>
In-Reply-To: <20181123151054.GA18175@kroah.com>
References: <alpine.DEB.2.21.1811211832430.2779@hadrien>
	<20181123151054.GA18175@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-usb@vger.kernel.org, linux-spi@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, atull@kernel.org, mdf@kernel.org, kbuild-all@01.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, 23 Nov 2018 16:10:54 +0100
Greg KH gregkh@linuxfoundation.org wrote:
...
>> Fixes: 0772a5bf580c ("usb: misc: add driver for FT232H based FPGA configuration devices")  
>
>I can't find this commit anywhere, nor the file that this patch touches.
>
>What tree is it in?

This new driver was submitted to the lists and is not in mainline
tree yet. It was committed to some tree for build testing the
submitted patches, it seems.

Thanks,

Anatolij
