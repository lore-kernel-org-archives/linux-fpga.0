Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20181029144222.26927-1-agust@denx.de> <20181029164857.GA2453@archbook>
 <20181030121913.3f5f8458@crub>
In-Reply-To: <20181030121913.3f5f8458@crub>
From: Alan Tull <atull@kernel.org>
Date: Thu, 1 Nov 2018 13:21:00 -0500
Message-ID: <CANk1AXR470s6XyfjR8=1SdiNAFsVj0oNA1-STVCu6_zY-kLf3A@mail.gmail.com>
Subject: Re: [PATCH] fpga: xilinx-spi: Use unique FPGA manager names
Content-Type: text/plain; charset="UTF-8"
To: Anatolij Gustschin <agust@denx.de>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Oct 30, 2018 at 6:19 AM Anatolij Gustschin <agust@denx.de> wrote:
>
> Hi Moritz,
>
> On Mon, 29 Oct 2018 09:48:57 -0700
> Moritz Fischer mdf@kernel.org wrote:
> ...
> >Sounds like a udev problem that can be solved by looking at the
> >parent device?
>
> Yes, but there are still all kinds of small embedded systems
> without udev/systemd support.

What do you see if you look at the following for your fpga manager
(may be other than fpga0)?

/sys/class/fpga_manager/fpga0/device

or

 /sys/class/fpga_manager/fpga0/of_node

Alan

>
> Thanks,
>
> Anatolij
