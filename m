Return-Path: <SRS0=Lr74=NJ=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=Lr74=NJ=ettus.com=moritz.fischer@kernel.org>
Date: Mon, 29 Oct 2018 09:48:57 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: xilinx-spi: Use unique FPGA manager names
Message-ID: <20181029164857.GA2453@archbook>
References: <20181029144222.26927-1-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029144222.26927-1-agust@denx.de>
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-fpga@vger.kernel.org, atull@kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Anatolij,

On Mon, Oct 29, 2018 at 03:42:22PM +0100, Anatolij Gustschin wrote:
> Currently we have the same FPGA manager name for all registered
> xlnx-slave-spi managers, so it is not clear which fpga manager
> index belongs to which configuration interface (SPI slave device).
> Use unique fpga manager name for each registered manager. With
> this change we have names with SPI slave device name encoded in
> the manager name string, e.g. like "xlnx-slave-spi spi1.2".

Sounds like a udev problem that can be solved by looking at the
parent device?

Cheers,

Moritz
