Return-Path: <SRS0=ek6B=K5=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=ek6B=K5=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:65096
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727776AbeHOAeD (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 14 Aug 2018 20:34:03 -0400
From: Federico Vaga <federico.vaga@cern.ch>
Reply-To: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH 0/8] fpga: Add managed create in FPGA API
Date: Tue, 14 Aug 2018 23:44:44 +0200
Message-ID: <3975392.G1LtsYJEZq@harkonnen>
In-Reply-To: <20180814191526.3247-1-atull@kernel.org>
References: <20180814191526.3247-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org

Hi Alan,

I think you forgot to add:

Suggested-by: Federico Vaga <federico.vaga@cern.ch>

on patches 2,3,4 which were suggested here

https://lkml.org/lkml/2018/7/26/145

and patch 8 here:

https://lkml.org/lkml/2018/7/18/959

On Tuesday, August 14, 2018 9:15:18 PM CEST Alan Tull wrote:
> Fix one functional FPGA bug.
> 
> Implement managed devm_fpga_(mgr|bridge|region)_create() functions.
> 
> More documentation cleanup to make the documentation more helpful
> and to emphasize the use of FPGA regions for FPGA programming.
> 
> Fix a few minor documentation corrections.
> 
> Alan Tull (8):
>   fpga: do not access region struct after fpga_region_unregister
>   fpga: mgr: add devm_fpga_mgr_create
>   fpga: bridge: add devm_fpga_bridge_create
>   fpga: add devm_fpga_region_create
>   dt-bindings: fpga: fix freeze controller compatible in region doc
>   fpga: bridge: fix obvious function documentation error
>   docs: fpga: document fpga manager flags
>   docs: fpga: document programming fpgas using regions
> 
>  .../devicetree/bindings/fpga/fpga-region.txt       |   4 +-
>  Documentation/driver-api/fpga/fpga-bridge.rst      |  37 ++-----
>  Documentation/driver-api/fpga/fpga-mgr.rst         | 121
> +++------------------ Documentation/driver-api/fpga/fpga-programming.rst
> | 103 ++++++++++++++++++ Documentation/driver-api/fpga/fpga-region.rst  
>    |  91 ++++++++-------- Documentation/driver-api/fpga/index.rst       
>     |   2 +
>  drivers/fpga/altera-cvp.c                          |   8 +-
>  drivers/fpga/altera-fpga2sdram.c                   |   8 +-
>  drivers/fpga/altera-freeze-bridge.c                |  13 +--
>  drivers/fpga/altera-hps2fpga.c                     |   7 +-
>  drivers/fpga/altera-pr-ip-core.c                   |   9 +-
>  drivers/fpga/altera-ps-spi.c                       |  11 +-
>  drivers/fpga/dfl-fme-br.c                          |  11 +-
>  drivers/fpga/dfl-fme-mgr.c                         |  11 +-
>  drivers/fpga/dfl-fme-region.c                      |  10 +-
>  drivers/fpga/dfl.c                                 |   6 +-
>  drivers/fpga/fpga-bridge.c                         |  74 +++++++++++--
>  drivers/fpga/fpga-mgr.c                            |  67 ++++++++++--
>  drivers/fpga/fpga-region.c                         |  68 ++++++++++--
>  drivers/fpga/ice40-spi.c                           |  10 +-
>  drivers/fpga/machxo2-spi.c                         |  11 +-
>  drivers/fpga/of-fpga-region.c                      |   9 +-
>  drivers/fpga/socfpga-a10.c                         |   5 +-
>  drivers/fpga/socfpga.c                             |  10 +-
>  drivers/fpga/ts73xx-fpga.c                         |  11 +-
>  drivers/fpga/xilinx-pr-decoupler.c                 |   4 +-
>  drivers/fpga/xilinx-spi.c                          |  12 +-
>  drivers/fpga/zynq-fpga.c                           |   5 +-
>  include/linux/fpga/fpga-bridge.h                   |   4 +
>  include/linux/fpga/fpga-mgr.h                      |  22 +++-
>  include/linux/fpga/fpga-region.h                   |   4 +
>  31 files changed, 437 insertions(+), 331 deletions(-)
>  create mode 100644 Documentation/driver-api/fpga/fpga-programming.rst


-- 
Federico Vaga
[BE-CO-HT]
