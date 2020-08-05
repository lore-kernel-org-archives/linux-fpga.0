Return-Path: <SRS0=n/6d=BP=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=n/6d=BP=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:46257 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgHEIjf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 5 Aug 2020 04:39:35 -0400
Date: Wed, 5 Aug 2020 16:36:05 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v3 4/4] fpga: dfl: add support for N3000 nios private
  feature
Message-ID: <20200805083605.GB20262@yilunxu-OptiPlex-7050>
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
 <1596524715-18038-5-git-send-email-yilun.xu@intel.com>
 <b5d4157b-1bdf-445c-58a7-abd2f485a5ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5d4157b-1bdf-445c-58a7-abd2f485a5ff@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Tom Rix <trix@redhat.com>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, Russ Weight <russell.h.weight@intel.com>

Thanks for the word smith. I'll add these changes.

Thanks,
Yilun

On Tue, Aug 04, 2020 at 11:45:33AM -0700, Tom Rix wrote:
> Some minor edits.
> 
> I have added definitions for fec, kr, and rs.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
> 
> Tom
> 
> > --- /dev/null
> > +++ b/Documentation/fpga/dfl-n3000-nios.rst
> > @@ -0,0 +1,39 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=====================================
> > +DFL N3000 Nios Private Feature Driver
> > +=====================================
> > +
> > +The dfl n3000 nios driver supports for the nios handshake private feature on
> > +Intel N3000 FPGA Card.
> > +
> > +This private feature provides a handshake interface to FPGA NIOS firmware,
> > +which receives the ethernet retimer configuration command from host and
> > +do the configuration via an internal SPI master. When nios finished the
> 
> does the configuration..
> 
> When nios finishes the ..
> 
> > +configuration, host takes over the ownership of the SPI master to control an
> > +Intel MAX10 BMC Chip on the SPI bus.
> > +
> > +So the driver does 2 major tasks on probe, requires NIOS firmware to configure
> , uses the NIOS firmware to configure the ethernet retimer, and then ..
> > +the ethernet retimer by operating the handshake interfaces, and then creates a
> > +spi master platform device with the MAX10 device info in spi_board_info.
> > +
> > +Module Parameters
> > +=================
> > +
> > +The dfl n3000 nios driver supports the following module parameters:
> > +
> > +* fec_mode: string
> > +  Require the NIOS firmware to set the FEC mode of the ethernet retimer on
> the FEC (Forward Error Correction) mode
> > +  the PAC N3000 FPGA card. The possible values could be:
> > +
> > +  - "rs": RS FEC mode (default)
> - "rs" : Reed Solomon FEC (default)
> > +  - "kr": KR FEC mode
> - "kr": Fire Code FEC
> > +  - "no": NO FEC mode
> > +
> > +  The configuration could only be set once after the board powers up, the
> The configuration can only be ..
> > +  firmware will not accept a second configuration afterward. So the fec mode
> second configuration.
> > +  will not be changed if the module is reloaded with a different param value.
> > +
> > +  The configured value of the fec mode could be queried from sysfs node:
> > +
> > +  /sys/bus/dfl/devices/dfl-fme.X.X/fec_mode
