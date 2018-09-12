Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 0/5] fpga: patches for v4.19
Date: Wed, 12 Sep 2018 09:43:22 -0500
Message-Id: <20180912144327.3130-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

Please take these five small patches for FPGA.  They
have been reviewed on the mailing lists and apply cleanly
on linux-next/master and char-misc-testing.

Thanks,
Alan

Alan Tull (3):
  fpga: do not access region struct after fpga_region_unregister
  fpga: bridge: fix obvious function documentation error
  docs: fpga: document fpga manager flags

Moritz Fischer (2):
  fpga: of-fpga-region: Use platform_set_drvdata
  fpga: dfl-fme-region: Use platform_get_drvdata()

 Documentation/driver-api/fpga/fpga-mgr.rst |  5 +++++
 drivers/fpga/dfl-fme-region.c              |  6 ++++--
 drivers/fpga/fpga-bridge.c                 |  2 +-
 drivers/fpga/of-fpga-region.c              |  5 +++--
 include/linux/fpga/fpga-mgr.h              | 20 ++++++++++++++------
 5 files changed, 27 insertions(+), 11 deletions(-)

-- 
2.7.4
