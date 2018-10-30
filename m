Return-Path: <SRS0=41lj=NK=denx.de=agust@kernel.org>
Return-Path: <SRS0=41lj=NK=denx.de=agust@kernel.org>
Date: Tue, 30 Oct 2018 12:19:13 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] fpga: xilinx-spi: Use unique FPGA manager names
Message-ID: <20181030121913.3f5f8458@crub>
In-Reply-To: <20181029164857.GA2453@archbook>
References: <20181029144222.26927-1-agust@denx.de>
	<20181029164857.GA2453@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, atull@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Moritz,

On Mon, 29 Oct 2018 09:48:57 -0700
Moritz Fischer mdf@kernel.org wrote:
...
>Sounds like a udev problem that can be solved by looking at the
>parent device?

Yes, but there are still all kinds of small embedded systems
without udev/systemd support.

Thanks,

Anatolij
