Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1510779112-5517-1-git-send-email-atull@kernel.org>
References: <1510779112-5517-1-git-send-email-atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Date: Mon, 4 Dec 2017 13:28:56 -0600
Message-ID: <CANk1AXRbsjuy4aB-W6QyaTJ8arqthfnEK_QLMP2pSN154n071g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] fpga: don't use drvdata in common fpga code
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Nov 15, 2017 at 2:51 PM, Alan Tull <atull@kernel.org> wrote:

Gentle reminder, this patch set is pretty straightforward, could use
some reviewing.

Alan

> This patch set goes on top of v6 of the non-dt support patchset that has
> been acked and I've asked Greg KH to send upstream.
>
> This patchset changes the fpga_*_register functions to not set drvdata,
> and changes parameters for register/unregister functions.  Also a
> bug fix due to changes in the DT overlay code.
>
> Setting drvdata is fine for DT based devices, that will have one
> manager, bridge, or region device per platform device.  PCIe based
> devices may have multiple FPGA mgr/bridge/regions under one pcie
> device.  Without these changes, PCIe-based solutions have to create an
> extra device for each child mgr/bridge/region to hold drvdata.
>
> Also changing the fpga_*_register/unregister functions to take the
> corresponding struct as the only parameter wherever they weren't already.
>
> * int fpga_bridge_register(struct fpga_bridge *br)
> * int fpga_mgr_register(struct fpga_manager *mgr)
> * int fpga_region_register(struct fpga_region *region)
> * void fpga_bridge_unregister(struct fpga_bridge *br)
> * void fpga_mgr_unregister(struct fpga_manager *mgr)
> * int fpga_region_unregister(struct fpga_region *region)
>
> Other changes:
>
> - Callers of fpga_(bridge|mgr)_register, are changed to alloc the
> bridge/mgr struct and partly fill it, adding name, ops and priv.
> - Caller uses devm for allocating the mgr/bridge structures.
> - Change the FPGA Region DT notifier to return NOTIFY_STOP if
> the overlay should be accepted.
>
> I posted a branch to the linux-fpga repo on kernel.org which has both
> the v6 non-DT support patchset and this v2 patchset for convenience.
> Branch name is next-20171113-non-dt-support-v6+v2
>
> Alan
>
> Alan Tull (5):
>   fpga: region: don't use drvdata in common fpga code
>   fpga: manager: don't use drvdata in common fpga code
>   fpga: bridge: don't use drvdata in common fpga code
>   fpga: region: change fpga_region_register to have one param
>   fpga: region: return NOTIFY_STOP if overlay shoud be accepted
>
>  Documentation/fpga/fpga-mgr.txt     | 24 ++++++++++++-----
>  Documentation/fpga/fpga-region.txt  |  3 +--
>  drivers/fpga/altera-cvp.c           | 18 ++++++++++---
>  drivers/fpga/altera-fpga2sdram.c    | 20 +++++++++++---
>  drivers/fpga/altera-freeze-bridge.c | 18 ++++++++++---
>  drivers/fpga/altera-hps2fpga.c      | 16 ++++++++---
>  drivers/fpga/altera-pr-ip-core.c    | 17 ++++++++++--
>  drivers/fpga/altera-ps-spi.c        | 18 ++++++++++---
>  drivers/fpga/fpga-bridge.c          | 53 ++++++++++++++-----------------------
>  drivers/fpga/fpga-mgr.c             | 49 +++++++++++++---------------------
>  drivers/fpga/fpga-region.c          | 13 ++++++---
>  drivers/fpga/ice40-spi.c            | 20 +++++++++++---
>  drivers/fpga/of-fpga-region.c       |  9 ++++---
>  drivers/fpga/socfpga-a10.c          | 16 ++++++++---
>  drivers/fpga/socfpga.c              | 18 ++++++++++---
>  drivers/fpga/ts73xx-fpga.c          | 18 ++++++++++---
>  drivers/fpga/xilinx-pr-decoupler.c  | 15 ++++++++---
>  drivers/fpga/xilinx-spi.c           | 18 ++++++++++---
>  drivers/fpga/zynq-fpga.c            | 16 ++++++++---
>  include/linux/fpga/fpga-bridge.h    |  7 ++---
>  include/linux/fpga/fpga-mgr.h       |  8 +++---
>  include/linux/fpga/fpga-region.h    |  4 ++-
>  22 files changed, 270 insertions(+), 128 deletions(-)
>
> --
> 2.7.4
>
