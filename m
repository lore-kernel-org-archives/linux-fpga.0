Return-Path: <SRS0=lsyE=3B=gmail.com=delicious.quinoa@kernel.org>
Return-Path: <SRS0=lsyE=3B=gmail.com=delicious.quinoa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170313215333.3008-1-atull@kernel.org>
References: <20170313215333.3008-1-atull@kernel.org>
From: Alan Tull <delicious.quinoa@gmail.com>
Date: Fri, 24 Mar 2017 13:09:22 -0500
Message-ID: <CANk1AXSpNoKdpvpW2ikq6y+0o6JnfBexRkMhHUG+-u7rszoLHg@mail.gmail.com>
Subject: Re: [PATCH 0/5] fpga: enhancements to support non-dt code
Content-Type: text/plain; charset=UTF-8
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Mar 13, 2017 at 4:53 PM, Alan Tull <atull@kernel.org> wrote:
> Set of patches that supports writing code that uses
> FPGA regions without Device Tree overlays.

OK here's where I try to clarify my intention for this code.  And
beg for reviews :)

This patchset is intended as a stepping stone towards supporting
PCIe FPGAs by allowing fpga regions to be created and used in
without device tree overlays.  Without it, I can see a lot of
code coming down the line where people have to reinvent things that
aren't called fpga-regions but ultimately are doing the same thing.

The idea is that if someone has some whizzbang scheme,
that somehow knows "Oh I have a FPGA here and some bridges
and I want to program it without getting a kernel oops", then that
code can use fpga_region_register() to create an fpga region device and
tell it what fpga manager to use and give it a method for getting
bridges.  There is an example of usage in of_fpga_region_probe().
Then fpga_region_program_fpga() is available for programming
the fpga, including handling enabling/disabling the bridges.

Alan

>
> Main differences from the RFC:
> * dropping the sysfs interface
> * dropping support for more than one DT overlay on a region
>
> Alan Tull (5):
>   fpga-mgr: pass parameters for loading fpga in image info
>   fpga-bridge: support getting bridge from device
>   doc: fpga-mgr: separate getting/locking FPGA manager
>   fpga-mgr: separate getting/locking FPGA manager
>   fpga-region: separate out common code from dt specific code
>
>  Documentation/fpga/fpga-mgr.txt  |  19 +-
>  drivers/fpga/Kconfig             |  12 +-
>  drivers/fpga/Makefile            |   1 +
>  drivers/fpga/fpga-bridge.c       | 107 +++++++--
>  drivers/fpga/fpga-mgr.c          |  56 ++++-
>  drivers/fpga/fpga-region.c       | 473 +++++++--------------------------------
>  drivers/fpga/fpga-region.h       |  50 +++++
>  drivers/fpga/of-fpga-region.c    | 453 +++++++++++++++++++++++++++++++++++++
>  include/linux/fpga/fpga-bridge.h |   7 +-
>  include/linux/fpga/fpga-mgr.h    |  17 ++
>  10 files changed, 766 insertions(+), 429 deletions(-)
>  create mode 100644 drivers/fpga/fpga-region.h
>  create mode 100644 drivers/fpga/of-fpga-region.c
>
> --
> 2.7.4
>
